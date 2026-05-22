from __future__ import annotations

import argparse
import json
import os
import re
import sys
from pathlib import Path
from typing import Any


REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


IMAGE_SUFFIXES = {".png", ".jpg", ".jpeg", ".webp", ".bmp"}


def _load_project_env() -> None:
    env_path = REPO_ROOT / ".env"
    if not env_path.exists():
        return
    try:
        from dotenv import load_dotenv
    except Exception:
        for line in env_path.read_text(encoding="utf-8", errors="ignore").splitlines():
            stripped = line.strip()
            if not stripped or stripped.startswith("#") or "=" not in stripped:
                continue
            name, value = stripped.split("=", 1)
            name = name.strip()
            value = value.strip()
            if not name:
                continue
            if (value.startswith('"') and value.endswith('"')) or (value.startswith("'") and value.endswith("'")):
                value = value[1:-1]
            os.environ[name] = value
        return
    load_dotenv(dotenv_path=env_path, override=True)


def _read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="ignore") if path.exists() else ""


def _extract_json5_string(raw: str, key: str) -> str:
    match = re.search(rf'"{re.escape(key)}"\s*:\s*"([^"]+)"', raw)
    return match.group(1).strip() if match else ""


def _extract_bundle_name(project_dir: Path) -> str:
    raw = _read_text(project_dir / "AppScope" / "app.json5")
    return _extract_json5_string(raw, "bundleName")


def _extract_ability_name(project_dir: Path) -> str:
    raw = _read_text(project_dir / "entry" / "src" / "main" / "module.json5")
    return _extract_json5_string(raw, "mainElement") or "EntryAbility"


def _find_latest_hap(project_dir: Path) -> Path:
    outputs_dir = project_dir / "entry" / "build" / "default" / "outputs" / "default"
    hap_files = [path for path in outputs_dir.rglob("*.hap") if path.is_file()]
    if not hap_files:
        raise FileNotFoundError(f"no .hap found under {outputs_dir}")

    def score(path: Path) -> tuple[int, float]:
        unsigned_bonus = 1 if "unsigned" in path.name.lower() else 0
        return unsigned_bonus, path.stat().st_mtime

    return sorted(hap_files, key=score, reverse=True)[0]


def _resolve_path(raw_value: str, base: Path = REPO_ROOT) -> Path:
    path = Path(raw_value).expanduser()
    return path.resolve() if path.is_absolute() else (base / path).resolve()


def _infer_single_project_dir(session_dir: Path) -> Path:
    projects_root = session_dir / "projects"
    if not projects_root.exists() or not projects_root.is_dir():
        raise FileNotFoundError(f"session projects dir not found: {projects_root}")
    dirs = sorted(path for path in projects_root.iterdir() if path.is_dir())
    if not dirs:
        raise FileNotFoundError(f"no project found under: {projects_root}")
    if len(dirs) > 1:
        names = ", ".join(path.name for path in dirs)
        raise ValueError(f"multiple projects found under {projects_root}; pass --project-dir explicitly: {names}")
    return dirs[0].resolve()


def _infer_latest_11_session_dir() -> Path | None:
    candidates = sorted(
        [path for path in REPO_ROOT.iterdir() if path.is_dir() and path.name.startswith("11")],
        key=lambda path: path.stat().st_mtime,
        reverse=True,
    )
    return candidates[0].resolve() if candidates else None


def _safe_load_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        return None


def _has_reference_images(path: Path | None) -> bool:
    if not path or not path.exists() or not path.is_dir():
        return False
    return any(item.is_file() and item.suffix.lower() in IMAGE_SUFFIXES for item in path.rglob("*"))


def _maybe_set_local_openclip_weight() -> None:
    if os.getenv("VISUAL_REVIEW_OPENCLIP_PRETRAINED") or os.getenv("OPENCLIP_PRETRAINED"):
        return
    candidate = REPO_ROOT / "models" / "openclip" / "ViT-B-32-laion2b" / "open_clip_model.safetensors"
    if candidate.exists():
        os.environ["VISUAL_REVIEW_OPENCLIP_PRETRAINED"] = str(candidate.resolve())


def _ensure_importable_model_env() -> None:
    """Allow standalone test-stage imports when model API keys are not configured."""
    os.environ.setdefault("OPENAI_API_KEY", "standalone-test-stage-dummy-key")
    os.environ.setdefault("DASHSCOPE_API_KEY", os.environ["OPENAI_API_KEY"])
    os.environ.setdefault("DEEPSEEK_API_KEY", os.environ["OPENAI_API_KEY"])


def _invoke_tool(tool_obj: Any, payload: dict[str, Any]) -> str:
    if hasattr(tool_obj, "invoke"):
        return str(tool_obj.invoke(payload))
    return str(tool_obj(**payload))


def _session_relative(path: Path, session_dir: Path | None) -> str:
    if session_dir:
        try:
            return "/" + path.resolve().relative_to(session_dir.resolve()).as_posix()
        except ValueError:
            pass
    return str(path.resolve())


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run the PageWeave test stage directly against a standalone HarmonyOS project."
    )
    parser.add_argument("--session-dir", default="", help="PageWeave session directory containing projects/designs/user_input.")
    parser.add_argument("--project-dir", default="", help="HarmonyOS project directory.")
    parser.add_argument("--hap-path", default="", help="Optional explicit .hap path.")
    parser.add_argument("--bundle-name", default="", help="Optional explicit bundle name.")
    parser.add_argument("--ability-name", default="", help="Optional explicit ability name.")
    parser.add_argument("--max-depth", type=int, default=5, help="Review traversal max depth.")
    parser.add_argument("--output-root", default="reports/qqmail", help="Directory for review outputs.")
    parser.add_argument("--architect-output", default="", help="Optional architect json for jump comparison.")
    parser.add_argument("--user-input-dir", default="", help="Reference image directory for visual review.")
    parser.add_argument("--skip-review", action="store_true", help="Skip review_node execution.")
    parser.add_argument("--skip-summary", action="store_true", help="Skip flow summary generation.")
    parser.add_argument("--skip-visual", action="store_true", help="Skip visual review generation.")
    parser.add_argument("--use-llm", action="store_true", help="Enable VLM review after image matching.")
    parser.add_argument("--no-install-hap", action="store_true", help="Do not install the HAP before review.")
    parser.add_argument("--run-jump-compare", action="store_true", help="Compare observed jumps with architect output.")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    _load_project_env()
    _ensure_importable_model_env()
    _maybe_set_local_openclip_weight()

    session_dir = _resolve_path(args.session_dir) if args.session_dir else _infer_latest_11_session_dir()
    project_dir = _resolve_path(args.project_dir) if args.project_dir else None
    if project_dir is None:
        project_dir = _infer_single_project_dir(session_dir) if session_dir else (REPO_ROOT / "qqmail").resolve()
    if not project_dir.exists() or not project_dir.is_dir():
        raise FileNotFoundError(f"project dir not found: {project_dir}")

    output_root_base = session_dir if session_dir else REPO_ROOT
    output_root = _resolve_path(args.output_root, base=output_root_base)
    output_root.mkdir(parents=True, exist_ok=True)

    hap_path = Path(args.hap_path).expanduser()
    if args.hap_path:
        hap_path = hap_path.resolve() if hap_path.is_absolute() else (project_dir / hap_path).resolve()
    else:
        hap_path = _find_latest_hap(project_dir).resolve()

    bundle_name = str(args.bundle_name or "").strip() or _extract_bundle_name(project_dir)
    if not bundle_name:
        raise ValueError("bundle name not found; pass --bundle-name")

    ability_name = str(args.ability_name or "").strip() or _extract_ability_name(project_dir)

    architect_default = (session_dir / "designs" / "navigation_design.json") if session_dir else REPO_ROOT / "designs" / "architect.json"
    architect_output = _resolve_path(args.architect_output, base=session_dir or REPO_ROOT) if args.architect_output else architect_default.resolve()
    run_jump_compare = bool(args.run_jump_compare and architect_output.exists())

    result: dict[str, Any] = {
        "status": "SKIPPED",
        "project_dir": str(project_dir),
        "session_dir": str(session_dir or ""),
        "hap_path": str(hap_path),
        "bundle_name": bundle_name,
        "ability_name": ability_name,
        "output_root": str(output_root),
    }

    if not args.skip_review:
        from review_node import run_review_workflow

        result = run_review_workflow(
            hap_path=str(hap_path),
            bundle_name_value=bundle_name,
            ability_name_value=ability_name,
            max_depth=args.max_depth,
            output_root=str(output_root),
            architect_output_path=str(architect_output),
            run_jump_compare=run_jump_compare,
            install_hap=not args.no_install_hap,
        )

    review_output_dir = Path(str(result.get("output_dir") or output_root)).resolve()
    review_output_arg = str(review_output_dir)
    architect_output_arg = str(architect_output)

    summary_output = ""
    if not args.skip_summary:
        from tools.review_flow_tools import summarize_review_features_by_page

        summary_output = _invoke_tool(
            summarize_review_features_by_page,
            {"review_output_dir": review_output_arg, "output_file_name": "flow_summary_user.md"},
        )
        print(summary_output)

    visual_output = ""
    user_input_default = (session_dir / "user_input") if session_dir else REPO_ROOT / "user_input"
    user_input_dir = _resolve_path(args.user_input_dir, base=session_dir or REPO_ROOT) if args.user_input_dir else user_input_default.resolve()

    if args.skip_visual:
        visual_output = "status: SKIPPED\nreason: --skip-visual"
    elif not _has_reference_images(user_input_dir):
        visual_output = (
            "status: SKIPPED\n"
            f"reason: no reference images found; pass --user-input-dir\n"
            f"user_input_dir: {user_input_dir}"
        )
        print(visual_output)
    else:
        from tools.review_flow_tools import run_visual_review_with_inputs

        visual_output = _invoke_tool(
            run_visual_review_with_inputs,
            {
                "review_output_dir": review_output_arg,
                "architect_output_path": architect_output_arg,
                "user_input_dir": str(user_input_dir),
                "output_file_name": "visual_review_output.json",
                "use_llm": bool(args.use_llm),
                "show_progress": True,
            },
        )
        print(visual_output)

    detailed_path = Path(str(result.get("review_detailed_output_path") or ""))
    test_result_payload = {
        "project_name": project_dir.name,
        "project_dir": str(project_dir),
        "session_dir": str(session_dir or ""),
        "bundle_name": bundle_name,
        "ability_name": ability_name,
        "hap_path": str(hap_path),
        "review_result": result,
        "summary_output": summary_output,
        "visual_output": visual_output,
    }
    if detailed_path.exists():
        test_result_payload["review_detailed_output"] = _safe_load_json(detailed_path)

    test_result_path = output_root / "test_result.json"
    test_result_path.write_text(json.dumps(test_result_payload, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"test_result_path: {test_result_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

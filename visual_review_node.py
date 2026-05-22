from __future__ import annotations

import argparse
import base64
import difflib
import importlib
import io
import json
import os
import time
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

try:
    from PIL import Image

    PIL_AVAILABLE = True
except Exception:  # noqa: BLE001
    Image = None
    PIL_AVAILABLE = False


DEFAULT_VLM_MODEL = "qwen-vl-max"
IMAGE_SUFFIXES = {".png", ".jpg", ".jpeg", ".webp", ".bmp"}


def _collect_images(root: Path) -> List[Path]:
    if not root.exists() or not root.is_dir():
        return []
    return sorted(
        [
            item
            for item in root.rglob("*")
            if item.is_file() and item.suffix.lower() in IMAGE_SUFFIXES
        ],
        key=lambda item: str(item).lower(),
    )


def _is_runtime_image_selected(path: Path) -> bool:
    normalized = str(path).replace("\\", "/").lower()
    normalized = normalized.replace("_", " ").replace("-", " ")
    if "before" in normalized or "return" in normalized:
        return False
    return ("after" in normalized) or ("init screen" in normalized) or ("initscreen" in normalized)


def _normalize_key(value: str) -> str:
    text = Path(str(value or "")).stem.lower()
    keep = []
    for char in text:
        keep.append(char if char.isalnum() else " ")
    return " ".join("".join(keep).split())


def _image_profile(path: Path) -> Dict[str, Any]:
    profile: Dict[str, Any] = {
        "name_key": _normalize_key(path.name),
        "size": path.stat().st_size if path.exists() else 0,
    }
    if not PIL_AVAILABLE or Image is None:
        return profile
    try:
        with Image.open(path) as image:
            width, height = image.size
            profile["width"] = width
            profile["height"] = height
            profile["aspect"] = round(width / height, 6) if height else 0
    except Exception:  # noqa: BLE001
        pass
    return profile


def _score_pair(reference_path: Path, runtime_path: Path) -> Dict[str, Any]:
    ref = _image_profile(reference_path)
    run = _image_profile(runtime_path)
    name_score = difflib.SequenceMatcher(
        None,
        str(ref.get("name_key") or ""),
        str(run.get("name_key") or ""),
    ).ratio()

    dimension_score = 0.0
    if ref.get("width") and ref.get("height") and run.get("width") and run.get("height"):
        width_ratio = min(float(ref["width"]), float(run["width"])) / max(float(ref["width"]), float(run["width"]))
        height_ratio = min(float(ref["height"]), float(run["height"])) / max(float(ref["height"]), float(run["height"]))
        aspect_diff = abs(float(ref.get("aspect") or 0) - float(run.get("aspect") or 0))
        aspect_score = max(0.0, 1.0 - min(1.0, aspect_diff))
        dimension_score = (width_ratio + height_ratio + aspect_score) / 3.0

    size_score = 0.0
    if ref.get("size") and run.get("size"):
        size_score = min(float(ref["size"]), float(run["size"])) / max(float(ref["size"]), float(run["size"]))

    if dimension_score > 0:
        final = 0.45 * name_score + 0.45 * dimension_score + 0.10 * size_score
        mode = "filename_dimension"
    else:
        final = 0.85 * name_score + 0.15 * size_score
        mode = "filename_size"

    return {
        "final": round(max(0.0, min(1.0, final)), 6),
        "name": round(max(0.0, min(1.0, name_score)), 6),
        "dimension": round(max(0.0, min(1.0, dimension_score)), 6),
        "size": round(max(0.0, min(1.0, size_score)), 6),
        "mode": mode,
    }


def _relative_paths(path_value: Path, root: Path) -> str:
    try:
        return path_value.resolve().relative_to(root.resolve()).as_posix()
    except Exception:  # noqa: BLE001
        return str(path_value)


def _build_vlm(model_name: str) -> Any:
    chatopenai_module = importlib.import_module("langchain_openai")
    pydantic_module = importlib.import_module("pydantic")

    ChatOpenAI = getattr(chatopenai_module, "ChatOpenAI")
    BaseModel = getattr(pydantic_module, "BaseModel")
    Field = getattr(pydantic_module, "Field")

    class VisualPairFeedback(BaseModel):
        overall: str = Field(description="PASS / FAIL")
        similarity_score: float = Field(description="0-100")
        differences: List[Dict[str, Any]] = Field(description="Difference items with impact/category")
        summary: str = Field(description="A short summary in Chinese")
        suggestions: str = Field(description="Actionable suggestions for improving consistency")

    api_key = str(os.getenv("DASHSCOPE_API_KEY", "")).strip()
    if not api_key:
        raise ValueError("DASHSCOPE_API_KEY is missing.")

    llm = ChatOpenAI(
        model=model_name,
        api_key=api_key,
        base_url=os.getenv("DASHSCOPE_BASE_URL") or "https://dashscope.aliyuncs.com/compatible-mode/v1",
        temperature=0.0,
    )
    return llm.with_structured_output(VisualPairFeedback)


def _image_b64(path: Path) -> str:
    return base64.b64encode(path.read_bytes()).decode("ascii")


def _vlm_compare_pair(
    llm: Any,
    runtime_image_path: str,
    runtime_b64: str,
    reference_image_path: str,
    reference_b64: str,
    score_payload: Dict[str, Any],
) -> Dict[str, Any]:
    messages_module = importlib.import_module("langchain_core.messages")
    HumanMessage = getattr(messages_module, "HumanMessage")
    SystemMessage = getattr(messages_module, "SystemMessage")

    prompt = (
        "你是移动端 UI 快速验收助手。只判断是否大致相似，不做过度细节分析。"
        "重点看页面主结构、关键组件、主要文案语义。顶部系统状态栏可忽略。"
        '输出严格 JSON: {"overall":"PASS|FAIL","similarity_score":0-100,'
        '"differences":[{"item":"...","impact":"high|medium|low","category":"layout|component|text|style"}],'
        '"summary":"...","suggestions":"..."}'
    )
    content = [
        {"type": "text", "text": f"lightweight_score={score_payload.get('final', 0)}"},
        {"type": "text", "text": f"[Runtime] {runtime_image_path}"},
        {"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{runtime_b64}"}},
        {"type": "text", "text": f"[Reference] {reference_image_path}"},
        {"type": "image_url", "image_url": {"url": f"data:image/jpeg;base64,{reference_b64}"}},
    ]
    result = llm.invoke([SystemMessage(content=prompt), HumanMessage(content=content)])
    if hasattr(result, "model_dump"):
        return result.model_dump()
    if isinstance(result, dict):
        return result
    return {"raw": str(result)}


def _build_user_markdown(report: Dict[str, Any]) -> str:
    stats = report.get("stats", {}) if isinstance(report, dict) else {}
    rows = report.get("pair_results", []) if isinstance(report, dict) else []

    lines = [
        "# Visual Review Summary",
        "",
        f"- runtime_image_count: {stats.get('runtime_image_count', 0)}",
        f"- reference_image_count: {stats.get('reference_image_count', 0)}",
        f"- matched_count: {stats.get('matched_count', 0)}",
        f"- avg_top1_score: {stats.get('avg_top1_score', 0)}",
        f"- scoring_mode: {stats.get('scoring_mode', 'lightweight')}",
        "",
        "## Top1 Matches",
    ]
    if not rows:
        lines.append("- No matches found")
        return "\n".join(lines) + "\n"

    for row in rows:
        reference_path = str(row.get("reference_image_path_rel") or row.get("reference_image_path") or "")
        runtime_path = str(row.get("runtime_image_path_rel") or row.get("runtime_image_path") or "")
        score = row.get("score", {}) if isinstance(row.get("score"), dict) else {}
        lines.append(f"- {reference_path} -> {runtime_path} (score={score.get('final', 0)})")
        feedback = row.get("visual_feedback", {}) if isinstance(row.get("visual_feedback"), dict) else {}
        if feedback.get("status") == "ok":
            review = feedback.get("review", {}) if isinstance(feedback.get("review"), dict) else {}
            summary = str(review.get("summary", "")).strip()
            if summary:
                lines.append(f"  {summary}")
        elif feedback.get("reason"):
            lines.append(f"  visual_feedback: {feedback.get('reason')}")
    return "\n".join(lines) + "\n"


def run_visual_review_page_elem(
    review_output_dir: Path,
    output_json_path: Path,
    user_input_dir: Path,
    show_progress: bool = True,
    use_llm: bool = True,
    llm_model: str = DEFAULT_VLM_MODEL,
    architect_output_path: Optional[Path] = None,
) -> Dict[str, Any]:
    _ = architect_output_path
    _ = show_progress
    t0 = time.perf_counter()

    runtime_paths_all = _collect_images(review_output_dir)
    runtime_paths = [path for path in runtime_paths_all if _is_runtime_image_selected(path)]
    runtime_filtered_out_count = max(0, len(runtime_paths_all) - len(runtime_paths))
    reference_paths = _collect_images(user_input_dir)

    if not runtime_paths:
        raise ValueError(f"No runtime images found under: {review_output_dir}")
    if not reference_paths:
        raise ValueError(f"No user input images found under: {user_input_dir}")

    llm_requested = bool(use_llm)
    llm_used = False
    llm_error = ""
    llm = None
    if llm_requested:
        try:
            llm = _build_vlm(llm_model)
            llm_used = True
        except Exception as exc:  # noqa: BLE001
            llm_error = str(exc)

    score_records: List[Tuple[float, int, int, Dict[str, Any]]] = []
    for ref_idx, reference_path in enumerate(reference_paths):
        for run_idx, runtime_path in enumerate(runtime_paths):
            score = _score_pair(reference_path, runtime_path)
            score_records.append((float(score.get("final", 0.0)), ref_idx, run_idx, score))
    score_records.sort(key=lambda item: item[0], reverse=True)

    assigned_ref_indices = set()
    assigned_run_indices = set()
    selected_pairs: List[Tuple[int, int, Dict[str, Any]]] = []
    for _, ref_idx, run_idx, score in score_records:
        if ref_idx in assigned_ref_indices or run_idx in assigned_run_indices:
            continue
        assigned_ref_indices.add(ref_idx)
        assigned_run_indices.add(run_idx)
        selected_pairs.append((ref_idx, run_idx, score))
        if len(assigned_ref_indices) >= len(reference_paths) or len(assigned_run_indices) >= len(runtime_paths):
            break

    pair_results: List[Dict[str, Any]] = []
    score_sum = 0.0
    for ref_idx, run_idx, score in selected_pairs:
        reference_path = reference_paths[ref_idx]
        runtime_path = runtime_paths[run_idx]
        score_sum += max(0.0, float(score.get("final", 0.0)))

        visual_feedback: Dict[str, Any] = {"status": "skipped", "reason": "llm_not_enabled"}
        if llm_requested and not llm_used:
            visual_feedback = {"status": "skipped", "reason": llm_error or "llm_not_available"}
        elif llm_used and llm is not None:
            try:
                review = _vlm_compare_pair(
                    llm=llm,
                    runtime_image_path=str(runtime_path),
                    runtime_b64=_image_b64(runtime_path),
                    reference_image_path=str(reference_path),
                    reference_b64=_image_b64(reference_path),
                    score_payload=score,
                )
                visual_feedback = {"status": "ok", "review": review}
            except Exception as exc:  # noqa: BLE001
                visual_feedback = {"status": "failed", "reason": str(exc)}

        pair_results.append(
            {
                "runtime_image_path": str(runtime_path),
                "reference_image_path": str(reference_path),
                "score": score,
                "visual_feedback": visual_feedback,
            }
        )

    elapsed_seconds = round(time.perf_counter() - t0, 3)
    matched_count = len(pair_results)
    avg_score = round(score_sum / matched_count, 6) if matched_count else 0.0

    report = {
        "review_output_dir": str(review_output_dir),
        "user_input_dir": str(user_input_dir),
        "generated_at": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "stats": {
            "runtime_image_total_count": len(runtime_paths_all),
            "runtime_image_count": len(runtime_paths),
            "runtime_image_filtered_out_count": runtime_filtered_out_count,
            "reference_image_count": len(reference_paths),
            "matched_count": matched_count,
            "reference_unmatched_count": max(0, len(reference_paths) - matched_count),
            "runtime_ignored_count": max(0, len(runtime_paths) - matched_count),
            "avg_top1_score": avg_score,
            "llm_requested": llm_requested,
            "llm_used": llm_used,
            "llm_model": llm_model if llm_requested else None,
            "scoring_mode": "lightweight_filename_dimension",
            "pil_available": PIL_AVAILABLE,
            "elapsed_seconds": elapsed_seconds,
        },
        "pair_results": pair_results,
        "llm_error": llm_error,
    }

    output_json_path.parent.mkdir(parents=True, exist_ok=True)
    project_root = Path(__file__).resolve().parent
    for row in pair_results:
        runtime_path = Path(str(row.get("runtime_image_path", "")))
        reference_path = Path(str(row.get("reference_image_path", "")))
        row["runtime_image_path_rel"] = _relative_paths(runtime_path, project_root)
        row["reference_image_path_rel"] = _relative_paths(reference_path, project_root)

    output_json_path.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    user_md_path = output_json_path.with_name(output_json_path.stem + "_user.md")
    user_md_path.write_text(_build_user_markdown(report), encoding="utf-8")

    report["machine_report_path"] = str(output_json_path)
    report["user_report_path"] = str(user_md_path)
    return report


def main() -> None:
    parser = argparse.ArgumentParser(description="Lightweight visual review fallback.")
    parser.add_argument("--review-output-dir", required=True)
    parser.add_argument("--user-input-dir", required=True)
    parser.add_argument("--output-json", default="artifacts/visual_review_output.json")
    parser.add_argument("--architect-output", default="")
    parser.add_argument("--no-progress", action="store_true")
    parser.add_argument("--disable-llm", action="store_true")
    parser.add_argument("--llm-model", default=DEFAULT_VLM_MODEL)
    args = parser.parse_args()

    report = run_visual_review_page_elem(
        review_output_dir=Path(args.review_output_dir).resolve(),
        output_json_path=Path(args.output_json).resolve(),
        user_input_dir=Path(args.user_input_dir).resolve(),
        show_progress=not args.no_progress,
        use_llm=not args.disable_llm,
        llm_model=args.llm_model,
        architect_output_path=Path(args.architect_output).resolve() if str(args.architect_output).strip() else None,
    )
    print(json.dumps(report.get("stats", {}), ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()

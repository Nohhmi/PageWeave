```markdown
# PageWeave
> **PageWeave: Generating Multi-Page HarmonyOS App Prototypes from Screenshots**

## 📖 System Overview

PageWeave is a multi‑agent framework that automatically generates runnable HarmonyOS application prototypes from a set of UI screenshots. It addresses two key challenges: merging multiple screenshots of the same page (different scroll positions, UI states, or overlays) and recovering inter‑page navigation relations from an unordered screenshot collection.

### Key Features

- **Multi‑agent pipeline** – Architecture Agent, Code Generation Agent, and Testing Agent work under an orchestrator.
- **Screenshot merging** – Automatically merges same‑page screenshots into a unified page model.
- **Navigation recovery** – Infers entry page, hierarchy, and inter‑page links from unordered screenshots.
- **End‑to‑end HarmonyOS project** – Generates full project skeleton, routes, ArkUI code, and compiles it into a HAP package.
- **Iterative compilation fixing** – Captures compilation errors, diagnoses them, and applies fixes.
- **Automated testing** – Tests the generated app, captures screenshot pairs, detects anomalies, and returns revision suggestions.

### How It Works

1. **Architecture Agent** – Extracts layout, controls, and text from each screenshot; merges same‑page screenshots; infers navigation structure.
2. **Code Generation Agent** – Creates the HarmonyOS project, writes ArkUI pages, registers routes, compiles, and iteratively fixes errors to produce a HAP.
3. **Testing Agent** – Installs the HAP on an emulator, interacts with the UI, collects before/after screenshots, identifies functional events, and outputs a test report with UI similarity scores (CLIP, SSIM, LPIPS) and revision suggestions.

### Model Backend

- **Qwen3‑VL‑Plus** – Single‑image information extraction and test‑related tasks (e.g., test script generation).
- **DeepSeek‑V4‑Pro** – Page merging, navigation inference, code generation, and compilation fixing.

### Evaluation Results

We evaluated PageWeave on four real‑world applications with 15–36 screenshots each. Results are averaged across the four apps:

| Metric | Description | PageWeave (average) |
| --- | --- | --- |
| **PRR** | Page Reconstruction Rate – correctly generated unique pages | 93.8% |
| **IIR** | In‑page Interaction Rate – correctly restored interactive elements | 93.1% |
| **INR** | Inter‑page Navigation Rate – correctly implemented navigation links | 91.0% |

For the most complex app (Zhihu, 36 screenshots), PageWeave achieved **IIR 76.7%** (vs. ablation 50.0%) and **INR 84.6%** (vs. ablation 48.0%).

## Environment Setup

### 1. Install Prerequisites

- Python `3.11+`
- [uv](https://docs.astral.sh/uv/)
- Node.js / npm
- HarmonyOS toolchain: `ohpm`, `hvigorw`

### 2. Configure Environment Variables

The project reads the `.env` file from the root directory. At a minimum, you need:

```env
DASHSCOPE_API_KEY=your_dashscope_api_key
DASHSCOPE_BASE_URL=https://dashscope.aliyuncs.com/compatible-mode/v1
```

To enable LangSmith, add the following:

```env
LANGSMITH_TRACING=true
LANGSMITH_API_KEY=your_langsmith_api_key
LANGSMITH_PROJECT=ImageToArkTS
```

### 3. Install Dependencies

Install Python dependencies:

```bash
uv sync
```

Install frontend dependencies:

```bash
cd frontend
npm install
```

## How to Run

### Method 1: Run the Main Pipeline

Place your input files into `agent_workspace/user_input`, then execute from the project root:

```bash
uv run python main.py
```

### Method 2: Start the Chat Interface

Start the backend from the project root:

```bash
uv run python runtime.py
```

Then start the frontend in the `frontend` directory:

```bash
cd frontend
npm run dev
```

Default access addresses:

- Backend: `http://127.0.0.1:8080`
- Frontend: `http://127.0.0.1:5173`

## Session Isolation (Local)

Local filesystem isolation is used by default, no additional cloud sandbox configuration required.

```env
# Optional, defaults to filesystem
SANDBOX_PROVIDER=filesystem
```

Launch the application:

```bash
uv run python runtime.py
```

Each frontend `session_id` maps to an isolated local directory:

`agent_workspace/sessions/<session_id>/...`
```

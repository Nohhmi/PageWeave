# PageWeave (Ablation Variant)

**This is an ablation version of PageWeave.** It uses the same code generation method as the full system, but **simplifies the architecture**: it replaces the dedicated Architecture Agent with simple prompts for merging screenshots and inferring navigation. The ablation variant is used in our paper to demonstrate the value of the full multi‑agent design.

## 📖 System Overview (Ablation)

The ablation variant of PageWeave generates HarmonyOS app prototypes from a set of UI screenshots, but **without** the explicit page merging and navigation planning stages. Instead, it relies on a single‑stage prompt‑based approach to combine screenshots and recover navigation relations. This simplified pipeline is significantly less effective for multi‑page or complex applications, as shown in our experimental results (e.g., on Zhihu (36 screenshots) the full PageWeave achieves **IIR 76.7% vs. 50.0%** and **INR 84.6% vs. 48.0%**).

Use this repository only for reproducibility of the ablation study. For the full system, please refer to the main PageWeave repository (link to be added).

### Key Differences from Full PageWeave

| Feature | Full PageWeave | Ablation Variant |
| --- | --- | --- |
| Dedicated Architecture Agent | Yes (extract, merge, plan) | No (replaced by simple prompts) |
| Cross‑screenshot merging | Structured merging with visual‑structural analysis | Prompt‑based merging |
| Navigation recovery | Two‑layer navigation planning | Simple prompt‑inferred links |
| Compilation fixing | Yes (iterative) | Yes (same) |
| Testing Agent | Yes | Yes |
## 📊 Evaluation Data

The generated outputs (code and screenshots) of this ablation variant for the four test applications are available in the [`test_result`](./test_result) directory, same as the full PageWeave results. You can compare them to see the impact of the dedicated architecture agent.

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

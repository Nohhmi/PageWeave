```markdown
# ImageToArkTS-DeepAgents

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


#!/bin/bash
set -eu

export OLLAMA_HOST="0.0.0.0:${PORT:-10000}"
export OLLAMA_ORIGINS="*"
export OLLAMA_KEEP_ALIVE=0
export OLLAMA_MAX_LOADED_MODELS=1
export OLLAMA_NUM_PARALLEL=1
export OLLAMA_CONTEXT_LENGTH=256

ollama serve &
PID=$!

cleanup() {
  kill "$PID" 2>/dev/null || true
}
trap cleanup EXIT TERM INT

until ollama list >/dev/null 2>&1; do
  kill -0 "$PID" 2>/dev/null || exit 1
  sleep 2
done

ollama pull qwen2.5:0.5b

wait "$PID"

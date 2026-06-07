#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
bun run lint 2>&1 | tail -30
bun run typecheck 2>&1 | tail -20
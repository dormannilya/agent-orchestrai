#!/bin/bash

set -e

REPO_URL="https://github.com/dormannilya/agent-orchestrai.git"
DIR="agent-orchestrai"

echo ""
echo "Installing Agent Orchestrator..."
echo ""

if ! command -v git &> /dev/null; then
  echo "Error: git is not installed. Please install git and try again."
  exit 1
fi

if [ -d "$DIR" ]; then
  echo "Directory '$DIR' already exists."
  echo "To reinstall, remove it first: rm -rf $DIR"
  exit 1
fi

if ! git clone "$REPO_URL" "$DIR"; then
  echo ""
  echo "Error: failed to clone repository."
  echo "Check your internet connection and try again."
  exit 1
fi

cd "$DIR"

mkdir -p output
mkdir -p skills

touch output/session_log.md

echo ""
echo "Done. Agent Orchestrator is ready in ./$DIR"
echo ""
echo "Next steps:"
echo "  1. Fill in USER_INFO.md  — your role, skills, and preferences"
echo "  2. Fill in PROJECT_INFO.md — your project context (optional)"
echo "  3. Open Claude Code, connect this repository, and describe your task"
echo ""
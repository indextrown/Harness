#!/usr/bin/env sh

# Git hooks 경로를 .githooks로 설정합니다.
# 사용법: scripts/install-hooks.sh
# 예시: scripts/install-hooks.sh

set -eu

if ! command -v git >/dev/null 2>&1; then
  echo "git이 설치되어 있지 않습니다." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "현재 디렉터리는 Git 저장소가 아닙니다." >&2
  echo "먼저 git init 또는 기존 저장소 연결이 필요합니다." >&2
  exit 1
fi

git config core.hooksPath .githooks
echo "Git hooks 경로 설정 완료: .githooks"

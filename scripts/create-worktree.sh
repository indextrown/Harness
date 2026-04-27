#!/usr/bin/env sh

# 새 작업 브랜치와 워크트리 작업 공간을 생성합니다.
# 사용법: scripts/create-worktree.sh <branch-name> <path>
# 예시: scripts/create-worktree.sh task/add-author-field ../Harness-add-author-field

set -eu

if [ "$#" -lt 2 ]; then
  echo "사용법: scripts/create-worktree.sh <branch-name> <path>" >&2
  echo "예시: scripts/create-worktree.sh task/add-author-field ../Harness-add-author-field" >&2
  exit 1
fi

branch_name="$1"
worktree_path="$2"

if ! command -v git >/dev/null 2>&1; then
  echo "git이 설치되어 있지 않습니다." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "현재 디렉터리는 Git 저장소가 아닙니다." >&2
  echo "먼저 git init 또는 기존 저장소 연결이 필요합니다." >&2
  exit 1
fi

git worktree add -b "$branch_name" "$worktree_path"
echo "워크트리 생성 완료: $worktree_path ($branch_name)"

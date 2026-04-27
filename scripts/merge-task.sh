#!/usr/bin/env sh

set -eu

if [ "$#" -lt 1 ]; then
  echo "사용법: scripts/merge-task.sh <branch-name> [base-branch]" >&2
  echo "예시: scripts/merge-task.sh task/add-author-field main" >&2
  exit 1
fi

branch_name="$1"
base_branch="${2:-main}"

if ! command -v git >/dev/null 2>&1; then
  echo "git이 설치되어 있지 않습니다." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "현재 디렉터리는 Git 저장소가 아닙니다." >&2
  exit 1
fi

current_branch="$(git rev-parse --abbrev-ref HEAD)"

if [ "$current_branch" != "$base_branch" ]; then
  echo "현재 브랜치: $current_branch" >&2
  echo "먼저 베이스 브랜치($base_branch)로 이동한 뒤 병합하세요." >&2
  exit 1
fi

git merge --no-ff "$branch_name"
echo "병합 완료: $branch_name -> $base_branch"

#!/usr/bin/env sh

# 로컬 작업 브랜치를 베이스 브랜치에 예외적으로 병합합니다.
# 기본 경로는 PR 생성 후 scripts/merge-pr.sh 를 사용하는 것입니다.
# 사용법: HARNESS_ALLOW_LOCAL_MERGE=1 scripts/merge-task.sh <branch-name> [base-branch]
# 예시: HARNESS_ALLOW_LOCAL_MERGE=1 scripts/merge-task.sh task/add-author-field main

set -eu

if [ "$#" -lt 1 ]; then
  echo "사용법: HARNESS_ALLOW_LOCAL_MERGE=1 scripts/merge-task.sh <branch-name> [base-branch]" >&2
  echo "예시: HARNESS_ALLOW_LOCAL_MERGE=1 scripts/merge-task.sh task/add-author-field main" >&2
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

if [ "${HARNESS_ALLOW_LOCAL_MERGE:-0}" != "1" ]; then
  echo "로컬 직접 병합은 기본적으로 금지됩니다." >&2
  echo "먼저 작업 브랜치를 push 하고 PR을 만든 뒤 scripts/merge-pr.sh 로 squash 병합하세요." >&2
  echo "정말 예외 복구가 필요할 때만 HARNESS_ALLOW_LOCAL_MERGE=1 로 실행할 수 있습니다." >&2
  exit 1
fi

git merge --no-ff "$branch_name"
echo "예외 로컬 병합 완료: $branch_name -> $base_branch"

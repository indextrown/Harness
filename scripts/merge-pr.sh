#!/usr/bin/env sh

# GitHub PR을 squash 병합하고 로컬을 main으로 정리합니다.
# 사용법: scripts/merge-pr.sh <pr-number|pr-url|branch> [base-branch]
# 예시: scripts/merge-pr.sh chore/repo-bootstrap-recovery main

set -eu

usage() {
  echo "사용법: scripts/merge-pr.sh <pr-number|pr-url|branch> [base-branch]" >&2
  echo "예시: scripts/merge-pr.sh chore/repo-bootstrap-recovery main" >&2
  exit 1
}

if [ "$#" -lt 1 ]; then
  usage
fi

target="$1"
base_branch="${2:-main}"

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI(gh)가 설치되어 있지 않습니다." >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git이 설치되어 있지 않습니다." >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "gh 로그인 상태가 아닙니다. 먼저 'gh auth login'을 실행하세요." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "현재 디렉터리는 Git 저장소가 아닙니다." >&2
  exit 1
fi

current_branch="$(git rev-parse --abbrev-ref HEAD)"

if [ "$current_branch" = "$base_branch" ]; then
  echo "현재 브랜치가 이미 베이스 브랜치입니다: $base_branch" >&2
fi

pr_title="$(gh pr view "$target" --json title --jq '.title')"
pr_number="$(gh pr view "$target" --json number --jq '.number')"
merge_subject="${pr_title} (#${pr_number})"

gh pr merge "$target" --squash --subject "$merge_subject" --delete-branch

git fetch origin "$base_branch"
git switch "$base_branch"
git pull --ff-only origin "$base_branch"

if [ "$current_branch" != "$base_branch" ]; then
  git branch -D "$current_branch" >/dev/null 2>&1 || true
fi

echo "병합 후 정리 완료: squash 병합, 원격 브랜치 삭제 요청, 로컬 main 복귀, 작업 브랜치 삭제"

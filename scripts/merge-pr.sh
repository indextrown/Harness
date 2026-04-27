#!/usr/bin/env sh

set -eu

usage() {
  echo "사용법: scripts/merge-pr.sh <pr-number|pr-url|branch> [merge|squash|rebase] [base-branch]" >&2
  echo "예시: scripts/merge-pr.sh chore/repo-bootstrap-recovery squash main" >&2
  exit 1
}

if [ "$#" -lt 1 ]; then
  usage
fi

target="$1"
merge_mode="${2:-squash}"
base_branch="${3:-main}"

case "$merge_mode" in
  merge|squash|rebase) ;;
  *)
    echo "머지 방식은 merge, squash, rebase 중 하나여야 합니다: $merge_mode" >&2
    exit 1
    ;;
esac

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

case "$merge_mode" in
  merge)
    gh pr merge "$target" --merge --delete-branch
    ;;
  squash)
    gh pr merge "$target" --squash --delete-branch
    ;;
  rebase)
    gh pr merge "$target" --rebase --delete-branch
    ;;
esac

git fetch origin "$base_branch"
git switch "$base_branch"
git pull --ff-only origin "$base_branch"

if [ "$current_branch" != "$base_branch" ]; then
  git branch -D "$current_branch" >/dev/null 2>&1 || true
fi

echo "병합 후 정리 완료: 원격 브랜치 삭제 요청, 로컬 main 복귀, 작업 브랜치 삭제"

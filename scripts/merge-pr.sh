#!/usr/bin/env sh

set -eu

usage() {
  echo "사용법: scripts/merge-pr.sh <pr-number|pr-url|branch> [merge|squash|rebase]" >&2
  echo "예시: scripts/merge-pr.sh chore/repo-bootstrap-recovery squash" >&2
  exit 1
}

if [ "$#" -lt 1 ]; then
  usage
fi

target="$1"
merge_mode="${2:-squash}"

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

if ! gh auth status >/dev/null 2>&1; then
  echo "gh 로그인 상태가 아닙니다. 먼저 'gh auth login'을 실행하세요." >&2
  exit 1
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

#!/usr/bin/env sh

set -eu

usage() {
  echo "사용법: scripts/create-pr.sh <title> [base-branch] [body-file]" >&2
  echo "예시: scripts/create-pr.sh \"chore: add repository publish recovery workflow\" main docs/templates/pr-template.md" >&2
  exit 1
}

if [ "$#" -lt 1 ]; then
  usage
fi

title="$1"
base_branch="${2:-main}"
body_file="${3:-docs/templates/pr-template.md}"

if ! command -v git >/dev/null 2>&1; then
  echo "git이 설치되어 있지 않습니다." >&2
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI(gh)가 설치되어 있지 않습니다." >&2
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
  echo "현재 브랜치가 베이스 브랜치와 같습니다: $current_branch" >&2
  echo "작업 브랜치에서 PR을 생성하세요." >&2
  exit 1
fi

if [ ! -f "$body_file" ]; then
  echo "PR 본문 파일이 없습니다: $body_file" >&2
  exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
  echo "워킹트리가 깨끗하지 않습니다. 커밋 후 PR을 생성하세요." >&2
  exit 1
fi

if ! git ls-remote --exit-code --heads origin "$current_branch" >/dev/null 2>&1; then
  echo "원격에 현재 브랜치가 없습니다. 먼저 push 하세요: $current_branch" >&2
  exit 1
fi

gh pr create --base "$base_branch" --head "$current_branch" --title "$title" --body-file "$body_file"

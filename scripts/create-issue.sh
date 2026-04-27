#!/usr/bin/env sh

set -eu

if [ "$#" -lt 2 ]; then
  echo "사용법: scripts/create-issue.sh <title> <body-file>" >&2
  echo "예시: scripts/create-issue.sh \"작성자 정보 추가\" docs/templates/issue-template.md" >&2
  exit 1
fi

title="$1"
body_file="$2"

if [ ! -f "$body_file" ]; then
  echo "이슈 본문 파일이 없습니다: $body_file" >&2
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI(gh)가 설치되어 있지 않습니다." >&2
  echo "설치 후 다시 시도하세요: https://cli.github.com/" >&2
  exit 1
fi

gh issue create --title "$title" --body-file "$body_file"

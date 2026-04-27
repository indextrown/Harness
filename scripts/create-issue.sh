#!/usr/bin/env sh

# GitHub 이슈를 생성합니다.
# 사용법: scripts/create-issue.sh <title> <body-file>
# 예시: scripts/create-issue.sh "작성자 정보 추가" docs/templates/issue-template.md

set -eu

validate_body_file() {
  file="$1"

  if rg -n \
    -e "짧고 명확한 작업 이름" \
    -e "왜 이 작업이 필요한지" \
    -e "현재 어떤 문제가 있는가" \
    -e "어떤 명령으로 확인할 것인가" \
    "$file" >/dev/null 2>&1; then
    echo "이슈 본문에 템플릿 기본 문구가 남아 있습니다. 실제 내용으로 바꿔주세요: $file" >&2
    exit 1
  fi
}

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

validate_body_file "$body_file"

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI(gh)가 설치되어 있지 않습니다." >&2
  echo "설치 후 다시 시도하세요: https://cli.github.com/" >&2
  exit 1
fi

gh issue create --title "$title" --body-file "$body_file"

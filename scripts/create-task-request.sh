#!/usr/bin/env sh

set -eu

if [ "$#" -lt 2 ]; then
  echo "사용법: scripts/create-task-request.sh <YYYY-MM-DD> <slug>" >&2
  echo "예시: scripts/create-task-request.sh 2026-04-28 add-author-field" >&2
  exit 1
fi

date_part="$1"
slug="$2"
target="docs/task-requests/active/${date_part}-${slug}.md"
template="docs/templates/task-request-template.md"

if [ -e "$target" ]; then
  echo "이미 존재합니다: $target" >&2
  exit 1
fi

if [ ! -f "$template" ]; then
  echo "템플릿이 없습니다: $template" >&2
  exit 1
fi

cp "$template" "$target"
echo "생성 완료: $target"

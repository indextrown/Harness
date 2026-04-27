#!/usr/bin/env sh

set -eu

if [ "$#" -lt 1 ]; then
  echo "사용법: scripts/complete-plan.sh <active-plan-path>" >&2
  echo "예시: scripts/complete-plan.sh docs/exec-plans/active/2026-04-28-add-author-field.md" >&2
  exit 1
fi

source_path="$1"

case "$source_path" in
  docs/exec-plans/active/*) ;;
  *)
    echo "active 계획 파일 경로만 받을 수 있습니다: $source_path" >&2
    exit 1
    ;;
esac

if [ ! -f "$source_path" ]; then
  echo "계획 파일이 없습니다: $source_path" >&2
  exit 1
fi

filename="$(basename "$source_path")"
target_path="docs/exec-plans/completed/$filename"

if [ -e "$target_path" ]; then
  echo "이미 completed에 같은 파일이 있습니다: $target_path" >&2
  exit 1
fi

mv "$source_path" "$target_path"
echo "이동 완료: $target_path"

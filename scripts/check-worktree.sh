#!/usr/bin/env sh

# 작업 브랜치/워크트리 사용 여부를 검사합니다.
# 사용법: scripts/check-worktree.sh
# 예시: scripts/check-worktree.sh

set -eu

if ! command -v git >/dev/null 2>&1; then
  echo "git이 설치되어 있지 않습니다." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "현재 디렉터리는 Git 저장소가 아닙니다." >&2
  echo "먼저 git init 또는 기존 저장소 연결이 필요합니다." >&2
  exit 1
fi

branch_name="$(git rev-parse --abbrev-ref HEAD)"

if [ "$branch_name" = "main" ] || [ "$branch_name" = "master" ]; then
  echo "경고: 현재 브랜치가 $branch_name 입니다." >&2
  echo "권장 흐름은 메인 브랜치 직접 수정 대신 워크트리 또는 작업 브랜치 사용입니다." >&2
  exit 1
fi

echo "작업 브랜치 확인 완료: $branch_name"

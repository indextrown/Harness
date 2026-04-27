#!/usr/bin/env sh

set -eu

echo "[verify] 하네스 기본 검증 시작"

if [ ! -f "AGENTS.md" ]; then
  echo "[verify] 실패: AGENTS.md가 없습니다." >&2
  exit 1
fi

if [ ! -d "docs/exec-plans/active" ]; then
  echo "[verify] 실패: docs/exec-plans/active 디렉터리가 없습니다." >&2
  exit 1
fi

if [ ! -d "logs" ]; then
  echo "[verify] 실패: logs 디렉터리가 없습니다." >&2
  exit 1
fi

echo "[verify] 저장소 기본 구조 확인 완료"
echo "[verify] 주의: 실제 앱 검증 명령은 아직 비어 있습니다."
echo "[verify] 프로젝트 코드가 추가되면 린트, 테스트, 빌드 명령을 이 스크립트에 채워 넣으세요."

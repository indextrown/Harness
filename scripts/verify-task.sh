#!/usr/bin/env sh

# 하네스 저장소 기본 구조와 검증 전제 조건을 확인합니다.
# 사용법: scripts/verify-task.sh
# 예시: scripts/verify-task.sh

set -eu

. "$(dirname "$0")/log-session.sh"

harness_log_init_current_branch
log_file="$(harness_log_file_for_current_branch 2>/dev/null || true)"

log_info() {
  printf '%s\n' "$1"
  if [ -n "${log_file:-}" ]; then
    printf '%s %s\n' "$(date '+%F %T')" "$1" >>"$log_file"
  fi
}

log_error() {
  printf '%s\n' "$1" >&2
  if [ -n "${log_file:-}" ]; then
    printf '%s %s\n' "$(date '+%F %T')" "$1" >>"$log_file"
  fi
}

log_info "[verify] 하네스 기본 검증 시작"

if [ ! -f "AGENTS.md" ]; then
  log_error "[verify] 실패: AGENTS.md가 없습니다."
  exit 1
fi

if [ ! -d "docs/exec-plans/active" ]; then
  log_error "[verify] 실패: docs/exec-plans/active 디렉터리가 없습니다."
  exit 1
fi

if [ ! -d "logs" ]; then
  log_error "[verify] 실패: logs 디렉터리가 없습니다."
  exit 1
fi

log_info "[verify] 저장소 기본 구조 확인 완료"
log_info "[verify] 주의: 실제 앱 검증 명령은 아직 비어 있습니다."
log_info "[verify] 프로젝트 코드가 추가되면 린트, 테스트, 빌드 명령을 이 스크립트에 채워 넣으세요."

if [ -n "${log_file:-}" ]; then
  log_info "[verify] 로그 세션 파일: $log_file"
fi

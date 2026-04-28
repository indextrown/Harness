#!/usr/bin/env sh

# 작업 브랜치 기준 로그 세션 파일을 만들고 찾는 공용 함수입니다.
# 사용법: . "$(dirname "$0")/log-session.sh"
# 예시: harness_log_init_current_branch && log_file="$(harness_log_file_for_current_branch)"

set -eu

harness_log_repo_root() {
  git rev-parse --show-toplevel
}

harness_log_safe_name() {
  printf '%s' "$1" | tr '/ ' '--' | tr -cd 'A-Za-z0-9._-'
}

harness_log_session_dir() {
  printf '%s/logs/.sessions' "$(harness_log_repo_root)"
}

harness_log_branch_file() {
  branch_name="$1"
  safe_name="$(harness_log_safe_name "$branch_name")"
  printf '%s/%s.path' "$(harness_log_session_dir)" "$safe_name"
}

harness_log_session_path_for_branch() {
  branch_name="$1"
  branch_file="$(harness_log_branch_file "$branch_name")"

  if [ ! -f "$branch_file" ]; then
    return 1
  fi

  cat "$branch_file"
}

harness_log_init_current_branch() {
  repo_root="$(harness_log_repo_root)"
  branch_name="$(git rev-parse --abbrev-ref HEAD)"

  mkdir -p "$repo_root/logs" "$(harness_log_session_dir)"

  if [ "$branch_name" = "main" ] || [ "$branch_name" = "master" ]; then
    return 0
  fi

  branch_file="$(harness_log_branch_file "$branch_name")"

  if [ -f "$branch_file" ]; then
    return 0
  fi

  safe_name="$(harness_log_safe_name "$branch_name")"
  session_path="$repo_root/logs/$(date +%F)-${safe_name}-session.log"

  : >"$session_path"
  printf '%s\n' "$session_path" >"$branch_file"
}

harness_log_file_for_current_branch() {
  branch_name="$(git rev-parse --abbrev-ref HEAD)"

  if [ "$branch_name" = "main" ] || [ "$branch_name" = "master" ]; then
    return 1
  fi

  harness_log_init_current_branch
  harness_log_session_path_for_branch "$branch_name"
}

harness_log_append() {
  message="$1"
  if ! log_file="$(harness_log_file_for_current_branch 2>/dev/null)"; then
    return 0
  fi

  printf '%s %s\n' "$(date '+%F %T')" "$message" >>"$log_file"
}

harness_log_remove_branch_session() {
  branch_name="$1"
  branch_file="$(harness_log_branch_file "$branch_name")"

  if [ -f "$branch_file" ]; then
    rm -f "$branch_file"
  fi
}

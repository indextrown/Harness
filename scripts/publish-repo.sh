#!/usr/bin/env sh

# 로컬 저장소를 GitHub 레포로 퍼블리시하거나 복구합니다.
# 사용법: scripts/publish-repo.sh <owner/repo|repo> [private|public]
# 예시: scripts/publish-repo.sh indextrown/Harness private

set -eu

usage() {
  echo "사용법: scripts/publish-repo.sh <owner/repo|repo> [private|public]" >&2
  echo "예시: scripts/publish-repo.sh indextrown/Harness private" >&2
  exit 1
}

if [ "$#" -lt 1 ]; then
  usage
fi

repo_input="$1"
visibility="${2:-private}"

case "$visibility" in
  private|public) ;;
  *)
    echo "공개 범위는 private 또는 public 이어야 합니다: $visibility" >&2
    exit 1
    ;;
esac

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
  git init -b main
fi

if [ -x "scripts/install-hooks.sh" ]; then
  scripts/install-hooks.sh >/dev/null
fi

mkdir -p project

if [ ! -f "project/README.md" ]; then
  cat > project/README.md <<'EOF'
# Project

실제 앱과 기능 코드는 이 디렉터리 하위에 구현합니다.
EOF
fi

current_branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || true)"
if [ -z "$current_branch" ]; then
  git checkout -b main >/dev/null 2>&1 || true
  current_branch="main"
fi

if ! git rev-parse HEAD >/dev/null 2>&1; then
  git add .
  git commit --no-verify -m "chore: bootstrap codex harness"
fi

case "$repo_input" in
  */*)
    owner_repo="$repo_input"
    ;;
  *)
    owner="$(gh api user --jq .login)"
    owner_repo="$owner/$repo_input"
    ;;
esac

if gh repo view "$owner_repo" >/dev/null 2>&1; then
  remote_url="https://github.com/$owner_repo.git"
  if git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "$remote_url"
  else
    git remote add origin "$remote_url"
  fi
  git push -u origin "$current_branch"
  echo "퍼블리시 완료: https://github.com/$owner_repo"
  exit 0
fi

gh repo create "$owner_repo" "--$visibility" --source=. --remote=origin --push

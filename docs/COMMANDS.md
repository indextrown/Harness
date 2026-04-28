# Commands

이 문서는 하네스 워크플로를 명령어 수준으로 정리합니다.

## 핵심 생각

좋은 하네스는 규칙을 문서에만 두지 않습니다.

- 이슈 생성
- 계획 생성
- 격리 작업 공간 생성
- 검증 실행
- PR 생성
- PR 병합
- 로컬 병합
- 저장소 퍼블리시 및 복구

위 흐름을 명령으로 고정해 두면, 에이전트와 사람이 같은 루틴을 따르기 쉬워집니다.

## 권장 순서

1. 이슈 생성
2. 작업 요청서 생성
3. 계획 생성
4. 워크트리 생성
5. 구현 및 검증
6. 사용자가 요청한 경우에만 원격 푸시
7. 원격 푸시가 이미 된 경우 특별한 이유가 없으면 PR 생성
8. 사용자가 요청한 경우에만 PR 병합 또는 로컬 병합
9. 계획 완료 처리
10. 작업 요청서 완료 처리
11. 저장소 퍼블리시 또는 복구

## `merge해` 요청 해석

사용자가 `merge해`라고 명시적으로 요청하면, 하네스는 다음을 한 흐름으로 봅니다.

1. 필요하면 커밋
2. 아직 병합되지 않은 브랜치 병합
3. 이미 병합된 브랜치 정리
4. 예외적으로 `main` 직접 커밋이면 원격 push
5. 필요하면 PR 생성과 PR 병합
6. 브랜치 정리와 `main` 복귀

즉 `merge해`는 단순 병합 명령이 아니라, 병합/정리/예외 처리까지 포함한 상위 요청으로 취급합니다.

## 명령 목록

### 이슈 생성

```bash
scripts/create-issue.sh "작성자 정보 추가" docs/templates/issue-template.md
```

설명:

- GitHub CLI `gh`가 설치되어 있어야 합니다.
- 본문은 템플릿 파일이나 별도 마크다운 파일로 넘깁니다.
- 템플릿 기본 문구가 그대로 남아 있으면 생성이 실패합니다.

### 계획 생성

```bash
scripts/create-plan.sh 2026-04-28 add-author-field
```

설명:

- `docs/exec-plans/active/` 아래에 실행 계획 파일을 만듭니다.

### 작업 요청서 생성

```bash
scripts/create-task-request.sh 2026-04-28 add-author-field
```

설명:

- `docs/task-requests/active/` 아래에 작업 요청서 파일을 만듭니다.
- 실행 계획보다 먼저 `무엇을 왜 하는지`를 고정하는 용도입니다.

### 워크트리 생성

```bash
scripts/create-worktree.sh task/add-author-field ../Harness-add-author-field
```

설명:

- 메인 작업 공간이 아닌 별도 작업 공간을 만듭니다.
- 현재 저장소가 Git 저장소여야 합니다.

### 작업 브랜치 확인

```bash
scripts/check-worktree.sh
```

설명:

- `main` 또는 `master`에서 직접 작업하는 흐름을 막기 위한 기본 체크입니다.

### 기본 검증

```bash
scripts/verify-task.sh
```

설명:

- 현재는 하네스 저장소 기본 구조만 점검합니다.
- 작업 브랜치에서는 `scripts/log-session.sh`를 통해 `logs/` 아래 세션 로그 파일도 함께 남깁니다.
- 앱 코드가 생기면 린트, 테스트, 빌드 명령을 여기에 추가합니다.

### PR 생성

```bash
scripts/create-pr.sh "chore: add repository publish recovery workflow" main docs/templates/pr-template.md
```

설명:

- 작업 브랜치에서만 실행합니다.
- 워킹트리가 깨끗해야 합니다.
- 현재 브랜치가 원격에 push 되어 있어야 합니다.
- 기본 PR 본문 템플릿은 `docs/templates/pr-template.md`입니다.
- 템플릿 기본 문구가 그대로 남아 있으면 생성이 실패합니다.
- 원격 push 자체는 사용자가 명시적으로 요청했을 때만 수행합니다.
- 작업 브랜치에서 커밋이 끝났고 원격 푸시도 이미 되어 있다면, 특별한 이유가 없는 한 여기까지 이어가는 것을 기본 흐름으로 봅니다.

### PR 병합

```bash
scripts/merge-pr.sh chore/repo-bootstrap-recovery squash main
```

설명:

- GitHub PR을 `merge`, `squash`, `rebase` 중 하나로 병합합니다.
- 기본값은 `squash`입니다.
- 병합 후 원격 브랜치를 삭제합니다.
- 이어서 로컬에서 `main`으로 자동 이동합니다.
- 기존 작업 브랜치는 로컬에서도 자동 삭제합니다.
- 단, 이 명령은 사용자가 명시적으로 `merge`를 요청했을 때만 실행합니다.
- 사용자가 `merge해`라고 요청했다면, 아직 병합되지 않은 브랜치 병합과 병합 완료 브랜치 정리도 함께 처리할 수 있습니다.
- 필요하면 커밋, push, PR 생성까지 같은 흐름에서 함께 처리할 수 있습니다.

### 로컬 병합

```bash
scripts/merge-task.sh task/add-author-field main
```

설명:

- 베이스 브랜치에서 실행해야 합니다.
- 기본값은 `main`입니다.

### 계획 완료 처리

```bash
scripts/complete-plan.sh docs/exec-plans/active/2026-04-28-add-author-field.md
```

설명:

- 활성 계획 파일을 `completed/`로 이동합니다.
- 완료 후 이력 보존과 재사용을 쉽게 만듭니다.

### 작업 요청서 완료 처리

```bash
scripts/complete-task-request.sh docs/task-requests/active/2026-04-28-add-author-field.md
```

설명:

- 활성 작업 요청서를 `completed/`로 이동합니다.
- 작업 목표와 배경 이력을 보존합니다.

### 훅 설치

```bash
scripts/install-hooks.sh
```

설명:

- `.githooks/` 아래 기본 훅을 Git에 연결합니다.
- 현재는 `pre-commit`에서 메인 브랜치 작업과 기본 검증을 막는 골격입니다.

### 저장소 퍼블리시 또는 복구

```bash
scripts/publish-repo.sh indextrown/Harness private
```

설명:

- 로컬 Git 초기화, 훅 설치, 첫 커밋, GitHub 레포 생성, 원격 설정, 푸시를 한 번에 처리합니다.
- 원격 레포가 삭제된 경우에도 같은 명령으로 다시 만들 수 있습니다.
- 자세한 설명은 `docs/REPOSITORY_BOOTSTRAP.md`를 읽습니다.

## 나중에 추가할 만한 명령

- 커밋 메시지 규칙 검사
- 스크린샷과 로그 아카이브 스크립트

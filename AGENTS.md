# AGENTS.md

이 저장소는 Codex 중심의 에이전트 우선 엔지니어링을 위해 구성됩니다.

변경을 시작하기 전에 여기서 시작하세요.

1. 저장소 목적과 운영 방식을 이해하려면 `README.md`를 읽습니다.
2. 저장소의 상위 구조를 파악하려면 `docs/ARCHITECTURE.md`를 읽습니다.
3. 현재 진행할 작업이 있다면 먼저 `docs/task-requests/active/` 아래 작업 요청서를 확인합니다.
4. 작업 요청서 운영 방식과 실행 계획 운영 방식은 `docs/TASK_REQUESTS.md`와 `docs/PLANS.md`를 읽습니다.
5. 프롬프트, 컨텍스트, 하네스의 역할 차이는 `docs/PROMPT_CONTEXT_HARNESS.md`를 읽습니다.
6. 긴 작업에서 컨텍스트를 어떻게 다룰지 이해하려면 `docs/CONTEXT_ENGINEERING.md`를 읽습니다.
7. 작업 형태에 맞는 팀 구조를 고르려면 `docs/TEAM_ARCHITECTURES.md`를 읽습니다.
8. 작업을 어떻게 검증할지 정하려면 `docs/EVALS_OBSERVABILITY.md`를 읽습니다.
9. 메인 대신 워크트리에서 작업하는 규칙은 `docs/WORKTREE_WORKFLOW.md`를 읽습니다.
10. 말이 아니라 장치로 강제하는 규칙은 `docs/VERIFY_AND_GUARDRAILS.md`를 읽습니다.
11. 로그와 실행 흔적을 어떻게 남길지는 `docs/VISIBILITY_AND_LOGS.md`를 읽습니다.
12. 실제 작업 명령은 `docs/COMMANDS.md`를 읽습니다.
13. 저장소 퍼블리시와 복구 절차는 `docs/REPOSITORY_BOOTSTRAP.md`를 읽습니다.
14. 작업이 구현 품질에 영향을 준다면 다음 문서를 확인합니다.
   - `docs/QUALITY_SCORE.md`
   - `docs/RELIABILITY.md`
   - `docs/SECURITY.md`
15. 작업이 제품 동작에 영향을 준다면 다음 문서를 확인합니다.
   - `docs/PRODUCT_SENSE.md`
   - `docs/product-specs/index.md`
16. 작업이 디자인이나 상호작용 패턴을 바꾼다면 다음 문서를 확인합니다.
   - `docs/DESIGN.md`
   - `docs/FRONTEND.md`

문서 목차:

- `docs/ARCHITECTURE.md`: 저장소 구조와 문서 아키텍처
- `docs/COMMANDS.md`: 이슈, 요청서, 계획, 워크트리, 검증, 병합 명령
- `docs/CONTEXT_ENGINEERING.md`: 긴 작업에서 컨텍스트를 다루는 규칙
- `docs/DESIGN.md`: 디자인 원칙과 시각 규칙
- `docs/EVALS_OBSERVABILITY.md`: 평가, 검증, 관측 설계
- `docs/FRONTEND.md`: 프론트엔드 구현 및 검증 가이드
- `docs/HARNESS_EVOLUTION.md`: 하네스 진화와 되먹임 규칙
- `docs/HARNESS_FACTORY.md`: 이 저장소의 하네스 포지셔닝
- `docs/PLANS.md`: 실행 계획 운영 방식
- `docs/PRODUCT_SENSE.md`: 제품 의도와 사용자 관점
- `docs/PROMPT_CONTEXT_HARNESS.md`: 프롬프트, 컨텍스트, 하네스의 차이
- `docs/QUALITY_SCORE.md`: 품질 기준과 검증 신호
- `docs/REPOSITORY_BOOTSTRAP.md`: Git 및 GitHub 퍼블리시, 복구 절차
- `docs/REFERENCES.md`: 외부 참고 자료 인덱스
- `docs/RELIABILITY.md`: 신뢰성 요구사항
- `docs/SECURITY.md`: 보안 기대사항
- `docs/TASK_REQUESTS.md`: 작업 요청서 운영 방식
- `docs/TEAM_ARCHITECTURES.md`: 팀 구조 패턴 선택 가이드
- `docs/VERIFY_AND_GUARDRAILS.md`: 강제 가능한 규칙과 가드레일
- `docs/VISIBILITY_AND_LOGS.md`: 로그, 스크린샷, 검증 흔적 규약
- `docs/WORKTREE_WORKFLOW.md`: 메인 대신 격리 작업 공간에서 일하는 방식
- `docs/design-docs/index.md`: 설계 문서 인덱스
- `docs/design-docs/core-beliefs.md`: 하네스 핵심 신념
- `docs/product-specs/index.md`: 제품 명세 인덱스
- `docs/templates/issue-template.md`: 이슈 본문 템플릿
- `docs/templates/pr-template.md`: PR 본문 템플릿
- `docs/templates/review-response-template.md`: 리뷰 응답 메모 템플릿
- `docs/templates/spec-template.md`: 제품 또는 기능 명세 템플릿
- `docs/templates/task-brief-template.md`: 역할별 작업 브리프 템플릿
- `docs/templates/task-request-template.md`: 작업 요청서 템플릿
- `docs/templates/verification-checklist-template.md`: 검증 체크리스트 템플릿

핵심 규칙:

- 이 파일은 백과사전이 아니라 지도처럼 유지합니다.
- 하네스 엔지니어링 관련 문서, 명령, 스크립트, 훅 구조를 바꿨다면 `AGENTS.md`도 같은 변경 안에서 반드시 함께 갱신합니다.
- 숨겨진 맥락보다 작고 링크 가능하며 버전 관리되는 마크다운 아티팩트를 우선합니다.
- 구현 파일은 루트에 흩뿌리지 말고, 명시된 개발 디렉터리 하위에만 추가합니다.
- 중요한 결정은 `docs/exec-plans/` 또는 `docs/design-docs/`에 남깁니다.
- 작은 변경의 계획은 짧게, 큰 변경의 계획은 명시적으로 작성합니다.
- 하네스 규칙은 프롬프트에만 두지 말고 문서, 템플릿, 스크립트, 체크리스트로 끌어내립니다.
- 메인 브랜치나 메인 작업 디렉터리에서 바로 고치는 흐름보다 격리된 작업 공간을 선호합니다.
- 모든 작업 이후 저장소가 다음 에이전트에게 더 읽기 쉬워지도록 합니다.
- 이슈와 PR은 템플릿 기본 문구를 그대로 두지 말고, 실제 문제, 실제 변경 내용, 실제 검증 결과를 구체적으로 적습니다.

구현 위치 규칙:

- 이 저장소의 공식 구현 루트는 `project/`입니다.
- 새 개발 파일은 `project/` 하위에만 추가합니다.
- 루트에는 문서, 설정, 하네스 파일만 두고 기능 코드는 두지 않습니다.

계획 규칙:

- 작은 작업: 코드를 수정하고 PR 또는 커밋 맥락에 짧은 메모를 남깁니다.
- 중간 이상 작업: 가능하면 먼저 `docs/task-requests/active/`에 작업 요청서를 만듭니다.
- 중간 규모 작업: `docs/exec-plans/active/`에 실행 계획을 만들거나 갱신합니다.
- 큰 작업 또는 모호한 작업: 먼저 실행 계획을 작성한 뒤 구현합니다.
- 작업 완료 후 계획 파일은 가능하면 `docs/exec-plans/completed/`로 옮깁니다.
- 작업 요청서도 완료 후 가능하면 `docs/task-requests/completed/`로 옮깁니다.

권장 작업 순서:

1. 필요하면 이슈를 만듭니다.
2. 중간 이상 작업이면 작업 요청서를 만듭니다.
3. 실행 계획을 만듭니다.
4. 가능하면 메인 대신 워크트리 또는 작업 브랜치를 준비합니다.
5. 구현 전에 검증 기준과 로그 산출물을 정합니다.
6. 구현 후 `scripts/verify-task.sh` 같은 검증 명령을 실행합니다.
7. 원격 `push`는 사용자가 명시적으로 요청했을 때만 진행합니다.
8. 작업 브랜치에서 커밋이 끝났고 원격 푸시도 이미 되어 있다면, 특별한 이유가 없는 한 PR 생성까지 이어갑니다.
9. `merge`는 사용자가 명시적으로 요청했을 때만 진행합니다.
10. PR 병합 후 원격 및 로컬 작업 브랜치를 정리하고 항상 `main`으로 돌아옵니다.
11. 병합 후 계획 파일과 작업 요청서를 완료 상태로 정리합니다.

`merge해` 요청 해석 규칙:

- 사용자가 `merge해`라고 하면 단순 병합만이 아니라 필요한 선행 단계를 함께 점검합니다.
- 아직 커밋되지 않은 변경이 있으면 먼저 커밋합니다.
- 원격 푸시가 안 되어 있으면 push 합니다.
- PR이 없으면 PR을 생성합니다.
- 그 다음 PR 병합까지 이어갑니다.
- 병합 후에는 원격/로컬 작업 브랜치를 정리하고 `main`으로 돌아옵니다.

권장 명령:

- 계획 생성: `scripts/create-plan.sh <date> <slug>`
- 작업 요청서 생성: `scripts/create-task-request.sh <date> <slug>`
- 워크트리 생성: `scripts/create-worktree.sh <branch> <path>`
- 작업 브랜치 확인: `scripts/check-worktree.sh`
- 기본 검증: `scripts/verify-task.sh`
- 로그 세션 공용 함수: `scripts/log-session.sh`
- PR 생성: `scripts/create-pr.sh <title> [base-branch] [body-file]`
- PR 병합: `scripts/merge-pr.sh <pr-number|pr-url|branch> [merge|squash|rebase] [base-branch]`
- 계획 완료 처리: `scripts/complete-plan.sh <active-plan-path>`
- 작업 요청서 완료 처리: `scripts/complete-task-request.sh <active-task-request-path>`
- 훅 설치: `scripts/install-hooks.sh`
- 저장소 퍼블리시 또는 복구: `scripts/publish-repo.sh <owner/repo|repo> [private|public]`
이슈 및 PR 작성 규칙:

- 이슈에는 현재 문제, 기대 결과, 제약, 검증 방법을 실제 맥락 기준으로 적습니다.
- PR에는 왜 바뀌는지, 무엇이 바뀌는지, 어떻게 검증했는지를 실제 실행 결과 기준으로 적습니다.
- 템플릿 예시 문구를 그대로 둔 상태로 이슈나 PR을 만들지 않습니다.
브랜치 정리 규칙:

- 원격 `push`는 사용자가 명시적으로 요청했을 때만 수행합니다.
- 작업 브랜치에서 커밋이 끝나고 원격 푸시까지 되어 있다면 특별한 이유가 없는 한 PR 생성까지 진행합니다.
- `merge`는 사용자가 명시적으로 요청했을 때만 수행합니다.
- 사용자가 `merge해`라고 요청했다면 아직 병합되지 않은 브랜치를 먼저 병합합니다.
- 이미 병합이 끝난 브랜치는 로컬과 원격에서 가능하면 항상 정리합니다.
- 예외적으로 실수로 `main` 브랜치에서 직접 커밋한 경우에는 그 변경을 되돌리기보다 `main`을 푸시해 반영합니다.
- 필요하면 커밋, push, PR 생성, PR 병합까지 한 흐름으로 진행합니다.
- PR 병합이 끝나면 원격 작업 브랜치는 삭제합니다.
- 로컬 작업 브랜치도 삭제합니다.
- 병합 후 로컬 작업 위치는 항상 `main` 브랜치로 되돌립니다.
- 다음 작업은 새 브랜치 또는 워크트리에서 다시 시작합니다.

문서화 규칙:

- 하네스 엔지니어링 업데이트가 있었다면 `AGENTS.md`를 먼저 확인하고 최신 구조에 맞게 갱신합니다.
- 동작, 아키텍처, 운영 가정이 바뀌면 문서를 갱신합니다.
- 검증 스크립트가 로그를 남기도록 바뀌면 `logs/` 위치와 파일 규칙 문서도 함께 갱신합니다.
- 같은 내용을 반복 복제하기보다 색인과 교차 링크를 선호합니다.
- 오래된 문서는 상충하는 새 문서를 덧씌우지 말고 기존 문서를 직접 갱신합니다.
- 외부에서 반복해서 참고하는 자료는 `docs/REFERENCES.md`에 정리합니다.

완료의 정의:

- 변경 사항이 동작합니다.
- 변경 사항을 검증할 수 있습니다.
- 저장소가 무엇을 왜 이렇게 만들었는지 계속 설명할 수 있습니다.
- 이번 실행에서 얻은 교훈이 다음 실행에도 재사용될 수 있습니다.

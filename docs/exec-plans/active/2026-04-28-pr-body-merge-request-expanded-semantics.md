# 요약

`merge해` 요청을 단순 병합이 아니라 필요 시 커밋, push, PR 생성, PR 병합, 브랜치 정리까지 포함하는 상위 요청으로 해석하도록 하네스 규칙을 정리합니다.

## 배경

기존에는 `push`와 `merge`를 별도 명령으로 다뤘지만, 사용자가 `merge해`라고 했을 때 어디까지 자동으로 이어갈지 해석이 분명하지 않았습니다. 이 PR은 그 해석을 `AGENTS.md`와 명령 문서에 명시해 이후 작업 흐름을 일관되게 만듭니다.

## 변경 내용

- `AGENTS.md`에 `merge해` 요청 해석 규칙을 추가했습니다.
- `docs/COMMANDS.md`에 `merge해`가 포함하는 단계와 기본 흐름을 추가했습니다.
- 관련 실행 계획 문서 `2026-04-28-merge-request-expanded-semantics.md`를 추가했습니다.

## 검증

- [x] `scripts/verify-task.sh` 실행
- [x] 하네스 기본 구조 검증 통과 확인
- [x] `AGENTS.md`와 `docs/COMMANDS.md`에서 `merge해` 해석 규칙이 읽히는지 수동 확인

## 참고 문서

- 작업 요청서: 없음
- 실행 계획: `docs/exec-plans/active/2026-04-28-merge-request-expanded-semantics.md`
- 관련 이슈: 없음

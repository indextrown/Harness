# Implementation Directory Rule

## 문제

실제 개발이 시작되면 에이전트가 루트에 코드 파일을 흩뿌릴 위험이 있다.

## 제약 조건

- 아직 이 저장소에는 앱 코드가 없다.
- 구현 루트는 `project/`로 고정한다.
- 진입 문서와 아키텍처 문서 모두 같은 원칙을 가져야 한다.

## 제안하는 접근 방식

1. `AGENTS.md`에 구현 위치 규칙을 추가한다.
2. `README.md`에 개발 파일 배치 원칙을 추가한다.
3. `docs/ARCHITECTURE.md`에 구현 루트 결정 항목을 추가한다.
4. `docs/QUALITY_SCORE.md`에 구조 일관성 신호로 반영한다.

## 검증

- `AGENTS.md`만 읽어도 구현 파일을 어디에 둘지 알 수 있어야 한다.
- `README.md`와 `ARCHITECTURE.md`가 같은 원칙을 설명해야 한다.
- 현재 코드가 없는 상태와도 충돌하지 않아야 한다.

## 의사결정 로그

- 2026-04-28: 기능 코드는 루트에 두지 않고 `project/` 하위에 두는 원칙을 추가하기로 했다.

## 진행 상황

- [x] `AGENTS.md` 반영
- [x] `README.md` 반영
- [x] `ARCHITECTURE.md` 반영
- [x] `QUALITY_SCORE.md` 반영

# Architecture

이 저장소는 하네스 우선 스캐폴드로 시작합니다.

## 최상위 지도

- `AGENTS.md`: 에이전트 진입점
- `README.md`: 저장소 목적 설명
- `docs/`: 오래 유지되는 맥락

## 문서 아키텍처

현재 `docs/`는 아래 성격으로 나뉩니다.

- 운영 지도: `PLANS.md`, `CONTEXT_ENGINEERING.md`, `TEAM_ARCHITECTURES.md`
- 품질 운영: `QUALITY_SCORE.md`, `RELIABILITY.md`, `SECURITY.md`, `EVALS_OBSERVABILITY.md`
- 제품 및 경험: `PRODUCT_SENSE.md`, `DESIGN.md`, `FRONTEND.md`, `product-specs/`
- 장기 기억: `design-docs/`, `REFERENCES.md`, `HARNESS_EVOLUTION.md`
- 반복 실행 도구: `templates/`, `exec-plans/`

## 의도한 진화 방향

제품 코드가 추가될수록 저장소는 계속 탐색하기 쉬워야 합니다.

- 구현 파일은 `project/` 하위에 배치합니다.
- 소스 코드는 도메인 또는 패키지 기준으로 묶습니다.
- 경계를 명시적으로 드러냅니다.
- 허용되는 의존 방향을 문서화합니다.
- 영리하지만 숨겨진 동작보다 안정적인 추상화를 선호합니다.

## 아키텍처 가이드

구현 디렉터리가 생기면 다음을 추가합니다.

- 구현 루트 디렉터리 결정: `project/`
- 도메인 지도
- 허용되는 의존 방향
- 중요한 런타임 경계
- 경계를 검증하는 훅 또는 체크

어떤 규칙이 반복해서 중요해진다면, 설명 문서에서 끝내지 말고 툴링으로 옮깁니다.

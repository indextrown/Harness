# References

이 문서는 이 저장소가 참고하는 외부 하네스 엔지니어링 자료를 정리합니다.

## 핵심 참고 저장소

### walkinglabs/awesome-harness-engineering

이 저장소는 하네스 엔지니어링을 다음 축으로 분류하는 참조 카탈로그입니다.

원문:

- https://github.com/walkinglabs/awesome-harness-engineering
- https://raw.githubusercontent.com/walkinglabs/awesome-harness-engineering/main/README.md

- Foundations
- Context, Memory and Working State
- Constraints, Guardrails and Safe Autonomy
- Specs, Agent Files and Workflow Design
- Evals and Observability
- Benchmarks
- Runtimes, Harnesses and Reference Implementations

이 저장소에 준 영향:

- 하네스를 단일 프롬프트가 아니라 여러 운영 축의 결합으로 본다.
- 컨텍스트 관리, 가드레일, 평가, 관측을 별도 문서로 분리한다.
- 장기 작업의 신뢰성은 모델보다 환경 설계에 크게 좌우된다는 관점을 채택한다.

### revfactory/harness

이 저장소는 Claude Code용 팀 아키텍처 팩토리입니다.

원문:

- https://github.com/revfactory/harness/blob/main/README_KO.md
- https://raw.githubusercontent.com/revfactory/harness/main/README_KO.md

특히 다음 아이디어를 참고했습니다.

- 6가지 팀 아키텍처 패턴
- 스킬과 오케스트레이션을 통한 역할 분리
- 검증 체계를 하네스의 핵심 기능으로 포함
- 하네스 진화 메커니즘으로 다음 실행을 개선

이 저장소에 준 영향:

- `docs/TEAM_ARCHITECTURES.md`의 패턴 분류
- `docs/HARNESS_EVOLUTION.md`의 진화 루프
- 템플릿 중심의 반복 가능한 작업 구조

## 함께 읽으면 좋은 자료

- OpenAI, `Harness engineering: leveraging Codex in an agent-first world`
- Anthropic, `Effective harnesses for long-running agents`
- Anthropic, `Effective context engineering for AI agents`
- OpenAI, `Testing Agent Skills Systematically with Evals`
- OpenAI, `Agent evals`

## 반영한 영상 포인트

사용자가 제공한 한국어 영상 요약에서 특히 다음 포인트를 이 저장소에 반영했습니다.

- 프롬프트 엔지니어링, 컨텍스트 엔지니어링, 하네스 엔지니어링의 역할 분리
- 큰 지시문 하나 대신 목차형 진입점과 점진적 공개
- 로그, 스크린샷, 실행 흔적을 통한 가시성 확보
- 말로만 금지하지 않고 스크립트, 훅, 검증 명령으로 강제
- 메인에서 바로 작업하지 않고 워크트리에서 격리 실행
- 계획 없이 구현하지 않는 흐름

## 이 저장소의 해석

이 저장소는 외부 모델 또는 런타임 전용 구현체가 아니라, Codex가 로컬 저장소에서 안정적으로 일하기 위한 하네스 스캐폴드입니다. 따라서 외부 저장소의 개념을 그대로 복제하기보다 다음처럼 번역합니다.

- 플러그인 구조 대신 저장소 문서 구조
- 전용 스킬 런타임 대신 템플릿과 체크리스트
- 팀 생성기 대신 패턴 선택 가이드
- 실험 결과 수치 인용보다 내부 재현 가능한 검증 루프 강조

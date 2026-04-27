# Repository Bootstrap and Recovery

이 문서는 저장소를 Git과 GitHub에 다시 연결하거나, 원격 레포가 삭제된 뒤 다시 만드는 절차를 설명합니다.

## 왜 필요한가

- 로컬 하네스 저장소는 남아 있는데 GitHub 원격이 삭제될 수 있습니다.
- 새 환경에서 이 하네스를 다시 Git 저장소로 만들 수도 있습니다.
- 이런 작업은 사람 기억에 맡기기보다 스크립트로 재실행 가능해야 합니다.

## 기본 명령

```bash
scripts/publish-repo.sh indextrown/Harness private
```

이 명령은 다음을 처리합니다.

1. 로컬 Git 저장소가 없으면 `git init -b main`
2. 훅 설치
3. `project/README.md` 같은 최소 구현 루트 보장
4. 첫 커밋이 없으면 초기 커밋 생성
5. GitHub 레포가 없으면 생성
6. 원격 `origin` 설정 또는 갱신
7. 현재 브랜치 푸시

## 복구 시나리오

### 1. GitHub 레포가 삭제된 경우

같은 이름으로 다시 만들고 싶다면:

```bash
scripts/publish-repo.sh indextrown/Harness private
```

### 2. 새 이름으로 퍼블리시하고 싶은 경우

```bash
scripts/publish-repo.sh indextrown/Harness-recovery private
```

### 3. 현재 GitHub 로그인 계정 이름을 자동으로 쓰고 싶은 경우

```bash
scripts/publish-repo.sh Harness private
```

## 주의 사항

- 첫 부트스트랩 커밋은 현재 훅 정책과 충돌할 수 있어 `--no-verify`를 사용합니다.
- 이미 레포가 존재하면 새로 만들지 않고 원격 URL을 맞춘 뒤 푸시합니다.
- 공개 범위는 `private` 또는 `public`만 받습니다.

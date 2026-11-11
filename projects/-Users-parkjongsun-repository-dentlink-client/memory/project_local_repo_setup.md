---
name: local-repo-setup-status
description: "집 Mac 작업환경을 사무실 Mac 기록의 현재 상태로 맞춘 결과 (2026-11-11) — env, 브랜치·worktree, 도구, 남은 차이"
metadata:
  node_type: memory
  type: project
  originSessionId: e1af17c3-c4e7-42a3-81bf-b4cdd2960e30
  modified: 2026-11-11T07:46:43.284Z
---

2026-11-11 사용자 목적: 특정 업무 재개 전에 집 Mac을 사무실 Mac과 최대한 같게. 정본 상세는 codex-personal-context `projects/dentlink-fe.md` "다른 기기에서 이어가기"(양쪽 기록 규칙에 따라 같은 내용).

**env (사용자 지시: example 키 기준, 값은 Git에서)**
- 웹 서비스 `.env.development` 3개: 최신 `.env.example` 구조 + Git 제거 직전본(`2fb2fdc50^`) 값. GitHub `*-dev` Variables와 차이 0. 빈 값: STG/PRD 전용 키, 의도적으로 비운 마케팅 키, 빌드 옵션, Git에 없는 개인/외부 토큰.
- `e2e/.env.development`·`.env.staging` 생성(46/49). `lab/.env.local`은 선택 값이라 미생성.
- 앱 `env/` 3개는 원래 Git 추적 파일(처음 "없음" 보고는 숨김 파일 누락 확인 실수). 루트 `.env`는 불필요(`@env` 사용 0).
- 구형 env 백업: `~/.local/share/dentlink-closeout/20261111-web-env-before-pull/`(0700), 삭제는 사용자 결정.

**작업 공간 (기록 SHA를 원격과 대조 후 복원, 모두 clean)**
- 웹 기본 checkout `feat/DL-17141-delay-cleanup`, worktree 6개(notification-center, order-status-web, dlds detached, dl-17101, dl-17101-develop, dl-14899) + env 상속·의존성.
- Office `feature/DL-17059` + worktree 2개, Lab `feature/DL-17060` + worktree 2개, studio `feat/DL-17046-gallery-examples`.
- `.codex/worktrees/...` 경로도 사무실과 같은 위치에 만들었다.
- 재현 못 한 것: 사무실의 미커밋 변경(Office `notificationSettings.ts`, 웹 알림센터 `useNotificationCopy.ts`), 이름 미기록 Office 옛 브랜치 4개, recovery ref.

**웹 정리 (같은 날 사용자 지시)**: 진행 중인 작업은 통합알림센터뿐. 완료 worktree 5개와 완료 로컬 브랜치 10개(원격 포함 확인)를 정리하고 기본 checkout을 `master`로 옮김. 웹에 남은 것 = `master` + `dentlink-client-notification-center`(feature/DL-17058) + LBX 보류 `feature/DL-16387`·`-stage-20261103`. studio·컨텍스트 저장소는 그대로. 이어 앱의 `~/.codex/worktrees` 완료 worktree 4개와 완료 로컬 브랜치도 정리 → 앱은 각 `main` + 알림센터 브랜치(Office feature/DL-17059, Lab feature/DL-17060)만 남음.

**GitHub 실조회 (2026-11-11)**: Office PR345·Lab PR41(태그 보완)은 11/10 main에 머지 완료 — codex 11/09 기록의 "머지 대기"는 지난 상태. 진행 중인 알림센터 PR: 웹 #4862 → release/v1.94.0 OPEN, Office #346·Lab #42 → main Draft OPEN. 기록상 "대기"는 항상 GitHub로 재확인할 것.

**도구**: Ruby3.4·JDK17·Android SDK·AVD `Dentlink_API_36`·Reactotron·Colima/Docker 격리 프로필(Stopped)·Chrome for Testing·Playwright. Office·Lab Android 개발 앱 설치.
- 함정: 16GB Mac에서 빌드 후 Gradle/Kotlin 데몬이 남으면 에뮬레이터가 멈춤 → `./gradlew --stop`. `yarn start`는 `--experimental-debugger` 옵션 오류라 `yarn metro-log` 사용. SDKROOT·UTF-8 로케일 필요.
- iOS 시뮬레이터 개발 앱 빌드는 시도하지 않음(플레이북상 Apple Silicon 빌드 경계).

관련: [[user-environment]], [[codex-guidelines-adopted]]

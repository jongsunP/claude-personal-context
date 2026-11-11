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

**커넥터·로그인 준비 (같은 날)**: Claude 계정의 Figma·Atlassian MCP 커넥터는 실제 조회로 정상(Jira는 innovaid 사이트 read-write). 인증 필요로 뜨는 `atlassian`·`figma`는 웹 저장소 팀 `.mcp.json`, `plugin:figma:figma`는 플러그인 중복이라 무시. Xcode 라이선스 미동의 → 사용자 터미널에서 `sudo xcodebuild -license accept` 필요. 테스트 로그인은 전용 Chrome for Testing 프로필 `~/.local/share/codex-test-sessions/dentlink/development/browser-profile`(CDP 9233), 비밀번호는 키체인 `codex.dentlink.development.{web-clinic|web-lab|app-office|app-lab}`에 사용자가 직접. Chrome Apple Events JS 허용은 보안 설정이라 사용자가 직접.

**도구**: Ruby3.4·JDK17·Android SDK·AVD `Dentlink_API_36`·Reactotron·Colima/Docker 격리 프로필(Stopped)·Chrome for Testing·Playwright. Office·Lab Android 개발 앱 설치.
- 함정: 16GB Mac에서 빌드 후 Gradle/Kotlin 데몬이 남으면 에뮬레이터가 멈춤 → `./gradlew --stop`. `yarn start`는 `--experimental-debugger` 옵션 오류라 `yarn metro-log` 사용. UTF-8 로케일 필요. SDKROOT 우회는 Xcode 27.2로 올라간 뒤 불필요해져 `.zshrc`에서 제거(전역이면 iOS 빌드 방해 위험). 새 Mac은 `sudo xcodebuild -license accept`를 사용자가 직접(미동의면 Xcode 도구 exit 69) — 2026-11-11 완료.
- iOS: Xcode 라이선스 동의 후 Office·Lab 개발 앱을 `xcodebuild ... -sdk iphonesimulator -derivedDataPath build`로 빌드 성공, iPhone 17 Pro(iOS 26.5)에 설치. 현재 Podfile은 시뮬레이터 arm64를 제외하지 않아 예전 "Apple Silicon 빌드 경계"는 해소. iOS 빌드 직후 고부하에 에뮬레이터 런처 ANR → 부하 내려간 뒤 회복.
- 로그인: Office·Lab 앱은 모두 8081 Metro로 빌드돼 한 번에 하나만 연결 → Office 로그인 후 Metro를 Lab으로 바꿔 Lab 로그인.
- 로그인 확인(2026-11-11): 웹 Clinic·Lab(테스트 Chrome 전용 프로필), Office Android·iOS(frankieDevOffice), Lab iOS(frankieDevLab) 로그인 확인. Android Lab(frankieDevLab)까지 전부 로그인 완료. 키체인 비밀번호 항목은 없음(선택). Chrome Apple Events JS 허용 확인. 사용자가 "다 했어"라고 해도 화면·쿠키 이름으로 실제 상태를 확인한 뒤 진행(여러 번 실제와 달랐음).

관련: [[user-environment]], [[codex-guidelines-adopted]]
- iOS 기기 창: Simulator.app 없음 → `open 'devices://device/open?id=<UDID>'`(DeviceHub). 창 소유 앱 이름은 `Device Hub`. 에이전트 셸은 화면 녹화·손쉬운 사용 권한이 없어 창 확인은 CGWindowList로.
- 최종 점검(2026-11-11): 키체인 계정 4개 모두 실제 로그인 성공(격리 컨텍스트, 값 미출력). `.zshrc`에 `$JAVA_HOME/bin` PATH 추가(없으면 `java`가 /usr/bin 껍데기로 실패). 사용자가 패널 탭을 닫아 기기·Metro는 꺼진 상태, Clinic 3000·Lab 3005 서버만 실행 중.
- 마감(2026-11-11): 세팅 완료, 사용자가 실행 중인 서버·기기·Metro를 직접 종료. 로그인은 기기·전용 Chrome 프로필·키체인에 남음. 다시 켤 때는 [[running-services-and-report-scope]]의 복구 순서. 정본 체크포인트는 codex `projects/dentlink-fe.md` 최상단 "집 Mac 작업환경 세팅·Claude Code 메인세션 지정 마감".
- 개발 준비 재점검(2026-11-11): 웹 훅 연결·Git 작성자·gh workflow 권한 OK, coverage-baseline.json을 최신 master로 재생성해 알림센터 worktree에 상속, Revopush CLI 설치. 남은 사용자 준비: Lab 시트 쓰기 인증(service-account.json 또는 gcloud ADC), `revopush login`, 두 앱 `scripts/.env.codepush.local`(Slack Webhook).
- 남은 인증 정리(2026-11-11): CodePush 알림 설정 `scripts/.env.codepush.local`은 두 앱 저장소에 이미 커밋돼 있어 준비 불필요(팀 README와 달리 Webhook 노출 상태, 팀 저장소는 미변경). Revopush 로그인은 사용자가 보류(CLI만 설치). 웹 Lab 시트 인증은 사용자가 "이제 그 시트에 추가 안 해도 된다"고 해 미준비(gcloud만 설치).
- 사용자 결정(2026-11-11): CodePush Webhook이 저장소에 커밋된 것은 팀 방식 그대로 둔다(다시 문제 제기하지 않음). Lab 번역 시트는 더 이상 채우지 않으므로 시트 인증 불필요.

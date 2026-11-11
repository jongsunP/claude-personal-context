---
name: local-repo-setup-status
description: 집 컴퓨터 /Users/parkjongsun/repository/ 로컬 레포 세팅 현황 (dentlink-app·lab-app·studio)
metadata:
  node_type: memory
  type: project
  originSessionId: e1af17c3-c4e7-42a3-81bf-b4cdd2960e30
  modified: 2026-11-11T05:48:50.445Z
---

2026-11-11 집 컴퓨터에 Innvoaid 레포 3개를 신규 clone·세팅했다. 위치는 모두 `/Users/parkjongsun/repository/` (기존 dentlink-client, codex-personal-context 옆).

- **dentlink-app** (Office RN 앱, main): Yarn 4.9.1(corepack) `yarn install` 완료
- **dentlink-lab-app** (Lab RN 앱, main): `yarn install` 완료
- **dentlink-studio** (PM/디자이너용 문서 Studio, pnpm 모노레포): `pnpm install --frozen-lockfile` + `pnpm access:setup`(커밋 검사 훅) 완료. 작업 모드 project. 실행은 `pnpm dev` → http://127.0.0.1:4100

**2026-11-11 실행 환경 세팅 완료:**
- Ruby: brew `ruby@3.4`(3.4.12) — `.tool-versions`의 3.2.2는 구정보, Gemfile.lock은 3.4.5 기준. bundler + 양쪽 앱 `bundle install`·`pod install` 완료
- 주의: CLT SDK 27.2와 Xcode 26.6 링커 불일치로 네이티브 gem 빌드가 깨짐 → `SDKROOT=$(xcrun --sdk macosx --show-sdk-path)` 필요 (.zshrc에 추가함). CocoaPods는 UTF-8 로케일(LANG) 필요
- Java: brew `openjdk@17`, JAVA_HOME .zshrc 설정
- Android: cask `android-commandlinetools`+`android-studio` 설치, `~/Library/Android/sdk`에 platform-tools·platforms;android-36·build-tools;36.0.0·ndk;27.1.12297006·emulator·system-image(arm64)·cmdline-tools;latest 설치, 라이선스 동의 완료. AVD `Pixel_9_API_36` 생성. ANDROID_HOME .zshrc 설정
- homebrew의 avdmanager는 자기 설치 폴더를 SDK 루트로 봐서 못 씀 → `~/Library/Android/sdk/cmdline-tools/latest/bin/avdmanager` 사용
- pod install이 lab-app pbxproj 주석을 정규화하는 노이즈 diff를 만듦 → checkout으로 되돌림 (매 pod install마다 재발 가능)

**미완료(세팅 잔여):**
- 두 RN 앱의 `env/.env.{development,staging,production}` + 루트 `.env`가 gitignore라 비어 있음 → 사무실 컴퓨터나 팀에서 복사 필요. 이것 없이는 앱 실행 불가

관련: [[codex-personal-context-handoff]]

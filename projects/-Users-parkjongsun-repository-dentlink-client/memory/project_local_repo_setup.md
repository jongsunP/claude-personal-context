---
name: local-repo-setup-status
description: 집 Mac 작업환경을 사무실 Mac과 맞춘 현황 (2026-11-11) — 완료된 것과 사람이 채워야 할 env
metadata:
  node_type: memory
  type: project
  originSessionId: e1af17c3-c4e7-42a3-81bf-b4cdd2960e30
  modified: 2026-11-11T06:12:44.249Z
---

2026-11-11 사용자 목적: 특정 업무 재개 전에 집 Mac 작업환경을 사무실 Mac과 최대한 맞춘다. 업무 상태·세션은 옮기지 않았다. 같은 내용을 codex-personal-context `projects/dentlink-fe.md`("다른 기기에서 이어가기")와 `dentlink-app-local-development.md`(설치 함정)에도 기록했다.

**완료 (경로 `/Users/parkjongsun/repository/`):**
- dentlink-client: master `bafb0b1b6`(Release/v1.92.0) fast-forward, pnpm install·build:packages 성공
- dentlink-app·dentlink-lab-app: clone(main), yarn·bundle·pod install
- dentlink-studio: clone, pnpm install, access:setup(project 모드), `pnpm dev` → 127.0.0.1:4100
- 도구: Ruby 3.4(brew), JDK 17, Android SDK(API 36)·AVD `Dentlink_API_36`, Reactotron, Android Studio, Cursor, Chrome, iOS 26.5 iPhone 17 Pro. `.zshrc`에 PATH/JAVA_HOME/ANDROID_HOME/SDKROOT
- 함정: CLT SDK 27.2 ↔ Xcode 26.6 링커 불일치로 `SDKROOT` 필요, pod install은 UTF-8 로케일 필요, brew avdmanager 대신 SDK 안의 cmdline-tools 사용

**남은 것 (사람이 사무실 Mac에서 복사):**
- 앱 env: Office·Lab 각 `env/.env.{development,staging,production}` + 루트 `.env` 없음 → 앱 실행 불가
- 웹 env: 서비스 `.env.development` 3개는 DL-16821 전 구형(최신 example 대비 키 누락 Admin8·Clinic10·Lab8, Clinic 구형 E2E 키 47개 잔존). `lab/.env.local`, `e2e/.env.development`, `e2e/.env.staging` 없음
- 구형 env 9개 백업: `~/.local/share/dentlink-closeout/20261111-web-env-before-pull/`(0700). 사무실 env로 교체 후 삭제 여부는 사용자 결정
- 앱 실제 실행·Reactotron 연결은 미검증

관련: [[user-environment]], [[codex-guidelines-adopted]]

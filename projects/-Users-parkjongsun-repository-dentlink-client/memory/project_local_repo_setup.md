---
name: local-repo-setup-status
description: 집 컴퓨터 /Users/parkjongsun/repository/ 로컬 레포 세팅 현황 (dentlink-app·lab-app·studio)
metadata:
  node_type: memory
  type: project
  originSessionId: e1af17c3-c4e7-42a3-81bf-b4cdd2960e30
  modified: 2026-11-11T05:33:50.162Z
---

2026-11-11 집 컴퓨터에 Innvoaid 레포 3개를 신규 clone·세팅했다. 위치는 모두 `/Users/parkjongsun/repository/` (기존 dentlink-client, codex-personal-context 옆).

- **dentlink-app** (Office RN 앱, main): Yarn 4.9.1(corepack) `yarn install` 완료
- **dentlink-lab-app** (Lab RN 앱, main): `yarn install` 완료
- **dentlink-studio** (PM/디자이너용 문서 Studio, pnpm 모노레포): `pnpm install --frozen-lockfile` + `pnpm access:setup`(커밋 검사 훅) 완료. 작업 모드 project. 실행은 `pnpm dev` → http://127.0.0.1:4100

**미완료(세팅 잔여):**
- 두 RN 앱의 `env/.env.{development,staging,production}` + 루트 `.env`가 gitignore라 비어 있음 → 사무실 컴퓨터나 팀에서 복사 필요
- iOS CocoaPods 미설치: `.tool-versions`는 Ruby 3.2.2 요구, 이 머신은 시스템 Ruby 2.6.10 + brew ruby만 있고 rbenv/asdf 없음
- Android SDK 없음 (`~/Library/Android/sdk` 부재). Xcode 26.6은 설치돼 있음

관련: [[codex-personal-context-handoff]]

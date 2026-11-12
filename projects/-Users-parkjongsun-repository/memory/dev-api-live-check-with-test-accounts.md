---
name: dev-api-live-check-with-test-accounts
description: dev API 실제 응답은 키체인 테스트 계정으로 에이전트가 직접 로그인해 조회한다 — 사용자에게 응답을 달라고 하거나 "토큰 필요"로 멈추지 않기 (2026-11-12)
metadata:
  type: feedback
---

dev 서버 API 실제 응답이 필요하면 키체인 테스트 계정(service `codex.dentlink.development.{web-clinic|web-lab|app-office|app-lab}`, 참조 `~/.local/share/codex-test-sessions/dentlink/development/secure-login-entry/keychain-references.json`)으로 직접 로그인해 조회한다. 사무실·집 Mac 모두 네 항목이 있다.
- 로그인: `POST https://dev-api.dentlink.io/app/auth/login`(앱, `Service-Type: OFFICE|LAB`) 또는 `/office|lab/auth/login`(웹). 응답 `data.accessToken`·`employeeId`·`employerId`를 `Authorization: Bearer`·`Employee-Id`·`Employer-Id` 헤더로.
- 알림 설정 조회 스크립트: 같은 폴더 `dev-notification-settings-get.py app-office app-lab`(값·토큰 미출력). 다른 API도 같은 방식.

**Why:** 2026-11-12 사용자가 "테스트 계정을 세팅했는데 왜 안 되냐, 앞으로는 직접 해달라"고 했다. 에이전트가 시도도 안 하고 토큰이 필요하다며 멈췄다.

**How to apply:** 비밀번호·토큰은 출력하지 않는다. dev(테스트 환경) 조회에만 쓰고 데이터 변경(PUT 등)은 작업 범위에서 필요할 때만, 운영 서버에는 쓰지 않는다.

관련: [[reference-notification-center-sources]]

---
name: test-credentials-and-env-tokens
description: env에 개인 토큰 금지, 개발 테스트 계정은 키체인에 저장해 계속 재사용 — 저장 위치·이름 규칙·사용법
metadata:
  type: feedback
---

2026-11-11 사용자 지시: env에는 지침대로 개인 토큰(Jira·OpenAI·Gemini·Notion·N8N 등)을 넣지 않는다. 대신 개발용 테스트 계정 아이디·비밀번호는 키체인 등에 저장돼 앞으로도 계속 쓸 수 있어야 한다.

**Why:** 매번 로그인을 다시 요청하지 않고 같은 테스트 계정으로 웹·앱 검증을 이어가기 위해. 개인 토큰은 개인 자격증명이라 공유 env에 두지 않는다.

**How to apply:**
- 키체인 service: `codex.dentlink.development.{web-clinic|web-lab|app-office|app-lab}`, account = 테스트 이메일.
- 입력은 사용자가 `~/.local/share/codex-test-sessions/dentlink/development/secure-login-entry/store-test-login.sh`(숨김 입력)로 직접. 참조 파일 `keychain-references.json`에는 service·계정만.
- 에이전트는 `security find-generic-password -s <service> -w`로 꺼내 로그인 입력에만 쓰고 값을 출력·기록하지 않는다. 존재 확인은 `-w` 없이.
- 웹 로그인 상태는 전용 Chrome for Testing 프로필(`.../development/browser-profile`, CDP 9233)을 먼저 재사용.

관련: [[codex-guidelines-adopted]], [[dentlink-fe-main-session]]

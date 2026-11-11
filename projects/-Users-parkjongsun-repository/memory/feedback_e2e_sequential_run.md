---
name: feedback-e2e-sequential-run
description: 로컬 E2E와 스테이징 E2E는 반드시 순차 실행 — 동시 실행 시 auth 파일 오염으로 false negative 발생
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 6415210f-01f0-4f17-976d-a3e9f7931031
---

로컬과 스테이징 E2E를 동시에 실행하지 않는다.

**Why:** `e2e/.auth/clinic.json` 등 auth 파일을 두 프로세스가 공유하는데, global-setup에서 각자 덮어쓰면서 토큰이 오염된다. 결과적으로 팀 설정 실패, 인증 실패 등 환경 문제처럼 보이는 false negative가 대량 발생한다. 실제로 로컬+스테이징 동시 실행 시 스테이징에서 14개 실패가 발생했고 로컬 단독 재실행에서는 재현되지 않았다.

**How to apply:** 로컬 완료 → 스테이징 실행 순서로 순차 실행. 절대 `run_in_background` 두 개 동시에 띄우지 않는다.

---
name: feedback-e2e-scripts-vs-specs
description: specs/ 폴더는 실제 테스트 시나리오만. one-off setup 스크립트는 e2e/scripts/에 보관
metadata:
  type: feedback
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

`e2e/clinic/specs/`는 실제로 실행될 E2E 테스트 시나리오만 포함해야 한다. skip 상태여도 "나중에 구현할 시나리오"여야 한다.

일회성 환경 설정 스크립트(계정 생성, 고정 오피스 등록 등)는 `e2e/scripts/`에 보관한다.

**Why:** 사용자의 명확한 기준 — "specs는 실제로 테스트할 시나리오가 모여있어야 된다. 이건 항상이야."

**How to apply:**
- 새 E2E 시나리오 → `e2e/clinic/specs/*.spec.ts`
- one-off 환경 구성 스크립트 → `e2e/scripts/*.spec.ts`
- 스크립트 내 주석의 실행 경로도 `e2e/scripts/` 기준으로 작성
- 실행: `RUN_SETUP_X=1 pnpm exec playwright test e2e/scripts/xxx.spec.ts --project=clinic --reporter=list`

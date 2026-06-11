---
name: feedback-e2e-fixture-office-risk
description: E2E 고정 오피스(setup script로 생성)는 언제든 삭제될 수 있음 — 테스트가 고정 오피스에만 의존하면 flaky 위험
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

`setup-request-access-office.spec.ts` 등으로 생성한 고정 오피스(employer)는 "영구 보존 — 삭제 금지" 주석이 있어도 실제로 삭제될 수 있다.

**실제 사례**: staging employer 1943 ([E2E] Request Access Target)이 삭제됨 → 이를 타겟으로 설정했던 Y 분기 테스트가 90s 타임아웃으로 실패. 재생성 후 employer 2086으로 업데이트.

**Why:** staging DB는 팀 내에서 관리되며 정기 리셋이나 데이터 정리가 발생할 수 있음.

**How to apply:**
- 테스트 타겟으로 "항상 존재가 보장되는 오피스"를 우선 사용: MAIN employer (`NEXT_PUBLIC_E2E_EMPLOYER_ID`)가 가장 안정적
- 고정 오피스가 필요한 경우 삭제됐을 때 복원 절차를 문서화(`RUN_SETUP_SCRIPT=1 NODE_ENV=staging pnpm exec playwright test setup-*.spec.ts`)
- env 파일 주석에 employerId를 기록해두면 삭제 여부를 빠르게 확인 가능

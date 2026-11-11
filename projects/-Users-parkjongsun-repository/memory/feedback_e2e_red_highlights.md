---
name: feedback-e2e-red-highlights
description: "Playwright UI 빨간색 waitFor 진단 원칙 — 근본 파악이 목적, 시간 단축은 부가적"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 8ef53b57-e747-49cc-90e8-87c04723f3f4
---

Playwright UI 트레이스 빨간색 waitFor를 보면 시간부터 줄이지 말고 근본을 먼저 파악한다.

**Why:** 시간을 줄였을 때 flaky 가능성이 생기면 대명제(일관된 결과) 위반 — 그게 더 큰 문제다. 단순히 "빨간색이 보여서 줄인다"는 접근은 잘못됨.

**How to apply:**

1. 이 요소는 진짜 없는 경우가 있나? (optional 요소 — 일부 플로우만 등장, 없으면 skip)
   → 빨간색 정상. N이 필요 이상 크면 줄일 수 있음
2. 이 요소는 있어야 하는데 늦게 나타나나? (서버 부하·렌더 지연 대비 대기)
   → N을 줄이면 flaky 위험. 원래 값 유지. 주석으로 이유 명시

특히 `waitForVisible(x, E2E_TIMEOUT_MS)` 패턴이 optional 체크에 사용되면 버그 (스테이징 90s 통째로 소비).

상세 진단 기준과 timeout 가이드라인은 [[project-e2e-master-plan]] → `.claude/skills/e2e/SKILL.md` "Playwright UI 빨간색 waitFor 진단 기준" 섹션에 있다.

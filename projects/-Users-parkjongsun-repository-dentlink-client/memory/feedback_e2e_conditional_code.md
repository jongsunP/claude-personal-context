---
name: feedback-e2e-conditional-code
description: E2E 테스트에서 조건 코드(if/catch) 사용 기준 — 허용과 금지
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0fadbd4a-2be1-4ab5-8e42-1ef1b673cdbd
---

사용자가 물음: "e2e 테스트에 조건을 걸거나 로직 짜듯이 하는 게 올바른 접근인가?"

## 기준

**허용:**
- 환경 차이(로컬 vs 스테이징)로 다른 UI 경로가 뜨는 경우 → `if (await ... .isVisible())`
- 선택적 UI 요소 (있을 수도 없을 수도) → `if (await .waitFor().catch(() => false))`
- 테스트 픽스처 정리 (`beforeAll` 탈퇴 등) — 시나리오가 아니라 인프라

**금지:**
- 사용자가 반드시 보고 클릭해야 하는 버튼을 조건으로 감싸기
- `if (await doneButton.isVisible()) await doneButton.click()` — 항상 있어야 할 버튼이면 조건 없이 click

**핵심 원칙:**
- 실제 사용자가 반드시 수행해야 하는 액션은 조건 없이 실행
- 환경 차이나 선택적 UI는 조건부 처리 허용

**Why:** 이번 작업에서 Milling Disc Type 조건 블록 안에 Durasoft(Hybrid) 재료 선택을 가뒀더니, 스테이징에서 Milling Disc Type이 없어 재료를 선택 안 한 채 Next를 클릭 → 폼 검증 실패 → 이동 불가 패턴이 발생했다.

**How to apply:** e2e 테스트 코드를 작성하거나 리뷰할 때 이 기준을 적용. 조건 코드가 "필수 액션을 감추고 있지 않은지" 체크.

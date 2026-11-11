---
name: feedback-denture-workflow-scope
description: 댄쳐 워크플로우 작업 범위 — 비-DENTURE 주문 로직은 건드리지 않음
metadata: 
  node_type: memory
  type: feedback
  originSessionId: bd9ad480-0db4-4ff6-87e9-00374c6e238d
---

댄쳐(Denture) 워크플로우 관련 작업은 DENTURE 주문에만 적용한다.

**Why:** 비-DENTURE 주문의 `isShowCaseList = !!isWorkflowLoading` 같은 의심스러운 로직이 있더라도, 해당 작업 범위가 댄쳐 주문에 한정되어 있으므로 수정하지 않는다.

**How to apply:** 댄쳐 워크플로우 관련 작업 시 비-DENTURE 분기 코드는 검토 보고만 하되 수정하지 않는다.

---
name: handoff-review-scope
description: 완성된 작업을 다른 에이전트에게서 넘겨받아 리뷰 지적만 처리할 때는 범위를 리뷰 대응으로 한정하고 범위 밖 사항을 무겁게 보고하지 않는다
metadata:
  node_type: memory
  type: feedback
  originSessionId: 64e5f883-42fa-4b78-8d56-577e5d6d31e0
  modified: 2026-10-15T07:12:08.586Z
---

이미 완성·반영된 작업에 뒤늦게 CodeRabbit 등 리뷰가 달려 에이전트가 바뀐 상태로 처리를 맡을 때, 목적은 **리뷰 지적 처리뿐**이다. 큰 그림·개념·정책을 바꾸거나 재검토하지 않는다.

**Why:** 2026-10-15 PR #4700(DL-16317) 인수 때 리뷰 3건만 처리하면 되는 상황에서, 이전 에이전트 원칙(확정 요구 밖 UI 승인 등)과 PR 무관 사항(다른 repo 미커밋 변경, ~/.claude 잔여 변경)을 "확인 필요"로 보고해 사용자가 혼란스러워했다.

**How to apply:**
- 이전 기록은 지적이 기존 의도에 맞는지 판단하는 근거로만 쓴다.
- 리뷰 지적을 고치는 수준의 수정(빈 화면 → 기존 안내 화면 재사용 등)은 승인 사항으로 올리지 않는다.
- PR과 무관한 발견은 보고 끝에 한 줄로만 적거나 생략한다. 진짜 PR 차단 요인만 "확인 필요"로 묻는다.

관련: [[codex-personal-context-handoff]], [[dl16317-permission-progress]]

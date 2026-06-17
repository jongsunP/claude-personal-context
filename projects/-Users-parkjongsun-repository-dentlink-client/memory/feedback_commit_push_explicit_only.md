---
name: feedback_commit_push_explicit_only
description: 커밋·푸쉬는 명시적 요청이 있을 때만 — 코드 수정 완료 후 자동 커밋·푸쉬 금지
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 341ad595-f009-4838-8004-c19da807c9f7
---

커밋·푸쉬는 사용자가 명시적으로 요청할 때만 실행한다.

**Why:** 코드 수정만 요청했는데 커밋·푸쉬까지 자동으로 진행해서 사용자가 검토할 기회를 빼앗았다.

**How to apply:** 코드 변경 작업 후 커밋·푸쉬는 하지 않는다. "커밋해줘", "푸쉬해줘", "커밋 푸쉬해줘" 같은 명시적 지시가 있을 때만 실행한다. [[feedback_pr_review_resolve]] 처럼 리뷰 resolve가 포함된 작업 흐름에서는 해당 지시에 커밋·푸쉬가 묵시적으로 포함될 수 있으나, 일반 코드 수정 작업은 해당 없음.

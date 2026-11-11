---
name: feedback_commit_push_explicit_only
description: 커밋·푸쉬는 명시적 요청이 있을 때만 — 코드 수정 완료 후 자동 커밋·푸쉬 금지
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 341ad595-f009-4838-8004-c19da807c9f7
---

커밋·푸쉬는 사용자가 명시적으로 요청할 때만 실행한다. PR 생성 작업 흐름이라도 예외 없음.

**Why:** 코드 수정 + 푸쉬 + PR 생성 흐름이라도 커밋 전에 사용자가 검토할 기회를 빼앗으면 안 된다. 2026-06-18 재강조: PR 생성 스킬 실행 중에도 커밋을 먼저 해버린 것이 문제였음.

**How to apply:** 코드 변경 완료 후 반드시 멈추고 대기한다. "커밋해줘", "푸쉬해줘", "커밋 푸쉬해줘" 같은 명시적 지시가 있을 때만 실행. PR 생성 스킬을 쓰더라도 커밋·푸쉬 단계는 별도로 확인받는다. [[feedback_pr_review_resolve]] 처럼 리뷰 resolve가 포함된 작업 흐름에서만 묵시적 포함 허용.

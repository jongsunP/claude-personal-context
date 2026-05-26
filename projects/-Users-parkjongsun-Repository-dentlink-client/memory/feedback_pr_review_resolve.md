---
name: feedback_pr_review_resolve
description: PR 리뷰 확인 요청 시 수정·커밋·push·resolve까지 한 번에 처리
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f676449a-d653-4892-bf54-aaafe5e1a299
---

사용자가 PR 리뷰를 봐달라고 하면 coderabbit 등 리뷰어 코멘트를 읽고, 적절한 항목은 수정·커밋·push, 스킵 항목은 이유 설명, 그리고 **GitHub resolve까지 한 번에** 처리한다.

**Why:** 사용자가 resolve를 직접 처리해야 하는 불편함을 없애기 위해 요청함.

**How to apply:** "리뷰 확인해줘" / "코드레빗 리뷰 처리해줘" 등의 요청 시 — 1) 코멘트 읽기 2) 수정 판단 및 적용 3) 커밋·push 4) gh API로 resolve 처리까지 자동 진행. resolve는 GitHub GraphQL API(`gh api graphql`)로 처리.

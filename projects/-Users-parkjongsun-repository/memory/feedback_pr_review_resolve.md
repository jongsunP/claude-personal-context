---
name: feedback_pr_review_resolve
description: PR 리뷰 확인 요청 시 수정·커밋·push·resolve까지 한 번에 처리
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f676449a-d653-4892-bf54-aaafe5e1a299
---

사용자가 PR 리뷰를 봐달라고 하면 coderabbit 등 리뷰어 코멘트를 읽고, 적절한 항목은 수정·커밋·push, 스킵 항목은 이유 설명, 그리고 **GitHub resolve까지 한 번에** 처리한다.

추가로 **PR 검토 시 미resolve된 CodeRabbit 리뷰가 있으면 항상 먼저 알려준다.**

**Why:** 사용자가 resolve를 직접 처리해야 하는 불편함을 없애기 위해 요청함. 미resolve 리뷰는 사용자가 놓치기 쉬우므로 선제 고지 필요.

**How to apply:**
- "리뷰 확인해줘" / "코드레빗 리뷰 처리해줘" 등의 요청 시 — 1) 코멘트 읽기 2) 수정 판단 및 적용 3) 커밋·push 4) gh API로 resolve 처리까지 자동 진행
- 사용자가 요청한 PR 리뷰 검토 범위에서 미resolve 스레드를 확인하고 남은 항목을 보고한다. 단순 PR 생성/푸시만으로 리뷰 조회·대응을 추가하지 않는다.
- resolve 확인: `gh api graphql -f query='{ repository(owner:...) { pullRequest(number:...) { reviewThreads { nodes { isResolved } } } } }'`


## 2026-11-16 최종 보완 — 안전한 최소 대응 후 마감

정본: codex-personal-context/DEVELOPMENT_STYLE.md의 CodeRabbit Review Safety And Closeout.
- 리뷰를 없애기보다 기존 기능 보존을 우선. 실제 코드·요구사항·계약으로 타당한 문제만 최소 수정하고 새로운 UX/정책/리팩터링을 임의 추가하지 않는다.
- 지적된 함수만 고치지 말고 실제 호출·후단 소비 경로까지 정상/실패 동작을 검증한 뒤 push. 이미 올린 리뷰 수정도 안전성 질문 시 요청 범위(예: Draft 해제 이후)만 재검토한다. 매번 전수조사하지 않는다.
- 타당한 건 수정, 미적용은 이유 답변 후 처리한 스레드 resolve. 범위 밖이라는 이유로 닫은 건 결함 해결로 주장하지 않으며 실제 미해결 차단은 숨기지 않는다.
- 마지막 한 번 확인하고 마감. 새 리뷰가 없으면 넘어가며 봇이 매 커밋을 승인할 때까지 강제 재요청/무한 폴링하지 않는다. 사용자가 지정한 PR/간격이 있을 때만 조회하고 마감 지시 시 종료.
- 테스트/resolve와 실제 기기 QA·리뷰 승인·머지·배포는 별개. 완료 후 정본/메모리 기록하고 대기.

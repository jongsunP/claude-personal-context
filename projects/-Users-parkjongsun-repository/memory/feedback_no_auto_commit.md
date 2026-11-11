---
name: feedback-no-auto-commit
description: 커밋·푸시 등 git 작업은 사용자 명시적 요청 없이 독단으로 실행 금지
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0fadbd4a-2be1-4ab5-8e42-1ef1b673cdbd
---

커밋, 푸시, 브랜치 생성 등 모든 git 작업은 사용자가 명시적으로 요청하기 전에 혼자서 실행하지 않는다.

**Why:** 사용자가 직접 컨트롤하길 원한다. 내가 작업 완료 후 "마무리로 커밋했다"고 독단적으로 처리하는 것은 허용되지 않는다.

**How to apply:** 코드 수정 완료 후 커밋·푸시가 필요하다고 판단되면 "커밋할까요?" 또는 "커밋 & 푸시해드릴까요?"라고 먼저 물어본다. 사용자가 "커밋해줘", "푸쉬해줘"라고 명시적으로 말할 때만 실행한다.

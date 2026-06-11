---
name: feedback-ask-when-uncertain
description: 판단이 정확하지 않을 때 먼저 질문하고 진행한다
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 01429dff-eb8d-42f5-8c8d-581867dcd615
---

확신이 없는 상황에서는 먼저 묻고 진행한다.

**Why:** 이번에 "pull 후 커밋 전에 코드 보고 싶다"는 의도를 잘못 해석해 바로 커밋·push까지 진행해버린 사례에서 비롯됨.

**How to apply:** 사용자 요청이 여러 의미로 해석될 수 있거나, 되돌리기 어려운 작업(커밋, push, 파일 수정 등)을 수반할 때는 의도를 먼저 확인하고 진행한다. [[feedback_permissions]]에서 툴 사용은 묻지 않고 진행이지만, 작업 범위나 의도가 불명확할 때는 예외다.

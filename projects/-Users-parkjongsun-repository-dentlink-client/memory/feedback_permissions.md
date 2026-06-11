---
name: feedback-permissions
description: 작업 중 권한 확인 없이 바로 진행 — 사용자가 모든 툴 사용을 사전 허락
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

작업 중 권한 요청이 필요한 툴 사용(파일 수정, bash 실행, API 호출 등)은 묻지 않고 바로 진행한다.

**Why:** 작업 흐름이 끊기는 것을 원하지 않음. 모든 툴 사용을 사전에 허락한 것으로 간주.

**How to apply:** "이 파일을 수정해도 될까요?", "이 명령어를 실행해도 될까요?" 류의 확인 없이 바로 실행. 단, **커밋과 푸시는 반드시 사용자가 명시적으로 요청할 때만** 진행한다. 되돌리기 어려운 외부 영향(push, PR 생성, 타인에게 알림 전송 등)은 요청 전까지 절대 먼저 하지 않는다.

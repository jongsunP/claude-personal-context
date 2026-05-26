---
name: feedback_warning_comment_placement
description: 경고성 주석은 관련 코드 블록 안이 아니라 파일/함수 상단 눈에 띄는 위치에 배치
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f676449a-d653-4892-bf54-aaafe5e1a299
---

경고성 NOTE 주석은 관련 코드 블록(주석 처리된 {} 등) 안에 넣지 말고, 함수 선언 바로 위 또는 파일 상단처럼 **독립적으로 눈에 띄는 위치**에 배치한다.

**Why:** 블록 안에 묻히면 읽는 사람이 놓칠 수 있다. 경고는 파일을 열자마자 바로 보여야 효과가 있다.

**How to apply:** "이 코드를 활성화하면 안 된다" 류의 NOTE는 해당 코드 블록 밖, 함수/파일 주석 앞에 단독 줄로 배치한다.

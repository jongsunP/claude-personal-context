---
name: feedback-briefing-include-backlog
description: 현황 브리핑 시 즉시 실행 항목 외에 백로그(미구현/세팅 대기) 항목도 함께 포함해야 함
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3b69aa96-504c-4ba1-9abb-bc3a1ed5b784
---

현황 브리핑 시 즉시 할 일만 나열하지 않고, 백로그(미구현·세팅 대기) 항목도 함께 언급한다.

**Why:** 사용자가 남은 과제를 전체적으로 파악하고 있는데, 브리핑에서 빠지면 Claude가 모르는 것처럼 보임.

**How to apply:** "남은 일이 뭐야" 질문 또는 세션 마무리 브리핑 시, 즉시 작업 항목 + 백로그 항목(세팅 대기·미구현)을 구분해서 함께 제시한다. 백로그는 repo의 `03-scenario-backlog.md`가 진실 소스.

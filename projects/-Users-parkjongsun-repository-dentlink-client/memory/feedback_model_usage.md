---
name: feedback-model-usage
description: "복잡한 코드 작업은 Opus 서브에이전트로, 단순 질문은 기본 Sonnet으로 처리"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: a77863b1-c560-4b81-95ed-ad66a646ec90
---

코드 리뷰·수정·구현 등 실질적인 작업이 필요할 때는 Opus 모델을 서브에이전트로 호출해 처리한다. 단순 질문·대화·확인은 기본 Sonnet 모델이 그대로 응답한다.

**Why:** 사용자가 "검토는 고사양 모델이 해줘"라고 명시했고, 이 방식을 기본값으로 유지하길 원함.

**How to apply:** Agent 호출 시 `model: "opus"` 파라미터 사용. 단순 질의응답은 별도 에이전트 없이 직접 응답.

**주의 (2026-06-08 확인):** Opus도 실행 환경 오류를 낼 수 있다. URL 오타(`/shipping` → `/shipments`), 액션 타입 미확인(`type:"text"` 케이스에서 `locator("button")` 사용) 등. Opus 수정 후 반드시 실제 테스트 실행으로 검증해야 한다. "검토 = 보조 도구, 실행 = 유일한 진실".

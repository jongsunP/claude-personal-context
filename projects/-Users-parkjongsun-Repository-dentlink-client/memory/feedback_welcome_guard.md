---
name: feedback-welcome-guard
description: /welcome 페이지에 이미 확인한 사용자를 홈으로 리다이렉트하는 가드를 추가하지 않는 것은 의도된 설계다
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f676449a-d653-4892-bf54-aaafe5e1a299
---

`/welcome` 페이지에 `welcomeConfirmedAt`이 설정된 사용자를 홈으로 리다이렉트하는 가드를 추가하지 말 것.

**Why:** 이는 의도된 설계다. 이미 welcome을 확인한 사용자도 URL로 직접 `/welcome`에 접근할 수 있도록 허용한다.

**How to apply:** `/welcome` 페이지 개선 작업 시 이 가드를 "빠진 것"으로 판단해 추가하지 말 것.

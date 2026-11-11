---
name: feedback-e2e-domain-principle
description: e2e 함수 설계 원칙 — 앱 컴포넌트가 같으면 e2e도 같은 함수를 써야 한다
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 943d2a07-e7ab-4ce5-8cf7-e50ef73dcd02
---

**앱 코드가 같은 컴포넌트면 e2e 함수도 하나를 공유한다.**

**Why:** 주문하기는 clinic 컴포넌트. lab이 주문하기 UI에 '껴있어서' lab에서 실행하는 것이지, lab 전용 컴포넌트가 아님. 앱 코드가 같으면 e2e도 같은 함수를 써야 한다. lab 전용인 것(Office Name, Find Dentist, URL prefix)만 파라미터로 주입.

**How to apply:**
- 새 spec이나 step 함수 작성 전에 앱 코드에서 같은 컴포넌트를 쓰는지 먼저 확인
- 이미 같은 도메인 step 함수가 있으면 무조건 재사용
- 서비스(clinic/lab)별로 달라지는 부분만 파라미터(`baseURL`, `officeName`, `dentistName`, `onBeforeNext` 등)로 분리
- 직접 구현이 필요한 경우 기존 함수에 optional 파라미터를 추가하는 방식으로 확장

**구체적 패턴 (completeOrderStep1):**
```ts
// lab에서도 clinic 공통 함수 재사용
await completeOrderStep1(p, {
  baseURL: LAB_URL,           // lab 전용
  officeName: ...,            // lab 전용
  dentistName: ...,           // lab 전용
  onBeforeNext: commonHideUpdateHistory,  // lab 전용 후처리
});
```

**관련 파일:**
- `e2e/clinic/steps/order/order-step1-profile.ts` — completeOrderStep1 (clinic/lab 통합)
- `e2e/clinic/steps/order/order-types.ts` — OrderStep1Input (확장 타입)

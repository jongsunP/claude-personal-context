---
name: project-dl15157-ga-tracking
description: "DL-15157 GA4/Meta Pixel 회원가입 전환 추적 — 버그 수정 완료, PR"
metadata: 
  node_type: memory
  type: project
  originSessionId: 34f25382-fe13-44d6-96ee-c12413abbd45
---

**현재 상태 (2026-06-24):** 완료.

- PR #4270 (`feature/DL-15157-3` → `release/v1.76.0`) 오픈
- PR #4271 (`feature/DL-15157-3` → `stage`) 오픈

핵심 구현 파일:
- `clinic/src/lib/gtag/gtag.ts` — `fireSignupConversion(email)`: SDK onload 후 이벤트 발송
- `clinic/src/lib/gtag/marketingTags.ts` — `captureAttribution()` / `getAttribution()`: UTM/광고 파라미터 저장
- `clinic/src/pages/_app.tsx` — 앱 진입 시 `captureAttribution()` 1회 실행 (isProduction 가드 적용)
- `clinic/src/lib/AuthSignupForm/useSignupForm.tsx` — 가입 성공 onSuccess에서 `fireSignupConversion` 호출

수정한 버그 (DL-15157-3):
- `fireSignupConversion()`에 isProduction 가드 누락 → `if (!isProduction) return;` 추가
- `.env.staging`, `.env.development`에 production과 동일한 GA4/Meta Pixel ID가 설정되어 있던 것 → 값 비움

교훈: gtag 진입점이 여러 개일 때 각각에 가드를 달아야 함. `captureAttribution`에만 가드가 있었고 신규 추가한 `fireSignupConversion`에는 누락됐었음.

**Why:** 스테이징 서버에서도 실제 GA4/Meta Pixel에 이벤트가 발송되는 버그.
**How to apply:** 향후 gtag 진입점 추가 시 isProduction 가드 필수 확인.

---
name: project-dl15157-ga-tracking
description: GA4 + Meta Pixel 회원가입 전환 이벤트 구현 완료, PR #4218 오픈
metadata:
  node_type: memory
  type: project
  originSessionId: 175d76c3-e67a-4c38-b338-bdeee9fbce7b
---

`feature/DL-15157` 브랜치. PR #4218 (→ release/v1.75.0) 오픈 상태 (2026-06-18).

핵심 구현:
- `clinic/src/lib/gtag/gtag.ts` — `fireSignupConversion(email)`: 회원가입 시점에만 GA4/Meta SDK 동적 로드 (lazy loading)
- `clinic/src/lib/gtag/marketingTags.ts` — `captureAttribution()` / `getAttribution()`: 최초 방문 UTM/광고 파라미터 저장, `_fbc` 쿠키 만료 보정
- `clinic/src/pages/_app.tsx` — 앱 진입 시 `captureAttribution()` 1회 실행 (production only)
- `clinic/src/lib/AuthSignupForm/useSignupForm.tsx` — 가입 성공 onSuccess에서 `fireSignupConversion` 호출
- `clinic/global.d.ts` — `window.dataLayer`, `window.gtag`, `window.fbq` 타입 선언
- `.env.production` — `NEXT_PUBLIC_GA4_MARKETING_ID`, `NEXT_PUBLIC_META_PIXEL_ID` 값 설정
- `.env.staging`, `.env.development` — 빈 값 (kill switch)

SDK lazy loading 이유: GA4/Meta SDK를 모든 페이지에서 로드할 필요 없음. 회원가입 이벤트 발생 시점에만 동적 삽입.

**Why:** 마케팅팀 + PM 스펙을 코드베이스에 맞게 적용. 개발자 피드백으로 lazy loading 리팩토링.
**How to apply:** 다음 세션 시작 시 PR #4218 머지 여부 확인.

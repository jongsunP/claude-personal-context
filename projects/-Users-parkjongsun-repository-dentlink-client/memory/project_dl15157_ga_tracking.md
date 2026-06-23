---
name: project-dl15157-ga-tracking
description: "DL-15157 GA4/Meta Pixel 회원가입 전환 추적 — 버그 수정 완료, PR"
metadata: 
  node_type: memory
  type: project
  originSessionId: 34f25382-fe13-44d6-96ee-c12413abbd45
---

**현재 상태 (2026-06-23):** PR #4260 (`feature/DL-15157-2` → master) 오픈. 스테이징 검증 완료.

핵심 구현 파일:
- `clinic/src/lib/gtag/gtag.ts` — `fireSignupConversion(email)`: SDK onload 후 이벤트 발송
- `clinic/src/lib/gtag/marketingTags.ts` — `captureAttribution()` / `getAttribution()`: UTM/광고 파라미터 저장
- `clinic/src/pages/_app.tsx` — 앱 진입 시 `captureAttribution()` 1회 실행 (현재 production 가드 주석 처리 중)
- `clinic/src/lib/AuthSignupForm/useSignupForm.tsx` — 가입 성공 onSuccess에서 `fireSignupConversion` 호출

수정한 버그 (기존 master 코드):
- SDK 로드 전 이벤트 발송 → `loadScriptOnce`에 onload 콜백 추가로 해결
- GA4 stub 화살표 함수로 배열 push → `function()` 선언으로 Arguments 객체 전달
- Meta Pixel fbevents.js onload 전 init/track 발송 → onload 이후로 이동

스테이징 검증 결과:
- GA4: `google-analytics.com/g/collect` — `en=dentlink_signup` 확인 ✅
- Meta Pixel: `facebook.com/tr` — `ev=CompleteRegistration` 확인 (네트워크 탭 이미지 타입) ✅
- transaction_id 두 채널 간 일치 확인 ✅

**배포 전 남은 작업:**
- PR #4260 머지
- `_app.tsx`의 `captureAttribution` production 가드 복구 (`// if (!isProduction) return;` 주석 해제)

**Why:** 마스터에 기존 구현이 있었으나 SDK 타이밍 버그로 실제 이벤트 미발송 상태였음.
**How to apply:** 다음 세션 시 PR #4260 머지 여부 및 production 가드 복구 여부 확인.

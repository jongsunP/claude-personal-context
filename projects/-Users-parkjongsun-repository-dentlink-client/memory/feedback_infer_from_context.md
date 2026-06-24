---
name: feedback-infer-from-context
description: 확인/수정 작업 시 기존 코드·작업 내역에서 먼저 추론하고 일관성 있게 처리
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3acdd6b9-3603-464b-a97b-9867e49fd837
---

기존 코드나 작업 내역에서 추론 가능한 것은 사용자가 지적하기 전에 먼저 처리한다.

**Why:** 아래 두 케이스가 대표적 실패 사례.
- `fireSignupConversion`에 가드 추가 시 `_app.tsx`의 기존 `if (!isProduction)` 스타일을 보면 같은 방식으로 작성했어야 하는데 다른 형태(`process.env.NEXT_PUBLIC_ENV !== "production"`)로 작성 → 사용자가 지적 후 수정
- `.env.staging` 수정 시 같은 성격의 `.env.development`도 세트로 처리했어야 하는데 누락 → 사용자가 지적 후 수정

**How to apply:**
- 코드 스타일/패턴: 같은 파일·모듈의 기존 코드를 먼저 확인하고 동일한 패턴으로 작성
- 환경 파일: 하나를 수정하면 같은 성격의 다른 환경 파일(.env.development, .env.staging 등)도 함께 확인하고 처리
- 일반 원칙: "이 작업과 세트로 해야 할 것이 있는가?"를 먼저 스스로 점검

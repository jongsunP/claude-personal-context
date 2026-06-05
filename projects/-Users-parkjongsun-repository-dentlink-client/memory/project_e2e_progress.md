---
name: project-e2e-progress
description: "E2E 자동화 작업 진행 상황 — 현재 브랜치, 완성된 스펙, 남은 작업"
metadata: 
  node_type: memory
  type: project
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

## 현재 작업 브랜치

`feature/DL-14803-1` (base: `release/v1.74.0`, origin push 완료)

**Why:** DL-14805-e2e 전체가 스쿼시 머지로 release/v1.74.0에 반영됨. 이후 신규 시나리오 작업은 이 브랜치에서 진행.

## 완성된 Spec 파일 (`e2e/clinic/specs/`)

| 파일 | 내용 | 브랜치 |
|------|------|--------|
| `00_signup.spec.ts` | 회원가입 → 병원생성 → 회원탈퇴 | release/v1.74.0 |
| `00_signup_validation.spec.ts` | 회원가입 폼 유효성 검증 (DL-14803) | feature/DL-14803-1 |
| `01_signin.spec.ts` | 로그인/실패 케이스 | release/v1.74.0 |
| `02_onboarding.spec.ts` | 온보딩 플로우 (DL-14810 완료) | release/v1.74.0 |
| `03_orders/crown.spec.ts` | Crown 주문 | release/v1.74.0 |
| `03_orders/denture.spec.ts` | Digital Denture 주문 | release/v1.74.0 |
| `03_orders/veneer.spec.ts` | Premium Veneer 주문 | release/v1.74.0 |
| `03_orders/instasmile.spec.ts` | Instasmile 주문 | release/v1.74.0 |
| `03_orders/step4-ui-state.spec.ts` | Step4 UI 상태 검증 (DL-14811) | feature/DL-14803-1 |
| `04_labShipment.spec.ts` | 기공소 배송/픽업 생성·수정·취소 | release/v1.74.0 |
| `05_labStatus.spec.ts` | 주문 상태 변경 | release/v1.74.0 |
| `06_linkTalk.spec.ts` | 링크톡 메시지/파일 전송 | release/v1.74.0 |
| `07_billing.spec.ts` | 어드민 결제생성 → Unpaid 조회 → 결제 완료 | release/v1.74.0 |

## feature/DL-14803-1 커밋 내역

1. `test: E2E 신규 시나리오 추가 (DL-14803, DL-14811)` — signup_validation, step4-ui-state, scanner-api, .env.staging
2. `test: E2E 리퍼럴/BP 환경변수 플레이스홀더 추가 (.env.development)` — .env.development
3. `fix: e2e Playwright UI clinic-account-setup 분리 제거` — storageState: undefined 제거 (00_signup, 00_signup_validation)

## 수정 이력 (중요)

**clinic-account-setup UI 분리 제거 (2026-06-05)**
- `test.use({ storageState: undefined })` → 제거
- `clearBrowserSession` 호출로 대체 (동일 효과, UI 분리 없음)
- 2026-05-21부터 존재했던 문제. feature/DL-14803-1에서 근본 수정.

## 남은 작업

- `NEXT_PUBLIC_E2E_REFERRAL_GROUP_CODE`, `NEXT_PUBLIC_E2E_BP_PARTNER_KEY` 실제 값 입력 필요 (스테이징/dev .env에 플레이스홀더만 있음)
- DL-14803 Step2/3/4 시나리오 — 실제 이메일 인증 필요, 별도 구현 검토 필요
- PR 생성: `feature/DL-14803-1` → `release/v1.74.0`
- 수동 테스트 결과 확인 후 PR

**How to apply:** 재개 시 `feature/DL-14803-1` 체크아웃 후 위 남은 작업 이어서 진행.

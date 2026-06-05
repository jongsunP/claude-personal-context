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
| `00_signup_step2_3_validation.spec.ts` | 회원가입 Step2/3 폼 유효성 검증 (DL-14803) | feature/DL-14803-1 |
| `03_orders/step4-ui-state.spec.ts` | Step4 UI 상태 검증 (DL-14811) | feature/DL-14803-1 |
| `04_labShipment.spec.ts` | 기공소 배송/픽업 생성·수정·취소 | release/v1.74.0 |
| `05_labStatus.spec.ts` | 주문 상태 변경 | release/v1.74.0 |
| `06_linkTalk.spec.ts` | 링크톡 메시지/파일 전송 | release/v1.74.0 |
| `07_billing.spec.ts` | 어드민 결제생성 → Unpaid 조회 → 결제 완료 | release/v1.74.0 |

## feature/DL-14803-1 커밋 내역

1. `test: E2E 신규 시나리오 추가 (DL-14803, DL-14811)` — signup_validation, step4-ui-state, scanner-api, .env.staging
2. `test: E2E 리퍼럴/BP 환경변수 플레이스홀더 추가 (.env.development)` — .env.development
3. `fix: e2e Playwright UI clinic-account-setup 분리 제거` — storageState: undefined 제거 (00_signup, 00_signup_validation)
4. `docs: e2e 스킬 업데이트 — storageState 금지 패턴, scanner-api, 신규 스펙 반영`
5. `test: E2E Signup Step 2/3 폼 유효성 검증 시나리오 추가 (DL-14803)` — 00_signup_step2_3_validation.spec.ts (10개 테스트 모두 통과)
6. `docs: e2e 스킬 업데이트 — Step2/3 validation spec, type=number 및 SelectDropdown 실패 패턴 추가`
7. `docs: e2e 스킬 — 자동화 불가/조건부 가능/미구현 구분 원칙 추가`
8. `e2e: ISV Step3 로컬/스테이징 환경별 optionButtons 분기 처리` — RADIO 타입 옵션 자동 선택 차이 대응, waitFor 추가, webServer timeout 300_000
9. `docs: e2e 스킬 — ISV RADIO 옵션 분기 패턴, 로컬 env override 실패 패턴 추가`

## 수정 이력 (중요)

**clinic-account-setup UI 분리 제거 (2026-06-05)**
- `test.use({ storageState: undefined })` → 제거
- `clearBrowserSession` 호출로 대체 (동일 효과, UI 분리 없음)
- 2026-05-21부터 존재했던 문제. feature/DL-14803-1에서 근본 수정.

## 남은 작업

- `NEXT_PUBLIC_E2E_REFERRAL_GROUP_CODE`, `NEXT_PUBLIC_E2E_BP_PARTNER_KEY` 실제 값 입력 필요 (스테이징/dev .env에 플레이스홀더만 있음)
- DL-14803 Step4 시나리오 (Request Access, 동일 주소 병원 분기) — 복잡한 office 세팅 필요, 별도 구현 필요
- **PR 생성 대기**: `feature/DL-14803-1` → `release/v1.74.0` — 로컬·스테이징 모두 92 passed, 5 skipped, 0 failed 수동 확인 완료 (2026-06-06). `gh auth login` 후 PR 생성 예정.

**How to apply:** 재개 시 `feature/DL-14803-1` 체크아웃 후 위 남은 작업 이어서 진행.

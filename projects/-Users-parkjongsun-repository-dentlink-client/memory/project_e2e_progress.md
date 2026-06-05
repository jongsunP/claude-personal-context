---
name: project-e2e-progress
description: E2E 자동화 현황 — 운영 중인 스펙 목록, 테스트 결과, 미완료 항목
metadata:
  node_type: memory
  type: project
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

## 운영 중인 Spec (`e2e/clinic/specs/`)

| 파일 | 내용 |
|------|------|
| `00_signup.spec.ts` | 회원가입 → 병원생성 → 회원탈퇴 |
| `00_signup_validation.spec.ts` | 회원가입 Step1 유효성 검증 |
| `00_signup_step2_3_validation.spec.ts` | 회원가입 Step2/3 유효성 검증 |
| `01_signin.spec.ts` | 로그인/실패 케이스 |
| `02_onboarding.spec.ts` | 온보딩 플로우 |
| `03_orders/crown.spec.ts` | Crown 주문 |
| `03_orders/denture.spec.ts` | Digital Denture 주문 |
| `03_orders/veneer.spec.ts` | Premium Veneer 주문 |
| `03_orders/instasmile.spec.ts` | Instasmile 주문 |
| `03_orders/step4-ui-state.spec.ts` | 주문 Step4 UI 상태 검증 |
| `04_labShipment.spec.ts` | 기공소 배송/픽업 생성·수정·취소 |
| `05_labStatus.spec.ts` | 주문 상태 변경 |
| `06_linkTalk.spec.ts` | 링크톡 메시지/파일 전송 |
| `07_billing.spec.ts` | 어드민 결제생성 → Unpaid 조회 → 결제 완료 |

## 테스트 결과 (2026-06-06)

로컬·스테이징 동일: **92 passed, 5 skipped, 0 failed**

Skip 5개는 모두 의도된 skip — [[project-e2e-backlog]] 참고.

## 미완료 항목

- Step4 "Request Access" / 동일 주소 병원 분기 — office 세팅 복잡, 별도 구현 예정
- `NEXT_PUBLIC_E2E_REFERRAL_GROUP_CODE`, `NEXT_PUBLIC_E2E_BP_PARTNER_KEY` — 백엔드 팀 확인 필요

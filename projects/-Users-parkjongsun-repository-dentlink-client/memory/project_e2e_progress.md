---
name: project-e2e-progress
description: "DL-14805 e2e 자동화 작업 진행 상황 — 브랜치, 완성된 스펙, 남은 작업"
metadata: 
  node_type: memory
  type: project
  originSessionId: f676449a-d653-4892-bf54-aaafe5e1a299
---

브랜치: `feature/DL-14805-e2e`
마지막 커밋: `d31a94db8` (2026-05-22) — "chore: e2e 작업중"

## 완성된 Spec 파일 (`e2e/clinic/specs/`)

| 파일 | 내용 |
|------|------|
| `00_signup.spec.ts` | 회원가입 → 병원생성 → 회원탈퇴 |
| `01_signin.spec.ts` | 로그인/실패 케이스 |
| `03_orders/crown.spec.ts` | Crown 주문 4단계 |
| `03_orders/denture.spec.ts` | Digital Denture 주문 4단계 |
| `03_orders/veneer.spec.ts` | Premium Veneer 주문 4단계 |
| `04_labShipment.spec.ts` | 기공소 배송/픽업 생성·수정·취소 |
| `05_labStatus.spec.ts` | 주문 상태 변경 12단계 (New → Completed) |
| `06_linkTalk.spec.ts` | 링크톡 메시지/파일 전송 |
| `07_billing.spec.ts` | 어드민 결제생성 → Unpaid 조회 → 결제 완료 |

## 삭제된 파일
- `02_onboard.spec.ts` — 마지막 커밋에서 의도적 삭제. 내용은 `00_signup.spec.ts`(병원생성 플로우)로 흡수됨.

## 인프라 파일 (완성)
- `steps/order/order-step1~4.ts` — 주문 단계별 헬퍼
- `steps/order/order-cases/crown/denture/veneer.ts` — 케이스 설정값
- `utils/lab.ts`, `utils/login.ts`, `utils/signin.ts`, `utils/session.ts`
- `setup/global-setup.ts` — 클리닉 계정 storageState 생성

## 남은 작업 (미확인)
1. `02_onboard.spec.ts` 재작성 여부 결정 (의도적 삭제인지 작업 중인지)
2. 실제 테스트 실행 검증 (코드 작성 완료, 통과 여부 미확인)
3. `e2e/clinic/page.ts` 루트 레벨 오래된 파일 정리 여부

**Why:** 다른 작업 진행 후 이 브랜치로 돌아올 때 빠르게 컨텍스트 복원하기 위해 저장.
**How to apply:** 새 세션에서 "e2e 작업 계속해줘" 시 이 메모리로 현황 파악 후 진행.

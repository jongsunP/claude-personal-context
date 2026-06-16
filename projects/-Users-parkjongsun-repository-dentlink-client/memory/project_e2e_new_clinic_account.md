---
name: project-e2e-new-clinic-account
description: "신규 E2E 전용 클리닉 계정 세팅 정보 — tata.test4 대체, staging 전용"
metadata: 
  node_type: memory
  type: project
  originSessionId: 3b69aa96-504c-4ba1-9abb-bc3a1ed5b784
---

## 배경

tata.test4@dentlink.app 계정을 개발자가 수동 테스트용으로 공유 사용 → 팀 오염 발생.
E2E 전용 계정으로 분리하기로 결정 (2026-06-16).

**Why:** 누군가 tata.test4로 staging 접속 중 팀을 "11"로 전환 → 05_labStatus 실패.
prepareOrderSession failsafe로도 방어 불가 (live 오염은 race condition 발생).

**How to apply:** 이 계정 정보를 기반으로 신규 E2E 시나리오 작성 및 .env.staging 업데이트.

---

## 계정 정보

| 항목 | 값 |
|------|-----|
| Email | `e2e.clinic@dentlink.app` |
| Password | `innovaid1` |
| First name | `Auto` |
| Last name | `Test` |
| Role | Dentist |

## 오피스 정보

| 필드 | 값 |
|------|-----|
| Office Name | `[OFFICE-STG] E2E Clinic` |
| Owner Name | `E2E Auto Test` |
| Phone | `1234567890` |
| Street Address | `123 E2E Street` |
| City | `Los Angeles` |
| State | `California` |
| Zip Code | `90001` |

## .env.staging 업데이트 대상

세팅 완료 후 아래 5개 값 업데이트 필요:

```
NEXT_PUBLIC_E2E_ACCOUNT_ID="e2e.clinic@dentlink.app"
NEXT_PUBLIC_E2E_ACCOUNT_PASSWORD="innovaid1"
NEXT_PUBLIC_E2E_EMPLOYER_NAME="[OFFICE-STG] E2E Clinic"
NEXT_PUBLIC_E2E_EMPLOYER_ID="???"   # 어드민 승인 후 확인
NEXT_PUBLIC_E2E_EMPLOYEE_ID="???"   # JWT decode로 확인
```

## 세팅 완료 조건

- [x] 어드민 승인 완료
- [x] 주문 카테고리 연결 (Crown, Digital Denture, Premium Veneer, ISV)
- [x] 기공소 연결 (tata.test3)
- [x] Default Scanner: 3Shape 설정 (원복 불가 — 전용 계정이라 문제 없음)
- [x] EMPLOYER_ID=2158 / EMPLOYEE_ID=2368 확인 후 .env.staging 업데이트
- [x] E2E 전체 실행 통과 확인 (94 passed, 5 skipped — 2026-06-16)

## 다음 작업

나머지 계정도 E2E 전용으로 분리 예정:
- tata.test3 → e2e.lab (05_labStatus lab side)
- tata.test5 → e2e.other (Y분기 Request Access 전용)
- jongsun.test5 → e2e.shipment (04_labShipment)
- chajju.admin → e2e.admin (07_billing 및 global-setup/teardown 어드민 API)

## 신규 어드민 계정 (생성 중)

| 항목 | 값 |
|------|-----|
| Email | `e2e.admin@dentlink.app` |
| Password | `innovaid1` |
| 환경 | dev + staging 동일 |
| 용도 | 어드민 API 전용 (브라우저 UI 미사용) |

employee ID: dev=1639, stg=2314 (로그인 응답에서 동적 추출 — env 저장 불필요)
✅ dev + staging .env 업데이트 완료

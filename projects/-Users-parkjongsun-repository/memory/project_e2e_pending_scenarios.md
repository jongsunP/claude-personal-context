---
name: project-e2e-pending-scenarios
description: PM 시나리오 티켓 분석 결과 — 구현 대기 중인 E2E 작업 목록 (최종 업데이트 2026-06-08)
metadata: 
  node_type: memory
  type: project
  originSessionId: 645c6120-0e5f-4a6e-bc64-c1b987d0180c
---

브랜치: `release/v1.74.0` (feature/DL-14805-e2e → release 머지 완료, master는 아직)
분석일: 2026-06-05 / 분류 업데이트: 2026-06-08

**Why:** PM으로부터 받은 시나리오 티켓 3개를 분석해 기존 spec 커버 현황 파악 완료.
**How to apply:** 사용자가 "진행해"라고 하면 아래 분류에 따라 접근 방식이 다르다.

---

## DL-14811 — 주문생성 4단계 ISV 시나리오 ✅ 완료 (2026-06-05)

**파일**: `e2e/clinic/specs/03_orders/instasmile.spec.ts` (신규), `e2e/clinic/steps/order/order-cases/instasmile.ts` (신규)
**결과**: 4/4 통과, 기존 crown/veneer/denture 회귀 없음

---

## DL-14810 — Onboarding 시나리오 ✅ 이미 완전 커버

`02_onboarding.spec.ts`가 Payment Method(Eximbay 외부창 자동화 불가) 제외하고 모두 커버.
**추가 작업 없음.**

---

## DL-14803 — Signup 시나리오 (일부 완료, 일부 미구현)

### ✅ 완료된 항목

| 파일 | 내용 |
|------|------|
| `00_signup.spec.ts` | 잘못된 인증코드, 유효한 회원가입(Step 1~3), 중복 이메일, 병원 신규 등록, 회원탈퇴 |
| `00_signup_validation.spec.ts` | Step1 이메일 버튼 활성화/비활성화 4케이스 |
| `00_signup_validation.spec.ts` | 리퍼럴 진입 `$250` 안내 문구 표시 (env 설정 시 실행, 미설정 시 skip) |
| `00_signup_validation.spec.ts` | BP 진입 Step1 이동 확인 (env 설정 시 실행, 미설정 시 skip) |
| `00_signup_step2_3_validation.spec.ts` | Step2/3 폼 유효성 검증 |

### ⏳ 미구현 항목 — 분류별 접근법

#### [분류 A] 직접 세팅 + 환경변수 입력만 하면 됨

**크레딧 메시지 노출 (리퍼럴/BP 진입)**
- spec은 이미 작성됨 (`00_signup_validation.spec.ts`)
- 현재 env 미설정으로 skip 상태
- `.env.staging` / `.env.development` 에 아래 두 값 직접 입력하면 즉시 실행됨:
  - `NEXT_PUBLIC_E2E_REFERRAL_GROUP_CODE` — 리퍼럴 그룹 코드 (예: `G2JDRG`)
  - `NEXT_PUBLIC_E2E_BP_PARTNER_KEY` — BP 파트너 키 (예: `tt4dKW`)
- **사용자가 직접 유효한 값을 확인 후 입력해야 함**

#### [분류 B] 복잡 — 별도 구현 필요 (브랜치: `feature/DL-14805-1-3`)

> 초기 세팅 이관 완료 (2026-06-09): env 4개 + 셋업 스크립트 커밋됨

**Step 4 오피스 검색 → No Result → Register your office**
- 앱 코드: `usePlacesSearchList` → `EmployerApisClinic.searchOfficesByGoogle()` 호출
- Google Places API를 서버 경유로 호출하는 구조 (`searchOfficesByGoogle`)
- 오피스 선택 후 `usePlaceDetail`(placeId → Google Places 상세)로 폼 자동 입력
- "No Result" 재현이 어려움 — Google이 결과를 안 돌려주는 키워드 필요 or API 모킹
- 전체 흐름이 외부 Google API에 의존 → 테스트 환경에서 안정적 재현 어려움
- **구현 전 접근 전략 고민 필요** (모킹 vs 실제 API 활용 vs 미구현 처리)

**Step 4 Request Access 플로우**
- 시나리오: 이미 등록된 동일 주소 오피스 선택 → Request Access → Pending 팝업 → OK → 미소속 화면
- 테스트 환경에서 "같은 주소의 오피스가 이미 등록된 상태" 재현 필요
- Request Access 후 계정 상태가 "미소속"으로 남아야 하므로 teardown 복구 전략 필요
- **구현 전 접근 전략 고민 필요**

**Why:** 분류 B 두 항목은 Google Places 외부 API 의존 또는 계정 상태 복구 문제로 단순 spec 작성으로 해결 안 됨.
**How to apply:** 분류 A는 env 값 확인 후 바로 진행. 분류 B는 먼저 전략 논의 후 구현.

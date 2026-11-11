---
name: project-e2e-refactor-findings
description: E2E 리팩토링 검토 결과 — 우선순위별 발견 항목 및 작업 순서 (2026-06-04)
metadata: 
  node_type: memory
  type: project
  originSessionId: ab6bf81b-aecc-4b30-bf99-cfc40ba44489
---

브랜치: `feature/DL-14805-e2e`
분석일: 2026-06-04
상태: **구현 완료 (2026-06-04)**

**Why:** 온보딩 시나리오 추가(4단계) 완료 후 코드 품질 개선을 위한 리팩토링 검토.
**How to apply:** 새 세션에서 리팩토링 작업 시작 시 이 메모리를 먼저 읽고 아래 순서대로 진행.

## 작업 순서 (우선순위)

### [Task 1] `05_labStatus.spec.ts` sleep 재시도 제거 ← 빠른 작업
- **파일**: `e2e/clinic/specs/05_labStatus.spec.ts:96-106`
- **문제**: 실패 시 `waitForTimeout(2000)` × 3 반복 — 원인 분석 없는 sleep 재시도
- **수정**: `waitForTimeout` 제거, `waitForLoadState` + `expect().toBeVisible()` 패턴으로 교체
- **예상 절감**: 최대 6s

### [Task 2] `global-setup.ts` networkidle 중복 제거 ← 빠른 작업
- **파일**: `e2e/setup/global-setup.ts:134, 148, 255, 268`
- **문제**: Change Office 전환 시 `networkidle` 4회 중복 대기
- **수정**: 실제 DOM 변화(모달 닫힘, 페이지 전환) 기준으로 대기 교체
- **예상 절감**: 4-8s

### [Task 3] `04_labShipment.spec.ts` 헬퍼 함수 분리 ← 가장 큰 작업
- **파일**: `e2e/clinic/specs/04_labShipment.spec.ts` (535줄)
- **문제**: 5개 인라인 함수가 spec 파일 안에만 존재, 재사용 불가
  - `commonCreateOrder` (~200줄) → `e2e/clinic/steps/lab/shipment-order.ts`
  - `commonCreateShipment` (~55줄) → `e2e/clinic/steps/lab/shipment-create.ts`
  - `commonCreatePickup` (~67줄) → `e2e/clinic/steps/lab/shipment-pickup.ts`
  - `commonCancelPickup` (~43줄) → 위 파일에 통합
  - `commonUpdateShipment` (~45줄) → `e2e/clinic/steps/lab/shipment-create.ts`에 통합
- **주의**: 분리 후 spec은 함수 조합만 남겨야 함. 기존 spec 동작 유지 필수

### [Task 4] `05_labStatus.spec.ts` 상태변경 함수 분리 ← 큰 작업
- **파일**: `e2e/clinic/specs/05_labStatus.spec.ts` (476줄)
- **문제**: 7개 상태변경 함수(57-262줄) 전부 spec 내 인라인
  - `statusChangeNewToPendingOrder` → `utils/lab.ts`
  - `statusChangePendingOrderToLabProcessing` → `utils/lab.ts`
  - 나머지 5개도 동일
- **주의**: `utils/lab.ts`에 이미 `statusChangeNewToLabProcessing` 있음 — 중복 확인 후 통합

### [Task 5] `02_onboarding.spec.ts` 중복 로직 추출 ← 중간 작업
- **파일**: `e2e/clinic/specs/02_onboarding.spec.ts`
- **문제**:
  - "Skip and do it later" 처리 4곳에서 중복 (줄 277-286, 300-309, 347-356, 585-595)
  - 슬라이드 탭 클릭 후 가시성 대기 패턴 4곳 반복
- **수정**: `steps/onboard/` 에 공통 함수 추가
  - `skipOnboardingLandingIfNeeded(page)` — "Skip and do it later" 처리
  - `activateBannerSlide(page, tabIndex, expectedText)` — 슬라이드 탭 클릭

## 기타 발견 (낮은 우선순위, 별도 처리)

- `global-setup.ts:281-285` `saveOnboardMeta` 함수 — 2줄짜리, 인라인 가능
- `07_billing.spec.ts:23-61` 어드민 API 로그인 인라인 — global-setup의 함수와 중복
- `02_onboarding.spec.ts` TODO 주석 3개 — 이슈 트래킹으로 이관 권장
- `01_signin.spec.ts:31-49` ipinfo 요청 — assert 없이 로그만 출력, 제거 고려

## 분리 후 스킬 업데이트 필요

Task 3, 4 완료 후:
- `.claude/skills/e2e/references/01-function-inventory.md` 에 신규 파일 추가
- `e2e/README.md` Spec 목록 특이사항 업데이트 (필요 시)

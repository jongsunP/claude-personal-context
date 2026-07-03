---
name: project_dl15443_progress
description: "DL-15443 E2E 작업 현황 — Denture 시나리오 교체, STG 1회 통과, LOCAL shade guide 미검증 중단"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9f92cf92-6f13-4866-b00f-345c1ce8aef9
---

## 작업 현황: DL-15443 — Denture E2E 시나리오 교체

**Why:** DENTURE COMPLETE 시나리오에서 더 이상 사용하지 않는 `Partial Denture (incl. Flipper)` 를 `Partial Denture with Framework` 로 교체.

**How to apply:** 신규 세션에서 워크트리 경로로 시작. STG 1회 통과, LOCAL shade guide 검증 미완료 상태로 커밋·푸시까지 완료.

---

## 워크트리 정보

- **경로**: `/Users/parkjongsun/Repository/dentlink-client-e2e`
- **브랜치**: `feature/DL-15443` (master HEAD 기준 생성)
- **원본 레포**: `/Users/parkjongsun/Repository/dentlink-client` (master 클린 상태)

---

## 변경된 파일 (4개, 커밋·푸시 완료)

| 파일 | 내용 |
|---|---|
| `e2e/clinic/steps/order/order-cases/denture.ts` | 상품·material·옵션 교체, shadeGuideValue 추가 |
| `e2e/clinic/steps/order/order-step2-product.ts` | Workflow 패널 열기 로직 개선 |
| `e2e/clinic/steps/order/order-step3-option.ts` | radioOptions soft skip, shadeGuideValue 처리 |
| `e2e/clinic/steps/order/order-types.ts` | `radioOptions?: string[]`, `shadeGuideValue?: string` 타입 추가 |

---

## 핵심 변경 내용

### denture.ts
- Step2: `Partial Denture (incl. Flipper)` → `/Partial Denture with Framework/`
- Step3: `materialButton` = `"Co-Cr Frame"`, `radioOptions: ["Artificial Teeth(1-5)"]`, `shadeGuideValue: "A2"`

### order-step2-product.ts
- 3회 retry 루프 → `panelAlreadyOpen` 체크 + 빠른/느린 경로 분기로 교체
- 토글 카테고리 재클릭 시 패널이 닫히는 문제 방어

### order-step3-option.ts
- `radioOptions` soft skip — 5s 내 미출현 시 continue (STG/LOCAL 제품 데이터 차이 대응)
- `shadeGuideValue` 처리 추가 — `data-e2e-id="shade-guide-dropdown-shade"` 로 모든 shade dropdown 탐지, `toBeEnabled()` 대기 후 클릭

---

## 테스트 결과

| 실행 | 결과 | 비고 |
|---|---|---|
| STG 전체 1회 | ✅ 94 passed | 통과 |
| LOCAL 전체 1회 | ❌ denture step3 실패 | "Artificial Teeth Shade" 섹션 미선택 |
| LOCAL 전체 2회 | ❌ denture step3 실패 | shadeGuideValue force:true disabled 문제 |
| LOCAL 전체 3회 | ❌ denture step3 실패 | toBeEnabled 추가했으나 결과 미확인 |
| STG 단독 | 중단 | 사용자 요청으로 정지 |

---

## 미해결 사항

- LOCAL에서 `toBeEnabled()` 대기 + `shadeGuideValue` 처리가 올바르게 동작하는지 미검증
- "Artificial Teeth Shade" 섹션이 LOCAL에만 존재 (STG/LOCAL 제품 데이터 차이)
- LOCAL 단독 실행 시 step2 cold start 타임아웃 문제 (전체 실행에서는 통과)
- PR 미생성

## 다음 세션 시작 시

1. STG 단독 denture spec 실행으로 step3 shade guide 검증
2. LOCAL 전체 실행으로 최종 확인
3. PR 생성

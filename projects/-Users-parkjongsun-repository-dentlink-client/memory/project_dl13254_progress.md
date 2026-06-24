---
name: project-dl13254-progress
description: DL-13254 다단계 보철물 주문 Phase 2 작업 현황 — 완료·미완료 포함 (2026-06-23 업데이트)
metadata: 
  node_type: memory
  type: project
  originSessionId: ad2ea609-2a47-43a4-b3a6-1085c14907d0
---

## 재개 트리거

사용자가 **"feature/DL-15197 이어서야"** 라고 말하면 이 작업을 이어서 진행한다.
시작 시 이 메모리를 읽고, 워크트리 `dentlink-client-allonx`를 기준으로 미완료 항목부터 확인한다.

---

## 기본 정보

- **Jira**: DL-13254 "[치과] 다단계 보철물 프로세스 구축 Phase 2"
- **브랜치**: `feature/DL-15197`
- **워크트리**: `/Users/parkjongsun/Repository/dentlink-client-allonx`
- **최신 커밋 (2026-06-23)**: `a20615590` — push 완료
- **베이스**: `origin/master` rebase 완료 (v1.75.0 기준, DL-15086 processingDays 포함)

**Why:** AOX 컨설팅 상품 전용 주문 플로우 구축. 핵심은 `productType === "CONSULTATION"` 여부로 UI 분기.

---

## 완료된 작업 ✅

### Phase 1 — 기반 (이전 세션)
| 커밋 | 내용 |
|---|---|
| `7334f5ef2` | productPrice API 함수·쿼리 훅 추가 (clinic/admin) |
| `c57a09e97` | 타입 정의: PriceDto·ProductPriceGroup·ProductPriceListDto, ProductAdminDto.type |
| `ac37b838c` | 어드민 상품 type(PROSTHETICS/DESIGN/CONSULTATION) CRUD UI |
| `932eb79d5` | 주문 3단계 가격 조회 연동 (clinic/admin productPriceData 흐름) |
| `149c799e5` | EstimatedCostPanel 초기 구현, OrderOptionForm 배치 |
| `70a75b738` | AoXWorkflowPanel 분리 (보류 파일 — 건드리지 말 것) |
| `f545f9764` | 가격 표시 개선 |
| `6f41ed31f` | EstimatedCostPanel 컨설팅 전용 가드·중복 식별자 수정 |
| `6c95bfef4` | EstimatedCostPanel 표시 로직 수정 |
| `c7e56bf5b` | 어드민 상품 등록·수정 폼에 상품 유형 Radio UI 추가 |

### Phase 2 — 이번 세션 (2026-06-23)
| 커밋 | 내용 |
|---|---|
| `892bd40bd` | order.types에 productType 추가, OrderOptionForm isConsultation 가드 |
| `6d2e183a3` | MANDATORY 처리·스웨거 동기화 전체 |
| `8039d28e3` | 어드민 상품 옵션 이미지 업로드 및 조회 표시 |
| rebase | origin/master rebase 완료 (processingDays 에러 해결) |
| 타입 보강 | OptionCreateAdminDto·OptionUpdateAdminDto에 imageUrl·isFeeScheduleVisible 추가 |
| `a20615590` | 주문 3단계 옵션 이미지 표시 + OptionImage 컴포넌트 추가 |

---

## 현재 동작 상세

### 가격표(EstimatedCostPanel) 노출 조건
```tsx
// CONSULTATION이 하나라도 있으면 표시 (정책)
const isConsultation = !!(
  (order as OrderAdminDto)?.caseGroups?.some(cg => cg.productType === "CONSULTATION") ||
  (order as OrderDto)?.product?.caseGroups?.some(cg => cg.productType === "CONSULTATION")
);
```

### 주문 3단계 옵션 이미지 표시
- `OptionImage.tsx` — 공통 이미지 컴포넌트 (`shared/ui/src/ProductOptions/OptionImage.tsx`)
- 옵션 레벨: `ProductOption.tsx`에 `imageUrl` prop 추가 → 타이틀 옆 20×20
- 옵션값 레벨: `OptionButtons`, `OptionCheckboxes`, `OptionRadioButtons` 모두 적용
- **주의**: 클리닉(오피스) API가 현재 imageUrl을 내려주지 않음 — BE에 추가 요청 완료, FE는 준비됨

### MANDATORY 옵션 처리
- **UI**: `CaseOptionForm.tsx` → `option.type === "MANDATORY"` 면 `return null` (렌더 스킵)
- **Validation**: clinic/admin `useOrderOptionUpdateForm` → `row.type === "MANDATORY"` 면 `return false`
- **가격 계산**: `EstimatedCostPanel` → `topLevel.type !== "MANDATORY"` 조건으로 항상 포함

### 타입 동기화
- `OptionAdminDto.imageUrl` — product.types.ts에 추가됨
- `OptionCreateAdminDto.imageUrl` + `isFeeScheduleVisible` — 추가됨
- `OptionUpdateAdminDto.imageUrl` + `isFeeScheduleVisible` — 추가됨

---

## 가격 계산 공식 (핵심 비즈니스 로직 — 반드시 유지)

```
priceCalculationType === "CASE_GROUP"  → 케이스 전체 치아 단일 그룹
priceCalculationType === "ARCH"        → 상악(UNS 1-16) / 하악(UNS 17-32) 별도 그룹

금액 per 그룹:
  pontic × ponticPrice
  + nonPontic 치아 누적:
      i=0 → price (기본가)
      1 ≤ i < threshold-1 → 0 (무료 구간)
      i ≥ threshold-1 → additionalPrice
  threshold === null → flat-fee: nonPontic > 0이면 price 1회
```

---

## 완료된 추가 작업 (2026-06-24 — 커밋 6abf1d45e)

### 주문 상세 EstimatedCostPanel — 서버 저장값 기반 구현
- `useEstimatedCostFromOrder(caseGroups)` 추가 — `caseGroup.price` + `caseGroup.optionPrice` 직접 사용, 추가 API 호출 없음
- `EstimatedCostPanelUI` pure UI 컴포넌트로 리팩터 (`lineItems/total/currency` props 수신)
- clinic `OrderDetailLayout`: `order.caseGroups` → `useEstimatedCostFromOrder`, currency = `order.office.currency`
- admin 주문 상세: `DataShowGroup` + `DataGrid.DataList`, currency = `data.office.currency`
- **대기 중**: BE에서 `caseGroups[].price` / `caseGroups[].optionPrice` 필드 값 확인 중 (현재 DEV에서 null)

---

## 미완료 항목 ❌

| # | 항목 | 설명 |
|---|---|---|
| 1 | 주문 상세 EstimatedCostPanel 데이터 확인 | BE에 caseGroups.price / optionPrice 필드 응답 확인 요청 |
| 2 | 클리닉 주문 2단계 제품 노출 막기 | 스펙 확인 후 진행 |
| 3 | PR 생성 | 작업 완료 후 |

**진행 순서**: BE 확인(1) → 2단계(2) → PR(3)

## 완료된 추가 작업 (2026-06-24)

| 커밋 | 내용 |
|---|---|
| `2ccdf9b02` | 옵션 imageUrl full-width 독립 표시 — OptionDto 타입 동기화, OptionImage banner 모드, ProductOption 타이틀 썸네일 제거, imageUrl 있으면 항상 option UI 위에 독립 렌더 |

---

## 참고: 관련 API 엔드포인트

| 서비스 | 엔드포인트 | 특이사항 |
|--------|-----------|---------|
| clinic | `GET /office/products/prices` | productIds만 필요 |
| admin  | `GET /admin/products/prices` | productIds + **officeId 필수** |
| 공용코드 | `GET /codes/product-types` | `["PROSTHETICS","DESIGN","CONSULTATION"]` 반환 |

**How to apply:** 다음 세션 재개 시 미완료 항목 표 확인 후 사용자와 우선순위 맞추고 진행.

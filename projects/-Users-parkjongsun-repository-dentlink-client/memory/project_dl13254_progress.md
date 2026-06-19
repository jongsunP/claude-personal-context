---
name: project-dl13254-progress
description: DL-13254 다단계 보철물 주문 Phase 2 작업 현황 — 워크트리·브랜치·완료·미완료 포함
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

- **Jira**: DL-13254 "[치과] 다단계 보철물 주문 프로세스 구축 Phase 2"
- **브랜치**: `feature/DL-15197`
- **워크트리**: `/Users/parkjongsun/Repository/dentlink-client-allonx`
- **기준 커밋(2026-06-19)**: `149c799e5` (모두 push 완료)

**Why:** 주문 3단계에 실시간 예상 금액 패널 추가 + 어드민 상품에 type 필드(PROSTHETICS/DESIGN/CONSULTATION) 지원.

---

## 완료된 작업 (커밋·push 완료)

### 1. API 함수·쿼리 훅 (`7334f5ef2`)
- `admin/src/queries/product-price.queries.ts` — `useAdminProductPricesQuery`
- `admin/src/queries/code.queries.ts` — `useProductTypesQuery`
- `clinic/src/services/productPrice/productPrice.query.ts` — `useProductPricesQuery`

### 2. 타입 정의 (`c57a09e97`)
- `shared/models/src/product-price/product-price.types.ts`
  - `PriceDto`, `ProductPriceGroup`, `ProductPriceListDto` 추가
  - `GetProductPricesQuery` (clinic — productIds만)
  - `GetProductPrices1Query` (admin — productIds + officeId 필수)
- `shared/models/src/api.types.ts` + `product/product.types.ts`
  - `ProductAdminDto.type?`, `ProductUpdateAdminDto.type`, `ProductCreateAdminDto.type`
  - union: `"PROSTHETICS" | "DESIGN" | "CONSULTATION"`

### 3. 어드민 상품 type 지원 (`ac37b838c`)
- `admin/src/lib/Product/useProduct.tsx` — defaultValues `type: "PROSTHETICS"`
- `admin/src/components/ProductForm/ProductFormLayout.tsx` — 동일
- `admin/src/lib/Product/useProductFields.tsx`
  - 조회 행: "상품 유형" 표시
  - 수정 행: `useProductTypesQuery`로 Radio 선택 UI

### 4. 주문 3단계 가격 조회 연동 (`932eb79d5`)
- `clinic/src/lib/OrderForm/useOrderOptionUpdateForm.ts` — `useProductPricesQuery(productIds)` 추가·반환
- `admin/src/lib/OrderForm/useOrderOptionUpdateForm.ts` — `useAdminProductPricesQuery({productIds, officeId})` 추가 (officeId = `order.office.id`)
- `clinic/src/components/Order/OrderOption.tsx` — `productPriceData` prop 전달
- `admin/src/components/Order/OrderOption.tsx` — 동일

### 5. Estimated Cost 패널 UI (`149c799e5`)
- `shared/ui/src/Order/OrderForm/OrderOptionForm.tsx`
  - 가격 계산 공식 주석 포함 (BE 스펙, 임의 수정 금지)
  - `estimatedCost` useMemo: 라인아이템(`label + price`) + `total` 반환
  - `findOptionValueName`: `optionGroups[].options[].optionValues[].name` 탐색
  - UI: 회색 박스(#f9f9f9) 라인아이템 → 구분선 → Total {currency} {amount} → 면책 문구
  - 아이콘: `SvgSignExclamationPosigntSignCircleFilled`
  - Figma 참조: node `115-16913`, `115-16960`

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
```

옵션 가격도 동일 공식, `optionValueId`로 `ProductPriceGroup.optionValues` 매칭.

---

## 미완료 / 다음 세션에서 이어서 할 작업

- [ ] **어드민 추가 작업**: 세션 중 사용자가 "어드민 남은 작업 있다"고 언급했으나 상세 내용 확인 전 세션 종료. 다음 세션 시작 시 사용자에게 어드민 추가 요구사항 재확인 필요.
- [ ] **실제 동작 검증**: 클리닉/어드민 앱에서 주문 3단계 진입 → Estimated Cost 표시 여부 육안 확인. 사용자가 "확인하고 말해줄게 대기" 상태에서 세션 종료됨.
- [ ] **PR 생성**: 아직 PR 미오픈. 작업 완료 확인 후 생성 예정.

**How to apply:** 다음 세션에서 이 브랜치 작업 재개 시, 먼저 미완료 항목을 사용자와 확인하고 진행.

---

## 참고: 관련 API 엔드포인트

| 서비스 | 엔드포인트 | 특이사항 |
|--------|-----------|---------|
| clinic | `GET /office/products/prices` | productIds만 필요 |
| admin  | `GET /admin/products/prices` | productIds + **officeId 필수** |
| 공용코드 | `GET /codes/product-types` | `["PROSTHETICS","DESIGN","CONSULTATION"]` 반환 |

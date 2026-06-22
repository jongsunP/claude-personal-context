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
- **현재 미커밋 변경 파일(2026-06-22)**:
  - `shared/ui/src/Order/OrderForm/EstimatedCostPanel.tsx`
  - `shared/ui/src/Order/OrderForm/OrderOptionForm.tsx`

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
- `shared/models/src/product/product.types.ts`
  - `ProductAdminDto.type?`, `ProductUpdateAdminDto.type`, `ProductCreateAdminDto.type`
  - union: `"PROSTHETICS" | "DESIGN" | "CONSULTATION"`

### 3. 어드민 상품 type 지원 (`ac37b838c`)
- `admin/src/lib/Product/useProduct.tsx` — defaultValues `type: "PROSTHETICS"`
- `admin/src/lib/Product/useProductFields.tsx` — 조회·수정 행에 상품 유형 UI

### 4. 주문 3단계 가격 조회 연동 (`932eb79d5`)
- `clinic/src/lib/OrderForm/useOrderOptionUpdateForm.ts` — `useProductPricesQuery(productIds)` 추가
- `admin/src/lib/OrderForm/useOrderOptionUpdateForm.ts` — `useAdminProductPricesQuery({productIds, officeId})`
- `clinic/src/components/Order/OrderOption.tsx`, `admin/src/components/Order/OrderOption.tsx` — `productPriceData` prop 전달

### 5. Estimated Cost 패널 UI (`149c799e5`)
- `shared/ui/src/Order/OrderForm/EstimatedCostPanel.tsx` (독립 파일로 분리)
- `shared/ui/src/Order/OrderForm/OrderOptionForm.tsx` — 우측 컬럼에 패널 배치

---

## 이번 세션(2026-06-22) 작업 내용 — 미커밋

### 문제: 패널이 AOX 컨설팅 상품에서 안 보이던 현상
- **원인**: 이전 세션에서 `categoryPurposeType === "IMPLANT"` → `productType === "CONSULTATION"` 로 판단하는 코드가 추가됐는데, 이 매핑이 검증되지 않은 잘못된 로직이었음
- **해결**: 해당 워카라운드 전체 삭제. `OrderOptionForm` 인터페이스에서 `productType`, `shadeGuide` 제거, `categoryPurposeType` 파생 제거
- **현재 상태**: 패널은 항상 표시됨 (노출 조건 미설정)
- **보류 처리**: `OrderOptionForm.tsx` 의 `<EstimatedCostPanel>` 위에 `// TODO (@Frankie): 상품 타입(productType) prop 추가 후 노출 조건 설정 필요` 주석 추가

### 문제: 패널에 모든 가격이 다 나오던 현상
- **원인**: `priceGroup.optionValues` 전체를 순회해서 모든 항목 표시
- **해결**: `EstimatedCostPanel.tsx` 표시 로직 수정
  - `findOptionNameByOptValId` → `buildTopLevelOptValInfo` 함수로 교체
  - top-level optionValues만 수집 (Material, Tooth Count 등 childOptions 안의 중첩 항목 제외)
  - `type === "MANDATORY"` → 항상 표시 (Verification Jig, 1st PMMA, 2nd PMMA)
  - 그 외 → form `caseOptions`에서 선택된 optionValueId일 때만 표시
  - 가격 계산 공식(`calcGroupPrice`)은 변경 없음

### FE 완료 상태 (2026-06-22 기준)
- MANDATORY 항상 표시 ✅
- 선택 시 BUTTON 항목 표시 ✅
- 중첩 optionValue(Material, Tooth Count 등)도 루트 option명으로 집계 ✅
  - 예: "12 units" 선택 시 → "Implant Count: $2,700" 으로 표시
  - `buildOptValInfoMap` 함수가 재귀로 모든 depth 탐색, 루트 option의 type·name으로 매핑
- Swagger 스펙 기반 calcGroupPrice 유지 ✅
- 선택 후 항목이 안 보이면 어드민 가격 미등록(데이터) 문제이지 FE 코드 문제 아님

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

## 중요 도메인 지식

### ProductDto vs ProductAdminDto
- `ProductDto` (clinic 카탈로그 API `GET /catalogs/option`): **`type` 필드 없음**
- `ProductAdminDto` (admin API `GET /admin/products/:id`): `type?: "PROSTHETICS" | "DESIGN" | "CONSULTATION"` 있음
- AOX 상담 상품: productId 2891, categoryId 1207, `ProductAdminDto.type === "CONSULTATION"`
- 클리닉에서 productType을 알 수 있는 방법 현재 없음 → TODO (@Frankie) 처리

### AoXWorkflowPanel.tsx
- `shared/ui/src/Order/OrderForm/AoXWorkflowPanel.tsx` 파일 존재
- 파일 상단에 TODO 주석 있고 아무데도 사용되지 않는 보류 파일. 건드리지 말 것.

---

## 미완료 / 다음 세션에서 이어서 할 작업

- [ ] **커밋·push**: 현재 변경 2파일 미커밋 상태. 사용자 명시 요청 시 진행.
- [ ] **TODO (@Frankie) 처리**: `productType` prop이 추가되면 `OrderOptionForm` → `EstimatedCostPanel` 노출 조건 설정. 카탈로그 API에 `type` 필드 추가되거나 별도 prop으로 전달받는 시점에 진행.
- [ ] **product base price 라벨**: `group.productName`이 비어있으면 `-`로 표시됨. 현재 사용자가 문제 제기하지 않아 보류 상태.
- [ ] **어드민 추가 작업**: 이전 세션에서 언급됐으나 상세 미확인. 재개 시 사용자에게 확인 필요.
- [ ] **PR 생성**: 아직 미오픈. 작업 완료 확인 후 생성.

**How to apply:** 다음 세션에서 이 브랜치 작업 재개 시, 먼저 미완료 항목을 사용자와 확인하고 진행.

---

## 참고: 관련 API 엔드포인트

| 서비스 | 엔드포인트 | 특이사항 |
|--------|-----------|---------|
| clinic | `GET /office/products/prices` | productIds만 필요 |
| admin  | `GET /admin/products/prices` | productIds + **officeId 필수** |
| 공용코드 | `GET /codes/product-types` | `["PROSTHETICS","DESIGN","CONSULTATION"]` 반환 |

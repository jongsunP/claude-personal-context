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

- **Jira**: DL-13254 "[치과] 다단계 보철물 주문 프로세스 구축 Phase 2"
- **브랜치**: `feature/DL-15197`
- **워크트리**: `/Users/parkjongsun/Repository/dentlink-client-allonx`
- **최신 커밋 (2026-06-23)**: `6d2e183a3` — push 완료

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
| `892bd40bd` | order.types에 productType 추가 (CaseGroupAdminDto/LabDto/Dto), OrderOptionForm isConsultation 가드 |
| `6d2e183a3` | MANDATORY 처리·스웨거 동기화 전체 |

---

## 현재 동작 상세

### 가격표(EstimatedCostPanel) 노출 조건
```tsx
// OrderOptionForm.tsx
const isConsultation = !!(
  (order as OrderAdminDto)?.caseGroups?.some(cg => cg.productType === "CONSULTATION") ||
  (order as OrderDto)?.product?.caseGroups?.some(cg => cg.productType === "CONSULTATION")
);

{isConsultation && productPriceData && (
  <EstimatedCostPanel productPriceData={productPriceData} />
)}
```

| 서비스 | productPriceData | isConsultation | 결과 |
|---|---|---|---|
| 클리닉 CONSULTATION | 있음 | true | ✅ 노출 |
| 어드민 CONSULTATION | 있음 | true | ✅ 노출 |
| 랩 | undefined (쿼리 없음) | 상관없음 | ❌ 미노출 |
| 비CONSULTATION | 있음 | false | ❌ 미노출 |

### MANDATORY 옵션 처리
- **UI**: `CaseOptionForm.tsx` → `option.type === "MANDATORY"` 면 `return null` (렌더 스킵)
- **Validation**: `clinic/admin useOrderOptionUpdateForm` → `row.type === "MANDATORY"` 면 `return false` (isRequired여도 통과)
- **가격 계산**: `EstimatedCostPanel` → `topLevel.type !== "MANDATORY"` 조건으로 항상 포함

### 타입 동기화 (2026-06-23 기준)
- `ProductOptionType`에 `"MANDATORY"` 추가 (enum.types.ts)
- `PriceType`에 `"CONSULTATION"` 추가 (enum.types.ts)
- `CategoryPurposeType`에서 `"IMPLANT"` 제거 (스웨거 spec 제거 반영)
- `CaseOptionLabDto.type`에 `"MANDATORY"` 추가 (order.types.ts)
- `order.types / product.types / api.types` 전체 `priceType`에 `"CONSULTATION"` 반영
- `CaseGroupLabDto.productType` — order.types에만 선제 추가, data-contracts 미반영 (BE 미오픈)

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

## 미완료 항목 ❌

### 클리닉
| 항목 | 설명 |
|---|---|
| 주문 2단계 제품 노출 막기 | 조건 미정 — 사용자가 2단계 작업 전 재안내 예정 |
| 주문 상세 가격표 | 3단계와 동일한 EstimatedCostPanel 추가 필요 |

### 어드민
| 항목 | 설명 |
|---|---|
| 주문 상세 가격표 | 클리닉 동일 |
| 옵션 이미지 추가 | 어드민 상품 옵션 폼에 이미지 필드 추가 |

### 랩
| 항목 | 설명 |
|---|---|
| 없음 | 모든 변경 없음 (가격표 미노출 이미 처리됨) |

### 공통
| 항목 | 설명 |
|---|---|
| PR 생성 | 미오픈. 작업 완료 확인 후 생성 |
| AoXWorkflowPanel | 보류 파일. 사용처 없음. 건드리지 말 것 |

---

## 참고: 관련 API 엔드포인트

| 서비스 | 엔드포인트 | 특이사항 |
|--------|-----------|---------|
| clinic | `GET /office/products/prices` | productIds만 필요 |
| admin  | `GET /admin/products/prices` | productIds + **officeId 필수** |
| 공용코드 | `GET /codes/product-types` | `["PROSTHETICS","DESIGN","CONSULTATION"]` 반환 |

**How to apply:** 다음 세션 재개 시 미완료 항목 표 확인 후 사용자와 우선순위 맞추고 진행.

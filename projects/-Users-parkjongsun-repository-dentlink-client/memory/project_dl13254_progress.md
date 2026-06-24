---
name: project-dl13254-progress
description: DL-13254 다단계 보철물 주문 Phase 2 작업 현황 — 완료·미완료 포함 (2026-06-24 업데이트)
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
- **워크트리**: `/Users/parkjongsun/repository/dentlink-client-allonx`
- **최신 커밋 (2026-06-24)**: `9f880931d` — push 완료
- **베이스**: `origin/release/v1.76.0` rebase 완료 (컨플릭 16개 해결)
- **PR #4281**: feature/DL-15197 → release/v1.76.0
- **PR #4282**: feature/DL-15197 → develop

**Why:** AOX 컨설팅 상품 전용 주문 플로우 구축. 핵심은 `productType === "CONSULTATION"` 여부로 UI 분기.

---

## 핵심 설계 원칙 (반드시 유지)

- **ID 하드코딩 금지**: 상품 ID, 카테고리 ID 등 환경 의존 ID 절대 사용 금지
- **서버 타입 기준**: `type === "CONSULTATION"` 판단은 오직 서버가 내려주는 값 기준
- **Admin 책임**: 어떤 상품을 CONSULTATION으로 설정할지는 Admin에서 컨트롤 — FE 코드와 무관

---

## 완료된 작업 ✅ (전체)

### Phase 1 — 기반 (이전 세션)
| 커밋 | 내용 |
|---|---|
| `7334f5ef2` | productPrice API 함수·쿼리 훅 추가 (clinic/admin) |
| `c57a09e97` | 타입 정의: PriceDto·ProductPriceGroup·ProductPriceListDto, ProductAdminDto.type |
| `ac37b838c` | 어드민 상품 type(PROSTHETICS/DESIGN/CONSULTATION) CRUD UI |
| `932eb79d5` | 주문 3단계 가격 조회 연동 (clinic/admin productPriceData 흐름) |
| `149c799e5` | EstimatedCostPanel 초기 구현, OrderOptionForm 배치 |
| `6f41ed31f` | EstimatedCostPanel 컨설팅 전용 가드·중복 식별자 수정 |
| `c7e56bf5b` | 어드민 상품 등록·수정 폼에 상품 유형 Radio UI 추가 |

### Phase 2 — 이번 세션 (2026-06-23 ~ 24)
| 커밋 | 내용 |
|---|---|
| `892bd40bd` | order.types에 productType 추가, OrderOptionForm isConsultation 가드 |
| `6d2e183a3` | MANDATORY 처리·스웨거 동기화 전체 |
| `8039d28e3` | 어드민 상품 옵션 이미지 업로드 및 조회 표시 |
| `a20615590` | 주문 3단계 옵션 이미지 표시 + OptionImage 컴포넌트 추가 |
| `2ccdf9b02` | OptionImage full-width 독립 표시 개선 |
| `6abf1d45e` | 주문 상세 EstimatedCostPanel — 서버 저장값 기반 (useEstimatedCostFromOrder) |
| `1faf61e4f` | Estimated Cost 패널 노출 조건 개선 (isConsultationOrder 양방향 감지) |
| `4dee024b2` | 주문 2단계 CONSULTATION 차단·필터 및 3단계 가격 패널 조건 적용 |

---

## 구현 내용 상세

### 주문 2단계 (상품 선택)
- **New 주문(clinic)**: `p.type === "CONSULTATION"` 상품만 노출 — Admin에서 type 세팅으로 컨트롤
- **Follow-up 주문(clinic)**: 전체 노출
- **기공소/어드민**: Order Type 무관 전체 노출
- **CONSULTATION 혼합 차단**: `handleReplaceCase` → 타입 충돌 시 `onConsultationMixingBlocked?.()` 콜백 → 토스트 경고
- **격리 범위**: `isOfficeService && isDentureCategory` 조건으로만 진입

### 주문 3단계 (옵션/가격)
- **EstimatedCostPanel 노출**: `isConsultation && serviceType !== "LAB"` — 치과/어드민만
- **isConsultation 감지**: `caseGroups[].productType === "CONSULTATION"` (admin 경로) OR `product.caseGroups[].productType === "CONSULTATION"` (clinic 경로) 양방향
- **악궁 x2 계산**: `toothNotationChartType === "ARCH"` 기반 (CaseNavigation과 동일 기준), catalog API 의존 없음
- **기존 상품 영향 없음**: EstimatedCostPanel이 CONSULTATION 전용이라 기존 코드 경로 미진입

### 주문 상세
- **CONSULTATION이면**: Order Summary 자리를 EstimatedCostPanel로 대체 (공존 아님)
- **데이터 소스**: `useEstimatedCostFromOrder` — `caseGroup.price` + `caseGroup.optionPrice` 서버 저장값 그대로
- **admin 경로**: `order.caseGroups`, **clinic 경로**: `order.product?.caseGroups` 양방향 감지
- **대기 중**: BE에서 `caseGroups[].price` / `caseGroups[].optionPrice` 값 응답 확인 필요 (현재 DEV null)

### 옵션 이미지
- `OptionImage.tsx` — banner 모드, option UI 위 full-width 독립 렌더
- 클리닉 API는 현재 imageUrl 미응답 — BE 요청 완료, FE 준비됨

### MANDATORY 옵션
- UI 렌더 스킵 (`return null`)
- Validation 제외
- 가격 계산엔 항상 포함

---

## 미완료 항목 ❌

| # | 항목 | 설명 |
|---|---|---|
| 1 | 주문 상세 가격 표시 | BE에서 `caseGroups[].price` / `optionPrice` DEV 응답 확인 후 검증 |

---

## 요구사항 대조표 (최종)

| # | 요구사항 | 상태 |
|---|---|---|
| 1 | New 주문: CONSULTATION 타입만 노출 | ✅ |
| 2 | Follow-up: 전체 노출 | ✅ |
| 3 | 기공소/어드민 2단계: 제한 없음 | ✅ |
| 4 | CONSULTATION 혼합 불가 | ✅ |
| 5 | 혼합 시 토스트 경고 | ✅ |
| 6 | 3단계 패널: 치과/어드민 노출 | ✅ |
| 7 | 3단계 패널: 기공소 미노출 | ✅ |
| 8 | 악궁당 x2 (상하악) | ✅ |
| 9 | Surgical Guide x2 미적용 | ✅ |
| 10 | 상품 노출 기준: ID 아닌 type | ✅ (Admin 세팅 영역) |
| 11 | 주문 상세: CONSULTATION이면 Order Summary 대체 | ✅ |
| 12 | 주문 상세: 서버 저장값 표시 | ✅ (BE 데이터 확인 대기) |

---

## 참고: 관련 API 엔드포인트

| 서비스 | 엔드포인트 | 특이사항 |
|--------|-----------|---------|
| clinic | `GET /office/products/prices` | productIds만 필요 |
| admin  | `GET /admin/products/prices` | productIds + **officeId 필수** |

**How to apply:** 다음 세션 재개 시 미완료 항목 확인 후 BE 데이터 검증 → PR 생성 순서로 진행.

---
name: project-dl13254-step2-spec
description: DL-13254 주문 2단계 PM 스펙 — 상품 노출 조건·컨설팅 혼합 제한·예상가격 표시
metadata: 
  node_type: memory
  type: project
  originSessionId: d8427aae-4557-444a-8253-ebfe224da2ec
---

## 주문 2단계 PM 스펙 (원문 보존)

### 치과 > 주문 > 2단계

- 컨설팅 주문서는 다른 상품과 함께 생성 못하도록 막기
- Order Type에 따른 상품 노출 조건 적용
  - **Order Type = New**
    - AoX Complimentary Consulting (productId: 2712)
    - Provisional Bridge Design (productId: 2714)
  - **Order Type = Follow-up**
    - AoX Complimentary Consulting
    - Provisional Bridge Design
    - Verification Jig & Wax Rim
    - 1st PMMA
    - 2nd PMMA
    - 3rd PMMA
    - All on 4 (4 implant sites)
    - All on 5 (5 implant sites)
    - All on 6 (6 implant sites)
    - All on 7 (7 implant sites)
    - All on 8 (8 implant sites)
    - Model Printing
    - Lab Analog
- 주문서 예상 가격 노출
  - 예상 가격은 치과/관리자에게만 노출 (기공소 노출 X)
  - Surgical Guide를 제외한 모든 상품: 악궁당 가격 × 2 추가
    - 예) 주문 2단계에서 상·하악 모두 선택 시 가격 × 2

### 치과 > 주문 > 주문상세

- AoX 컨설팅 주문서의 경우, Order Summary 대신 **Estimated Cost** 노출

### 기공소/관리자 > 주문 > 2단계

- Order Type 관계없이 모든 상품 선택 가능 (제한 없음)

---

## 구현 시 주요 고려사항

- **상품 노출 조건**: Order Type(`NEW` / `FOLLOW_UP`)을 기준으로 2단계에서 보여줄 상품 목록 필터링
- **혼합 제한**: 장바구니(caseGroups)에 CONSULTATION 상품이 있으면 다른 상품 추가 불가, 반대도 마찬가지
- **예상 가격 계산**: 악궁(arch) 선택 수 × 단가 (Surgical Guide 예외)
- **주문상세 Estimated Cost**: clinic 주문상세에서 `isConsultation` 조건으로 Order Summary → Estimated Cost 패널 교체
- **lab/admin 2단계**: 기존 상품 노출 로직 그대로 유지

**How to apply:** 주문 2단계 작업 착수 전 이 스펙을 기준으로 구현 범위 확정 후 진행.

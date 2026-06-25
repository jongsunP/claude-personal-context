---
name: project-dl15287-progress
description: DL-15287 Shippable 상품 구분 명칭 Physical로 변경 작업 현황
metadata: 
  node_type: memory
  type: project
  originSessionId: 73d5cbfd-0711-48b9-8f28-fcab732e0fc0
---

## 현황: PR 오픈 (#4285)

**브랜치:** `feature/DL-15287` (base: `release/v1.76.0`)
**PR:** #4285 → `release/v1.76.0` (https://github.com/Innvoaid/dentlink-client/pull/4285)

**Why:** 'Shippable'이 Digital과 대칭되지 않고 공급자 관점 언어 → 'Physical'로 명칭 통일

**How to apply:** 다음 대화에서 이 티켓 이어서 작업 시 PR 머지 여부부터 확인.

---

## 변경 내용

파일 1개 (`OrderCategoryFormContentSelectProduct.tsx`), 문자열 3개 수정:

- 탭 라벨: `"Shippable"` → `"Physical"`
- Physical 안내 문구: `"These are physical products that will be shipped to your office."`
- Digital 안내 문구: `"These are digital products. No physical shipment included."`

내부 식별자(`isShippable`, `SHIPPABLE`, `shippableProducts`)는 API 계약값이므로 변경 범위 제외.

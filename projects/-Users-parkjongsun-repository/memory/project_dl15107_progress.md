---
name: project-dl15107-progress
description: DL-15107 Denture 워크플로우 SELECT 옵션 구조 변경 작업 현황
metadata: 
  node_type: memory
  type: project
  originSessionId: eabe9861-890d-4891-9906-2b90aae71cb5
---

## 현황: QA 픽스 PR 오픈 (#4284)

**브랜치:** `feature/DL-15107`
**워크트리 경로:** `/Users/parkjongsun/Repository/dentlink-client-denture`
**PR:** #4266 → `release/v1.76.0` (https://github.com/Innvoaid/dentlink-client/pull/4266)
**QA 픽스 PR:** #4284 (`feature/DL-15107-qa-1` → `release/v1.76.0`) — SELECT 버튼 flex:1 제거로 콘텐츠 크기 복원

**Why:** [치과] Denture 26 Q3 구조 변경 — Partial Denture 삭제, 선택 화면 2열 레이아웃 적용, Temporary Denture 안내 문구 To-be 반영

**How to apply:** 다음 대화에서 이 티켓 이어서 작업 시 PR 머지 여부부터 확인.

---

## 변경 파일 (3개)

- `shared/ui/src/Order/OrderForm/OrderCategoryForm/OrderCategoryFormWorkflow/component/field/OrderCategoryFormWorkflowFieldSelect.tsx`
- `shared/ui/src/Order/OrderForm/OrderCategoryForm/OrderCategoryFormWorkflow/configs/OrderCategoryFormWorkflow.types.ts`
- `shared/ui/src/Order/OrderForm/OrderCategoryForm/OrderCategoryFormWorkflow/configs/dentures.config.tsx`

## 커밋 (4개, master rebase 완료)

1. `[DL-15107]` Denture 워크플로우 SELECT 옵션 행 분할 및 타입/라벨 정리
2. `fix` Temporary Denture 선택 안내 문구 To-be 반영
3. `fix` columnsPerRow 행 레이아웃 flex-wrap 및 균등 폭 적용
4. `fix` columnsPerRow 음수 방어 조건 추가 및 renderOptionItem 타입 오류 수정

## 최종 검토 결과 (2026-06-24)

**결론: PASS** — FE 코드 추가 수정 불필요

- 전 항목 구현 완료 확인 (Partial Denture 삭제, 2열 레이아웃, 문구 변경, Wax Rim 단계 삭제, Try-in 타이틀·안내문구 변경)
- 이미지(waxtryin1/2.png)는 CDN 서빙 구조라 코드 경로 변경 불필요
- **배포 전 확인 필요**: CDN 이미지 교체 시점에 `waxtryin1.png?t=XXXXXX` 캐시버스팅 쿼리 코드 추가 필요 (선례: frameworkTryIn1.png?t=260608)

---

## 영향 범위

Denture 타입 주문의 워크플로우 SELECT 단계 UI만 변경 (데이터 구조 변경 없음).

### Clinic (치과)
| 페이지 | 경로 | 영향 |
|---|---|---|
| 주문 생성 | `/orders/create` | Denture 워크플로우 SELECT 화면 |
| 주문 수정 | `/orders/[order_id]/[step]` | 기존 Denture 주문 편집 시 |

### Lab (기공소)
| 페이지 | 경로 | 영향 |
|---|---|---|
| 주문 생성 | `/orders/create` | Denture 워크플로우 SELECT 화면 |
| 주문 수정 | `/orders/[order_id]/[step]` | 기존 Denture 주문 편집 시 |
| 주문 상세 | `/orders/[order_id]` | `OrderDetailBoxWorkflow` — 워크플로우 요약 표시 |

### Admin
| 페이지 | 경로 | 영향 |
|---|---|---|
| 주문 생성 | `/orders/create` | Denture 워크플로우 SELECT 화면 |
| 주문 수정 | `/orders/[order_id]/[step]` | 기존 Denture 주문 편집 시 |
| 주문 상세 | `/orders/[order_id]` | 워크플로우 요약 표시 |
| 배송 상세 | `/shipments/[shipment_id]` | OrderForm 포함 |

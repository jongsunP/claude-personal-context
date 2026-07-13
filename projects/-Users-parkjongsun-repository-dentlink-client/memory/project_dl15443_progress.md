---
name: project_dl15443_progress
description: "DL-15443 E2E Denture 시나리오 교체 — PR #4337 생성 완료"
metadata: 
  node_type: memory
  type: project
  originSessionId: b38ba49f-0c20-4c71-8ac7-32e7ba45c50a
---

## 작업 현황: DL-15443 — PR 오픈 완료

**Why:** Partial Denture (incl. Flipper) 제품이 스테이징에서 사라져 Partial Denture with Framework로 교체.

**How to apply:** 완료. PR #4337 오픈 (→ release/v1.77.0). 현재 `dentlink-client-e2e` 워크트리는 DL-15560(진단 브랜치)으로 이동.

---

## PR

- **#4337**: https://github.com/Innvoaid/dentlink-client/pull/4337
- **타겟**: `release/v1.77.0`
- **브랜치**: `feature/DL-15443`

---

## 최종 변경 파일

| 파일 | 내용 |
|---|---|
| `e2e/clinic/steps/order/order-cases/denture.ts` | Partial Denture with Framework로 교체, Co-Cr Frame/radioOptions/shadeGuideValue 추가 |
| `e2e/clinic/steps/order/order-step3-option.ts` | radioOptions/shadeGuideValue 처리 추가 (master 원본 PUT 응답 대기 유지, 사이드이펙트 없음) |
| `e2e/clinic/steps/order/order-types.ts` | radioOptions, shadeGuideValue 타입 추가 |
| `e2e/clinic/specs/02_onboarding.spec.ts` | waitForURL timeout 45s 고정 (Next.js 컴파일 ~22s 대응) |

**order-step2-product.ts는 master 원본 그대로 유지** — 변경 불필요 확인됨.

---

## 핵심 결정

- `order-step2-product.ts` Workflow 로직을 건드리면 ISV/Crown 등 다른 케이스에 사이드이펙트 발생 → master 원본 유지
- `order-step3-option.ts`는 `radioOptions`/`shadeGuideValue` 처리만 추가, PUT API 응답 대기는 master 원본 유지

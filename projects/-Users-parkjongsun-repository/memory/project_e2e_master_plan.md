---
name: project-e2e-master-plan
description: E2E 자동화 현재 목표 — v1.77.1 버전업 대응. 작업현황·블로커·노하우는 전부 repo에서 관리 (위치 포인터)
metadata:
  node_type: memory
  type: project
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

## 히스토리 요약

1. **원래 E2E 작업** — `feature/DL-14805-1-3`, PR #4200 머지 완료 (master)
   - 전 spec 계정·오피스 e2e 전용, 팀 오염 차단, flaky waitForResponse 전수 제거
2. **v1.77.1 패키지 업그레이드** — React Query v5, Next.js 16, Styled-Components v6
   - 업그레이드 이후 E2E 다수 실패 → `feature/DL-15560`에서 대응 작업

## 세션 환경

- **현재 작업 워크트리:** `dentlink-client-e2e` → 브랜치 `feature/DL-15560`
- **remote push 완료:** `origin/feature/DL-15560`

## 현재 상태 (2026-07-14 기준)

### DL-15560 수정 내용 (커밋 완료)

| 수정 파일 | 내용 |
|-----------|------|
| `playwright.config.ts` | 로컬 `navigationTimeout` 30s → 45s |
| `timeouts.ts` | 로컬 `E2E_TIMEOUT_MS` 15s → 20s |
| `order-setup.ts` | `CHANGE_OFFICE_WAIT` 분리 (staging 30s) + `waitForLoadState` 추가 |
| 모든 orders/labStatus spec | `beforeAll` 내 `test.setTimeout(staging: 5min)` 추가 |
| `signup-step{1,2,3}.ts`, `shipment-order.ts`, `lab.ts`, `withdrawal.ts` | "Next" 버튼 `exact: true` 일괄 적용 |
| `shipment-create.ts` | `/lab/employers/own/clients` API `page.route()` 모킹 추가 |
| `order-step4-additional.ts` | `selectPickupDate`: pickup POST 200 대기 + turnaround-date 재호출 대기. `selectTurnaroundDate`: `toBeEnabled` 체크 추가 |
| `order-step2-product.ts` | standard 모드에 products API 응답 대기 추가. Workflow 모드 15_000/10_000 하드코딩 → E2E_TIMEOUT_MS |
| `labStatus.spec.ts` | Design Confirmation `.check({ force: true })` → `.click({ force: true })` |
| `SKILL.md` | 로컬·스테이징 순차 실행 주의사항 추가 |

### 검증 현황 (2026-07-14)

- **스테이징 수정금지 상품**: 전부 존재 확인 (isDisplay: true) — 어드민 작업 불필요
- **로컬 1회 (단독)**: 91 passed, 3 failed (crown/denture/veneer step4), 5 skipped
  - 실패 원인: pickup POST 항상 400 — 로컬 어드민 픽업 서비스 설정 문제 (스테이징은 통과됨)
- **스테이징 1회 (단독, b5zl7z40s)**: 70 passed, 5 failed
  - crown step4 통과 → 스테이징 pickup 설정 OK
- **스테이징 2회 (단독, b6rrtmf3u)**: 66 passed, 6 failed

### 남은 블로커

#### 블로커 A: 스테이징 step2 상품 선택 간헐적 실패
- crown/denture/instasmile/veneer step2 → `selectProduct` 90s 타임아웃
- 스크린샷 확인 결과: "Choose Your Product" 화면에서 **Category 드롭다운이 비어있음**
  - categories API가 90s 동안 응답 안 하거나 아예 호출이 안 된 상태
  - denture/instasmile은 2회 모두 실패 → 지속적 실패 (단순 flaky 아님)
  - crown/veneer는 1회차 통과, 2회차 실패 → flaky
- **핵심 미확인 사항**: 스테이징 앱에서 유저가 직접 주문 step2를 열었을 때 카테고리가 정상 로드되는가?
  - 된다 → v1.77.1 이후 RQ v5로 categories 쿼리 `enabled` 조건 변경 → E2E 코드에서 해당 상태 미충족 가능성
  - 안 된다 → 앱 자체 문제, E2E 수정 아님

#### 블로커 B: 스테이징 labStatus step1 실패
- 주문 생성 중 step2 "Digital" 버튼 90s 타임아웃 (2회차)
- 1회차에서는 Design Confirmation 단계에서 실패 — 다른 지점에서 실패
- step2 UI 자체가 간헐적으로 제대로 로드 안 되는 것으로 추정
- 블로커 A 해결 시 함께 해결될 가능성

#### 블로커 C: 로컬 crown/denture/veneer step4 실패
- pickup POST → 400 ("Cannot add order to pickup")
- 로컬 어드민에서 픽업 서비스 활성화 필요
- 스테이징은 이미 통과됨 → 코드 수정은 완료, 환경 설정만 필요

### 완결 기준

1. 블로커 A/B 해결 후 스테이징 1회 통과
2. 블로커 C 해결 후 로컬 1회 통과
3. 스테이징 2회 + 로컬 2회 연속 통과 → **완결**

## 단일 진실 소스 원칙 — 작업현황은 repo에서 관리

개인 메모리에는 작업현황·백로그·노하우를 **복제하지 않는다**. 전부 repo 파일이 진실 소스:

| 내용 | 위치 (repo) |
|------|------------|
| 미착수 시나리오 백로그 | `.claude/skills/e2e/references/03-scenario-backlog.md` |
| 실패 패턴·노하우 | `.claude/skills/e2e/SKILL.md` |
| 실행 방법·환경변수 | `e2e/README.md` |

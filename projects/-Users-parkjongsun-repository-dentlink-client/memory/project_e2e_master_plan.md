---
name: project-e2e-master-plan
description: E2E 자동화 현재 목표 — 유지·성장 모드. 작업현황·백로그·노하우는 전부 repo에서 관리 (위치 포인터)
metadata:
  node_type: memory
  type: project
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

## 세션 환경

- **현재 작업 워크트리:** `dentlink-client-e2e` → 브랜치 `feature/DL-15560`
- **세션 목적:** E2E 관련 작업 및 테스트 전용

## 현재 상태 (2026-07-13 기준)

**패키지 업그레이드(Next.js 16 / RQ v5 / SC v6) 이후 E2E 수정 완료 — `feature/DL-15560`.**

### DL-15560 수정 내용 (완료)

| 수정 파일 | 내용 |
|-----------|------|
| `playwright.config.ts` | 로컬 `navigationTimeout` 30s → 45s (Next.js 16 이후 페이지 전환 느려짐 대응) |
| `timeouts.ts` | 로컬 `E2E_TIMEOUT_MS` 15s → 20s |
| `order-setup.ts` | `CHANGE_OFFICE_WAIT` 분리 (staging 30s) + `waitForLoadState("domcontentloaded")` 추가 |
| 모든 orders/labStatus spec | `beforeAll` 내 `test.setTimeout(staging: 5min)` 추가 |
| `signup-step{1,2,3}.ts`, `shipment-order.ts`, `lab.ts` 등 | "Next" 버튼 `exact: true` 일괄 적용 |
| `shipment-create.ts` | `/lab/employers/own/clients` API `page.route()` 모킹 추가 (Elasticsearch 환경 의존 제거) |

### 검증 결과

- **로컬 2연속**: ✅ 94 passed, 5 skipped × 2회
- **스테이징**: ❌ crown/veneer/step4-ui-state/labStatus step2 실패 — 스테이징 어드민 상품 미등록 (코드 무관). 나머지는 통과.

### 어드민 상품 재등록 필요 (미완료)

- `Crown(수정금지,회귀테스트용)` — Restorations 카테고리
- `Design Service - Crown(수정금지,회귀테스트용,배송없음)` 의 Digital 서브 상품
- 재등록 후 `pnpm e2e:clinic:stg` 2연속 통과 확인 필요

### 완료된 것 (이전 이력)
- 모든 E2E 계정·오피스 e2e 전용 완료 — 외부 계정 의존성 0
- 팀 오염 근본 차단 + 방어코드 전 spec 적용
- flaky waitForResponse 전수 제거
- 신규 spec: 00_signup_step4_office_find (Y/N 분기)
- PR #4200 머지 완료 (`feature/DL-14805-1-3` → master)

**버전업 대응 코드 수정 완료. 어드민 환경 세팅 후 스테이징 2연속 통과로 최종 완료.**

## 단일 진실 소스 원칙 — 작업현황은 repo에서 관리

개인 메모리에는 작업현황·백로그·노하우를 **복제하지 않는다**. 전부 repo 파일이 진실 소스:

| 내용 | 위치 (repo) |
|------|------------|
| 미착수 시나리오 백로그 (A: 세팅 정보 대기 / B: 의도적 후순위) | `.claude/skills/e2e/references/03-scenario-backlog.md` |
| 실패 패턴·노하우 (isVisible timeout 함정, JWT base64url 등) | `.claude/skills/e2e/SKILL.md` |
| 자동화 불가/조건부/미구현 3분류 원칙 | SKILL.md 동일 섹션 |
| 실행 방법·환경변수·트러블슈팅 | `e2e/README.md` |

**How to apply:** e2e 작업 시작 시 위 repo 파일들을 먼저 읽는다. 진행사항이 바뀌면 repo 파일을 수정하고, 이 메모리에는 모드 전환(유지→대규모 개편 등) 같은 방향성 변화만 기록한다.

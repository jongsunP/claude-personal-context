---
name: project-e2e-local-goal
description: e2e 로컬/스테이징 전 스크립트 정상화 목표 — 완료 조건 및 미해결 이슈
metadata: 
  node_type: memory
  type: project
  originSessionId: 80c988c8-7768-4224-aec2-f6b760d3b176
---

브랜치: `feature/DL-14805-e2e`
목표: `package.json`의 아래 4개 스크립트가 모두 정상 동작해야 PR 가능

| 스크립트 | 환경 |
|---------|------|
| `pnpm e2e:clinic` | 로컬 (clinic:3001, lab:3006, admin:3003) |
| `pnpm e2e:clinic:ui` | 로컬 UI 모드 |
| `pnpm e2e:clinic:stg` | 스테이징 |
| `pnpm e2e:clinic:ui:stg` | 스테이징 UI 모드 |

**Why:** 사용자가 개발 중 직접 실행하는 e2e 스크립트 모두 안정적으로 동작해야 함.
**How to apply:** PR 생성 전 반드시 4개 스크립트 정상화 확인.

## 수정 완료 이슈 (2026-06-04)

### 1. `04_labShipment` — lab 서버 미실행
- `pnpm e2e:clinic` 스크립트 사용 시 `NEXT_PUBLIC_E2E_BASE_LAB_URL` 자동 설정 → 해결됨

### 2. `00_signup` 병원생성 — dev API "Data integrity error" ✅ 수정
- **원인**: 초 단위 4자리 suffix → ~2.7시간 주기 재사용으로 DB unique 충돌
- **수정**: ms 기반 suffix로 교체 (`_ts.toString().slice(-8)`) — 병원명도 초 단위 포함
- **파일**: `e2e/clinic/specs/00_signup.spec.ts:47-52`

### 3. `02_onboarding` Complete Your Setup — employerId null ✅ 수정
- **원인**: dev API 병원 승인 후 employee 레코드 생성 지연 → `findEmployerIdByName` null 반환
- **수정**: `findEmployerIdByName` 30초 폴링(3초 간격)으로 변경, `tryFindEmployerIdByName` 분리
- **파일**: `e2e/setup/global-setup.ts`

### 4. `06_linkTalk` — 모달이 주문 클릭 차단 ✅ 수정
- **원인**: dev React Query 데이터 로드가 3s 초과 → 팝업 감지 실패
- **수정**: "Don't show again today" 대기 3s→8s, 클릭 후 modal hidden 명시적 대기 추가
- **파일**: `e2e/clinic/specs/06_linkTalk.spec.ts`

## 추가 수정 (2026-06-09 — feature/DL-14805-1-3)

### 5. `05_labStatus` beforeAll 타임아웃 (로컬) ✅ 수정
- **원인 1**: `test.setTimeout`이 describe 스코프에서 호출되면 테스트에만 적용 — `beforeAll` 훅은 config `timeout: 30_000` 그대로 사용
- **원인 2**: `browser.newContext()`로 직접 생성한 컨텍스트는 `clinicUse`의 `navigationTimeout` 미상속 → `page.goto("localhost:3006")` lab 서버 JIT 컴파일이 30s 초과
- **수정**: `beforeAll` 내부에서 `test.setTimeout(90_000)` + `page.setDefaultNavigationTimeout(90_000)` 명시

### 6. `02_onboarding` Scanner 페이지 이동 타임아웃 (로컬) ✅ 수정
- **원인**: `E2E_TIMEOUT_MS = 15_000` (로컬) — navigator 타임아웃으로 사용 시 dev 서버 SSR 컴파일 시간 초과
- **수정**: `waitForURL` timeout 파라미터 제거 → config 기본값 사용 (로컬 30s, 스테이징 120s)

## 최종 현황 (2026-06-09)

로컬 3회 연속 통과 — 팀 오염 없음, 속도 정상.
스테이징 3회 연속 통과 — 이전 변경사항과 호환 확인.

**4개 스크립트 모두 정상** ✅

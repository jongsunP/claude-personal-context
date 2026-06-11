---
name: project-e2e-progress
description: DL-14805 e2e 자동화 작업 진행 상황 — 브랜치, 완료/잔여 작업, 다음 방향
metadata:
  type: project
---

현재 브랜치: `feature/DL-14805-1-3`
E2E 작업 폴더: `/Users/parkjongsun/Repository/dentlink-client-e2e` (git worktree)
상태: **수동 재테스트 대기 중 — addInitScript 근본 해결 완료 (2026-06-09)**
마지막 커밋: `44e17c6b6 fix(e2e): addInitScript로 팀 오염 재발 경로 근본 차단 + 90s 대기 제거`
PR: `feature/DL-14805-1-3` → `release/v1.75.0` (#4200)

## 세션 시작 시 읽어야 할 파일

1. `e2e/README.md` — 코딩 가이드라인, 팀 오염 진단 섹션
2. `.claude/skills/e2e/SKILL.md` — E2E 스킬 진입점
3. `e2e/clinic/steps/order/order-setup.ts` — 팀 오염 방어 핵심 코드

## 팀 오염 방어 현황 (2026-06-09 완료)

3중 방어:
1. `activateDefaultTeamOnServer()` — 서버 DB를 기본 팀으로 확정 (fresh 로그인 + PATCH)
2. `page.addInitScript` — 앱 JS 실행 전 올바른 `activeEmployeeId` 주입 (재오염 경로 차단)
3. runtime PATCH — 브라우저 세션 토큰도 올바른 팀으로 동기화 (runtimeToken→freshToken 재시도)

초기 팀 확인 대기: 90s → 10s(스테이징) / 3s(로컬). 이상 시 즉시 Change Office fallback.

재오염 근본 원인: `clinic.json` localStorage가 온보딩 팀 ID → `page.goto('/')` 시 앱 auto-PATCH → 서버 DB 재오염.
해결: `addInitScript`가 앱 JS보다 먼저 실행되어 localStorage 선점.

## 잔여 작업

### 1. 수동 테스트 검증 (진행 중)
- addInitScript 수정 후 팀 오염 재발 여부 확인
- `prepareOrderSession` 소요 시간 10s 이내인지 확인
- 잔여 flaky 3개 확인:
  - `step4-ui-state.spec.ts` — Insta Smile Vision 카테고리 액션 버튼
  - `06_linkTalk.spec.ts` — 덴트링크서포트
  - `07_billing.spec.ts` — Unpaid 결제 데이터 없음

### 2. 이후 방향 (테스트 결과 확인 후)
- 잔여 flaky 성공/실패 판별 → 오염 파생이면 자연 해결, 아니면 별도 수정
- DL-14803 분류 A: 리퍼럴/BP 진입 크레딧 메시지 spec
- DL-14803 분류 B / DL-14811 ISV: Request Access 플로우 (`feature/DL-14805-2` 기존 작업 있음)

## 운영 명령어

```bash
pnpm e2e:clinic:stg           # 스테이징 전체
pnpm e2e:clinic               # 로컬 전체
pnpm e2e:clinic:ui:stg        # 스테이징 UI 모드
# 특정 spec만
NODE_ENV=staging pnpm exec playwright test e2e/clinic/specs/03_orders/crown.spec.ts --project=clinic --reporter=list
```

## ⚠️ 테스트 실행 규칙
- 스테이징과 로컬을 절대 동시에 실행하지 않는다 (동일 API 서버 동일 계정 → 세션 충돌)

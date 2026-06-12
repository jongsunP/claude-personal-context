---
name: project-e2e-master-plan
description: E2E 자동화 현재 목표 — 유지·성장 모드. 작업현황·백로그·노하우는 전부 repo에서 관리 (위치 포인터)
metadata:
  node_type: memory
  type: project
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

## 현재 상태 (2026-06-12 기준)

`feature/DL-14805-1-3` — **커밋·push 완료. PR 존재 (기존 PR 사용)**

### 주요 변경 (누적)
- 신규 spec: `00_signup_step4_office_find` (Signup Step4 — Y/N 분기)
- `00_signup.spec.ts`, `00_signup_step2_3_validation.spec.ts`: `OTHER_ACCOUNT` → `SIGNUP_TEST_ACCOUNT` 분리 (tata.test5 보호)
- `e2e/scripts/` 폴더 신설 — one-off setup 스크립트 이동 (specs/에는 실제 시나리오만)
- `playwright.config.ts`: `clinic-scripts` project 추가
- flaky `waitForResponse` 전수 제거: 낙관적 네비게이션 abort 패턴(waitForURL + waitForResponse 동시) 및 단계별 저장 오탐 패턴 근본 수정
- `02_onboarding.spec.ts`: `test.setTimeout(60_000)` 추가 (Next.js JIT 컴파일 대응)
- SKILL.md: 실패 패턴 2건 추가 (abort 패턴, API 미호출 패턴)
- README, 백로그 문서 업데이트

### 검증 진행 상황
- 로컬: 2연속 94 passed / 0 failed ✅
- 스테이징: 2연속 94 passed / 0 failed ✅

**유지·성장 모드.**

## 단일 진실 소스 원칙 — 작업현황은 repo에서 관리

개인 메모리에는 작업현황·백로그·노하우를 **복제하지 않는다**. 전부 repo 파일이 진실 소스:

| 내용 | 위치 (repo) |
|------|------------|
| 미착수 시나리오 백로그 (A: 세팅 정보 대기 / B: 의도적 후순위) | `.claude/skills/e2e/references/03-scenario-backlog.md` |
| 실패 패턴·노하우 (isVisible timeout 함정, JWT base64url 등) | `.claude/skills/e2e/SKILL.md` |
| 자동화 불가/조건부/미구현 3분류 원칙 | SKILL.md 동일 섹션 |
| 실행 방법·환경변수·트러블슈팅 | `e2e/README.md` |

**How to apply:** e2e 작업 시작 시 위 repo 파일들을 먼저 읽는다. 진행사항이 바뀌면 repo 파일을 수정하고, 이 메모리에는 모드 전환(유지→대규모 개편 등) 같은 방향성 변화만 기록한다.

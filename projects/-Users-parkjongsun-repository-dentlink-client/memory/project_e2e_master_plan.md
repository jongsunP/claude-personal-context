---
name: project-e2e-master-plan
description: E2E 자동화 현재 목표 — 유지·성장 모드. 작업현황·백로그·노하우는 전부 repo에서 관리 (위치 포인터)
metadata:
  node_type: memory
  type: project
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

## 현재 상태 (2026-06-17 기준)

`feature/DL-14805-1-3` — **모든 작업 완료. PR #4200 Ready for review.**

### 검증 결과
- 스테이징 전체 통과 ✅ (2026-06-17 사용자 직접 확인)
- 로컬 전체 통과 ✅ (2026-06-17 사용자 직접 확인, `e2e:clinic:ui` 전체 실행)

### 이번 브랜치 주요 변경
- 신규 spec: `00_signup_step4_office_find` (Signup Step4 — Y/N 분기)
- `SIGNUP_TEST_ACCOUNT` 분리 (e2e.signup 전용, tata.test5 보호)
- `e2e/scripts/` 신설 + `clinic-scripts` playwright project 추가
- flaky `waitForResponse` 전수 제거 (abort 패턴, API 미호출 패턴)
- `browser.newContext()` page timeout 미상속 전수 수정
- 모든 E2E 계정·오피스 e2e 전용 완료 — 외부 계정 의존성 0
- 배송 생성 `.nth(0)` 잠재 버그 수정 → `.filter({ hasText: orderId }).first()`
- 회원가입 입력값 e2e 전용 통일 (`firstName: "Auto"`, `ownerName: "Auto Owner"`)
- `signup-step3` combobox locator name 속성 제거 (pre-selected 시 accessible name 변경 방지)
- `00_signup` serial 타임아웃 보강 (로컬 30s→60s, 스테이징 120s 유지)

### 다음 할 일

1. **PR #4200 머지** — 팀 확인 후 진행 (혼자 머지 안 함)
2. **다음 E2E 시나리오 추가** — `.claude/skills/e2e/references/03-scenario-backlog.md` 백로그 참고. `/e2e <시나리오>` 스킬로 진입

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

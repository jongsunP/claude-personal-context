---
name: project-e2e-master-plan
description: E2E 자동화 현재 목표 — 유지·성장 모드. 작업현황·백로그·노하우는 전부 repo에서 관리 (위치 포인터)
metadata:
  node_type: memory
  type: project
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

## 현재 상태 (2026-06-11 기준)

`feature/DL-14805-1-3` — **검증 중, 커밋 전**

### 이번 세션 주요 변경
- 신규 spec: `00_signup_step4_office_find` (Signup Step4 — Y/N 분기)
- `00_signup.spec.ts`, `00_signup_step2_3_validation.spec.ts`: `OTHER_ACCOUNT` → `SIGNUP_TEST_ACCOUNT` 분리 (tata.test5 보호)
- `e2e/scripts/` 폴더 신설 — one-off setup 스크립트 이동 (specs/에는 실제 시나리오만)
- `playwright.config.ts`: `clinic-scripts` project 추가
- 계정 정리: `e2e.signup` (signup/withdraw 테스트용), `tata.test5` (Y 분기 영구 계정)
- README, SKILL.md, 백로그 문서 업데이트

### 검증 진행 상황
- 로컬: 여러 번 94 passed / 0 failed ✅
- 스테이징: 1회 성공 ✅ → 추가 반복 진행 예정 → 로컬 추가 반복 예정 → 커밋

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

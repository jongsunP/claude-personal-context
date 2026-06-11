---
name: project-e2e-master-plan
description: E2E 자동화 현재 목표 — 유지·성장 모드. 작업현황·백로그·노하우는 전부 repo에서 관리 (위치 포인터)
metadata: 
  node_type: memory
  type: project
  originSessionId: 8ef53b57-e747-49cc-90e8-87c04723f3f4
---

## 현재 상태 (2026-06-11 기준)

`feature/DL-14805-1-3` — **코드 완료, 커밋 전 수동 테스트 중**
- 추가 spec: `00_signup_step4_office_find` (Signup Step4 — Create Office Y/N 분기)
- 헤드리스 테스트: 94 passed, 0 failed (스테이징 확인 완료, 로컬 확인 중)
- staging REQUEST_ACCESS 오피스 재생성 완료 (employer 2086, 기존 1943은 삭제됨)

**유지·성장 모드.**

- **신규 시나리오 대응**: PM/기획 요청 → `/e2e` 스킬로 코드 추가 → 테스트 → 재수정
- **스킬 가꾸기**: 실패 패턴, 새 함수, 환경 변경사항 발견 시 SKILL.md 업데이트

## 단일 진실 소스 원칙 — 작업현황은 repo에서 관리

개인 메모리에는 작업현황·백로그·노하우를 **복제하지 않는다**. 전부 repo 파일이 진실 소스:

| 내용 | 위치 (repo) |
|------|------------|
| 미착수 시나리오 백로그 (A: 세팅 정보 대기 / B: 의도적 후순위) | `.claude/skills/e2e/references/03-scenario-backlog.md` |
| 실패 패턴·노하우 (isVisible timeout 함정, JWT base64url 등) | `.claude/skills/e2e/SKILL.md` |
| 자동화 불가/조건부/미구현 3분류 원칙 | SKILL.md 동일 섹션 |
| 실행 방법·환경변수·트러블슈팅 | `e2e/README.md` |

**How to apply:** e2e 작업 시작 시 위 repo 파일들을 먼저 읽는다. 진행사항이 바뀌면 repo 파일을 수정하고, 이 메모리에는 모드 전환(유지→대규모 개편 등) 같은 방향성 변화만 기록한다.

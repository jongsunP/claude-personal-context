---
name: codex-personal-context-handoff
description: 이전 에이전트(Codex)의 작업 기록 정본 repo — Dentlink 작업 이어받을 때 먼저 pull·확인
metadata:
  node_type: memory
  type: reference
  originSessionId: 64e5f883-42fa-4b78-8d56-577e5d6d31e0
  modified: 2026-10-15T07:09:22.017Z
---

`/Users/parkjongsun/Repository/codex-personal-context` (main 직접 push)는 이전 에이전트(Codex)가 Dentlink FE 작업 기록을 남긴 정본이다. 사용자가 "이전 에이전트가 하던 작업"을 이어달라고 하면 여기부터 본다.

- 읽는 순서: AGENTS → BOOTSTRAP → SESSION_WORKFLOW → PROFILE/AI_WORKFLOW/DEVELOPMENT_STYLE → PROJECTS → `projects/<project>.md`
- 프로젝트 파일 맨 위 `## 현재 상태 — YYYY-MM-DD <요약>`이 최신 체크포인트이고, 그 아래는 이력. 확정 정책·의도(예: 권한관리 부분 상세 허용 범위)가 본문에 있다.
- 함께 갱신하는 파일: `MEMORY_CHANGELOG.md`(날짜별 bullet), `PROJECTS.md`, `HANDOFF.md`. 커밋은 `docs: <요약>`.
- Codex 세션 원본 transcript: `~/.codex/sessions/YYYY/MM/DD/*.jsonl` (작업 폴더 `~/Documents/ChatGPT/<프로젝트>`).
- 기록에 있는 이전 에이전트 원칙 중 눈여겨볼 것: 확정 요구 밖 UI 동작(에러/빈 상태/자동 이동) 추가는 근거 제시 후 승인, 브랜치 `feature/`만, 테스트·helper·Storybook은 필요할 때만, "CodeRabbit 리뷰 확인" = 스레드 검증→수정/답글→resolve→검사→commit/push 한 사이클 위임(merge 제외).
- 2026-10-15 사용자 지시로 Claude도 이 repo에 기존 형식대로 기록·커밋·푸시했다(35dd0ef). 같은 프로젝트를 이어서 작업한 뒤에는 정본 상단 "현재 상태" + MEMORY_CHANGELOG·PROJECTS·HANDOFF를 함께 갱신한다.

관련: [[dl16317-permission-progress]]

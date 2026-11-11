---
name: feedback_branch_naming
description: 신규 Dentlink 브랜치는 feat/<Jira> (2026-11-04부터, Web·Office·Lab 공통). 기존 feature/ 브랜치는 이름 유지
metadata:
  node_type: memory
  type: feedback
  originSessionId: e5247354-d961-4c2a-9f34-3ef9d766328d
  modified: 2026-11-11T06:11:57.624Z
---

2026-11-04 팀 공지(Slack)로 Dentlink Web/Admin·Office·Lab의 신규 작업 브랜치는 `feat/<Jira>`를 쓴다. 이전 `feature/<Jira>` 규칙을 대체하지만, 이미 만든 `feature/` 브랜치·PR은 자동으로 이름을 바꾸지 않는다. PR 제목 prefix 변경은 아니다.

**Why:** 팀 컨벤션 변경(브랜치명 축약). 정본은 codex-personal-context `DEVELOPMENT_STYLE.md`의 Branch Naming And Draft PR Metadata.

**How to apply:**
- 신규 작업·QA·후속·임시·백업·전달·동기화·worktree 브랜치 모두 `feat/{ticket-or-name}`. 예외는 `release/` 계열과 사용자가 정확한 이름을 지정한 경우뿐.
- `codex/`, `claude/` 같은 에이전트 prefix는 어떤 용도로도 금지. 도구 기본값도 예외가 아니다.
- 예: `feat/DL-17303`, `feat/v2.2.4-codepush-tag`

관련: [[codex-guidelines-adopted]]

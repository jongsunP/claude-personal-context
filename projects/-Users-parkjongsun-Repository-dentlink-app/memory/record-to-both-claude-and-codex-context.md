---
name: record-to-both-claude-and-codex-context
description: 모든 기록은 Claude 메모리와 ~/Repository/codex-personal-context 양쪽에 반드시 함께 남긴다
metadata:
  type: feedback
---

작업 기록(체크포인트·결정·조사 결과·선호)은 Claude 자체 메모리와 `~/Repository/codex-personal-context`(프로젝트 파일 상단 "현재 상태" + `MEMORY_CHANGELOG.md`, 필요 시 `PROJECTS.md`) **양쪽에 모두** 남긴다. 한쪽만 쓰지 않는다.

**Why:** 사용자가 2026-11-10 명시 지시. codex-personal-context가 이전 에이전트(Codex)와 공유하는 정본이고, Claude 메모리는 Claude 세션의 자동 회상용이라 둘 다 필요하다.

**How to apply:** 의미 있는 마감마다 codex-personal-context를 갱신해 commit·push하고, 같은 내용을 Claude 메모리 파일에도 반영한다. codex-personal-context `AGENTS.md`에도 같은 규칙을 적어 두었다. 관련: [[dentlink-app-fix-approval-scope]], [[dentlink-notification-center-status-20261110]].

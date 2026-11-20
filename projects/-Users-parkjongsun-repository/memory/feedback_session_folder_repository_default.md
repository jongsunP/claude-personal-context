---
name: feedback-session-folder-repository-default
description: 새 세션은 사용자가 따로 지정하지 않으면 조사·구현 모두 cwd를 ~/Repository로 만든다(2026-11-20)
metadata:
  type: feedback
---

새로 만드는 모든 세션(조사·정리·구현 포함)의 작업 폴더는 사용자가 따로 지정하지 않으면 `~/Repository`(집 Mac `~/repository`)로 한다. 구현 세션도 `feat/<Jira>` worktree는 Git으로 만들되 `start_session` `cwd`는 `~/Repository`, worktree 절대경로는 브리프에 적는다.

**Why:** 2026-11-20 사용자가 dentlink-client 폴더로 열린 조사 세션을 보고 다른 세션처럼 Repository 아래로 두길 원했고, 구현 세션 예외 권고에도 "모두 Repository로"를 선택했다.
**How to apply:** 이 폴더에선 repo CLAUDE.md·PR 전 E2E 가드 훅(`scripts/e2e-guard/check.sh`)·repo 전용 스킬(/pr-create, /e2e-guard)이 자동 적용되지 않는다. 세션 브리프에 "작업 전 repo CLAUDE.md 직접 읽기, PR 전 E2E 가드 절차 직접 수행, git은 절대경로/-C 사용"을 넣는다. 관련: [[project-main-session]]

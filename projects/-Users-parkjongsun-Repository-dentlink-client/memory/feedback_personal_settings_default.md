---
name: feedback-personal-settings-default
description: 사용자가 별도 지정 없이 요청하는 설정은 모두 개인 설정(~/.claude/)에 적용해야 함
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f31a703f-709a-4341-be24-2196ffe6fe2b
---

개인 설정과 팀/프로젝트 설정을 다음 기준으로 철저히 분리한다.

- **개인** (말투, 언어, Claude 행동 방식, 메모리 등) → `~/.claude/` → `jongsunP/claude-personal` 레포
- **팀/프로젝트** (컨벤션, 아키텍처 규칙, 공유 가이드 등) → `dentlink-client/CLAUDE.md` → 프로젝트 레포

**Why:** 팀 설정과 개인 설정을 완전히 분리해서 관리하고 싶어함. 개인 취향이나 Claude 동작 설정이 팀 공유 파일에 섞이지 않도록.

**How to apply:** 설정 관련 요청 시 성격에 따라 자동으로 분류해서 적용. "어디에 적용할까요?" 묻지 않는다. 개인적인 것은 `~/.claude/`에, 팀과 공유해야 할 것은 프로젝트 `CLAUDE.md`에.

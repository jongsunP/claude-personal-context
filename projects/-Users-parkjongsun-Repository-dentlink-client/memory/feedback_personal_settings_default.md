---
name: feedback-personal-settings-default
description: 사용자가 별도 지정 없이 요청하는 설정은 모두 개인 설정(~/.claude/)에 적용해야 함
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f31a703f-709a-4341-be24-2196ffe6fe2b
---

별도로 지정하지 않는 한, 사용자의 모든 설정 변경 요청은 개인 설정(~/.claude/CLAUDE.md 또는 ~/.claude/settings.json)에 적용한다. 프로젝트 CLAUDE.md(팀 공유)는 건드리지 않는다.

**Why:** 팀 설정과 개인 설정을 분리하고 싶어함. 프로젝트 CLAUDE.md는 팀 공유 파일이므로 개인 취향을 넣지 않음.

**How to apply:** 설정 관련 요청 시 "어디에 적용할까요?" 묻지 말고 바로 ~/.claude/ 에 적용. 단, 사용자가 명시적으로 "프로젝트에" 또는 "팀 설정에" 라고 하면 프로젝트 CLAUDE.md에 적용.

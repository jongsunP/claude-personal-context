---
name: connect-tools-directly-when-blocked
description: 외부 도구(Slack·Jira 등) 접근이 막히면 브라우저 로그인 우회 대신 커넥터(MCP)로 직접 연결하는 방식을 먼저 제안
metadata:
  type: feedback
---

Slack·Jira·Notion 등 외부 도구를 읽거나 써야 하는데 접근 제한(로그인 페이지, 권한 없음 등)에 막히면, 브라우저 로그인이나 붙여넣기 요청보다 **해당 커넥터(MCP)를 직접 연결**하는 방식을 먼저 제안한다(`search_mcp_registry` → `suggest_connectors`). 연결은 사용자가 승인한다.

**Why:** 사용자가 2026-11-10 "앞으로도 이런식으로 제한있으면 직접 연결하는 방식으로, 지라든 뭐든"이라고 지시. 목적은 이후 세션에서도 항상 바로 읽을 수 있게 하는 것. 이날 Slack 커넥터를 연결했다.

**How to apply:** 외부 링크·도구가 막히면 즉시 레지스트리에서 커넥터를 찾아 연결 카드를 띄운다. 연결 후에도 메시지 전송·티켓 생성 같은 쓰기 동작은 초안을 보여주고 확인받는다. 관련: [[record-to-both-claude-and-codex-context]].

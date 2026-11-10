---
name: connectors-status
description: 연결된 외부 커넥터 현황(2026-11-10) — Slack·Figma·Notion 동작, Jira(Atlassian Rovo)는 관리자 승인 대기
metadata:
  type: reference
---

2026-11-10 기준 Claude 커넥터 상태(사용자 계정 jongsun 기준, 각 도구에서 직접 확인):

- **Slack**: 연결·동작. innovaidhq 워크스페이스 스레드 읽기 가능(`slack_read_thread` 등). 메시지 전송은 초안 확인 후에만.
- **Figma**: 연결·동작(whoami 확인). DentLink Team(Dev seat, guest) 접근.
- **Notion**: 연결·동작(get-self 확인). 워크스페이스 "이노바이드".
- **Jira/Confluence (Atlassian Rovo)**: 커넥터는 연결됐지만 접근 가능한 사이트 목록이 비어 있음 → innovaid.atlassian.net **관리자 승인 필요**(사용자 판단). 승인 전에는 Jira를 커넥터로 읽을 수 없다.

**How to apply:** 외부 링크를 받으면 위 커넥터로 먼저 읽는다. Jira가 필요하면 아직 관리자 승인 전인지 확인하고, 막히면 사용자에게 알린다. 관련: [[connect-tools-directly-when-blocked]].

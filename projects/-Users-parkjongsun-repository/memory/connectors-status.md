---
name: connectors-status
description: 연결된 외부 커넥터 현황 — Slack(읽기 전용)·Figma·Notion 동작, Atlassian은 11-11 집 Mac에서 innovaid 사이트 정상 확인
metadata:
  type: reference
---

2026-11-10 기준 Claude 커넥터 상태(사용자 계정 jongsun 기준, 각 도구에서 직접 확인):

- **Slack**: 연결·동작. innovaidhq 워크스페이스 스레드 읽기 가능(`slack_read_thread` 등). **읽기 전용 — 메시지 전송·리액션·캔버스 등 쓰기는 절대 하지 않는다**(사용자 지시 2026-11-10). 답장이 필요하면 초안만 주고 사용자가 직접 보낸다.
- **Figma**: 연결·동작(whoami 확인). DentLink Team(Dev seat, guest) 접근.
- **Notion**: 연결·동작(get-self 확인). 워크스페이스 "이노바이드".
- **Jira/Confluence (Atlassian)**: 11-10 사무실에서는 접근 가능한 사이트가 비어 "관리자 승인 대기"였으나, 2026-11-11 집 Mac에서 Claude 계정 Atlassian 커넥터가 `innovaid.atlassian.net`(Jira/Confluence read-write)로 실제 조회되는 것을 확인했다. 사무실 세션에서도 같은 계정 커넥터를 쓰되, 막히면 그때 다시 확인한다.

**How to apply:** 외부 링크를 받으면 위 커넥터로 먼저 읽는다. Jira가 막히면 사이트 접근 목록부터 확인하고 사용자에게 알린다. 관련: [[connect-tools-directly-when-blocked]].

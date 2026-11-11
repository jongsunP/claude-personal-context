---
name: env-team-rule-no-agent-env
description: dentlink-client 최신 CLAUDE.md 팀 규칙 — 에이전트는 실제 .env 파일을 읽기·생성·수정하지 않고 Git 이력·GitHub Variables로 값을 조회·복원하지 않는다
metadata:
  type: feedback
---

최신 master의 `dentlink-client/CLAUDE.md`에 팀 규칙이 있다: 환경변수 값은 사람이 관리한다. 에이전트는 값 없는 `.env.example`, 변수 이름, 사용 코드만 다룬다. 실제 `.env*`(example 제외)를 읽거나 만들거나 고치지 않고, Git 이력·GitHub Variables/Secrets·로그·프로세스 환경으로 값을 우회 조회하거나 복원하지 않는다.

**Why:** 2026-11-11 오전 사용자 지시로 집 Mac 웹 env를 Git 직전본 값으로 재구성하고 GitHub DEV Variables와 대조했는데, 이는 이 팀 규칙에 어긋났다(당시 이전 버전 CLAUDE.md만 확인). 사용자에게 알렸고, 사용자가 "팀 규칙이 맞고 이번만 내가 시킨 것"이라고 확인했다. 기존 env 파일은 그대로 둔다.

**How to apply:** 앞으로 env가 필요하면 키 이름·`.env.example`만 다루고 실제 값 준비는 사람에게 안내한다. 사용자가 다시 env 값 작업을 지시하면 이 팀 규칙과 충돌함을 먼저 알리고 확인한다. 작업 전 해당 저장소의 최신 `CLAUDE.md`를 다시 확인한다.

관련: [[test-credentials-and-env-tokens]], [[codex-guidelines-adopted]]

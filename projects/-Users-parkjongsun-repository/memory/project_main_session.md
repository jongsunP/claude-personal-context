---
name: dentlink-fe-main-session
description: 에이전트별 Dentlink FE 메인세션 구조(2026-11-12 확정) — 사무실/집 Claude 메인 ID·폴더·역할·하위 세션 만드는 법·앱 설정
metadata:
  type: project
---

2026-11-12 사용자 확정: 에이전트(사무실 Codex, 사무실 Claude Code, 집 Codex, 집 Claude Code, 이후 추가분)마다 **메인세션은 하나**이고 각자 따로 운영한다. 메인끼리 메시지·통제 없음. 공통 기록은 codex-personal-context에만, 회사 저장소(`~/.codex`, `~/.claude`)에는 그 에이전트 실행에 필요한 것만 둔다. 정본은 codex `projects/dentlink-fe.md` Session Ownership.

| 에이전트 | 메인세션 | 폴더 |
| --- | --- | --- |
| 사무실 Claude | "Dentlink FE 메인세션 (사무실 Claude)" `local_322c0b9d-e807-4b1c-ad23-416fd7d5b025` (11-12 지정, dentlink-app 폴더에서 옮김) | `/Users/parkjongsun/Repository` |
| 집 Claude | "Dentlink FE 메인세션" `local_ee66b909-c034-43a9-af56-066bf4ace9c5` (11-11 지정) | `/Users/parkjongsun/repository` |
| 사무실 Codex | 메인세션 `01a08f0c-…` | `Documents/ChatGPT/메인 프로젝트` |
| 집 Codex | 미지정 | — |

**Why:** 사용자는 메인을 접수·조율 중심으로 두고 구현은 기능별 세션에 맡기는 Codex 시절 운영을 원하고, 기기·에이전트가 늘어도 기록은 개인 Git 저장소 하나로 모으려 한다.

**How to apply:**
- macOS 대소문자 무시로 사무실 `Repository`와 집 `repository`는 같은 메모리 폴더 키(`-Users-parkjongsun-repository/memory`)를 쓴다. 웹 폴더 키 `-Users-parkjongsun-repository-dentlink-client/memory`는 여기로 연결된 링크.
- 하위 세션: Git으로 `feat/<Jira>` 브랜치·worktree를 직접 만든 뒤 `start_session`(`cwd`=worktree, `use_worktree: false`, `model`·`effort` 생략=메인 상속). 만든 뒤 `get_session`으로 모델 확인. 넘긴 뒤 폴링 금지(완료 알림은 앱이 줌).
- 앱 설정(계정/기기): 브랜치 접두어 `feat`, 새 세션 Remote Control 연결 켬(사무실은 11-12 설정). 새 세션 기본 모델 설정은 `claude-sonnet-4-6`이라 하위 세션 모델은 반드시 상속으로.
- 메인세션은 보관하지 않는다. "정리하고 대기"는 기록 저장 후 대기 의미.
- 동기화·기록 시점은 [[record-to-both-claude-and-codex-context]].

관련: [[codex-guidelines-adopted]], [[local-repo-setup-status]], [[user-environment]]

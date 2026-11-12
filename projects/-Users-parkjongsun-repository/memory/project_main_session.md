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
- 메인은 메인 폴더 아래 모든 프로젝트를 직접 읽기·수정·Git·빌드·실행할 수 있다. 구현은 기본 하위 세션, 수정 전 대상 repo·브랜치·worktree 확인, 각 repo CLAUDE.md 적용.
- **에이전트 전달함(2026-11-12, 방향 무관: Codex↔Claude·기기 간·모든 에이전트):** 사용자가 "다른 에이전트도 이렇게 하래"라고 하면 codex `AGENT_INBOX.md`의 그 에이전트 섹션에 남긴다. 동기화 때 내 섹션·"모든 에이전트"의 `열림` 항목을 적용하고 완료 표시. 남긴 것: 집 Claude(메인 폴더 아래 전체 제어 방식), 사무실 Codex(pull+setup-local-codex.sh), 집 Codex(사용 시 메인 지정), 모든 에이전트(11-12 구조·시점 확인).

- **2026-11-12 사용자 지시:** 메인은 특정 작업에 묶지 않는 일반 메인(세션 PR 표시도 해제). 기능별 상시 하위 세션을 둔다 — 통합알림센터는 `local_62b33d4f-d04d-4faa-8d55-5db9ceefc994`("Dentlink 알림센터 (하위 세션)")이 전체 담당(보관 안 함). 이름만 바꾸는 게 아니라 실제로 알림센터 요청은 그 세션으로 보낸다. 넘긴 뒤 추적·폴링 금지, 완료 알림이 오면 간단히 전달(재검증은 사용자가 요청할 때만).
- **역할 재확인(사용자 2026-11-12):** 메인은 말 그대로 작업을 총괄하는 세션이다. 새 작업 접수(분류 후 해당 상시 하위 세션 또는 새 하위 세션으로)나 작업 지침 업데이트 요청이 올 때 움직이고, 그 외에는 정리·기록 후 대기한다.

관련: [[codex-guidelines-adopted]], [[local-repo-setup-status]], [[user-environment]]

---
name: dentlink-fe-main-session
description: Claude Code "Dentlink FE 메인세션"(2026-11-11 지정) — 정체·폴더·역할·하위 세션 만드는 법·앱 설정
metadata:
  type: project
---

2026-11-11 사용자 지시로 집 Mac의 Claude Code 세션 `local_ee66b909-c034-43a9-af56-066bf4ace9c5`("Dentlink FE 메인세션", claude-opus-5-5)이 웹·Office·Lab 전체를 총괄하는 메인세션이 됐다. 정본 기록은 codex `projects/dentlink-fe.md` Session Ownership.

**Why:** 사용자는 메인을 접수·조율 중심으로 두고 실제 구현은 기능별 세션에 맡기는 Codex 시절 운영을 그대로 원한다. 사무실 Mac의 Codex 메인세션(`01a08f0c-…`)과의 관계는 아직 정하지 않았다.

**How to apply:**
- 폴더 `/Users/parkjongsun/repository`(저장소들이 모인 일반 폴더). 메모리는 이 폴더 키에 있고, 웹 폴더 키 `-Users-parkjongsun-repository-dentlink-client/memory`는 여기로 연결된 링크.
- 하위 세션: Git으로 `feat/<Jira>` 브랜치·worktree를 직접 만든 뒤 `start_session`(`cwd`=worktree, `use_worktree: false`, `model`·`effort` 생략=메인 상속). 만든 뒤 `get_session`으로 모델 확인, 첫 체크포인트 기록. 넘긴 뒤 폴링 금지(완료 알림은 앱이 줌).
- 앱 설정: 브랜치 접두어 `feat`(원래 `claude`), 새 세션 Remote Control 연결 켬. 새 세션 기본 모델 설정은 `claude-sonnet-4-6`이라 모델은 반드시 상속으로.
- 메인세션은 보관하지 않는다. "정리하고 대기"는 기록 저장 후 대기 의미.

관련: [[codex-guidelines-adopted]], [[local-repo-setup-status]], [[user-environment]]

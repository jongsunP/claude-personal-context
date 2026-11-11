---
name: user-environment
description: 사용자의 작업 환경 — 사무실 Mac(주 실행 호스트) vs 집 Mac(보조), 경로 차이와 맞추는 원칙
metadata:
  node_type: memory
  type: user
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
  modified: 2026-11-11T06:12:03.976Z
---

사용자는 두 대의 Mac을 사용한다.

- **사무실 Mac**: 주 작업 환경이자 Codex 세션의 실행 호스트. 휴대폰·다른 PC는 이 Mac을 원격 제어하는 용도(원격화)이며 실행 환경 이전과 구분한다. 기록상 경로는 `/Users/parkjongsun/Repository/...`(대문자 R).
- **집 Mac**: 보조 환경. 경로는 `/Users/parkjongsun/repository/...`(소문자, APFS 대소문자 무시라 같은 경로로 동작). `~/.claude`와 codex-personal-context를 git으로 동기화해 이어서 작업한다.

2026-11-11 사용자 의도: 특정 업무를 재개하기 전에 **집 Mac 작업환경을 사무실 Mac과 최대한 똑같이 맞추는 것**이 우선. 세팅 현황은 [[local-repo-setup-status]].

**How to apply:** 집 Mac에서는 사무실 작업을 이어받는 맥락. env·인증·의존성·서버·worktree는 git pull로 복원되지 않으므로 기록(codex `projects/dentlink-fe.md` "다른 기기에서 이어가기", `dentlink-app-local-development.md`)의 표준 구성과 실제 기기를 대조해 차이를 보고한다.

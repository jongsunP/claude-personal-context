---
name: dentlink-app-pr-team-rules
description: Dentlink 앱 PR 팀 규칙 — 제목 양식([DL-xxxxx]/[QA]), 스쿼시 머지는 PR 제목, release 네이티브 PR은 머지 전 재설치·빌드·실기기 확인
metadata:
  type: feedback
---

앱 개발자(다니엘)가 2026-11-10 요청한 팀 규칙. 정본은 codex-personal-context `DEVELOPMENT_STYLE.md`.

- PR 제목: Jira 있으면 `[DL-xxxxx] 제목`. 티켓 없는 `release/*` 대상 수정은 `[QA] 제목`(선례 dentlink-app #317/#320). `fix: ...` 같은 커밋형 제목으로 두지 않는다.
- 스쿼시 머지는 커밋 메시지가 아니라 **PR 제목**으로. 저장소 설정 `COMMIT_OR_PR_TITLE`이라 커밋 1개 PR은 기본값이 커밋 제목이므로 머지 화면에서 바꾼다.
- release 대상 네이티브 변경 PR은 머지 전에 PR 브랜치 `yarn install` 재설치(`patches/native` 적용) → Android 빌드 → 실기기에서 빌드 에러·이슈 해결 확인 → 결과를 팀 스레드와 PR 검증란에 공유. 머지·심사 제출은 앱 개발자.

**Why:** 팀 리뷰·스쿼시 이력 일관성과 심사 전 안정성 확인을 위해 앱 개발자가 요청했다.
**How to apply:** 앱 PR 생성·수정 시 제목 양식을 먼저 맞추고, 네이티브 변경이면 위 실기기 검증을 머지 전 단계로 계획한다. 관련: [[dentlink-app-fix-approval-scope]], [[dentlink-notification-center-status-20261110]].

---
name: project_release_cleanup_20261123
description: 11/23 이번 릴리즈(웹 v1.94.0·치과 2.2.5·기공소 1.0.6) 상용 배포 전환에 맞춰 로컬 worktree·브랜치·실행 기기 정리 완료
metadata:
  type: project
---

2026-11-23 사용자: 이번 릴리즈 웹·앱은 상용 배포, 로컬 작업 종료 → 정리 지시.
- 삭제(모두 PR 머지·head 확인): worktree 4개(웹 `dentlink-client-notification-center`, Codex `~/.codex/worktrees/dl17208-office`·`dl17208-web`·`dentlink-notification-dev`), 로컬 브랜치 14개(웹 feat/DL-17542·feature/DL-16387·feature/DL-17058·feat/DL-17058-develop·feat/DL-17231, 앱 feature/DL-17059·feat/DL-17423, 기공소 feat/DL-17262·-api-cleanup·feat/DL-17310·feature/DL-17060·release/v1.0.5). 원격 브랜치 유지.
- 남은 로컬: 세 저장소 메인 checkout(각 release 최신, clean)+main/master. `~/.codex/worktrees/*` 빈 표시 파일(0B)과 `dentlink-studio`(별도 작업)는 유지.
- 웹 메인 checkout 미추적 `lab/scripts/i18n/service-account.json`: 시트 연동 제거(#4928) 후 미사용 개인 인증 파일. 열람·삭제하지 않음, 사용자 판단.
- 세션: DL-17548·기공소 번역 시트 세션은 이미 보관, 메인세션·디자인 캡처 조사 세션 유지.

**Why:** 상용 배포 후 새 작업은 다음 release에서 새 브랜치로 시작하므로 이번 릴리즈 로컬 흔적은 불필요.

**How to apply:** 다음 작업은 최신 release/main에서 새 feat 브랜치·worktree로 시작. 관련: [[notification-center-resume-20261116]], [[project_local_cleanup_20261116]].

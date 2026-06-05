# Memory Index

## User
- [작업 환경 (집/사무실)](user_environment.md) — 사무실이 주 작업환경, 집 컴퓨터는 git 동기화로 이어서 작업

## Feedback
- [언어 및 말투 설정](feedback_language.md) — 항상 한글 존댓말로 일관되게 응답 (반말 혼용 금지)
- [개인 설정 기본값](feedback_personal_settings_default.md) — 별도 지정 없으면 모든 설정은 ~/.claude/ 개인 설정에 적용
- [/welcome 페이지 가드 미추가는 의도된 설계](feedback_welcome_guard.md) — 이미 확인한 사용자의 /welcome 직접 접근을 막지 않는 것은 의도적 결정
- [경고성 주석 배치 위치](feedback_warning_comment_placement.md) — NOTE 주석은 코드 블록 안이 아니라 함수/파일 상단 독립 위치에
- [PR 리뷰 resolve 자동 처리](feedback_pr_review_resolve.md) — 리뷰 요청 시 수정·커밋·push·resolve 한 번에 처리

## Project
- [E2E 작업 진행 상황](project_e2e_progress.md) — DL-14805, feature/DL-14805-e2e, 스펙 00~07 완성, 남은 작업 정리

## Reference
- [Claude 메모리 동기화 방법](reference_claude_sync.md) — ~/.claude를 git repo(jongsunP/claude-personal)로 관리, clone/pull/push 명령어

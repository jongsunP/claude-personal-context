# Memory Index

## User
- [사용자 프로필](user_profile.md) — parkjongsun, Dentlink 프론트 개발자, 협업 파트너로서의 Claude를 지향
- [작업 환경 (집/사무실)](user_environment.md) — 사무실이 주 작업환경, 집 컴퓨터는 git 동기화로 이어서 작업

## Feedback
- [언어 및 말투 설정](feedback_language.md) — 항상 한글 존댓말로 일관되게 응답 (반말 혼용 금지)
- [메모리 자동 저장 기준](feedback_memory_management.md) — 작업 마무리/중요 판단 시 자동 저장·push, 일관된 협업 방식 유지
- [툴 사용 권한 사전 허락](feedback_permissions.md) — 작업 중 모든 툴 사용 묻지 않고 바로 진행 (외부 영향 제외)
- [긴 작업 중간 보고](feedback_progress_update.md) — 1분 이상 무응답 금지, 간략한 진행 상황 텍스트 보고 필수
- [개인 설정 기본값](feedback_personal_settings_default.md) — 별도 지정 없으면 모든 설정은 ~/.claude/ 개인 설정에 적용
- [/welcome 페이지 가드 미추가는 의도된 설계](feedback_welcome_guard.md) — 이미 확인한 사용자의 /welcome 직접 접근을 막지 않는 것은 의도적 결정
- [경고성 주석 배치 위치](feedback_warning_comment_placement.md) — NOTE 주석은 코드 블록 안이 아니라 함수/파일 상단 독립 위치에
- [PR 리뷰 resolve 자동 처리](feedback_pr_review_resolve.md) — 리뷰 요청 시 수정·커밋·push·resolve 한 번에 처리
- [미완료 작업 선제 고지](feedback_honesty_incomplete.md) — 요청을 완전히 못 했으면 사용자가 묻기 전에 먼저 솔직하게 말한다
- [E2E 빨간색 waitFor 진단 원칙](feedback_e2e_red_highlights.md) — 근본 파악 우선. 시간 단축이 목적 아님. flaky 위험 생기면 대명제 위반
- [불확실할 때 먼저 질문](feedback_ask_when_uncertain.md) — 의도가 불명확하거나 되돌리기 어려운 작업 전엔 먼저 확인 후 진행
- [E2E page.route() 모킹 허용 조건](feedback_e2e_route_mocking.md) — Elasticsearch 등 환경 의존적 표시용 API에 한해 허용. 핵심 API는 real 호출 필수
- [E2E 고정 오피스(setup fixture) 삭제 위험](feedback_e2e_fixture_office_risk.md) — 영구 보존 주석 있어도 삭제 가능. MAIN employer가 가장 안정적 타겟

## Project
- [E2E 마스터 플랜](project_e2e_master_plan.md) — 유지·성장 모드. 백로그·노하우는 repo(.claude/skills/e2e/, e2e/README.md)가 진실 소스
- [레거시 페이지 목록](project_legacy_pages.md) — /office/onboard/ 등 미사용 페이지, 수정 범위 제외

## Reference
- [Claude 메모리 동기화 방법](reference_claude_sync.md) — ~/.claude를 git repo(jongsunP/claude-personal)로 관리, clone/pull/push 명령어

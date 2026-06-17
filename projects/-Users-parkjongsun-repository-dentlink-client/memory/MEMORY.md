# Memory Index

## User
- [사용자 프로필](user_profile.md) — parkjongsun, Dentlink 프론트 개발자, 협업 파트너로서의 Claude를 지향
- [작업 환경 (집/사무실)](user_environment.md) — 사무실이 주 작업환경, 집 컴퓨터는 git 동기화로 이어서 작업

- [npm 캐시 권한 문제](user_npm_cache_permission.md) — ~/.npm 일부 root 소유, optional dep 조용한 설치 실패 원인

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
- [브리핑 시 백로그 포함](feedback_briefing_include_backlog.md) — 현황 브리핑 시 즉시 작업 외 백로그(미구현·세팅 대기)도 함께 언급
- [E2E 빨간색 waitFor 진단 원칙](feedback_e2e_red_highlights.md) — 근본 파악 우선. 시간 단축이 목적 아님. flaky 위험 생기면 대명제 위반
- [불확실할 때 먼저 질문](feedback_ask_when_uncertain.md) — 의도가 불명확하거나 되돌리기 어려운 작업 전엔 먼저 확인 후 진행
- [E2E page.route() 모킹 허용 조건](feedback_e2e_route_mocking.md) — Elasticsearch 등 환경 의존적 표시용 API에 한해 허용. 핵심 API는 real 호출 필수
- [E2E 고정 오피스(setup fixture) 삭제 위험](feedback_e2e_fixture_office_risk.md) — 영구 보존 주석 있어도 삭제 가능. MAIN employer가 가장 안정적 타겟
- [E2E specs vs scripts 폴더 기준](feedback_e2e_scripts_vs_specs.md) — specs/는 실제 시나리오만. one-off 환경 설정 스크립트는 e2e/scripts/에 보관
- [claude-personal-context 레포 자동 동기화](feedback_claude_personal_repo_sync.md) — 설정·메모리 변경 시 커밋·푸시 자동 처리
- [브랜치 네이밍 컨벤션](feedback_branch_naming.md) — 모든 브랜치에 feature/ prefix 필수 (QA 브랜치 포함)
- [커밋·푸쉬 명시적 요청 시에만](feedback_commit_push_explicit_only.md) — 코드 수정 후 커밋·푸쉬는 자동 실행 금지, 명시적 지시 필요

## Project
- [E2E 신규 클리닉 계정 세팅](project_e2e_new_clinic_account.md) — e2e.clinic@dentlink.app, tata.test4 대체 계정, 오피스 정보 및 .env 업데이트 체크리스트
- [DL-14752 티켓 진행 현황](project_dl14752_progress.md) — 6개 티켓 중 DL-14887 완료, 나머지 5개 미완료
- [E2E 마스터 플랜](project_e2e_master_plan.md) — 유지·성장 모드. 백로그·노하우는 repo(.claude/skills/e2e/, e2e/README.md)가 진실 소스
- [E2E SSE 발견 — networkidle 무력화](project_e2e_sse_discovery.md) — lab 앱 전역 SSE(50s 하트비트)가 networkidle을 막음. 픽업/배송 페이지에서 toPass+reload 패턴 사용
- [레거시 페이지 목록](project_legacy_pages.md) — /office/onboard/ 등 미사용 페이지, 수정 범위 제외

## Reference
- [Claude 메모리 동기화 방법](reference_claude_sync.md) — ~/.claude를 git repo(jongsunP/claude-personal-context)로 관리, clone/pull/push 명령어

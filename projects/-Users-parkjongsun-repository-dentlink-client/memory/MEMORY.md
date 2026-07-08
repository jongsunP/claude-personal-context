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
- [의도적 제외 결정은 반드시 기록](feedback_intentional_exclusion.md) — 범위 제외·예외 처리 판단은 메모리나 주석에 근거 남기기
- [PR 생성 시 /pr-create 스킬 필수](feedback_pr_create_skill.md) — PR 생성 요청 시 항상 /pr-create 스킬·템플릿 사용, 임의 형식 금지
- [기존 코드·컨텍스트 기반 선제 추론](feedback_infer_from_context.md) — 확인/수정 시 기존 패턴·세트 파일을 먼저 보고 일관성 있게 처리 (사용자 지적 전에)
- [워크트리 고아 폴더 판단 기준](feedback_worktree_orphan_check.md) — git worktree list 미등록 + .git 파일 존재 둘 다 확인 후 결론

## Project
- [DL-14232 초대 기능 작업 현황](project_dl14232_invite_progress.md) — feature/DL-14232, 워크트리 `dentlink-client-invite`. FE 하위 8개 티켓(DL-15489~15495, DL-15162). 플래닝 진행 중.
- [DL-15478 이미지 최적화 원복](project_dl15478_progress.md) — feature/DL-15478, PR #4335 오픈. DL-15348 프리로드·eager 제거, 배포 후 성능 확인 예정
- [DL-15443 작업 현황](project_dl15443_progress.md) — feature/DL-15443, 워크트리 `/Repository/dentlink-client-e2e` 준비 완료. 코드 변경 완료, 테스트 실행·pass 확인 대기
- [라벨 프린트 PDF 작업 현황](project_pdf_print_work.md) — 서버사이드(DL-15438)만 배포 결정. PR #4336 Draft 오픈(master 비교용). concurrency limiter + node_modules 경로 적용 완료
- [DL-15107 작업 현황](project_dl15107_progress.md) — feature/DL-15107, PR #4266 오픈 + QA 픽스 PR #4284 오픈 (→ release/v1.76.0)
- [DL-15287 작업 현황](project_dl15287_progress.md) — feature/DL-15287, Shippable→Physical 명칭 변경, PR #4285 오픈 (→ release/v1.76.0)
- [DL-13254 작업 현황](project_dl13254_progress.md) — feature/DL-15197, rebase 완료, 옵션 이미지·OptionImage 컴포넌트 완료. 남은 것: 주문상세 EstimatedCostPanel, 2단계 상품 노출, PR
- [DL-13254 주문 2단계 PM 스펙](project_dl13254_step2_spec.md) — 상품 노출 조건(New/Follow-up), 컨설팅 혼합 제한, 예상 가격 표시, lab/admin은 제한 없음
- [E2E 신규 클리닉 계정 세팅](project_e2e_new_clinic_account.md) — e2e.clinic@dentlink.app, tata.test4 대체 계정, 오피스 정보 및 .env 업데이트 체크리스트
- [DL-14752 티켓 진행 현황](project_dl14752_progress.md) — 코드 검증 완료. 배포 후 수기 확인 3건(DL-14732, DL-14754, DL-15168), PR #4219 머지 대기
- [DL-15157 GA4/Meta Pixel 전환 추적](project_dl15157_ga_tracking.md) — 회원가입 lazy loading 구현 완료, PR #4218 오픈
- [E2E 마스터 플랜](project_e2e_master_plan.md) — 유지·성장 모드. 백로그·노하우는 repo(.claude/skills/e2e/, e2e/README.md)가 진실 소스
- [E2E SSE 발견 — networkidle 무력화](project_e2e_sse_discovery.md) — lab 앱 전역 SSE(50s 하트비트)가 networkidle을 막음. 픽업/배송 페이지에서 toPass+reload 패턴 사용
- [레거시 페이지 목록](project_legacy_pages.md) — /office/onboard/ 등 미사용 페이지, 수정 범위 제외
- [DL-14232 Clinic Invite](../../dentlink-client-invite.md) — Clinic 초대/회원관리 UI 작업 체크포인트. 실제 Clinic invite API 전 단계까지 완료

## Reference
- [Claude 메모리 동기화 방법](reference_claude_sync.md) — ~/.claude를 git repo(jongsunP/claude-personal-context)로 관리, clone/pull/push 명령어
- [DL-13254 링크 모음](reference_dl13254_links.md) — AOX 관련 Figma 디자인·FigJam 보드·Notion Component 문서·Jira 티켓 URL
- [스테이징 배포 태그 형식](reference_stg_deploy_tag.md) — 코드 변경 없이 배포 시 `stg/clinic/[브랜치명]` 태그 push 사용

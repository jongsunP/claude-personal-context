---
name: codex-guidelines-adopted
description: 이전 에이전트(Codex)의 작업 지침을 Claude도 그대로 따른다 — Dentlink 작업 전반의 권한·브랜치·범위·기록·보고 규칙 요약
metadata:
  node_type: memory
  type: feedback
  originSessionId: 64e5f883-42fa-4b78-8d56-577e5d6d31e0
  modified: 2026-10-16T07:13:00.191Z
---

2026-10-15 사용자 지시: 다른 작업을 하더라도 codex-personal-context의 지침과 히스토리를 따른다. 정본은 그 repo의 AGENTS / SESSION_WORKFLOW / AI_WORKFLOW / DEVELOPMENT_STYLE / DECISION_FRAMEWORK / PROFILE이며, 아래는 요약이다. 애매하면 정본을 다시 읽는다 ([[codex-personal-context-handoff]]).

**Why:** 사용자는 AI가 바뀌어도 이어지는 개인 지식 시스템을 원한다. Codex 기간(2026-09~10)에 다듬어진 규칙이 최신 기준이다.

**How to apply:**
- **시작·재개:** 작업 시작 시 codex-personal-context `git pull` → 해당 `projects/<project>.md` 상단 "현재 상태" 확인 → 제품 repo fetch로 branch/HEAD/원격 차이/dirty/worktree 소유권 대조 후 진행. 기록보다 live Git·최신 사용자 지시가 우선. 맥락 복원만으로 구현·QA·서버를 재개하지 않는다(대기 상태 보존). 브랜치·워크트리 상태를 바꾸자고 제안하기 전에도 최신 "현재 상태"를 먼저 읽는다 — 2026-10-16 기록에 "워크트리는 release detached 유지"가 있는데 확인 없이 feature로 switch를 제안·실행해 되돌린 일이 있었다.
- **권한:** 제품 코드 commit/push/PR 변경/merge/배포는 명시 요청 시에만. 보호 브랜치(master/develop/release/*) 직접 push·우회는 별도 승인. DB는 읽기 전용, 비밀값 출력 금지.
- **CodeRabbit 처리 요청** = 미해결 스레드 전부 검증 → 수정 또는 근거 답글 → resolve → 비례 검사 → commit/push → CodeRabbit 체크 완료까지 새 스레드 재확인. merge 제외. 단순 "PR 만들어줘"는 생성에서 끝(감시·대응 안 함).
- **웹 브랜치:** 신규 작업은 최신 `origin/master`에서 `feature/<Jira>`(에이전트 prefix 금지). PR 대상은 배포 예정 `release/vX.Y.Z`(live 확인). release 기반은 이미 release에 들어간 작업의 후속/QA 수정만. 예정 릴리즈가 없다는 이유로 master 기준을 다시 묻지 않는다. develop/stage는 환경 브랜치일 뿐.
- **앱:** Office(`dentlink-app`)·Lab(`dentlink-lab-app`)은 별도 repo. 일반 feature PR은 `develop` 대상, release는 QA/배포 단계. 웹 규칙을 앱에 적용하지 않는다.
- **범위:** 확정 요구·디자인 밖의 사용자 노출 UI/문구/동작(에러·빈 상태·자동 이동 포함)을 새로 넣을 땐 근거·제안 후 승인. 단 리뷰 지적을 고치는 수준은 예외([[handoff-review-scope]]). 가장 가까운 기존 구현 패턴(컴포넌트·hook·query·상태·타입)을 그대로 따른다.
- **추가 파일:** 새 테스트 파일·helper 모듈·분석 파일·문서·Storybook은 검증 편의만으로 추가하지 않는다(요청 또는 필요 설명 후 승인). 기존 테스트 파일에 회귀 케이스 추가는 가능. 권한관리 기능은 Storybook 미사용.
- **worktree:** 한 worktree에 쓰는 세션은 하나. 변경 전 정확한 경로·브랜치 확인, 다른 worktree로 작업을 옮기지 않는다. 웹/앱 Git 이력은 섞지 않는다.
- **완료 상태 구분:** 구현 / 로컬 검사 / commit·push / PR / merge / 배포 / 실계정 QA / analytics 수신을 각각 따로 보고. 검증 안 한 완료는 주장하지 않는다. 사실·관찰·가설·권고·미확인을 구분.
- **Jira:** 사용자에게 배정된 하위 카드에만 댓글(부모는 요청 시). 비개발자 보고자 대상 결과 중심 문장, 배포 상태 문구 금지. 승인된 업무 접수 시 Web/Office/Lab 제품별 카드 분리(영향 없는 제품은 만들지 않음).
- **Lab 문구 변경:** i18n 리소스·번역 시트 반영·검증까지 기본 범위.
- **스토리 포인트:** 1pt = 6시간(0.5=3h, 0.25=1.5h). 피보나치 아님.
- **답변:** 질문에는 짧게, 헤딩·긴 목록 최소화. 인계·결정 기록은 이어갈 만큼 자세히. 코드블록은 복사용(명령어·정확한 값·붙여넣을 문구)만.
- **결정 제안:** 목표 → 제약 → 옵션 → 장단점 → 리스크 → 권고 순. 근거 없는 확신 금지.
- **마감:** 의미 있는 마감 시 codex-personal-context에 기록 후 자동 commit/push(개인 기록은 예외적으로 자동). 형식: 프로젝트 파일 맨 위 `## 현재 상태 — YYYY-MM-DD <요약>` 추가, 이전 섹션은 "이전 체크포인트"로 내림, `MEMORY_CHANGELOG.md` 날짜 아래 bullet, 필요 시 `PROJECTS.md`·`HANDOFF.md` 요약 갱신, 커밋 `docs: <요약>`. 공유 제품 repo에는 개인 진행 기록을 넣지 않는다.

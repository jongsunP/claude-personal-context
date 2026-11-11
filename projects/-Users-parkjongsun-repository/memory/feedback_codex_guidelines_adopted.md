---
name: codex-guidelines-adopted
description: Dentlink 작업은 codex-personal-context 지침을 정본으로 따른다 — 읽는 순서, Claude Code 대응표, 자주 쓰는 핵심 규칙 요약(정본 우선)
metadata:
  node_type: memory
  type: feedback
  originSessionId: 64e5f883-42fa-4b78-8d56-577e5d6d31e0
  modified: 2026-11-11
---

2026-10-15 사용자 지시로 Claude도 codex-personal-context 지침과 기록을 그대로 따른다. 2026-11-11에 핵심 문서를 전부 정독하고, Codex 고유 절차는 `AI_WORKFLOW.md`의 **Claude Code Mapping** 표로 바꿔 적용하기로 정리했다. 아래는 빠르게 떠올리기 위한 요약이며 **정본은 항상 그 저장소**다(요약과 다르면 정본을 따른다). [[codex-personal-context-handoff]]

**Why:** 사용자는 AI가 바뀌어도 이어지는 개인 지식 시스템을 원한다. 규칙을 여기 복제해 두면 낡아서 어긋난다(10/15 요약이 11/04 브랜치 규칙, 10/29 앱 전략을 놓쳤던 일).

**How to apply:**
- 읽는 순서: BOOTSTRAP → SESSION_WORKFLOW → PROFILE → AI_WORKFLOW → DEVELOPMENT_STYLE → PROJECTS → `projects/<project>.md`. 기록보다 현재 사용자 지시·live Git·GitHub가 우선.
- 기록은 Claude 메모리와 codex 저장소 **양쪽**에(11-10). 마감 시 codex 저장소는 자동 commit·push, 제품 저장소는 명시 요청 시에만.
- 브랜치 `feat/<Jira>`(11-04~), 에이전트 접두어 금지. 웹 신규는 최신 `origin/master` 기준, PR은 배포 예정 release로. 앱은 `main → feat → release → main`, develop 미운용(10-29~). 앱 PR 제목 `[DL-xxxxx] 제목`, 스쿼시 머지는 PR 제목으로.
- 배포 준비는 PR 생성까지. 머지·배포는 별도 명시 지시. 배포 결과 폴링 안 함: 앱은 CodePush 활성 확인, 웹은 Actions 시작 1회 확인 후 종료(11-09).
- 요청 범위 밖 호출·폴링·조사 금지. 애매하면 한 번 묻고 기다림(11-05). 넘긴 세션은 맡기고 폴링 금지.
- 확정 요구·디자인 밖 사용자 노출 UI/문구/동작 추가는 근거 제시 후 승인. 기존 UI·호출 경로를 따른다. 정책·BE 계약 > 디자인 프레임.
- 앱 변경은 최종 코드로 시뮬레이터/에뮬레이터에서 영향 화면만 비례 검증 후 QA 인계.
- Jira: 내 하위 카드에만 댓글, 비개발자 대상 결과 중심, 배포 상태 문구 금지. 1SP = 6시간, AI 산정은 초안.
- 보고: 질문엔 짧게. 현황 브리핑은 **완료한 것 → 현재 영향 → 남은 일**, 여러 요청 보고는 `요청·작업 / 결과` 표.
- Codex 전용 절차(세션 model/thinking, 원격 PIN, `~/.codex`, Codex Atlassian 플러그인)는 Claude Code Mapping 표대로.

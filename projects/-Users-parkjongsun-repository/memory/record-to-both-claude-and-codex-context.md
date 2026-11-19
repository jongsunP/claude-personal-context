---
name: record-to-both-claude-and-codex-context
description: 모든 기록은 Claude 메모리와 ~/Repository/codex-personal-context 양쪽에 반드시 함께 남긴다
metadata:
  type: feedback
---

작업 기록(체크포인트·결정·조사 결과·선호)은 Claude 자체 메모리와 `~/Repository/codex-personal-context`(프로젝트 파일 상단 "현재 상태" + `MEMORY_CHANGELOG.md`, 필요 시 `PROJECTS.md`) **양쪽에 모두** 남긴다. 한쪽만 쓰지 않는다.

**Why:** 사용자가 2026-11-10 명시 지시. codex-personal-context가 이전 에이전트(Codex)와 공유하는 정본이고, Claude 메모리는 Claude 세션의 자동 회상용이라 둘 다 필요하다.

**시점(2026-11-12 사용자 보정):** 동기화는 새 세션 시작·재개 시 필요한 범위(이 저장소·Claude 메모리·작업 대상 repo live Git)를 자동으로 맞춘다 — "매일 첫 프롬프트" 같은 고정 일과가 아니다. 기록은 요청받은 작업(프롬프트)이 끝날 때 한다. 보통 사용자가 "저장/메모리"를 요청하지만, 요청이 없어도 남길 가치가 있는 결정·상태 변화·지침 변경은 넣는다. 사소한 중간 과정은 제외. codex `AGENTS.md` Wrap-Up에도 같은 문장.

**How to apply:** 의미 있는 마감마다 codex-personal-context를 갱신해 commit·push하고, 같은 내용을 Claude 메모리 파일에도 반영한다. codex-personal-context `AGENTS.md`에도 같은 규칙을 적어 두었다. 관련: [[dentlink-app-fix-approval-scope]], [[dentlink-notification-center-status-20261110]].

**2026-11-13 재확인:** 시작·재개 자동 동기화는 기존대로 한다. 작업 도중 사용자가 지침 업데이트를 알려주거나 문서·기억 간 충돌을 발견하면 관련 최신 정본을 자동으로 다시 읽고 필요한 로컬 지침/기억을 맞춘다. pull 성공만으로 최신 규칙 적용을 보장한 것으로 보지 않는다. 매일1회·매프롬프트 전수확인·백그라운드 감시는 추가하지 않는다. 정본: SESSION_WORKFLOW.md의 Rule Application Model.

**적용 범위 재확인(11/13):** 번역뿐 아니라 전체 작업지침의 필요한 변경을 자동 확인·반영한다. 모든 문서를 무조건 조회하라는 뜻이 아니다.

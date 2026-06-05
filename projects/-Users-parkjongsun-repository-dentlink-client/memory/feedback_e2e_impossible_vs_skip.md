---
name: feedback-e2e-impossible-vs-skip
description: E2E spec 작성 시 자동화 불가 / 조건부 가능 / 미구현 3가지를 반드시 구분해야 함
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

spec에는 실행 가능한 것만 작성한다. 3가지를 명확히 구분한다.

| 유형 | 처리 방식 |
|------|----------|
| **자동화 불가** | spec 미작성. SKILL.md + Jira 코멘트에 사유 기록 |
| **조건부 가능** | spec 작성 + `skipReason` 패턴으로 조건부 skip |
| **미구현** | spec 미작성. 향후 `/e2e` 스킬로 추가 |

**Why:** `test.skip`으로 불가 항목을 spec에 남기면 Playwright 리포트에 영구 skipped 노이즈가 쌓이고, "언젠가 구현 가능"으로 오해를 유발한다. 불가와 미구현은 spec 밖(SKILL.md + Jira)에서 관리한다.

**How to apply:** 새 시나리오 작성 시 먼저 이 3가지 중 어디에 해당하는지 판단 후 처리. 코드뿐 아니라 Jira 커버리지 보고 시에도 동일하게 구분해서 표기한다. [[project-e2e-progress]]

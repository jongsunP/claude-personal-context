---
name: feedback-memory-management
description: "메모리 저장 기준 — 작업 마무리나 중요도 판단 시 자동으로 저장, 일관된 작업 방식 유지"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
  modified: 2026-10-15T07:31:13.852Z
---

작업의 마무리로 보이거나 중요하다고 판단되면 사용자가 요청하지 않아도 알아서 메모리에 저장한다.

사용자가 원하는 것은 단순한 작업 처리가 아니라 **대화를 거듭할수록 쌓이는 일관된 작업 방식**이다. 발전은 좋지만 매 세션마다 초기화되는 것은 원하지 않는다.

**Why:** Claude와의 협업 방식 자체가 자산이기 때문. 매 대화마다 처음부터 설명하는 비효율을 없애고 싶어함.

**How to apply:**
- 작업이 마무리되거나 전환점이 보이면 핵심 내용을 메모리에 저장하고 push
- 피드백, 결정, 패턴 — 한 번 확인된 방식은 메모리에 기록해서 다음 세션에도 유지
- 사용자가 같은 설명을 두 번 하지 않도록. "지난번에도 말했는데"가 없도록
- **브랜치명·PR번호·커밋 해시 등 일시적 상태는 Claude 메모리에 저장하지 않는다.** `git branch`, `gh pr list` 로 확인 가능한 것은 메모리 대상이 아님
- 프로젝트 진행 체크포인트(SHA·PR·QA·다음 시작점)는 codex-personal-context `projects/<project>.md`에 기존 형식으로 남긴다. Claude 메모리는 규칙·선호·정본 위치만 ([[codex-guidelines-adopted]])

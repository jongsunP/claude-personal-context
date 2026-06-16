---
name: feedback_branch_naming
description: 브랜치명에는 항상 feature/ prefix를 붙인다 (QA 브랜치 포함)
metadata: 
  node_type: memory
  type: feedback
  originSessionId: e5247354-d961-4c2a-9f34-3ef9d766328d
---

모든 작업 브랜치는 `feature/` prefix를 포함해야 한다. QA용 브랜치도 예외 없이 동일하게 적용.

**Why:** 프로젝트 브랜치 네이밍 컨벤션. 너무 당연해서 별도 언급 없이도 지켜야 하는 규칙.

**How to apply:** 브랜치 생성 시 항상 `feature/{ticket-or-name}` 형식으로 생성. QA, hotfix 등 특수 목적 브랜치도 동일하게 `feature/` prefix 적용.

예시:
- `feature/DL-14754`
- `feature/DL-14752-qa-1`

---
name: feedback_branch_naming
description: 브랜치명에는 항상 feature/ prefix를 붙인다 (QA 브랜치 포함)
metadata: 
  node_type: memory
  type: feedback
  originSessionId: e5247354-d961-4c2a-9f34-3ef9d766328d
---

별도 지시가 없으면 모든 브랜치는 `feature/` prefix가 기본이다. `release/`가 아닌 이상 거의 항상 `feature/`를 붙인다.

**Why:** 프로젝트 브랜치 네이밍 컨벤션. 너무 당연해서 별도 언급 없이도 지켜야 하는 규칙.

**How to apply:** 브랜치 생성 시 항상 `feature/{ticket-or-name}` 형식으로 생성. QA용·작업용·핫픽스 등 모든 브랜치에 동일하게 적용. 예외는 `release/` 계열뿐이며 사용자가 명시적으로 다른 prefix를 지정할 때만 따른다.

예시:
- `feature/DL-14754`
- `feature/DL-14752-qa-1`

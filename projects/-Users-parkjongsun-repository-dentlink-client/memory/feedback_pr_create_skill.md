---
name: feedback_pr_create_skill
description: PR 생성 시 항상 /pr-create 스킬의 템플릿을 사용해야 함
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 73d5cbfd-0711-48b9-8f28-fcab732e0fc0
---

PR 생성 요청 시 반드시 `/pr-create` 스킬을 호출하고, 스킬 내 `01-pr-builder.md` 템플릿을 사용하여 PR 제목·본문을 작성한다.
직접 `gh pr create`를 임의 형식으로 실행하는 것은 금지.

**Why:** 팀 PR 컨벤션(Description / Issue / Changes / Task List / References / To Reviewers 섹션)이 스킬 템플릿에 정의되어 있으며, 사용자가 이 형식을 일관되게 유지하길 원함.

**How to apply:**
- "PR 만들어줘", "PR 생성해줘", "PR 올려줘" 등 PR 생성 관련 요청 → 반드시 `Skill({ skill: "pr-create" })` 호출
- 스킬이 로드된 후 템플릿 기반으로 초안을 작성하고 사용자 확인 후 생성
- 타겟 브랜치는 사용자가 명시한 경우 그대로 사용, 없으면 `master`

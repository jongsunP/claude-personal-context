---
name: feedback-branch-policy
description: "브랜치 정책 — cherry-pick 금지, release/master 직접 커밋 금지, 의도 애매 시 재확인"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: dec1636b-e940-4a2b-8270-114a1b60885a
---

release 또는 master에는 절대 직접 커밋하지 않는다. 항상 feature 브랜치를 따서 작업하고 PR로 머지한다.

cherry-pick은 사용자가 명시적으로 요청하지 않는 한 절대 하지 않는다.

브랜치 작업 범위나 어느 브랜치에 적용할지 의도가 애매할 때는 먼저 사용자에게 물어본다.

**Why:** 사용자가 일부러라도 브랜치를 따는 이유가 release/master를 보호하기 위해서다. cherry-pick을 무단으로 실행하면 의도치 않은 릴리즈에 코드가 포함될 수 있다.

**How to apply:** 작업 브랜치가 feature/* 인지 항상 확인. release/* 또는 master에서 직접 커밋/push 요청이 와도 먼저 재확인. cherry-pick 요청은 사용자가 "cherry-pick 해줘"라고 명시할 때만 실행.

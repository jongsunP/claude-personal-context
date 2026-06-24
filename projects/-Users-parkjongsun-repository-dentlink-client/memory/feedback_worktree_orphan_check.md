---
name: feedback_worktree_orphan_check
description: 워크트리 고아 폴더 판단 시 .git 파일 존재 여부까지 확인해야 함
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 6f6f6a5f-7780-4b22-b8a4-29f26d41d8e0
---

워크트리였다가 해제된 폴더인지 확인할 때 `git worktree list` 미등록만으로 "고아 폴더 맞다"고 단정 짓지 않는다.

**Why:** 사용자 말만 믿고 삭제 전 `.git` 파일(워크트리임을 증명하는 `gitdir` 참조 파일) 존재를 확인하지 않아 근거 없이 단정했다는 지적을 받음.

**How to apply:** 워크트리 고아 여부 판단 시:
1. `git worktree list` 로 등록 여부 확인
2. 폴더 내 `.git` 파일 존재 + 내용(`gitdir: ...`) 확인
3. 두 가지가 일치할 때만 "워크트리 고아 폴더"로 결론 내리기

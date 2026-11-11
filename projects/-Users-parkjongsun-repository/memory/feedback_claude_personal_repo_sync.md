---
name: claude-personal-repo-sync
description: 클로드 개인 설정/메모리 확인·저장은 항상 리모트 기준 — pull/push 자동 처리
metadata: 
  node_type: memory
  type: feedback
  originSessionId: b61b6ce4-4372-466b-ad4c-e5671a175a48
---

"확인해줘"는 항상 리모트(jongsunP/claude-personal-context) 기준이다. 로컬 파일만 보는 것으로 끝내지 않는다.
저장도 마찬가지로 리모트에 push까지 완료해야 저장으로 간주한다.

**Why:** 집/사무실 환경 간 git 동기화로 작업을 이어가는 구조이므로, 리모트가 항상 진실 소스다.

**How to apply:**
- "확인해줘" → `git pull` 후 리모트 최신 내용 기준으로 확인
- 메모리 저장 → 파일 작성 후 `git add`, `git commit`, `git push`까지 완료
- `~/.claude` 변경이 생기면 묻지 않고 커밋·푸시 자동 처리

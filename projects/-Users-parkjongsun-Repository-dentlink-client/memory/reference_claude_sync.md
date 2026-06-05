---
name: reference-claude-sync
description: 새 컴퓨터에서 ~/.claude 메모리/설정 동기화하는 git 기반 방법
metadata: 
  node_type: memory
  type: reference
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

Claude 개인 설정 및 메모리는 `git@github.com:jongsunP/claude-personal.git` 저장소로 관리.

**처음 클론 (새 컴퓨터 최초 설정):**
```
git clone https://github.com/jongsunP/claude-personal.git ~/.claude
```

**메모리가 업데이트됐을 때 (pull):**
```
cd ~/.claude && git pull
```

**새 컴퓨터에서 메모리를 변경했을 때 (push):**
```
cd ~/.claude && git add -A && git commit -m "update" && git push
```

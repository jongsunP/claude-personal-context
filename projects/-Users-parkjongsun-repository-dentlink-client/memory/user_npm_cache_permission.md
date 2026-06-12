---
name: user-npm-cache-permission
description: 사무실 맥 ~/.npm 캐시 일부가 root 소유 — optional dep 설치가 조용히 실패함
metadata: 
  node_type: memory
  type: user
  originSessionId: a88fe62a-06cc-440a-b105-c1cfcc95fb21
---

사무실 MacBook Pro의 `~/.npm` 캐시 일부 디렉토리가 root 소유라서(과거 sudo npm 흔적), npm 설치 시 optional dependency 다운로드가 EACCES로 조용히 실패한다. claude-code 네이티브 바이너리 누락(2026-06-12)의 원인이었음.

**해결법**: `--cache /tmp/npm-cache-fresh` 등 새 캐시 경로로 우회 설치. 근본 해결은 `sudo chown -R parkjongsun:staff ~/.npm` (사용자가 직접 실행 필요 — 2026-06-12 기준 미실행).

---
name: user-environment
description: 사용자의 작업 환경 — 집 컴퓨터 vs 사무실 컴퓨터 구분
metadata: 
  node_type: memory
  type: user
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

사용자는 두 대의 컴퓨터를 사용한다.

- **사무실 컴퓨터**: 주 작업 환경. 평소 개발 작업이 진행되는 곳.
- **집 컴퓨터**: 보조 환경. 사무실에서 하던 작업을 이어서 진행할 수 있도록 `~/.claude`를 git으로 동기화해서 사용. ([[reference-claude-sync]] 참고)

**How to apply:** 집 컴퓨터에서 작업 시 사무실에서 진행하던 작업을 이어받는 맥락임을 인지. 메모리 기반으로 이전 작업 컨텍스트를 복원해서 진행한다.

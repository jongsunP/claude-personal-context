---
name: project-legacy-pages
description: 레거시(미사용) 페이지 목록 — 수정/검토 범위에서 제외
metadata: 
  node_type: memory
  type: project
  originSessionId: 01429dff-eb8d-42f5-8c8d-581867dcd615
---

## 레거시 페이지

- `/office/onboard/` (landing.tsx, [step].tsx) — 더 이상 사용하지 않는 페이지. 검토·수정 범위 제외.

**Why:** 신규 병원 등록 플로우가 /auth/signup → /office/find → /office/register 로 대체됨.
**How to apply:** 이 경로 파일에 대한 스타일/기능 수정 요청 시 레거시 페이지임을 먼저 확인한다.

---
name: dl17548-cp-scrp-split
description: "DL-17548 CP Retention Type SCRP 두 선택지 분리 — 웹 PR #4936·치과앱 PR #358 생성, BE #2744 미머지라 STG는 400"
metadata:
  node_type: memory
  type: project
  originSessionId: 554a9257-f367-4b53-a8fd-a085c4c33121
  modified: 2026-11-23T05:54:32.513Z
---

2026-11-23 기준. 부모 DL-17368(v1.94.0), BE DL-17547(Leo, PR dentlink-backend#2744 → develop, 미머지).

- 웹 PR #4936 `feat/DL-17548` → `release/v1.94.0`, 치과앱 PR #358 `feat/DL-17548` → `release/v2.2.5`(release 기준, main 포함 확인). 기공소앱은 웹 WebView라 변경 없음. 미머지·미배포.
- worktree: `~/Repository/dentlink-client-dl17548`, `~/Repository/dentlink-app-dl17548`.
- 결정: 두 SCRP 모두 주문 옵션 "SCRP (Screwmentable)" 연결(기획 미확인 기본안), 기존 SCRP는 Crown Cemented로 표시·선택. 생성 모델은 DEV 재생성 시 무관 변경이 커서 재생성하지 않고 FE 타입 계층에만 추가. 이미지 4장 270×180 교체, 웹 `?t=20261123`. 웹 카드 제목은 480px 이상에서 nowrap.
- API: DEV 저장·조회 확인, STG는 400(BE 미반영). 사용자 지시로 E2E 가드 SKIPPED.

**Why:** BE와 배포 시점이 어긋나면 SCRP 저장이 실패한다.
**How to apply:** 머지·배포 요청 시 BE #2744의 STG/운영 반영 여부를 먼저 확인한다. 관련: [[record-to-both-claude-and-codex-context]]

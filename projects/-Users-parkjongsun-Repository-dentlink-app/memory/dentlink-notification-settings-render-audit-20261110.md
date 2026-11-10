---
name: dentlink-notification-settings-render-audit-20261110
description: "알림 수신 설정 화면이 서버 응답과 1:1이 아닌 지점 조사 결과(4개 제품, 조사만·수정 승인 대기)"
metadata:
  node_type: memory
  type: project
  originSessionId: 19d690a1-9ac7-4e38-9ce5-5fb075646951
  modified: 2026-11-10T09:02:21.377Z
---

2026-11-10 조사만 완료(코드 수정·커밋 없음). 정본: `~/Repository/codex-personal-context/projects/dentlink-unified-notification-center-settings-render-audit-2026-11-10.md`.

- 4개 제품(Office앱·Lab앱·Clinic웹·Lab웹) 모두 서버 `view.employee.categories` 순서로 항목·채널·값을 그림. FE 하드코딩 목록은 없음(구 `ProfileNotificationSection`은 미사용 dead code).
- 서버와 다른 지점: 이름은 FE 사전(서버 view에 카테고리·도메인·채널 displayName 없음), 묶음 규칙이 제품마다 다름(Office앱 `domain==="ORDERS"`만 / Lab앱 `channels` 유무 / 웹 `CREDITS`·`PAYMENTS`만 단독), `view.user` 전 제품 미표시, 웹은 `toggleChannel=PUSH` 항목과 PUSH 채널 제외(의도된 정책), 상위 OFF 시 채널 숨김.
- 실서버 재조회는 토큰 필요로 미실행 — 채널 구성은 11/9 카탈로그 기준 추정.

**Why:** 사용자가 "설정 화면이 서버 응답대로 안 그려지는 것 같다"고 관찰해 원인 후보를 정리함.
**How to apply:** 수정 요청이 오면 위 원인 중 어느 것인지 먼저 특정하고, displayName은 BE 보완·웹 PUSH 제외/공통 묶음 규칙/user 영역은 기획 결정이 필요함을 구분한다. 승인 범위는 [[dentlink-app-fix-approval-scope]]를 따른다.

**확정 기준(2026-11-10 사용자):** view의 employee→user를 디자인 순서대로, 각 categories를 서버 순서 그대로 그린다. 서버 displayName은 제거 예정(orderScopes 포함). FE가 공통 대문자 코드로 매핑하고 없으면 코드 그대로 노출. 기공소는 다국어(영=디자인 영어, 한=한글). 매핑 누락은 즉시 보고. 누락 확인 결과: 치과앱·치과웹 orderScope(ALL_ORDERS/MY_ORDERS_ONLY) 매핑 없음(displayName 제거 시 주문 범위 선택 사라짐), 치과앱 도메인 사전은 ORDERS만, employee/user 영역 제목 없음. 기공소앱·기공소웹은 누락 없음. 수정은 승인 대기.

**구현(2026-11-10, 미커밋):** 치과앱·기공소앱 각 feature 브랜치 checkout, 웹은 worktree `~/Repository/dentlink-client-notification-center`(feature/DL-17058)에서 수정. GET 배열 순서대로 employee→user, 연속 묶음만 합침, displayName FE 사용 제거(Swagger 생성 파일은 유지), 웹 PUSH 항목·채널 노출. 매핑은 사용자가 공유 예정(주문 범위 매핑 비어 있어 지금은 코드 노출). 테스트·tsc 통과, 화면 실행 확인·commit 대기.

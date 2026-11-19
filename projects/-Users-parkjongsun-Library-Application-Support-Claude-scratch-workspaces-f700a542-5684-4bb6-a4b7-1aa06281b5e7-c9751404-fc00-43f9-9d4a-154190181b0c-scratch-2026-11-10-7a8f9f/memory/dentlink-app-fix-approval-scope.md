---
name: dentlink-app-fix-approval-scope
description: "Dentlink 앱 수정 승인 범위 — 조사≠실행, JS(CodePush)만, 네이티브/심사·애매하면 다시 묻기, 리뷰용 PR은 건드리지 않기"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 5612716a-ee2d-406e-9c3a-04f8abfdb01a
  modified: 2026-11-10T06:40:56.507Z
---

Dentlink 앱(치과앱 dentlink-app / 기공소앱 dentlink-lab-app) 작업에서 사용자가 반복해 정한 경계:

- "조사해줘", "파악되는지"는 조사만 한다는 뜻이다. 수정·commit·push·배포는 명시 지시가 있을 때만 한다. 작업 중에도 "아직 처리하지 말고 조사만"이라고 다시 확인했다.
- 추가 수정은 JS(CodePush로 나갈 수 있는 범위)만 허용한다. 네이티브 변경(스토어 심사 필요)이 필요하면 하지 않고, 사이드이펙트나 심사 영향이 애매하면 임의로 처리하지 않고 다시 묻는다.
- 실행 전에 "이해한 내용"을 브리핑하고 승인을 받은 뒤 시작한다.
- 앱 개발자 리뷰용으로 남겨 둔 Draft PR은 상태·본문·base를 그대로 두고, 해당 브랜치에 커밋만 push해서 포함시킨다.
- 개발 배포는 feature 브랜치에서 `node scripts/codepush.js dev all --mute`(치과앱 → 기공소앱 순서)로 하고, history 1회 확인 뒤에는 감시하지 않는다.

**Why:** 이전 에이전트(Codex)가 조사 질문을 실행 승인으로 잘못 해석해 패치를 삭제·push한 일이 있었고, 사용자는 웹 개발자라 앱 네이티브 영향 판단을 확실히 해 주기를 원한다.

**How to apply:** 앱 작업 요청을 받으면 먼저 조사인지 실행인지 구분한다. 실행이면 범위(JS/네이티브, 앱 종류, PR 처리)를 브리핑하고 승인을 받는다. 결과는 웹 개발자도 이해할 수 있게 쉬운 말로 설명한다. 작업 기록 정본은 [[codex-personal-context-canonical]].

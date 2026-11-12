---
name: notification-web-push-hiding-pending-be-key
description: 알림 설정 웹 PUSH 숨김은 toggleChannel 추론으로 된 임시 처리 — BE가 노출 대상 키를 주면 어느 에이전트든 그 키로 재수정 (2026-11-12)
metadata:
  type: project
---

웹 알림 설정은 `toggleChannel === "PUSH"`인 카테고리(링크톡, 덴트링크 서포트)를 숨기고, 다른 항목의 PUSH 체크를 뺀다. 코드: web `shared/models/src/notifications/notifications.settings.ts` `groupNotificationSettings`(`hiddenChannel`), `shared/ui/src/NotificationUI/NotificationCenter.tsx`가 `"PUSH"`를 넘김. 저장할 때 숨긴 값은 그대로 보낸다.

**Why:** `toggleChannel`은 BE 정의상 "카테고리 토글이 담당하는 채널"이다. 어떤 UI 형태로 그릴지 알려 주는 화면 구성 메타이지 노출 대상이 아니다. "푸시 전용"이라는 정보는 알림 스프레드시트에만 있다. 그래서 지금 처리는 FE 추론이고, 구성이 바뀌면 어긋날 수 있다. 예를 들어 토글이 PUSH인데 MAIL 채널이 함께 있으면 웹에서 MAIL까지 사라지고, 토글이 PUSH가 아닌 앱 전용 카테고리는 걸러내지 못한다. 사용자가 BE(Leo, DL-17114)에 노출 대상 키(예: `platforms: ["APP"]`)를 추가해 달라고 직접 요청하기로 했다(2026-11-12).

**How to apply:** 키가 생기기 전까지는 지금 방식을 유지한다. BE 응답이나 스웨거에 노출 대상 키가 생기면, 어느 에이전트든 웹(필요하면 앱도) 숨김 조건을 그 키 기준으로 바꾸고 `toggleChannel` 추론을 없앤다. 정본: codex `projects/dentlink-unified-notification-center.md` "웹 PUSH 숨김 근거".

관련: [[dentlink-notification-center-status-20261110]], [[reference-notification-center-sources]]

---
name: dentlink-notification-center-status-20261110
description: Dentlink 통합알림센터 2026-11-10 마감 상태 — iOS 배너 수정 v142/v40, Android 패치 PR 완료, 웹 노출 페이지 현황
metadata:
  type: project
---

2026-11-10 마감 기준(정본: `codex-personal-context/projects/dentlink-unified-notification-center.md` 상단).

1. **iOS 푸시 탭 후 배너 재표시:** 원인은 iOS 알림 탭을 Notifee가 먼저 받는데(링크 순서상 최상위 delegate) 1차 수정이 Firebase 탭 경로만 처리한 것. 2차 JS 수정(Notifee PRESS·getInitialNotification에서 `remote.messageId` 기록)을 치과앱 `feature/DL-17059@d4de608`, 기공소앱 `feature/DL-17060@e9108b8`에 push, Development CodePush 치과앱 2.2.4 v142·기공소앱 1.0.5 v40. Draft PR #346/#42 본문·상태 불변. **iOS 실기기 확인은 사용자 몫(대기).**
2. **Android Notifee ReactHost 호환 패치:** 알림센터와 분리해 dentlink-app#348(→release/v2.2.5), dentlink-lab-app#44(→release/v1.0.6) PR까지 **완료**. 반영·심사는 앱 개발자. PR 본문 맨 위 요약(필요 이유·위험도 낮음~보통) 포함.
3. **웹 알림센터 서비스별 노출 페이지 현황:** **완료**(기획자 공유, 결정 후 변경 또는 현행 유지). master `bafb0b1`·develop `d76c85f` 동일. 치과 웹: 미노출 없음. 기공소 웹 미노출: 주문상세 `/orders/[order_id]`, 주문 승인, `/mc/*`, `/milling/*`(데스크톱·모바일), `/pickup`·`/pickup/[id]`·`/shipping/[id]`·`/shipping/scan`·`/members`·`/my` 계열(모바일만). 상세는 codex-personal-context `projects/dentlink-unified-notification-center-web-visibility-2026-11-10.md`.
4. 루트 `patches/`(iOS Notifee 등) 새 설치 미적용 발견은 사용자 결정으로 **고려하지 않음**.

**Why:** 다음 세션이 같은 조사를 반복하지 않고 남은 일(iOS 실기기 확인 결과 대응)만 이어가기 위함.
**How to apply:** 재개 시 위 정본과 live Git을 대조하고, 사용자 실기기 결과에 따라 다음을 정한다. 관련: [[dentlink-app-fix-approval-scope]], [[record-to-both-claude-and-codex-context]].

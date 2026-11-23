---
name: feedback_notification_center_stg_only
description: 2026-11-20부터 알림센터 작업은 웹·앱 모두 DEV는 신경 쓰지 않고 스테이징(STG)만 배포·확인
metadata:
  node_type: memory
  type: feedback
  originSessionId: 8de30aa4-aa51-486a-8718-e5359b4600ef
  modified: 2026-11-20T07:54:26.018Z
---

2026-11-20 사용자 지시: "이제 웹이던 앱이던 개발서버는 신경 안 써도 됨. 지금부터는 스테이징만."
- 앱 CodePush는 STG만(release 브랜치 기준, 사용자가 지정한 브랜치), DEV CodePush·DEV 최신화 제안을 하지 않는다.
- 웹 STG 배포는 release/v1.94.0로 사용자가 직접 할 수 있으니, 웹 배포는 요청받을 때만.
- 상태 보고에서 "DEV 미반영"을 남은 일로 올리지 않는다.

- 예외: 11/20 사용자가 "앱만 릴리즈 브랜치로 개발도 배포"를 지시해 DEV CodePush를 함(지시가 있을 때만).

**Why:** 알림센터가 release 머지·STG QA 단계로 넘어가 DEV 정합성은 더 이상 의미가 없다.

**How to apply:** 배포·검증·남은 일 정리 때 STG 기준으로만 판단한다. 단 로컬 시뮬·에뮬 기기 테스트 환경은 DEV([[feedback_app_local_test_dev]], 11/23). 다시 DEV를 언급하면 그때 따른다. 관련: [[notification-center-resume-20261116]]

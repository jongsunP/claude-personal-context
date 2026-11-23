---
name: feedback_app_local_test_dev
description: 앱 기기 테스트는 따로 지시가 없으면 항상 로컬 DEV(개발) 빌드·DEV API로 한다 (2026-11-23)
metadata:
  type: feedback
---

2026-11-23 사용자 지시: "로컬로 확인해 개발로", "따로 시키지 않는 이상은 앱 테스트는 항상 이거야".
- 시뮬레이터·에뮬레이터 확인은 로컬 Metro + DEV 디버그 빌드(`yarn ios:dev`, `yarn android:dev`)와 DEV API·키체인 DEV 테스트 계정으로 한다. STG 디버그 빌드를 새로 만들지 않는다.
- 배포(CodePush)·보고 기준이 STG인 것([[feedback_notification_center_stg_only]])과 별개다. 그 규칙은 배포·QA 대상 이야기이고, 로컬 기기 테스트 환경은 DEV.

**Why:** STG 디버그 빌드는 새로 빌드해야 해서 오래 걸리고, 로컬 확인은 DEV로 충분하다는 사용자 판단.

**How to apply:** 기기 확인을 시작할 때 묻지 않고 DEV로 진행한다(실행 자체의 사전 확인 규칙 [[feedback_ask_before_device_runs]]는 유지). 사용자가 STG를 지정하면 그때 STG.

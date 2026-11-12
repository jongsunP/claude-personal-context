---
name: swagger-generated-files-as-is
description: Dentlink 스웨거 생성 파일은 생성 결과 그대로 쓰고, 변경은 FE 가공 계층에만 (2026-11-12 사용자)
metadata:
  type: feedback
---

스웨거 생성 파일(앱 `src/models/Api.ts`, 웹 `shared/models/src`)은 생성 결과를 그대로 커밋하고 손으로 고치지 않는다. 필요한 변경은 그 위에 FE가 만든 타입·export·매퍼·기능 코드에만 넣는다.

**Why:** 생성 파일은 서버 변경에 따라 계속 다시 만들어지므로, 손수정은 다음 생성 때 사라지고 차이만 만든다.

**How to apply:** 스웨거 갱신 후 깨지는 곳은 생성 파일이 아니라 그것을 쓰는 FE 코드에서 맞춘다. 앱의 알림 전용 `src/models/NotificationApi.ts` 같은 별도 추출본은 알림 설정 작업 때 생성 타입 기준으로 정리할 대상이다. 정본은 codex `DEVELOPMENT_STYLE.md`(API Contracts 절).

관련: [[dentlink-notification-center-status-20261110]]

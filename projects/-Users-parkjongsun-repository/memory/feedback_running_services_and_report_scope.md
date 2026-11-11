---
name: running-services-and-report-scope
description: 실행 중인 패널 탭은 사용자가 닫아야 할 정리 대상이 아님을 명확히 알릴 것, 사무실 Mac 미커밋 변경은 보고에서 언급하지 않음
metadata:
  type: feedback
---

2026-11-11 사용자가 "패널 탭은 내가 정리해야 되는 줄 알고 다 껐다"고 했다. 그 결과 웹 Clinic 서버·에뮬레이터·iOS 시뮬레이터·Metro·테스트 Chrome·Reactotron이 모두 꺼졌고 다시 복구했다. 또 "사무실 Mac의 것은 별도로 있는 거니까 말 안 해줘도 된다"고 했다.

**Why:** 내가 "필요 없는 탭은 닫으셔도 된다"고 안내하면서 어떤 탭이 계속 돌아야 하는지를 구분해 주지 않아 사용자가 전부 닫았다. 사무실 Mac의 미커밋 작업은 사용자가 이미 알고 따로 관리한다.

**How to apply:**
- 실행 환경을 띄워 둘 때는 "계속 켜 둘 탭"(웹 서버, Metro, 에뮬레이터 등)과 "닫아도 되는 탭"을 이름으로 명확히 나눠 알린다. 사용자가 할 일이 아닌 것은 "닫으셔도 된다"고 말하지 않는다.
- 복구 순서: Reactotron → iOS 부팅·`devices://` 창 → 에뮬레이터(패널 탭) → Metro(기본 Office, 패널 탭) → 테스트 Chrome(전용 프로필, 3000·3005) → 앱 실행. 로그인은 기기·프로필에 남아 있다.
- 브리핑·남은 일 보고에서 사무실 Mac의 미커밋 변경은 언급하지 않는다.

관련: [[local-repo-setup-status]], [[dentlink-fe-main-session]]

---
name: feedback_ask_before_device_runs
description: 시뮬레이터·에뮬레이터를 띄워 검증하려면 먼저 묻고, 그 환경에 확인할 데이터가 있는지부터 확인
metadata:
  type: feedback
---

시뮬레이터·에뮬레이터·Metro를 띄워 앱 동작을 확인하려면 **띄우기 전에 사용자에게 묻는다**. 묻기 전에 그 환경(DEV 등)에 확인할 데이터가 실제로 있는지부터 확인하고 함께 알린다. 데이터가 없거나 실기기 CodePush 후 사용자가 직접 보는 편이 나으면 그렇게 제안한다.

**Why:** 2026-11-19 유저 크레딧 Auto-apply 토글(DL-17501 3차) 수정 중, 지침의 "양OS 전환 확인"을 이유로 묻지 않고 에뮬·시뮬·Metro를 띄웠다. 사용자: "시뮬에뮬할꺼면 물어보고 해야지. 데이터부터 있지도 않은데", "실기기 코드푸쉬되면 내가 볼께".

**How to apply:** 기기 확인이 필요해 보이면 이유·대상 환경·데이터 유무·예상 소요를 짧게 말하고 승인받는다. 승인 없이는 테스트·정적검사까지만 하고 기기 확인은 사용자 실기기 QA로 남긴다. [[feedback_app_runtime_risk_based]] [[feedback_devices_outside_claude_app]]

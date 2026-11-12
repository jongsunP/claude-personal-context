---
name: feedback_devices_outside_claude_app
description: 앱 작업 시 iOS 시뮬레이터·Android 에뮬레이터·Metro는 클로드 앱 밖에서 띄운다(인앱 시뮬 패널 사용 안 함)
metadata:
  type: feedback
---

앱 작업에서 시뮬레이터·에뮬레이터를 띄워야 하면 **둘 다 클로드 앱 밖**에서 띄운다. 인앱 iOS 시뮬레이터 패널(attach)은 쓰지 않는다(쓴 경우 detach).

**Why:** 2026-11-12 사용자 지시. 에뮬은 밖, 시뮬은 안에 있어 사용 방식이 갈렸다. 둘 다 같은 곳이면 상관없지만 통일이 필요하다.

**How to apply:**
- 사무실 Mac Xcode 27.2에는 Simulator.app이 없고 `/Applications/Xcode.app/Contents/Applications/DeviceHub.app`이 있다 → `open` 으로 DeviceHub를 띄운다. 헤드리스 확인은 `xcrun simctl io <udid> screenshot`.
- 에뮬레이터·Metro는 내 셸 백그라운드가 아니라 macOS 터미널 창으로 띄운다: `~/.local/share/dentlink-local-runtime/{android-emulator,office-metro-8081}.command`를 `open -a Terminal`. 내 셸에서 띄운 에뮬레이터는 세션 중 꺼졌다.
- 실행 후 어떤 창을 계속 켜 둬야 하는지 안내한다([[feedback_running_services_and_report_scope]]).

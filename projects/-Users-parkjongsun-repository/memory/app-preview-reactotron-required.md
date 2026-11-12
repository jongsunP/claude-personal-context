---
name: app-preview-reactotron-required
description: 앱 실행·미리보기를 띄울 때 Reactotron 실행 + Android adb reverse 9090 + iOS·Android 두 연결 확인까지가 한 세트 (2026-11-12 사용자 지적)
metadata:
  type: feedback
---

앱(Office·Lab)을 시뮬레이터·에뮬레이터에 띄우거나 Metro를 켤 때는 Reactotron도 함께 켜고 연결까지 확인한다. 지침은 이미 있다(codex `projects/dentlink-app-local-development.md`의 Reactotron 단계, `AGENTS.md` "Direct app preview must verify both iOS and Android debugger/Reactotron connections").
- `open -a Reactotron`(9090 LISTEN 확인) → Android `adb reverse tcp:9090 tcp:9090`(Metro 8081/8082 reverse와 별도) → 앱 다시 불러오기(`curl -X POST http://localhost:<metro포트>/reload` 또는 Reactotron의 Reload App) → Reactotron Connections에 iOS·Android 둘 다 보이는지 확인.
- 사용자가 직접 보는 미리보기면 연결 목록(디바이스 선택)을 펼쳐 둔다.

**Why:** 2026-11-12 알림센터 작업 세션이 Metro 8081/8082와 기기는 띄웠지만 Reactotron을 켜지 않고 9090 reverse도 빠뜨렸다. 사용자가 "지침이 제대로 없냐, 왜 안 켜고 연결 안 했냐"고 지적했다.

**How to apply:** Metro·기기를 띄우는 모든 세션(메인·작업 세션)에서 Reactotron 연결 확인 전에는 미리보기 준비 완료라고 하지 않는다.

관련: [[user-environment]]

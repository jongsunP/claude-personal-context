---
name: feedback_app_server_toggle_pattern
description: 앱에서 서버 저장 토글 구현·수정 시 체크리스트(DL-17501·17524 결과) — Switch는 정상, 화면·저장 흐름에서 해결
metadata:
  type: feedback
---

앱 토글이 서버에 저장되면 아래를 한 번에 적용한다. 공용 `Switch` 컴포넌트는 고장이 아니며(프로필·알림설정 정상), 원인은 사용하는 화면과 저장 흐름이었다.

1. 누르는 즉시 표시, 저장·확인 중에도 입력 허용, 같은 필드는 마지막 선택을 순차 저장. `disabled`는 권한 없음·오류·확인값 없음일 때만(저장/조회 중 금지).
2. 다음 값은 Switch가 넘기는 `!value`가 아니라 마지막 선택(ref) 기준으로 계산(화면 갱신 전 연속 탭 대비).
3. 저장 직후 확인 GET이 이전 값을 줄 수 있음(DEV에서 확인) → 다르면 바로 덮지 말고 0/200/500/1000ms 재확인, 끝까지 다를 때만 서버 값, 새 탭 오면 중단.
4. 토글 상태는 작은 컴포넌트로 분리해 목록·화면 전체 재렌더 방지(안드로이드 FlatList 화면에서 ~170ms 막힘).
5. RefreshControl `refreshing`은 사용자 당김만. 재마운트되는 목록 안 스위치는 `animateOnMount={false}`, 작은 스위치는 `hitSlop={10}`.
6. 공용 Switch 기본값은 범위 결정 없이 바꾸지 않고 사용처에서 해결.
7. 양OS 첫 탭·연속 탭·저장 후 되돌아감 확인. 임시 로그는 `adb logcat -s ReactNativeJS` / iOS `com.facebook.react.log` 스트림, 끝나면 제거. 시뮬·에뮬은 실행 전 확인.

**Why:** 2026-11-19 유저 크레딧 Auto-apply(DL-17501 3회·DL-17524)에서 지침 일부만 적용해 반복 지적을 받았고, 측정으로 원인(확인 GET 이전 값 덮어쓰기, 화면 전체 재렌더, 갱신 전 `!value`)을 확정·해결했다. 사용자가 다음 작업에도 활용하도록 지침화를 지시.

**How to apply:** 앱 토글 신규/수정 시 위 항목을 처음부터 모두 적용하고 미루지 않는다. 정본은 codex-personal-context DEVELOPMENT_STYLE "Dentlink App Implementation Boundaries". [[feedback_inline_settings_responsiveness]] [[feedback_ask_before_device_runs]]

---
name: feedback_no_guessing_on_direction
description: 방향 결정 근거(기존 선례·약속)는 코드로 확인한 사실만 말하고 넘겨짚어 일반화하지 않음
metadata:
  type: feedback
---

방향을 정하는 근거로 기존 선례·팀 약속을 들 때는 코드·자료로 확인한 범위만 말한다. 일부 사례를 "전체 규칙"처럼 일반화하거나 추정을 사실처럼 말하지 않는다. 확인 못 한 부분은 "미확인"으로 분리한다.

**Why:** 2026-11-19 DL-17505 논의에서 결제수단 5곳에만 쓰인 `useAppAwareToast`를 "웹뷰 토스트는 앱으로 넘기는 약속"으로 일반화해 방향을 권했고, 사용자가 상용 주문상세는 웹 토스트라고 바로잡음. 사용자: "이건 말그대로 방향을 결정하는 중요한건데 넘겨집지마."

**How to apply:** 방향/설계 의견 전 근거 사례의 적용 범위(사용처 수·대상 화면·상용 반영)를 grep/master로 확인하고 그 범위대로 말한다. [[feedback_infer_from_context]] [[feedback_ask_when_uncertain]]

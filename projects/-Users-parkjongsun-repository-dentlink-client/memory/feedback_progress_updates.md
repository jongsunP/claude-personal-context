---
name: feedback-progress-updates
description: 작업이 클 경우 중간 진행 상황을 텍스트로 보여줘야 한다 (항상 적용)
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7eb41077-2576-4f45-a320-2ddc851dc2cf
---

작업이 클 경우, 실시간이 아니어도 좋으니 중간마다 현재 진행 중인 단계를 텍스트로 표시해야 한다.

**Why:** 사용자가 작업을 중간에 멈추고 다른 작업을 하다가 돌아오는 경우가 있어, 진행 상황 인지가 필요하다.

**How to apply:** 큰 작업(파일 여러 개 수정, 다단계 분석, 테스트 실행 등)은 각 단계 시작 전 "--- [단계명] ---" 형태로 짧게 현재 단계를 텍스트 출력. 모든 작업에 항상 적용.

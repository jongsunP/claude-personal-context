---
name: feedback-progress-update
description: 긴 작업 중 1분 이상 무응답 시 중간 진행 상황 보고 필수
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

작업이 길어질 때 1분 이상 아무 출력 없이 진행하지 않는다. 중간에 간략한 진행 상황을 텍스트로 보고한다.

**Why:** 사용자 입장에서 작업이 진행 중인지 멈춘 건지 알 수 없어 불안함.

**How to apply:** 파일 읽기·코드 작성·테스트 실행 등 시간이 걸리는 작업은 "지금 X 하는 중입니다" 형태로 중간 보고. 한 줄이면 충분.

---
name: project-e2e-master-plan
description: E2E 자동화 마스터 플랜 4단계 — 전체 목표와 진행 상태
metadata: 
  node_type: memory
  type: project
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

## 4단계 계획

| 단계 | 내용 | 상태 |
|------|------|------|
| 1. UI 대응 | 바뀐 UI에 맞게 기존 시나리오·셀렉터 수정 | ✅ 완료 (92/5/0) |
| 2. 리팩토링 | 마이크로 함수 구조화 (steps/ 단위 함수 → spec에서 조합만) | ❓ 확인 필요 |
| 3. Skill 등록 | 새 시나리오도 기존 함수 재조합으로 처리 가능한 스킬 추가 | ✅ 완료 (`/e2e` 스킬) |
| 4. PM 시나리오 대응 | 스킬 통해 코드 추가 → 테스트 → 재수정 사이클 자동화 | 🔄 진행 가능 (PM 요청 대기) |

**Why:** 처음부터 잡은 큰 그림. 단계별로 순서대로 진행.

**How to apply:** 재개 시 2단계 리팩토링 완료 여부 확인 후 이어서 진행. [[project-e2e-progress]]

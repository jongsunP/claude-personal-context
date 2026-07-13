---
name: feedback-e2e-determinism
description: E2E 테스트 결정론 원칙 — 몇 번 어떻게 실행해도 항상 동일한 결과
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 022017ba-4061-4ddd-b8dc-eb8fbc381a99
---

E2E 테스트는 실행 방식(`:clinic` / `:clinic:stg` / `:clinic:ui`)이나 실행 횟수(1회/연속/반복)에 관계없이 **항상 동일한 결과**를 내야 한다.

**Why:** "됐다가 안 됐다"는 E2E 신뢰 파괴. 플랫폼·환경·타이밍에 의존하는 테스트는 의미 없음.

**How to apply:**
- flaky 발생 시 timeout 늘리기·retry 추가는 임시방편. 근본 원인(세션 만료, 상태 의존, 타이밍 가변) 제거 필수.
- 세션 만료: `ensureSessionActive(page)` 패턴으로 자동 재로그인 (stg 장시간 실행 대응).
- 상태 기반 대기: 시간 기반 `timeout`이 아니라 실제 렌더링 완료 요소 대기.
- 검증 기준: 로컬 2연속 + 스테이징 2연속 = 완료. 한 환경 1회 통과는 완료 아님.
- 이 원칙은 `.claude/skills/e2e/SKILL.md` "E2E 신뢰성 대원칙" 섹션에도 기록.

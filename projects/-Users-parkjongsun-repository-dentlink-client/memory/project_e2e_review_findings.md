---
name: project-e2e-review-findings
description: PR
metadata: 
  node_type: memory
  type: project
  originSessionId: b9df4a98-c1fa-47b3-8b7a-36e925a8a259
---

PR #4200 (feature/DL-14805-1-3) 머지 전 e2e 전체를 재검토하고 후속 커밋으로 수정 완료.

**확정된 함정 패턴 (SKILL.md에도 기록됨):**
- `isVisible({ timeout })` / `isHidden({ timeout })`의 timeout은 Playwright에서 **무시됨**(즉시 반환). 대기 의도면 `e2e/clinic/utils/wait.ts`의 `waitForVisible()` 사용. `isChecked`/`isEnabled` 등은 timeout 유효.
- JWT payload는 base64url — `Buffer.from(s, "base64")`로 디코드하면 `-`/`_` 포함 토큰에서 조용히 깨짐. 반드시 `"base64url"`.
- 팀 오염의 진짜 근본 원인: 테스트 계정 JWT에 누적된 잔류 `[E2E] Onboarding` employer 8개(ID 1732~1746) — 수동 삭제 + `cleanupStaleOnboardEmployers` 자동 정리(TEST 계정 포함)로 해결.
- navigationTimeout 90s는 `prepareOrderSession`에서 중앙 설정 (spec별 개별 설정 불필요).

**Cursor 협업 이력:** 커밋 `c3833a394`(nav timeout), `091f789f4`(로그 축약) — 둘 다 타당 판정.

**How to apply:** 새 e2e 코드 리뷰 시 위 패턴 우선 확인. 보고서는 repo 루트 `e2e-change-report.md` (미커밋, 공유용). [[project-e2e-master-plan]] [[project-e2e-backlog]]

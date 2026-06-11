---
name: feedback-e2e-reliability
description: E2E 테스트의 최우선 원칙 — 일관성. 됐던 테스트가 안되면 E2E를 신뢰할 수 없게 된다
metadata: 
  node_type: memory
  type: feedback
  originSessionId: dec1636b-e940-4a2b-8270-114a1b60885a
---

## 대명제 (최우선 원칙)

**E2E 테스트는 항상 일관된 결과를 내야 한다.**

- 코드 자체가 문제여서 실패하는 것은 정상 실패
- 그렇지 않다면 **성공이면 항상 성공, 실패면 항상 실패**여야 한다
- 됐던 것이 다음 실행에서 갑자기 안 되거나, 실패했다가 재시도하면 성공하는 flaky 테스트 = E2E 신뢰 파괴

**Why:** 여러 사람이 독립적으로 실행할 때 서로 다른 결과가 나오면 "테스트를 믿을 수 없다"는 의미가 됨. E2E가 신뢰를 잃으면 아무도 결과를 보지 않게 됨.

**How to apply:** flaky 발생 시 최우선 수정 대상. "retry로 통과하면 됐다"는 임시방편 — 근본 원인(레이스 컨디션, 클릭 stable 대기 실패, env 의존성 불명확 등)을 반드시 찾아 제거한다.

---

## flaky 유형별 근본 해결 원칙

| 유형 | 임시방편(X) | 근본 해결(O) |
|------|------------|------------|
| 클릭 stable 대기 타임아웃 | `retries: 1` | `{ force: true }` 또는 클릭 전 요소 상태 명확히 대기 |
| API 완료 전 submit | `waitForTimeout(1000)` | `waitForResponse(url)` + 앱 코드 isLoading 포함 |
| env 변수 미설정 | 그냥 실행 | `.env.staging` 동기화 + env 오류 시 명확한 에러 메시지 |
| global-setup 파일 없음 | 파일 없이 spec 실행 | global-setup이 반드시 먼저 실행되도록 의존성 명확히 |

---

## 실패 분류 결정 트리

됐던 테스트가 실패했을 때:

1. **앱 코드/서버 변경?** → 정상 실패. 앱 코드 수정 후 E2E 업데이트
2. **flaky(retry 시 성공)?** → E2E 코드 문제. trace.zip으로 원인 진단 후 근본 수정 (→ [[feedback-e2e-flaky-diagnosis]])
3. **env 변수 불일치?** → 실행 환경 문제. `.env.staging` 동기화 + 문서화
4. **global-setup 파일 없음?** → 실행 환경 문제. global-setup 실행 여부 확인

**어느 경우에도 "retry로 통과하면 됐다"는 허용하지 않는다.**

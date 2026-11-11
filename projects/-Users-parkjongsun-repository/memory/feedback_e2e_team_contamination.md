---
name: feedback-e2e-team-contamination
description: E2E 팀 오염(activeEmployeeId 덮어쓰기) 근본 원인과 해결 패턴
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 26970bfd-b94a-434e-8671-df4cc448f293
---

E2E 테스트에서 "팀 설정 실패" 에러가 반복 발생 시 이 패턴을 먼저 확인한다.

## 근본 원인 메커니즘

`clinic/src/common/apis/fetcher.ts:120`:
```ts
if (employeeId) {
  localStorage.setItem("activeEmployeeId", employeeId);  // 토큰 갱신 시 서버 응답으로 덮어씀
}
```

토큰 갱신(401→refresh) 시 서버가 DB에 저장된 "현재 활성 팀" employeeId를 응답에 포함 → `fetcher.ts`가 `localStorage.activeEmployeeId`를 덮어씀. 동일 패턴이 `axiosInstance.ts:102`에도 있음.

즉, 서버 DB의 활성 팀이 오염되어 있으면 localStorage 패치가 무력화된다.

## 해결 패턴 (global-setup.ts)

`localStorage` 패치만으로는 불충분. **서버 DB도 함께 전환해야 한다.**

```ts
// ✅ 올바른 방법 — page.context().request는 CORS 없이 직접 HTTP
const token = await page.evaluate(() => localStorage.getItem("accessToken"));
if (token) {
  await page.context().request.patch(`${API_BASE_URL}/office/employee/activates`, {
    headers: {
      Authorization: `Bearer ${token}`,
      "employee-id": DEFAULT_OFFICE.employeeId,
      "Content-Type": "application/json",
      "zone-id": Intl.DateTimeFormat().resolvedOptions().timeZone,
    },
  });
}
await page.evaluate((id) => localStorage.setItem("activeEmployeeId", id), id);

// ❌ localStorage 패치만으로는 토큰 갱신 후 재오염 발생
await page.evaluate((id) => localStorage.setItem("activeEmployeeId", id), id);
```

## 핵심 API

`PATCH /office/employee/activates` = clinic 앱의 Change Office 동작.
- `OfficeSelectListModal.tsx`: `setActiveEmployeeId(id)` → `activateEmployeeMutate()` 순서
- `employee-id` 헤더에 전환할 팀의 employeeId 지정

## Why

서버 DB에 저장된 "현재 활성 팀"이 있고, 토큰 갱신 시 그 값이 응답에 포함된다. `02_onboarding.spec.ts`처럼 같은 계정으로 다른 팀 컨텍스트를 사용하는 spec이 앞에서 실행되면 서버 DB가 오염된 채로 남아 이후 테스트에서 계속 터진다.

## How to apply

global-setup에서 clinic.json storageState 저장 전 `ensureDefaultOfficeContext` 호출 시, 반드시 `PATCH /office/employee/activates`로 서버 DB를 기본 팀으로 확정해야 한다.

### 추가 패턴: spec 간 오염 차단 (2026-06-08 발견)

서버 DB를 바꿀 수 있는 describe의 `afterAll`에서 반드시 팀 복원을 호출한다.

```ts
test.afterAll(async () => {
  await activateDefaultTeamOnServer();  // 기본 팀 복원
  await page?.context().close().catch(() => {});
});
```

`activateDefaultTeamOnServer`는 `order-setup.ts`에서 export — `{ ok, freshToken }` 반환.

### runtime PATCH 재시도 패턴 (2026-06-08 추가)

`runtimeToken`(localStorage accessToken)이 만료됐을 때 401이 나고 브라우저 세션 전환이 안 되는 버그 발견.
`patchToken = runtimeToken || freshToken` 패턴은 만료된 runtimeToken이 있으면 freshToken을 아예 사용하지 않는 문제가 있었음.

**수정**: runtimeToken → 401 시 freshToken으로 재시도. 둘 다 실패해야 warn.

```ts
const tokensToTry = [runtimeToken, freshToken].filter((t): t is string => !!t);
for (const token of tokensToTry) {
  const res = await page.context().request.patch(...).catch(() => null);
  if (res?.ok()) break;  // 성공하면 중단
  if (res && res.status() !== 401) { console.warn(...); break; }  // 401 외 에러는 warn 후 중단
}
```

**증상**: `05_labStatus.spec.ts` test 1 팀 설정 실패 — clinic.json 토큰 만료 → runtime PATCH 401 → freshToken 미사용 → 브라우저 세션 팀 미전환.

### 오염 원천 패턴 (2026-06-08 추가)

`CLINIC_STORAGE_STATE` 사용 여부와 무관하게, **기본 계정으로 실제 로그인 + 앱 홈 이동**이 발생하면 서버 DB 오염 가능.

`01_signin.spec.ts` 사례:
- `storageState: undefined` + 기본 계정 로그인 후 홈(`/`) 이동
- 앱 초기화 과정에서 `PATCH /office/employee/activates` 자동 호출 가능 → 서버 DB 변경
- `afterAll`에 `activateDefaultTeamOnServer()` 복원 없으면 이후 spec 팀 설정 실패

**체크 원칙 확장**: `CLINIC_STORAGE_STATE` 뿐만 아니라 기본 계정으로 실제 로그인·앱 초기화가 발생하는 모든 spec이 오염 원천이 될 수 있다.

### "Welcome & Demo" 최종 해결 (2026-06-08)

온보딩 독립 세션 분리로 오염 원천 차단:
- `canUseOnboardSession = true` → 온보딩 계정 독립 세션 → 기본 계정 서버 DB 건드리지 않음
- `canUseOnboardSession = false` → 기본 계정 fallback → `afterAll` 복원

### addInitScript 근본 차단 (2026-06-09 추가)

**문제**: `page.goto("/")` 시점에 `clinic.json`의 `localStorage.activeEmployeeId`가 온보딩 팀 ID일 수 있음 → 앱이 이 값으로 초기화되면서 `PATCH /office/employee/activates`를 온보딩 팀으로 자동 호출 → 서버 DB 재오염 → 이후 runtime PATCH로 복원해도 불안정한 경쟁 조건 발생.

**근본 해결**: `prepareOrderSession`에서 `page.addInitScript`로 앱 JS 실행 전 올바른 `activeEmployeeId` 주입. `reload()`에도 지속 → 모든 탐색에서 재오염 경로 차단.

```ts
await page.addInitScript((id) => {
  try { localStorage.setItem("activeEmployeeId", id); } catch (_) {}
}, EMPLOYEE_ID);
```

이 스크립트는 `page.goto`/`page.reload` 마다 앱 JS보다 먼저 실행되므로, 앱의 초기화 로직이 localStorage를 읽는 순간 항상 올바른 팀 ID가 들어있다.

**속도 개선**: 초기 팀 확인 대기를 `E2E_TIMEOUT_MS`(90s) → `10s`(로컬 3s)로 단축. 10s 내 확인 안 되면 Change Office fallback 즉시 진입 (이전: 90s 낭비 후 fallback). 총 worst-case ~1.5분 → ~30-40초.

### env 누락 시 silent 무력화 방지 (2026-06-09 추가)

Opus 심층 검토에서 발견: env(`EMPLOYEE_ID`, `ACCOUNT_ID/PASSWORD`) 미설정 시 `activateDefaultTeamOnServer`가 warn 없이 `{ ok: false }`만 반환 → 팀 오염 방어 전체가 silent하게 꺼짐.

**수정**: env 누락 시 명시적 warn 추가.
```ts
if (!EMPLOYEE_ID || !TEST_ACCOUNT.email || !TEST_ACCOUNT.password) {
  console.warn("[e2e] activateDefaultTeamOnServer: 필수 env 미설정 — 팀 오염 방어 비활성화");
  return { ok: false, freshToken: null };
}
```
`prepareOrderSession`에서도 `patchOk=false + EMPLOYEE_ID 없음` 시 추가 warn.

**추가 발견 (Opus 검토)**:
- `fetcher.ts:130-135`: 토큰 갱신 응답에 `employeeId` 없으면 `removeItem`까지 함 → 팀 없음 상태 → 90초 대기 트리거 가능
- 오염은 지연 발현됨: 오염 spec이 마지막이면 그 run은 통과, 뒤 spec 추가 시 비로소 터짐 → 회귀 시점과 원인이 분리됨

### 문서화 완료 (2026-06-08)

재발 방지를 위해 `/e2e` 스킬 통해 spec 추가 시 자동으로 검토되도록:
- `02-spec-writer.md` 규칙 9번: 팀 오염 방지 3단계 체크리스트
- `e2e/README.md` 섹션 5: 90초 지연 증상, 진단, 해결 패턴
- `SKILL.md` Step 4: 팀 오염 방지 체크리스트 안내

[[project-e2e-progress]]

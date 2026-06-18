---
name: feedback-e2e-locator-principle
description: e2e locator 선택 원칙 — 앱 코드 확인 + 인터랙션 대상 요소를 직접 기다리기
metadata:
  node_type: memory
  type: feedback
  originSessionId: 943d2a07-e7ab-4ce5-8cf7-e50ef73dcd02
---

**e2e locator 작성 전에 반드시 앱 코드를 열어 해당 요소가 어떻게 렌더링되는지 확인한다.**

**Why:** 동적 값 하드코딩(날짜 포맷 등) + 타이밍 가정 실패(컨테이너가 뜬 뒤 자식이 아직 없는 순간에 `.all()` 호출)가 모두 스테이징에서 timeout으로 나타남. 앱이 외부 스크립트 등으로 약간만 느려져도 잠재 버그가 드러남.

**How to apply:**

### 1. locator 우선순위 (위에서 아래 순)
- `data-e2e-id` / `data-testid` — 가장 안정적, 없으면 추가 요청
- `name` attribute — form input에서 고정 식별자 (예: `input[name="patientBirthday"]`)
- `role + accessible name` — `getByRole("button", { name: "..." })`, 버튼/링크에 적합
- `aria-label` — `getByLabel(...)`, **앱 코드에서 하드코딩된 값인지 반드시 확인**
- `placeholder` — `getByPlaceholder(...)`, locale 무관한 고정값인지 확인
- CSS selector (`.pvs-container button` 등 컨테이너 스코핑) — 동일 텍스트 버튼이 여러 개일 때 스코프 좁히기
- 순수 텍스트 (`getByText`) — 최후 수단

### 2. `.all()` 호출 전 반드시 실제 셀이 존재함을 먼저 확인

```ts
// ❌ 컨테이너만 기다린 뒤 .all() → 자식 셀이 아직 없을 수 있음 (타이밍 버그)
await page.waitForSelector(".calendar-table");
const cells = await page.locator(".calendar-table [data-date].valid").all();

// ✅ 실제 클릭할 요소를 기다린 뒤 .all()
await page.waitForSelector(".calendar-table [data-date].valid", { timeout: E2E_TIMEOUT_MS });
const cells = await page.locator(".calendar-table [data-date].valid").all();
```

**원칙: `.all()`은 "지금 DOM에 있는 것만" 반환하고 대기하지 않는다. 반드시 `waitForSelector`로 적어도 1개가 존재함을 먼저 확인한 뒤 호출한다.**

### 3. 동일 텍스트 버튼이 여러 개면 스코프를 좁혀라

```ts
// ❌ 페이지 전체에서 "Not selected" — 투어라운드 토글과 픽업 버튼이 동시에 매치될 수 있음
await page.getByRole("button", { name: "Not Selected" }).first().click();

// ✅ 픽업 섹션 컨테이너 안으로 스코프 한정
await page.locator(".pvs-container").getByRole("button").click();
```

### 4. 텍스트/라벨이 동적 생성인지 반드시 확인
- 앱 코드에서 상수로 정의됐는지 → 안전
- `EnumMap`, `config`, 서버 응답, 사용자 설정 등에서 오는지 → 대체 locator 필요
- 확인 방법: `grep -rn "텍스트값" shared/ui/src clinic/src`

### 5. fallback 코드는 실제로 동작하는지 검증 후 작성
- dead code(실제로 도달하지 않는 경로)는 조용히 실패하므로 쓰지 않거나 에러를 throw
- 클래스명 참조 시 앱 코드에서 실제 클래스 확인 (`div.calendar-ui-body` ≠ `div.calendar-body`)

**구체적 사례:**
- `DateField` aria-label = `dateFormat.toUpperCase()` (동적) → `input[name="patientBirthday"]` 사용
- `.pvs-container button` — "Not selected" 텍스트 버튼이 2개일 때 컨테이너 스코핑으로 해결 (2026-06-18)
- `waitForSelector(".calendar-table [data-date].valid")` — 컨테이너 대신 실제 셀 대기 (2026-06-18)

**관련 파일:**
- `e2e/clinic/steps/order/order-step4-additional.ts` — selectPickupDate, selectFirstValidCalendarDate
- `e2e/clinic/utils/lab.ts` — commonCalendarPicker, commonPickupCalendarPicker

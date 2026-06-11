---
name: feedback-e2e-locator-principle
description: e2e locator 선택 원칙 — 텍스트 기반 전에 앱 코드에서 안정적인 속성을 먼저 확인
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 943d2a07-e7ab-4ce5-8cf7-e50ef73dcd02
---

**e2e locator 작성 전에 반드시 앱 코드를 열어 해당 요소가 어떻게 렌더링되는지 확인한다.**

**Why:** `getByLabel("MM/DD/YYYY")` 가 병원 설정의 날짜 포맷(`dateFormat.toUpperCase()`)에 따라 동적으로 생성되는 값이어서 스테이징에서 타임아웃 발생. 앱 코드를 확인하지 않으면 이런 동적 값을 하드코딩하게 됨.

**How to apply:**

1. **locator 우선순위 (위에서 아래 순)**
   - `data-e2e-id` / `data-testid` — 가장 안정적, 없으면 추가 요청
   - `name` attribute — form input에서 고정 식별자 (예: `input[name="patientBirthday"]`)
   - `role + accessible name` — `getByRole("button", { name: "..." })`, 버튼/링크에 적합
   - `aria-label` — `getByLabel(...)`, **앱 코드에서 하드코딩된 값인지 반드시 확인**
   - `placeholder` — `getByPlaceholder(...)`, locale 무관한 고정값인지 확인
   - CSS selector — 최후 수단, class명 변경 시 깨짐

2. **텍스트/라벨이 동적 생성인지 반드시 확인**
   - 앱 코드에서 상수로 정의됐는지 → 안전
   - `EnumMap`, `config`, 서버 응답, 사용자 설정 등에서 오는지 → 대체 locator 필요

3. **확인 방법**
   - 해당 컴포넌트 파일 grep: `grep -rn "텍스트값" shared/ui/src clinic/src`
   - 텍스트가 앱 코드에 없으면 → 런타임 동적 생성 의심

**구체적 사례:**
- `DateField`: aria-label = `dateFormat.toUpperCase()` (동적) → `input[name="patientBirthday"]` 사용
- `PatientGenderTypeMap`: `{ value: "OTHER", label: "Other" }` (하드코딩) → `getByRole("button", { name: "Other" })` 안전
- `TextInput label="Patient Name"`: 하드코딩 → `getByLabel("Patient Name")` 안전

**관련 파일:**
- `shared/ui/src/InputBase/InputBase.tsx` — `aria-label={label ?? subject}` 구조
- `shared/ui/src/DateField/DateField.tsx` — `label={dateFormat.toUpperCase()}` 동적 생성
- `e2e/clinic/steps/order/order-step1-profile.ts` — BIRTH_DATE_SELECTOR 적용 사례

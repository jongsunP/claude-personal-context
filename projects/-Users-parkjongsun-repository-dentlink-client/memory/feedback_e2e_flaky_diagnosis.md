---
name: feedback-e2e-flaky-diagnosis
description: "E2E 테스트 flaky(됐다 안됐다) 발생 시 진단 순서와 원칙 — trace.zip 분석, 레이스 컨디션 패턴"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: dec1636b-e940-4a2b-8270-114a1b60885a
---

됐던 테스트가 갑자기 실패할 때는 E2E 코드 문제가 아니라 **앱 변경이나 타이밍 이슈**가 원인인 경우가 대부분이다.

## 진단 순서

1. **실패 spec의 trace.zip 분석 먼저**
   ```bash
   unzip test-results/<실패폴더>/trace.zip -d /tmp/trace_extracted
   # 1-trace.network 파싱으로 PUT/POST API 400 여부 확인
   python3 -c "
   import json
   with open('/tmp/trace_extracted/1-trace.network') as f:
       for line in f:
           s = json.loads(line).get('snapshot', {})
           r = s.get('request', {}); resp = s.get('response', {})
           if resp.get('status', 0) >= 400:
               print(r.get('method'), resp.get('status'), r.get('url'))
   "
   ```
2. 400/500 API 있으면 → resources/<sha1>.json 에서 request body + response message 확인
3. 타이밍 이슈 확인: API A의 시작/완료 시각 vs 클릭 시각 비교 (`_monotonicTime`)

## 레이스 컨디션 핵심 패턴

**SPA에서 `waitForLoadState("domcontentloaded")`는 API 로드 완료를 의미하지 않는다.**  
클라이언트 사이드 라우팅(Next.js Pages Router)에서는 HTML은 이미 로드된 상태이고, 데이터 패치는 컴포넌트 마운트 후에 비동기로 발생한다.

### 발생 조건
- react-hook-form의 default value가 빈 배열/null
- `useEffect`에서 API 응답 후 `setValue` 호출
- E2E가 버튼 visible만 확인하고 즉시 클릭
- → form data가 default(빈 값)인 채로 submit

### 해결 패턴
```typescript
// ❌ 위험: visible만 확인, API 로드 여부 모름
await nextButton.waitFor({ state: "visible", timeout });
await nextButton.click();

// ✅ 안전: 의존 API 완료 후 클릭
await page.waitForResponse(
  (res) => res.url().includes("/catalogs/option") && res.status() === 200,
  { timeout }
);
await nextButton.waitFor({ state: "visible", timeout });
await nextButton.click();
```

## 앱 코드 측 근본 수정 원칙

API 데이터가 로드되기 전에 submit 버튼이 활성화되어 있으면 앱 코드 버그이기도 하다.  
`useOrderOptionUpdateForm.ts` 패턴: `isLoading: isLoading || isProductOptionsLoading`처럼 의존 쿼리 loading 상태를 버튼 disabled에 포함시킨다.

**Why:** 2026-06-08 `05_labStatus.spec.ts` test 3 실패 — `catalogs/option` API 완료 70ms 전에 Next 클릭 → `caseGroups: []` → PUT 400 "Case Info is required". trace.zip 분석으로 확인.

**How to apply:** flaky 실패 발생 시 먼저 trace.zip의 네트워크 로그에서 400/500 응답 찾기. PUT/POST body가 빈 배열이거나 null이면 레이스 컨디션 의심. 의존 API `waitForResponse` 추가 + 앱 코드 isLoading 포함 여부 검토.

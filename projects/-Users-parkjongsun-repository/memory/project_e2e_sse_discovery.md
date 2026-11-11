---
name: project-e2e-sse-discovery
description: lab 앱 전역 SSE 연결이 E2E networkidle을 무력화한다는 발견 — E2E 작업 시 항상 인지 필요
metadata: 
  node_type: memory
  type: project
  originSessionId: dbabde72-ee09-4234-94db-606bde156408
---

## 발견 (2026-06-15)

`cancelLabPickup` 테스트가 스테이징에서 유독 느린 원인을 조사하다 발견.
이전까지 SSE 관련 언급은 E2E 코드 전체에 없었음 — 최초 발견.

## SSE 아키텍처 (lab 앱)

- 컴포넌트: `lab/src/components/ServerSentEvent/ServerSentEvent.tsx` — `_app.tsx`에 전역 마운트
- 상태: `isConnectSSEAtom` (Jotai), 기본값 `false`, SPA 네비게이션 전반에 걸쳐 유지됨
- 활성화: 픽업/배송 생성 경로에서 `setIsConnectSSE(true)` 호출 (`usePickupList.tsx:224`)
- 연결: `${API}/messages/sse/connect`, 서버 하트비트 **50초 주기**, 응답이 끝나지 않는 long-lived 연결

## 왜 networkidle이 실패하는가

Playwright `networkidle` = 진행 중인 연결 **0건**으로 500ms 이상 유지.  
SSE는 연결이 닫히지 않으므로 조건 충족 불가 → E2E_TIMEOUT_MS 전체 소모 또는 flaky.

**Why:** `networkidle`이 느리거나 타임아웃 나면 React Query polling이 아닌 SSE가 원인.

## 영향 범위

`04_labShipment.spec.ts`: createLabPickup(test 3)에서 SSE 활성화 → cancelLabPickup(test 4)에서 SSE 살아있음.  
SSE가 활성인 페이지(`/pickup`, `/shipment` 등)의 `networkidle` 사용 코드 전체.

## 해결 방법

`networkidle` 제거 + `expect().toPass()` + 조건부 `page.reload()` 패턴.  
상세 페이지 goto 후 stale 상태면 reload → 서버 fresh 상태 재확인. SSE 완전 무관.

**How to apply:** E2E 작업 시 `networkidle`을 쓰려는 상황이 나오면 해당 페이지에 SSE가 활성인지 먼저 확인한다. 픽업/배송/SSE 관련 페이지라면 `toPass + reload` 패턴을 우선 검토한다.

## 문서화 위치

- `SKILL.md`: "앱 전역 SSE 연결과 networkidle" 전용 섹션 + 실패 패턴 표 236행
- `e2e/README.md`: 코딩 가이드라인 > 1. 대기 패턴 > 피해야 할 패턴에 추가
- 실제 수정 파일: `e2e/clinic/steps/lab/shipment-pickup.ts` (커밋 `90bc87856`)

---
name: feedback-e2e-route-mocking
description: E2E에서 page.route() 모킹이 허용되는 조건 — Elasticsearch 등 환경 의존적 API에 한정
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

`page.route()`로 API를 모킹하는 것은 일반적으로 E2E 대원칙(실제 시스템 검증)에 어긋나지만, 아래 조건이 모두 충족되면 허용된다.

**허용 조건**:
1. 해당 API가 환경(Elasticsearch 인덱스 상태 등)에 따라 결과가 달라지는 불안정 요소일 것
2. 모킹 대상이 "표시용" API일 것 (핵심 비즈니스 로직 API는 반드시 real 호출)
3. 모킹으로 우회하는 API 다음에 이어지는 real API(예: POST /office/employee)가 실제로 호출되어 검증될 것

**적용 사례**:
- `/office/employers/search-office` (Elasticsearch 기반 오피스 매칭): staging에서 인덱스가 비어있어 항상 0건 반환 → `page.route()`로 모킹, 이후 Request Access(`POST /office/employee`)는 real API 호출
- `/lab/employers/own/clients` (lab 배송 생성 오피스 검색): staging Elasticsearch 인덱스에서 E2E 클리닉 오피스 미조회 → `page.route("**/lab/employers/own/clients**", ...)`로 모킹. 이후 오피스 선택 → 주문 선택 → Create → Confirm 플로우는 real API 호출. `page.route()`는 `page.goto` **이전**에 등록해야 페이지 진입 시 첫 API 요청도 인터셉트된다.

**Why:** staging Elasticsearch 인덱스가 비어있어 search-office가 0건 반환 → 모킹 없이는 Y 분기 테스트 자체가 불가. 핵심 로직(employee 생성 API)은 real API로 검증하므로 대원칙 위반 아님.

**How to apply:** 새 spec 작성 시 모킹이 필요하다고 느껴지면 위 3가지 조건 먼저 확인. 조건 미충족이면 모킹 대신 다른 방법 탐색.

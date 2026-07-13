---
name: project-e2e-master-plan
description: E2E 자동화 현재 목표 — 유지·성장 모드. 작업현황·백로그·노하우는 전부 repo에서 관리 (위치 포인터)
metadata:
  node_type: memory
  type: project
  originSessionId: f986b725-5853-4964-b0af-0a1559a8707b
---

## 세션 환경

- **현재 작업 워크트리:** `dentlink-client-e2e` → 브랜치 `feature/DL-15560`
- **세션 목적:** E2E 관련 작업 및 테스트 전용

## 현재 상태 (2026-07-13 기준)

**패키지 업그레이드(Next.js 16 / RQ v5 / SC v6) 이후 스테이징 E2E 전면 진단 완료.**
`feature/DL-15560`은 진단 전용 브랜치 — 수정은 별도 워크트리에서 진행.

### 스테이징 진단 결과 (99개 중 49 통과 / 11 실패 / 34 미실행)

#### 작업 우선순위

**1순위 — 기존 문제 (버전업 무관)**
- `00_signup.spec.ts` — `waitForSignupEmailVerified` 90s 타임아웃. 스테이징 이메일 발송 지연. skip 또는 폴링 시간 조정 필요.
- `03_orders/crown.spec.ts` — `Crown(수정금지,회귀테스트용)` 스테이징 카탈로그 미등록. 이전에도 반복 발생. `[LAB-STG] E2E Lab`에 상품 재등록으로 해결 (코드 수정 없음).

**2순위 — 버전업 유발 문제 (단일 원인, 9건 + cascade 34건)**
- 공통 패턴: `prepareOrderSession: Change Office 실패 → API 재패치 시도` 후 `page.goto: Target page, context or browser has been closed`
- 집중 파일: `e2e/clinic/steps/order/order-setup.ts` — `prepareOrderSession` 함수의 Change Office UI 흐름
- 영향 spec: denture, instasmile, step4-ui-state(2), veneer, labStatus, linkTalk(2), billing

**3순위 — 신규 시나리오**
- 별도 작업자 있음. 2순위 해결 시 신규 spec의 실패 대부분 자동 해소될 가능성 높음.

### 완료된 것 (이전 이력)
- 모든 E2E 계정·오피스 e2e 전용 완료 — 외부 계정 의존성 0
- 팀 오염 근본 차단 + 방어코드 전 spec 적용
- flaky waitForResponse 전수 제거
- 신규 spec: 00_signup_step4_office_find (Y/N 분기)
- PR #4200 머지 완료 (`feature/DL-14805-1-3` → master)

**유지·성장 모드 → 현재 버전업 대응 모드.**

## 단일 진실 소스 원칙 — 작업현황은 repo에서 관리

개인 메모리에는 작업현황·백로그·노하우를 **복제하지 않는다**. 전부 repo 파일이 진실 소스:

| 내용 | 위치 (repo) |
|------|------------|
| 미착수 시나리오 백로그 (A: 세팅 정보 대기 / B: 의도적 후순위) | `.claude/skills/e2e/references/03-scenario-backlog.md` |
| 실패 패턴·노하우 (isVisible timeout 함정, JWT base64url 등) | `.claude/skills/e2e/SKILL.md` |
| 자동화 불가/조건부/미구현 3분류 원칙 | SKILL.md 동일 섹션 |
| 실행 방법·환경변수·트러블슈팅 | `e2e/README.md` |

**How to apply:** e2e 작업 시작 시 위 repo 파일들을 먼저 읽는다. 진행사항이 바뀌면 repo 파일을 수정하고, 이 메모리에는 모드 전환(유지→대규모 개편 등) 같은 방향성 변화만 기록한다.

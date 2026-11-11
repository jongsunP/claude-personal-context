---
name: project-e2e-roadmap
description: E2E 테스트 코드 로드맵 — UI 대응·리팩토링·스킬화·신규 시나리오 추가 4단계 계획
metadata: 
  node_type: memory
  type: project
  originSessionId: ab6bf81b-aecc-4b30-bf99-cfc40ba44489
---

## 목표

Spec 파일에서 마이크로 함수들을 조합만 하면 테스트가 동작하는 구조.
새로운 시나리오가 들어와도 하드코딩 없이 기존 함수 재조합으로 처리.
**모든 e2e 작업은 `/e2e` 스킬을 통해 처리한다.**

## 단계별 계획

### 1단계: UI 대응 ✅ 완료 (2026-06-01)
- 로컬: 46/46 전체 통과
- 스테이징: 00~07 전체 통과 확인

### 2단계: 리팩토링 ✅ 완료 (2026-06-01)
- withLabPage 홈 네비게이션 제거 (~48s 절감)
- 캘린더 picker sequential evaluate → single evaluate (~15s 절감)
- Change Status 이중 로케이터 변수 추출, 불필요 주석 정리
- 전체 e2e 코드 주석·상수·스타일 통일
- pages/page.ts 레거시 삭제
- 로컬 버그 3건 수정 (millingDiscType 분기, test.setTimeout 순서, Done 타임아웃)
- 04 addOrdersButton 23초 오버레이 버그 수정
- 참고: 04(jongsun.test5) / 05(tata.test3) lab 계정이 달라 storageState 공유 불가 — 구조적 한계

### 3단계: Skill 등록 ✅ 완료 (2026-06-01)
- `.claude/skills/e2e/SKILL.md` + `references/01-function-inventory.md` + `references/02-spec-writer.md`
- `/e2e <시나리오 또는 Jira 티켓>` → 함수 목록 파악 → spec 작성 → 테스트 실행 → 실패 시 자동 수정

### 4단계: 신규 시나리오 추가 — PM 요청 기반 자동화 ← 현재
- PM으로부터 새 시나리오 접수 → `/e2e` 스킬로 처리
- 스킬 내부에서 기존 함수 활용 + 필요한 부분만 신규 작성
- 코드 추가 → 테스트 실행 → 실패 시 재수정 사이클 자동 처리
- 정상 통과 확인 후 완료

**온보딩 시나리오 (2026-06-04)에서 배운 패턴:**
- 계정 상태에 따라 화면이 달라지는 경우 → `test.skip` + 조건부 처리 분리
- storageState가 다른 전용 계정이 필요하면 `steps/onboard/onboard-setup.ts` 처럼 별도 파일로 분리
- global-setup에서 계정 생성/병원 창설 필요 시 → teardown에서 반드시 자동 삭제
- 외부 결제 창(Eximbay 등) → 자동화 불가 항목은 명시적으로 테스트 제외 처리

## 스킬 파일 관리 원칙

새 spec이 추가되거나 steps/ 파일이 변경될 때마다 반드시 업데이트:
1. `.claude/skills/e2e/SKILL.md` — Step 2의 spec 번호 목록
2. `.claude/skills/e2e/references/01-function-inventory.md` — 읽어야 할 파일 목록
3. `e2e/README.md` — Spec 목록 표 (새 spec 추가 시)

## How to apply
- e2e 관련 작업 요청 시 이 로드맵의 단계를 확인하여 현재 어느 단계인지 파악
- 새 시나리오 추가는 반드시 `/e2e` 스킬을 통해 처리
- 리팩토링 시 기존 steps/ 구조를 참고하여 일관성 유지
- 신규 시나리오 추가 시 하드코딩 금지 — 반드시 기존 함수 재활용 우선

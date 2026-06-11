---
name: feedback-e2e-work-protocol
description: e2e 작업 시작 전 반드시 읽어야 할 파일 목록과 완료 후 업데이트 체크리스트
metadata: 
  node_type: memory
  type: feedback
  originSessionId: ab6bf81b-aecc-4b30-bf99-cfc40ba44489
---

e2e 관련 작업(새 시나리오 추가, 스펙 수정, 디버깅 등)을 시작할 때는 반드시 아래 절차를 따른다.

**Why:** 이번 DL-14805 작업이 여러 단계(UI 대응→리팩토링→스킬 등록→신규 시나리오)로 길게 진행되며 스킬·README·메모리에 맥락이 분산되어 있어, 세션이 바뀌면 컨텍스트를 잃기 쉽다. 항상 동일한 출발점에서 시작해야 일관성을 유지할 수 있다.

## 작업 시작 전 (항상)

1. `memory/project_e2e_progress.md` 읽기 — 현재 진행 상황, 남은 작업, 실패 테스트
2. `e2e/README.md` 읽기 — 코딩 가이드라인, 대기 패턴, 조건 코드 기준, 환경 차이 처리
3. `.claude/skills/e2e/SKILL.md` 읽기 — 스킬 정의 및 spec 번호 목록 확인

새 시나리오 작성 시 추가:
4. `.claude/skills/e2e/references/01-function-inventory.md` 읽기 — 재사용 가능한 함수 목록

## 작업 방식 원칙

- **새 e2e 시나리오는 항상 `/e2e` 스킬을 통해 처리한다.** 스킬 없이 직접 spec을 작성하지 않는다.
- e2e 작업의 맥락(코딩 가이드라인, 패턴, 함수 목록)은 스킬 파일과 README에 집중되어 있다.
- spec은 시나리오만, steps는 재사용 단위 — 이 구조를 항상 유지한다.
- **테스트는 항상 전체 실행** (`pnpm e2e:clinic:stg` 등) — 특정 spec만 따로 실행하지 않는다.

## 작업 완료 후 업데이트 체크리스트

새 spec 파일이 추가되었다면:
- [ ] `SKILL.md` Step 2의 spec 번호 목록에 추가
- [ ] `e2e/README.md`의 Spec 목록 표에 추가

새 steps/ 또는 utils/ 파일이 추가되었다면:
- [ ] `01-function-inventory.md`의 읽어야 할 파일 목록에 추가

작업이 완료되거나 중단되었다면:
- [ ] `project_e2e_progress.md` 현황 업데이트

**How to apply:** e2e 작업 요청("e2e 테스트 추가해줘", "온보딩 시나리오 작성해줘", "Test N 수정해줘" 등)이 들어오면 위 "작업 시작 전" 항목을 읽고 시작한다.

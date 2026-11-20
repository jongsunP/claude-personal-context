---
name: lab-i18n-code-only-no-sheet
description: "2026-11-20 확정(모든 에이전트) — 번역 시트 운영 완전 중단, 기존 ko/en JSON이 정본 데이터. generate/check/audit도 안 씀. 시트 연동 제거 PR #4928 리뷰 대기"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 05846ca8-e9d4-45e8-adaf-eb1c24e1bfe7
  modified: 2026-11-20T05:08:27.237Z
---

2026-11-20 사용자 확정: 번역 시트는 앞으로 아예 운영하지 않는다. 이미 만들어진 ko/en JSON 자체가 데이터(정본)이고, 앞으로도 JSON만 유지한다. 검증 스크립트(`check:i18n`·`generate:i18n`·`audit:i18n`)도 쓰지 않는다. (11-11에는 "시트는 그대로 두고 스크립트는 유지"였으나 이번에 시트 관련 코드 제거 방향으로 바뀜.)

**Why:** 시트 동기화가 필요 없고, JSON을 데이터로 직접 관리하는 개념이 사용자의 의도다. 검증 도구 유무를 선택지로 되묻지 말 것 — 사용자가 이 질문 반복을 헷갈린다고 지적함.

**How to apply:**
- Lab 문구 추가·변경·삭제 시 ko/en JSON(웹 `lab/src/i18n/locales/{en,ko}/*.json`, Lab 앱 `src/configs/i18n/locales/{en,ko}.ts`)을 함께 수정한다. 시트 행 추가·생성 명령 실행 안 함.
- **`pnpm generate:i18n`(및 `lab`의 `generate:locales`) 실행 금지**: 시트에서 JSON을 재생성하므로 11-20 기준 JSON 3,682 key 중 2,086개가 삭제된다.
- 웹 dentlink-client 제거: 11-20 PR #4928(`feat/lab-i18n-remove-sheet`→`release/v1.94.0`, c0cb9b998) 생성, 리뷰·머지 대기. 아래 목록 + manifest의 런타임 미사용 필드(sourceLanguage·allowedComponentTags·allowedEmptyTranslations)도 제거. 새 worktree에선 무시 파일 `next-env.d.ts`(clinic/lab/admin)·`coverage-baseline.json`이 없어 pre-commit/pre-push 훅이 실패하니 복사/생성 후 진행:
  - 지움: `lab/scripts/i18n/` 전체, package.json의 generate/check/export/audit:i18n, `lab/package.json` generate:locales, `googleapis`·`csv-parse`, `lab/.env.example`의 GOOGLE_SERVICE_ACCOUNT_KEY·SHEETS_* , manifest `sheet`·`sheetHeader`, `.gitignore` service-account, 지침 7곳(AGENTS.md·claude.md·.cursorrules·lab/README.md·.claude/.codex skills/i18n)의 시트 반영 문구, catalog README 시트·생성 절차.
  - 남김: JSON, manifest의 언어·namespace·기본값(런타임 `i18n.resources.ts`가 import), `i18n.resources.generated.ts`(주석만 수정, 일반 파일화), `LocaleProvider`. `dotenv`는 e2e가 써서 유지.
  - 빌드·CI·훅·테스트는 이 스크립트를 안 씀 → 제거 영향 없음.
- Lab 앱(dentlink-lab-app)은 이미 로컬 리소스 정본 방식이라 할 일 없음. `src/configs/utils/googleSheets.ts`는 테스트 계정 시트로 번역과 무관.
- 정본: codex `SESSION_WORKFLOW.md`의 Dentlink Lab Translation Work.

관련: [[codex-guidelines-adopted]]

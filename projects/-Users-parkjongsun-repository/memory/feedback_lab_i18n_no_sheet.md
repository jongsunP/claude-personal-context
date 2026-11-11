---
name: lab-i18n-code-only-no-sheet
description: 2026-11-11부터 Lab 문구 변경은 코드의 ko/en 리소스(JSON)만 넣고 번역 시트는 채우지 않는다
metadata:
  type: feedback
---

2026-11-11 사용자 지시: i18n은 앞으로 코드의 ko·en 리소스(웹 Lab JSON, Lab 앱 locale 파일)는 만들지만 번역 시트는 굳이 추가하지 않는다. 원래는 시트까지 동기화하는 개념이었으나 바뀌었다.

**Why:** 사용자가 시트 동기화 단계를 더 이상 필요로 하지 않는다. 그래서 시트 쓰기 인증(gcloud ADC·서비스 계정)도 준비하지 않았다.

**How to apply:**
- Lab 정적 문구를 추가·변경·삭제하는 작업에는 ko/en 리소스 반영과 검증을 기본 포함한다. 시트 행 추가는 사용자가 요청할 때만.
- 팀 문서(`dentlink-client/CLAUDE.md`, `lab/i18n/catalog/README.md`)가 아직 시트 반영을 안내해도 이 사용자 결정이 우선한다.
- 시트→리소스 생성 명령(웹 `generate:i18n`, Lab 앱 실행·빌드 시 자동 `i18n`)이 코드에 직접 넣은 새 키를 덮어쓰거나 빠뜨리지 않는지 실행 전에 확인한다.
- 정본: codex `SESSION_WORKFLOW.md`의 Dentlink Lab Translation Work.

관련: [[codex-guidelines-adopted]]

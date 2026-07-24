---
name: feedback-notion-format
description: 노션 문서 정리 요청 시 응답 형식 — 마크다운 코드블록 하나로 전체 제공
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7af44387-e0c6-4bab-b140-732615ecd17e
  modified: 2026-07-24T09:17:03.062Z
---

노션에 넣을 텍스트를 요청하면 ` ```markdown ``` ` 코드블록 하나에 전체 내용을 담아 한 번에 복사할 수 있도록 제공한다.
내부 형식은 마크다운: `##` 섹션 헤더, `###` 소제목, `*` 불릿, ` ``` ` 코드블록.

**Why:** 코드블록 없으면 복사 불가. 마크다운 없으면 Notion 붙여넣기 시 구조가 없어짐. 내부 마크다운 없이 plain text만 주면 사용자가 "마크다운 어디갔어"라고 물음.

**How to apply:** 노션 문서 작업 요청 시 항상 ` ```markdown ``` ` 래퍼 + 내부 마크다운 형식. 수정된 부분만 주지 말고 전체를 한 블록으로. 블록 앞뒤에 설명 텍스트 붙이지 말 것.

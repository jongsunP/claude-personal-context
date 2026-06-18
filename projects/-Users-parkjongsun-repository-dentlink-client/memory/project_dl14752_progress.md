---
name: project-dl14752-progress
description: DL-14752 하위 티켓 코드 검증 완료. 배포 후 수기 확인 항목 3개 남음
metadata: 
  node_type: memory
  type: project
  originSessionId: 341ad595-f009-4838-8004-c19da807c9f7
---

PR #4213 (→ release/v1.75.0) 머지 완료 (2026-06-17).

Frankie 담당 서브티켓 코드 레벨 검증 완료 (2026-06-18):
- DL-14732: Office 멤버 리스트 padding 수정 코드 존재. 배포 후 플로팅 간격 시각 확인 필요
- DL-14754: Office 디자인 개선 다수 변경 존재. 배포 후 전체 UI 시각 확인 필요
- DL-14664: RequestAccess 페이지 구현 확인됨
- DL-15166: Order 캔슬 버튼 조건부 렌더링 확인됨
- DL-15165: lab Order 리스트 필터 UI 확인됨
- DL-15168: 칩 높이 스타일 변경 코드 존재. 배포 후 시각 확인 필요
- DL-15170: 탭 하단 여백 확인됨
- DL-15079: Amplitude 이벤트 코드 반영됨. 프로덕션 배포 후 데이터 확인 필요
- DL-14907: PR #4219 (`release/v1.75.0-qa-1` → `release/v1.75.0`) 오픈, 수동 머지 대기

배포 후 수기 확인 필요:
- DL-14732: 플로팅 간격
- DL-14754: Office 디자인 전체
- DL-15168: 칩 높이

**Why:** 사용자가 Jira 완료 처리를 직접 하므로 Claude는 현황만 기억.
**How to apply:** 다음 세션 시작 시 #4219 머지 여부 확인 후 진행.

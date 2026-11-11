---
name: project_dl14232_invite_progress
description: DL-14232 치과 employee 초대 기능 — FE 전체 작업 현황 및 워크트리 정보
metadata: 
  node_type: memory
  type: project
  originSessionId: 0dfb4bf0-dbcd-460e-8f2d-039cb294e717
---

# DL-14232 — [치과] employee 초대 기능

**Why:** DSO에서 관리자가 사용자를 직접 초대·관리할 수 있는 기능. 기공소와 동일하게 지원.

**How to apply:** 초대 관련 작업은 모두 이 티켓 하위에서 진행. 워크트리 `dentlink-client-invite` / 브랜치 `feature/DL-14232` 에서 이어서 작업.

## 워크트리 정보

- 경로: `/Users/parkjongsun/Repository/dentlink-client-invite`
- 브랜치: `feature/DL-14232`
- 기준: PR #4353 → `master` (현재 conflict 상태, 병합 전 재동기화 필요)
- 최신 커밋: `da1e63a31` ([DL-14232] fix: 치과 초대 목록 높이 및 본문 스크롤 수정)

## [FE] 하위 작업 목록

| 티켓 | 제목 | 상태 |
|---|---|---|
| DL-15162 | [FE] 개발 플래닝 | 완료 |
| DL-15489 | [FE] 어드민 작업 | ✅ PR #4342 (→ develop, merged) |
| DL-15490 | [FE] 이메일 템플릿 및 링크 | 해야 할 일 |
| DL-15491 | [FE] 초대시 쿠키 세팅 및 기존 쿠키 갱신 | 해야 할 일 |
| DL-15492 | [FE] 초대시 홈 알림 및 필요한 세팅 | 해야 할 일 |
| DL-15493 | [FE] 클리닉 회원 관리페이지 UI 변경 | Ready for Deploy |
| DL-15494 | [FE] 클리닉 회원 초대 페이지 API | Ready for Deploy — 실제 API 연동 완료 |
| DL-15495 | [FE] 디자인시스템 변경 대응 | Ready for Deploy |
| DL-15499 | QA | 해야 할 일 |
| DL-15503 | [FE] 클리닉 회원 초대 페이지 UI | Ready for Deploy — 사용자 기능 QA 정상 확인 |

## 관련 비FE 작업 (참고용)

- DL-15163: [BE] 기공소 초대 로직 분석 및 치과 초대 기획 분석 (완료)
- DL-15470: [BE] Role type 마이그레이션 (Ready for Deploy)
- DL-15471: [BE] 관리자 회원 초대 목록 페이지에 치과 필터 추가 (진행 중)
- DL-15472: [BE] 치과 초대 이메일 발송 (해야 할 일)
- DL-15473: [BE] 치과 초대 목록 API 개발 및 기존 멤버 조회 API 수정 (해야 할 일)
- DL-15479: [BE] 관리자 치과/기공소 초대 기능 (진행 중)

## 진행 이력

- 2026-07-07: 워크트리 생성, FE 하위 작업 8개 확인. DL-15162(개발 플래닝)만 진행 중 상태.
- 2026-07-07: **DL-15489 완료** (PR #4342, feature/DL-15489 → develop)
- 2026-07-07: **DL-15493 멤버 리스트/상세 drawer 구조 정리 완료**
  - 멤버 상세 drawer 전환, SlideDrawer 공용 컴포넌트 생성, OfficeMemberDetailContent Figma 기반 구현
  - 최종 커밋: `291dfb61c`
- 2026-07-09: **`/office/managed/invites` API 연동 완료**
  - `usePendingMembersQuery` 생성 (status 파라미터 기반)
  - `useOfficePendingMembers` mock → 실제 API 전환
  - 탭 상태: URL query `?status=ALL|PENDING|EXPIRED`
  - 탭 카운트: `OfficePendingMemberListDto.counts` 에서 직접 참조
  - approve / reject mutation에 invalidateQueries 추가
- 2026-07-09: **코드 리뷰 수정 전체 (15개 파일) 커밋** (`e4fc864a8`)
  - canRemoveMember undefined guard 추가
  - OfficeMemberAuthorityChip EnumTypes 통일
  - OfficeMemberDetailDrawer → useIsBelowTablet
  - (Me) 라벨 Figma 스펙 (body2/bold/information)
  - InviteMembersModal Date.now() → useRef 카운터
  - MAX_INVITE_EMAIL_COUNT 상수 중앙화 (InviteMembersModal.types.ts)
  - OfficePendingMembersDropdown label 매칭 제거
  - Page/Table 네이밍·flex 컨벤션 통일
  - SlideDrawer 스크롤 락 타이밍 isMounted 기준
  - useInvitations query 로직 hook 내부 이동 (admin)
  - useInviteCreate import 경로·any 타입 수정 (admin)
- 2026-07-09: **버그 수정 2건**
  - handleInviteMembers 빈 함수 lint 에러 수정 (`c5ba31238`)
  - StyledMobileList display:none CSS 오버라이드 깨짐 수정 (`50dbae903`)
    - styled(DisplayFlexCol) → styled.div 로 원복 (CSS 주입 순서 문제)
- 2026-07-09: **디자인 QA 수정 커밋/푸시 완료** (`277a3314b`)
  - shared `ChartDropdown` 추가 및 초대 페이지 role/authority 드롭다운에 적용
  - ChartDropdown 메뉴 포탈/fixed positioning 적용으로 테이블/리스트 내부 clipping 방지
  - 초대 페이지 Pending Members 제목/도움말 링크/테이블 헤더/row padding/status/last-row border/min-height 조정
  - 테이블 높이는 44px header + 300px body minimum 기준으로 정리, 임의 `548px` 높이 제거
  - Invite Members modal 폭/높이/좌우 컬럼/이메일 입력 문구/Member Info 테이블/empty state/footer 버튼 정렬
  - 회원 상세 profile header full-name wrapping, authority badge + `(Me)` 위치, Member Info border/typography 조정
  - 회원 상세 authority dropdown selected check 제거
  - PopupMenu outside-click 판정 수정: drawer blank/dim 영역 클릭 시 dropdown 닫힘
  - 당시 상위 DL-14232에 코멘트를 작성했으나 사용자가 삭제함. 이후 상위 카드에는 진행 댓글을 추가하지 않음
- 2026-07-09: **멤버 상세 Member Info 후속 보더 수정 커밋/푸시 완료** (`f00341b5d`)
  - `Member Info` 리스트 래퍼의 외곽 border/radius/overflow 제거
  - row 사이 divider만 유지하여 Figma 의도처럼 테이블 박스 형태로 보이지 않게 조정
  - 당시 상위 DL-14232 comment `43085`에 기록했으나 사용자가 삭제함
- 2026-07-10: **클리닉 초대 API/페이지/모달 최종 QA 및 목록 높이 규칙 반영 완료** (`da1e63a31`)
  - Pending Members의 create/resend/cancel/delete/update/approve/reject 실제 API 연동 완료
  - Figma `224:47539`, `224:48696` 기준 header 44px, body min 300px, row 72px, viewport bottom 75px 규칙 반영
  - 기존 공용 `DataGrid.SimpleList`로 교체해 헤더를 제외한 본문만 내부 스크롤되도록 구성
  - 공용 Layout과 페이지의 중복 bottom padding 제거로 페이지/목록 이중 스크롤 해소
  - 사용자가 로컬 실제 화면에서 기능 동작이 모두 정상임을 확인
  - Jira는 담당 하위 카드 DL-15503의 기존 comment `43090`만 갱신하고, 상위 DL-14232에는 댓글을 추가하지 않음

## 현재 상태 및 남은 작업

- 이번 브랜치 범위의 클리닉 회원 목록/상세, 초대 페이지/모달, 초대 API 연결과 사용자 기능 QA는 완료됨.
- 모바일에서는 초대 페이지 진입과 Pending Members 버튼을 의도적으로 지원하지 않음.
- 별도 하위 작업 DL-15490(이메일 템플릿/링크), DL-15491(쿠키), DL-15492(홈 알림)은 Jira상 해야 할 일 상태로 남아 있음.
- PR #4353은 open draft이며 최신 커밋을 포함하지만 현재 `master`와 conflict 상태임. 병합 전에 conflict 해소가 필요함.

## 설계 메모

- 탭 카운트: 별도 API 없음. `findPendingMembers` 응답 `counts.all/pending/expired` 사용
- sourceType `EMPLOYEE` → approve/rejectEmployee API, `INVITATION` → invitation create/resend/cancel/delete/update API
- Pending Members 높이: table header 44px + body minimum 300px, viewport 하단 75px 전까지 증가하고 이후 본문만 스크롤
- 최종 표는 공용 `DataGrid.SimpleList`를 사용하며 shared UI 코드는 변경하지 않음
- 최신 검증: `git diff --check`, `pnpm type`, 변경 파일 lint, commit-hook Clinic/Lab/Admin type, push-hook 전체 앱 lint 및 shared coverage 통과. lint는 기존 warning만 존재.

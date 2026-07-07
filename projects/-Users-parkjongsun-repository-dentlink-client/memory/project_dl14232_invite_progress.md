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
- 기준: `origin/master` (faf7f6fff)

## [FE] 하위 작업 목록

| 티켓 | 제목 | 상태 |
|---|---|---|
| DL-15162 | [FE] 개발 플래닝 | 진행 중 |
| DL-15489 | [FE] 어드민 작업 | ✅ PR #4342 (→ develop) |
| DL-15490 | [FE] 이메일 템플릿 및 링크 | 해야 할 일 |
| DL-15491 | [FE] 초대시 쿠키 세팅 및 기존 쿠키 갱신 | 해야 할 일 |
| DL-15492 | [FE] 초대시 홈 알림 및 필요한 세팅 | 해야 할 일 |
| DL-15493 | [FE] 클리닉 회원 초대 페이지 UI | 진행 중 (member detail drawer 미커밋) |
| DL-15494 | [FE] 클리닉 회원 초대 페이지 API | 해야 할 일 |
| DL-15495 | [FE] 디자인시스템 변경 대응 | 해야 할 일 |

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
  - `user.apis.admin.ts` 신규 API 7개 추가 (findUserInvitationList, updateUserInvitationAuthority, updateUserInvitationRole, resendUserInvitation, deleteUserInvitation, validateUserInvitationEmails, createUserInvitationList)
  - `MemberInvitesAdmin` 컴포넌트 + `useInviteCreate` / `useDeleteInvitation` 훅 admin 서비스에 신규 생성
  - `DataFilters`에 `filterHeaderAction` / `hideSearch` / `onChangeFilter` / `disabledSearch` prop 추가
  - 그룹타입·그룹명 선택 시 Search 없이 즉시 URL 반영 (Search 버튼 제거)
  - Invite New Members 버튼: 항상 노출, 그룹타입+그룹명 모두 선택 시에만 활성화
  - `useInviteCreate`를 `shared/ui` → `lab/src/lib/members/`로 이동 (서비스 소유 원칙)
  - `InvitationItem` string literal → enum 타입 교체, `HYGIENIST` role 추가
  - 타이포 수정: "Invite New Memers" → "Invite New Members"

- 2026-07-07: **DL-15493 멤버 상세 drawer 구조 정리 진행 중 (미커밋)**
  - 작업 브랜치/워크트리: `/Users/parkjongsun/Repository/dentlink-client-invite`, `feature/DL-14232`
  - 멤버 상세는 더 이상 `/office/managed/members/[employee_id]` route/page로 가지 않음. 데스크탑/모바일 모두 `/office/managed` 리스트에서 선택 시 drawer를 띄움.
  - 공용 drawer 레이아웃은 `shared/ui/src/SlideDrawer/SlideDrawer.tsx` 로 생성. 다른 화면에서도 재사용 가능한 portal 기반 right slide drawer.
  - 이 페이지 전용 shell은 `OfficeMemberDetailDrawer`, 상세 본문/로직은 `OfficeMemberDetailContent` 로 분리.
  - desktop은 right drawer, mobile은 같은 drawer shell의 100% width fullscreen 표현. X 클릭 시 리스트로 복귀. mobile dim click close는 비활성.
  - 리스트 row snapshot을 `employeeSnapshot` 으로 즉시 표시하고, `useEmployeeDetailQuery(employeeId)` 로 상세 데이터를 보강.
  - 권한 변경/Remove Member 로직은 새 `OfficeMemberDetailContent` 로 이식. PopupMenu trigger의 nested button warning은 div trigger로 수정.
  - 기존 old 상세 코드 삭제: `MemberDetailLayer`, `MemberInfo`, `MemberDelete`, `MemberRequest`, `pages/office/managed/members/[employee_id].tsx`.
  - `OFFICE_MANAGED_MEMBERS` route 상수와 menu entry 제거. 기존 상세 URL은 404 확인.
  - 검증: `pnpm --filter dentlink-clinic-web type` 통과, `/office/managed` Next compile/200 확인.
- 다음 작업: DL-15490 ([FE] 이메일 템플릿 및 링크)

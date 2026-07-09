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
- 최신 커밋: `50dbae903` (fix: StyledMobileList display:none 오버라이드 깨짐 수정)

## [FE] 하위 작업 목록

| 티켓 | 제목 | 상태 |
|---|---|---|
| DL-15162 | [FE] 개발 플래닝 | Ready for Deploy |
| DL-15489 | [FE] 어드민 작업 | ✅ PR #4342 (→ develop, merged) |
| DL-15490 | [FE] 이메일 템플릿 및 링크 | 해야 할 일 |
| DL-15491 | [FE] 초대시 쿠키 세팅 및 기존 쿠키 갱신 | 해야 할 일 |
| DL-15492 | [FE] 초대시 홈 알림 및 필요한 세팅 | 해야 할 일 |
| DL-15493 | [FE] 클리닉 회원 초대 페이지 UI | ✅ UI 완료 + API 연동 완료 (approve/reject) |
| DL-15494 | [FE] 클리닉 회원 초대 페이지 API | 진행 중 (초대 생성·Resend·Cancel·Delete BE 미준비) |
| DL-15495 | [FE] 디자인시스템 변경 대응 | 해야 할 일 (이번 범위 외) |
| DL-15499 | QA | 해야 할 일 |
| DL-15503 | [FE] 클리닉 회원 초대 페이지 UI | 해야 할 일 |

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

## 현재 남은 작업 (DL-15494 범위)

- 초대 생성 API (`createInvitation`) 연동 — BE 준비 대기
- Resend / Cancel / Delete mutation — invitationId 기반, BE 미준비
- Role / Authority 수정 API — sourceType별 분기, BE 미준비
- 모바일 초대 페이지 디자인 미확정 — Figma 확정 후 반영

## 설계 메모

- 탭 카운트: 별도 API 없음. `findPendingMembers` 응답 `counts.all/pending/expired` 사용
- sourceType `EMPLOYEE` → approve/rejectEmployee API, `INVITATION` → invitation API (BE 미준비)
- 모바일 초대 리스트: Figma 디자인 미제공 상태로 임시 구현 (이메일+상태, 드롭다운, 액션 버튼 카드 형태)

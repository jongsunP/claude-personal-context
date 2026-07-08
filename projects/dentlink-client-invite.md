# Dentlink Invite checkpoint - 2026-07-08

Repo: /Users/parkjongsun/repository/dentlink-client
Branch: feature/DL-14232
Latest pushed commit: ef4a0606a [DL-14232] ui: 초대 화면 디자인 시스템 정리
Status: pushed, worktree clean at the time of handoff

## User direction / constraints

- Always answer the user in Korean honorific style.
- Goal for clinic invite work: complete up to immediately before real invite API integration.
- Do not call invite APIs directly while checking UI.
- No e2e required for this task; only UI click/smoke checks were requested.
- Use existing project UI/design system first. New styling/components are allowed only when there is no suitable existing component or when a local adapter is needed.
- Figma is the reference, but implementation should follow existing project conventions where exact Figma parity conflicts with established components.
- Do not commit additional changes unless the user explicitly asks.

## Branch-wide invite-related completed work

### Admin completed

- Included branch commit: 150345436 feat: 어드민 초대 기능 신규 API 전체 대응 및 기공소 리팩토링 (DL-15489)
- Admin invitation list was updated for the new invite API flow.
- Admin member invite creation was added through MemberInvitesAdmin.
- Admin invitation email validation/create hooks were added.
- Admin invitation resend and delete flows are wired.
- Admin invitation list filtering/query handling and query key were updated.

### Lab completed

- Lab member invite creation logic was refactored.
- Lab invite UI continues through the shared MemberInvitesUI flow.
- Existing Lab invite list/update/resend/cancel flow remains in place.

### Clinic member management completed

- Included branch commits: DL-15493 series 95d993e1a, 370f122dc, e261acc11, 291dfb61c.
- /office/managed member list shows Pending Members entry point only for OWNER authority.
- OFFICE_MANAGED_INVITES link constant points to /office/managed/invites.
- Member list authority chip was added/normalized.
- Member detail was changed to drawer-based UI; old standalone detail route/components were removed.
- Member detail drawer and authority UI were adjusted to existing project UI primitives.

### Clinic invite page completed

- Included branch commits: faad6f8a4 and ef4a0606a.
- Added /office/managed/invites route guarded by OWNER authority.
- Added OfficePendingMembersPage using mock/local state.
- Added mock invite data, invite types, and useOfficePendingMembers local-state hook.
- Implemented All / Pending / Expired tabs.
- Implemented Pending Members table with Email / Role / Authority / Status / Action columns.
- Implemented role and authority dropdowns using existing DropdownBase through a clinic-local adapter.
- Implemented status labels for Pending Acceptance, Pending Approval, and Invitation Expired.
- Implemented action buttons for Resend / Cancel / Approve / Reject / Delete as UI/local handlers.
- Implemented responsive/mobile list representation.
- Added provisional Invite Members modal using existing Modal/Button/dropdown pieces. Figma modal design is not available yet.
- Reworked invite page to use existing UI primitives: Tabs, DataListTable, DropdownBase, Modal, Button, Chip, Typography, Icon.
- Removed over-splitting where possible; kept local table/dropdown/modal components because they are clinic invite specific adapters/compositions.

### Figma/design notes confirmed

- Figma source: 0097. 치과 employee 초대 기능, node 101:4640 / invite page area 224:48715.
- Confirmed invite layout: toolbar height 54, tab compact instances, Invite Members button, Pending_chart/card, 55px card header, table header 44px, rows 72px, role/authority dropdowns 160x37.
- Help link text: Check role & authority differences.
- Help icon is Arrow/diagonal-line; screen used SvgArrowDiagonalLine but icon/style was reviewed against Figma.
- Pagination/stepper should not be shown because it was removed/hidden recently.
- Invite modal design was not available in Figma, so current modal is explicitly provisional.

## Verification already done

- Commit hook type checks passed when committing ef4a0606a.
- Push to origin/feature/DL-14232 succeeded.
- Browser UI smoke checked without direct API calls:
  - /office/managed/invites rendered.
  - All/Pending/Expired tab interaction worked.
  - Role/authority dropdowns opened and selection responded.
  - Invite Members modal opened/closed.
  - /office/managed member list rendered.
  - Member detail drawer opened.
- Push hook produced existing lint/coverage output but did not block push.

## Remaining work

### Clinic remaining before completion/release

- Connect real clinic invite APIs.
- Replace mock data/local hook with API/query/mutation hooks.
- Map API DTO values for role, authority, status, expiration dates, and actions.
- Wire create invite, resend, cancel, approve, reject, and delete to real mutations.
- Add server-backed loading/error/empty behavior.
- Revisit Invite Members modal when Figma design becomes available.
- Do final QA after API integration.

### Current overall judgment

- Admin/Lab invite API-related work is already included in this branch and should be treated as completed scope unless new regressions are found.
- Clinic invite work is complete only to the API-before stage: UI shell, design-system cleanup, routing, owner-only entry point, and local/mock interactions are done.
- The main remaining blocker is real Clinic invite API integration.


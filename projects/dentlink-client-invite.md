# Dentlink Client Invite - DL-14232

Last updated: 2026-07-09

## Repository

```text
/Users/parkjongsun/Repository/dentlink-client-invite
```

## Branch

```text
feature/DL-14232
```

## Jira

```text
DL-14232 - [치과] employee 초대 기능
```

## Latest Pushed Commit

```text
f00341b5d [DL-14232] fix: 멤버 상세 정보 보더 수정
```

## Current Status

- Admin invite API work: completed in branch.
- Lab invite refactor: completed in branch.
- Clinic member-management design work: completed/reviewed.
- Clinic invite page/modal UI: completed up to the point before real Clinic invite API integration.
- Real Clinic invite API is still unavailable, so invite list/create/send is mock/local state only.
- Latest design QA follow-up commit was pushed to `origin/feature/DL-14232`.

## User Direction / Constraints

- Always answer the user in Korean honorific style.
- Figma is the reference, but implementation should follow existing FE conventions and existing components.
- Do not hardcode or invent patterns when existing UI/form/query conventions can be used.
- Do not call invite APIs directly while checking UI because Clinic invite API is not ready.
- Commit/push only when explicitly requested.

## Branch-Wide Invite Work

### Admin

- Admin invite API work is already included in this branch.
- Admin invitation list/create/validation/resend/delete flows were handled in prior commits.

### Lab

- Lab invite flow was refactored in prior commits.
- Lab continues through the existing shared MemberInvitesUI flow.

### Clinic Member Management

- `/office/managed` member list and member detail drawer were reviewed.
- Owner-only Pending Members entry point exists.
- Member authority label was normalized across desktop/mobile/detail.
- Member detail mutation refresh behavior was fixed so lists/detail/counts update after API actions.

## Clinic Work Completed

- `/office/managed/invites` invite page.
- All / Pending / Expired tabs.
- Pending Members table.
- No pagination on invite page.
- Empty/min-height and dynamic row-height behavior.
- Status/action mapping:
  - Pending Acceptance: Resend / Cancel
  - Pending Approval: Approve / Reject
  - Invitation Expired: Resend / Delete
- Invite Members modal based on existing project `Modal`.
- Email chip input based on existing `MultiChipInput`.
- Email validation:
  - empty guard
  - invalid email guard
  - duplicate email guard
  - max 10 emails
- Draft invitation table in modal.
- Send button disabled until every draft has role and authority.
- Role/Authority code API hooks:
  - `useRoleTypeQuery`
  - `useAuthorityTypeQuery`
- Role/Authority dropdowns use existing `PopupMenu` through a local adapter and `useFixedPortal`.
- Shared `ChartDropdown` was added for compact chart/table dropdown use.
- Clinic invite role/authority dropdowns now use `ChartDropdown`.
- `ChartDropdown` keeps the compact trigger/menu shape close to the existing dropdown family while adding Figma-requested chart dropdown states.
- Dropdown menus are portaled/fixed so they are not clipped inside invite table/list containers.
- The gray selected row background in an open dropdown is intentional for the chart dropdown request and aligned with the design-system update direction.

## Latest Design QA Corrections

- Invite page/table:
  - Pending Members heading/help-link typography and spacing adjusted.
  - Table header background, first/last column padding, row height, status colors, and bottom-border behavior adjusted.
  - Table min-height follows 44px header + 300px body minimum; arbitrary 548px height was removed.
  - Mobile invite page entry remains hidden because mobile invite page is not supported by the requirement.
- Invite Members modal:
  - Modal width/min-height, two-column layout, email input copy, Member Info table, empty state, scroll behavior, and footer buttons adjusted against Figma.
- Member list/detail:
  - Member detail profile area now shows profile icon, full name without ellipsis, authority badge, and `(Me)` beside the badge.
  - Member Info row separators and Typography variants normalized; outer border/radius/overflow was removed in follow-up commit `f00341b5d` so the section does not look like a table box.
  - Member authority dropdown selected-check icon removed.
  - PopupMenu outside-click behavior fixed for drawer/dim clicks.

## Latest Follow-Up Correction

- Commit/push: `f00341b5d [DL-14232] fix: 멤버 상세 정보 보더 수정`.
- Removed the `Member Info` list wrapper outer border/radius/overflow.
- Kept only row-to-row divider lines, matching the intended member-detail Figma structure.
- Jira DL-14232 comment `43085` records the pushed commit and verification.

## Member List / Detail Sync

The following mutations now invalidate relevant queries so lists/detail refresh after API actions:

- authority change
- member removal
- approval
- rejection

Affected cache categories:

- pending employee list
- desktop managed employee list
- mobile infinite managed employee list
- approved employee counts when counts can change
- selected employee detail cache

## Verification

- `git diff --check` passed.
- Direct clinic TypeScript check passed: `cd clinic && ./node_modules/.bin/tsc --noEmit`.
- Follow-up verification: `pnpm --filter dentlink-clinic-web type`, `pnpm --filter dentlink-clinic-web lint`, commit-hook clinic/lab/admin type checks, and push-hook lint/shared coverage guard passed with existing warnings/output.
- Commit hook type checks passed for clinic/lab/admin.
- Push hook lint/coverage checks completed successfully with existing project warnings.
- Build was intentionally not run in the latest pass.
- Computer Use visual QA was intentionally left to the user in the latest pass.

## Remaining Future Work

When Clinic invite APIs are available:

- Replace mock/local invite state with API queries.
- Wire create/resend/cancel/approve/reject/delete mutations.
- Map API DTO values for role, authority, status, expiration, and row actions.
- Add loading/error states for API-backed invite list/modal.
- Add post-mutation query invalidation using the same member-list sync standard.

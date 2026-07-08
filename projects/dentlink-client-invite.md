# Dentlink Client Invite - DL-14232

Last updated: 2026-07-08

## Repository

```text
/Users/parkjongsun/repository/dentlink-client
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
34e9c0ee8 [DL-14232] feat: 클리닉 초대 UI 및 멤버 갱신 처리 보정
```

## Current Status

- Admin invite API work: completed in branch.
- Lab invite refactor: completed in branch.
- Clinic member-management design work: completed/reviewed.
- Clinic invite page/modal UI: completed up to the point before real Clinic invite API integration.
- Real Clinic invite API is still unavailable, so invite list/create/send is mock/local state only.

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
- Shared UI components were not modified for this work.
- The gray selected row background in an open dropdown comes from existing `PopupMenu` `selected` behavior, not a custom Figma-only style.

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

- `corepack pnpm --filter dentlink-clinic-web type` passed.
- `corepack pnpm --filter dentlink-clinic-web build` passed.
- `corepack pnpm --filter dentlink-clinic-web lint` passed with existing project warnings.
- `corepack pnpm prettier --check <changed files>` passed.
- `git diff --check` passed.
- Commit hook type checks passed for clinic/lab/admin.
- Push hook completed; it printed existing lint/coverage warnings but did not block push.

## Remaining Future Work

When Clinic invite APIs are available:

- Replace mock/local invite state with API queries.
- Wire create/resend/cancel/approve/reject/delete mutations.
- Map API DTO values for role, authority, status, expiration, and row actions.
- Add loading/error states for API-backed invite list/modal.
- Add post-mutation query invalidation using the same member-list sync standard.

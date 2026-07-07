# Dentlink Invite: Office Member Detail Drawer checkpoint

Date: 2026-07-07
Repo: /Users/parkjongsun/Repository/dentlink-client-invite
Branch: feature/DL-14232
Related work: DL-14232 / DL-15493 member management invite flow

## Confirmed direction

- Member detail is no longer a standalone route/page experience.
- Desktop and mobile both open member detail from /office/managed list interaction.
- Desktop presentation is a right-side drawer.
- Mobile presentation is fullscreen via the same drawer shell behavior.
- X closes back to the member list; mobile does not navigate to /office/managed/members/[employee_id].
- The new drawer layout is a reusable shared UI component, not member-specific code.
- This page composes that reusable drawer with Office-specific member detail content.

## Implemented structure

- shared/ui/src/SlideDrawer/SlideDrawer.tsx: reusable portal-based slide drawer with dim, Escape close, body scroll lock, right-to-left animation, responsive 100% mobile width.
- clinic/src/components/OfficeMemberList/OfficeMemberDetail/OfficeMemberDetailDrawer.tsx: page-specific shell using SlideDrawer and member detail query.
- clinic/src/components/OfficeMemberList/OfficeMemberDetail/OfficeMemberDetailContent.tsx: Figma-based member detail UI and logic.
- OfficeMemberList and OfficeMemberMobileList both keep selectedEmployee state and open OfficeMemberDetailDrawer instead of navigating.
- employeeSnapshot from list is used for immediate render; useEmployeeDetailQuery(employeeId) refreshes with detail data.
- Authority change and Remove Member logic moved into OfficeMemberDetailContent.

## Removed old route/code

- Deleted /office/managed/members/[employee_id].tsx.
- Deleted old Grid-based detail components: MemberDetailLayer, MemberInfo, MemberDelete, MemberRequest.
- Removed OFFICE_MANAGED_MEMBERS link constant usage and menu entry.
- Existing member detail route was verified as 404 after deletion.

## Figma/design notes

- Source design: 0097. 치과 employee 초대 기능, Office & Member Details, drawer1-1 variants.
- Figma requirements followed: profile header, full name without ellipsis, authority chip, Me beside chip, Member Info rows, authority dropdown arrow for admin-editable case, Remove Member for valid admin case, desktop right drawer, mobile fullscreen, X close.
- Figma Make animation guidance followed in SlideDrawer: open 500ms, close 300ms, fade/slide ease-in-out.

## Verification

- pnpm --filter dentlink-clinic-web type passed.
- Next dev compile for /office/managed succeeded.
- /office/managed returned 200.
- /office/managed/members/1 returned 404 after route removal.
- validateDOMNesting warning from PopupMenu trigger was fixed by changing the authority trigger from button to div.

## Next start point

- Worktree intentionally uncommitted per user request.
- Next likely step: browser QA with logged-in clinic account for desktop and mobile widths, especially drawer open/close, authority dropdown, remove member visibility, and support-widget z-order on mobile.

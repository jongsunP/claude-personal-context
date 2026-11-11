---
name: project_dl15478_progress
description: DL-15478 이미지 최적화 원복 작업 현황
metadata: 
  node_type: memory
  type: project
  originSessionId: 49de5b81-9d47-4a02-85c5-976be08802a6
---

feature/DL-15478, PR #4335 오픈 (→ release/v1.77.0). 배포 후 성능 체감 확인 예정.

**Why:** DL-15348에서 옵션 이미지 지연 개선을 위해 적용한 `loading="eager"` + `/_next/image` URL 프리로드 2종이 오히려 초기 네트워크 요청 폭증으로 전체 성능에 악영향을 준다고 판단하여 원복.

**변경 파일:**
- `OptionImage.tsx`: `loading="eager"` 제거
- `ProductOptionForm.tsx`: 프리로드 `useMemo` + `useEffect` 제거
- `useOrderCategoryWorkflow.ts`: step 이미지 프리로드 로직 + `getCdnUniversalUrl` import 제거

**트레이드오프:** 원복 후 옵션 클릭 시 이미지 최초 로드 지연이 다시 나타날 수 있음. 재발 시 별도 티켓으로 대응.

**How to apply:** 배포 후 이미지 지연 재제보 시 이 티켓 맥락 참고.

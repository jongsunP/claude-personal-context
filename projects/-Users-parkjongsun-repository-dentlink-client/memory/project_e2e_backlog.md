---
name: project-e2e-backlog
description: E2E 미완료 항목 및 알려진 제약 — 신규 작업 시 참고
metadata:
  node_type: memory
  type: project
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

## 미구현 시나리오

### Signup Step4
- **"Request Access"**: 기존 병원 검색 후 가입 요청 — 테스트용 병원 환경 세팅 필요
- **"Create Office"**: 동일 주소 병원 존재 시 Y/N 분기 — 시나리오 재현 어려움

## 환경변수 미입력

| 변수 | 용도 |
|------|------|
| `NEXT_PUBLIC_E2E_REFERRAL_GROUP_CODE` | 리퍼럴 URL 진입 테스트 (2개 skip 원인) |
| `NEXT_PUBLIC_E2E_BP_PARTNER_KEY` | BP 파트너 URL 진입 테스트 (2개 skip 원인) |

백엔드 팀에 값 확인 후 `.env.staging`, `.env.development`에 입력 시 자동 실행됨.

## 알려진 제약

- **Default Scanner null 복원 불가**: `setDefaultScannerPlatform` API가 null 설정 미지원. 테스트 계정에 Default Scanner 미설정이면 step4 관련 3개 자동 skip.
- **ISV Step3 환경별 분기**: `option.type === "RADIO"` 옵션이 로컬은 자동 선택, 스테이징은 토글 버튼. `isStagingE2E` 분기로 처리.
- **로컬 실행**: `.env.development` URL이 `:3000`이라 `reuseExistingServer` 오작동. `pnpm run e2e:clinic` 사용 필수.

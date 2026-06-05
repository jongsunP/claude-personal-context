---
name: project-e2e-backlog
description: "E2E 미완료 작업·백로그 — 다음 세션 재개 시 우선 확인"
metadata:
  node_type: memory
  type: project
  originSessionId: c652ebcc-c9e4-43db-86c9-01454ae0f1eb
---

## 진행 중 (feature/DL-14803-1)

### PR 미생성
- `feature/DL-14803-1` → `release/v1.74.0` PR 아직 안 만듦
- 수동 테스트 결과 확인 후 생성 예정

---

## 미구현 시나리오

### DL-14803 회원가입 — Step2/3/4 (이메일 인증 필요)
현재 `00_signup_validation.spec.ts`는 Step1 UI 검증만 커버.
이메일 실제 인증이 있어야 Step2 이후 진입 가능.

- **Step2**: 국가 드롭다운, 전화번호 숫자만 입력 검증
- **Step3**: Role 선택 (Dentist/Assistant/Office Manager 등)
- **Step4 "Request Access"**: 기존 병원 검색 후 가입 요청 플로우
- **Step4 "Create Office"**: 동일 주소 병원 존재 시 Y/N 분기

**Why:** 실제 이메일 인증 코드 수신이 필요 → 고정 인증 코드 환경 필요 (현재 `NEXT_PUBLIC_EMAIL_VERIFICATION_CODE=4520` 로 기존 signup spec은 우회 중)

**How to apply:** `00_signup.spec.ts`의 `completeSignupFlow` 패턴 참고. 인증 코드 고정값 환경이 확인되면 /e2e 스킬로 바로 추가 가능.

---

## 환경변수 미입력

| 변수 | 파일 | 용도 |
|------|------|------|
| `NEXT_PUBLIC_E2E_REFERRAL_GROUP_CODE` | `.env.staging`, `.env.development` | 리퍼럴 URL 진입 테스트 |
| `NEXT_PUBLIC_E2E_BP_PARTNER_KEY` | `.env.staging`, `.env.development` | BP 파트너 URL 진입 테스트 |

값 미입력 시 해당 테스트는 자동 skip됨. 스테이징 DB 또는 백엔드 팀에 값 확인 필요.

---

## Opus 검토 결과 미처리 항목

Opus가 검토했으나 아직 코드로 추가되지 않은 시나리오:
- DL-14810 (Onboarding): `02_onboarding.spec.ts` 이미 구현 완료 — 실행 확인만 필요
- 기타 Opus 검토 시나리오: 다음 세션에서 Jira 티켓 기준으로 재확인 필요

---

## 알려진 제약/한계

- **Default Scanner null 복원 불가**: `setDefaultScannerPlatform` API가 null 설정을 지원 안 함. originalPlatform이 null이었으면 테스트 후 복원 불가. crown/denture/veneer spec은 PVS를 명시 선택하므로 영향 없음.
- **Scanner 관련 step4 테스트**: 테스트 계정에 구강 스캐너가 미등록이면 시나리오 3이 자동 skip.

**How to apply:** 재개 시 이 파일부터 읽고 미완료 항목 확인.

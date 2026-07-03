---
name: project-pdf-print-work
description: 라벨 프린트 PDF 관련 작업 현황 — 공통 베이스 완성 + 3개 브랜치 준비 완료, develop 브랜치 통한 스테이징 테스트 준비 (2026-07-03)
metadata: 
  node_type: memory
  type: project
  originSessionId: faec4704-b772-4c8b-a330-01e99c874fd0
---

# 라벨 프린트 PDF 작업 현황

**Why:** 기공소(lab)에서 배송 라벨 출력 시 텍스트 깨짐(아랍어) 현상 발생. CDN 리소스 로딩 실패가 원인.
**How to apply:** PDF 관련 작업 시 이 문서 먼저 참조. 브랜치 3개 로컬+원격 준비 완료. develop 브랜치를 통해 스테이징 검증 예정.

---

## 핵심 개념

- **공통 베이스** = 결정과 무관하게 반드시 들어가야 할 모든 수정
- **3개 브랜치** = "서버사이드 변환을 추가할지, 어떤 구조로 할지"라는 하나의 결정만을 위한 분기

---

## 브랜치 상태 (2026-07-03 기준)

| 브랜치 | 역할 | 상태 |
|---|---|---|
| `fix/shipping-label-native-pdf-print` | 원본 PR #4214 (base: release/v1.75.0) | 보존, 건드리지 않음 |
| `fix/shipping-label-native-pdf-print-backup` | 원본 백업 | 보존 |
| `fix/pdf-label-common` | 공통 베이스 임시 브랜치 | **삭제됨** (내용은 3개 브랜치에 모두 포함) |
| `feature/DL-15437` | DL-15437 — 브라우저 PDF.js 로컬 리소스 방식 | ✅ 로컬 + 원격 완료 |
| `feature/DL-15438` | DL-15438 — 서버 전용 API Route | ✅ 로컬 + 원격 완료 |
| `feature/DL-15439` | DL-15439 — 3트랙 풀 체인 | ✅ 로컬 + 원격 완료 |

---

## 공통 베이스에 포함된 수정 (3개 브랜치 모두 포함)

| 커밋 | 내용 |
|---|---|
| `281879737` | PDF.js CDN → 로컬 `/pdfjs/` 이전 (핵심 원인 해결) |
| `d6a32d6d4` | PrintPdf 안정성 개선 (isActive race condition, 에러 UI, 타입 안전성, 보안 로그) |
| `945aadbd1` | console.error 제거 |
| `04539053b` | usePrintImage race condition 수정 (currentSrcRef) |

---

## 트랙별 구조

- **Track 1:** `/api/pdf-to-image` — 서버에서 PDF → PNG 변환 (@napi-rs/canvas + pdfjs-dist)
- **Track 2:** 브라우저 PDF.js — 로컬 `/pdfjs/` 리소스 사용 (CDN 의존 없음)
- **Track 3:** `/api/download/files` (기존 프록시) + 브라우저 PDF.js

## 브랜치별 추가분

| 브랜치 | 공통 베이스 위 추가분 |
|---|---|
| `feature/DL-15437` | 없음 (공통 베이스 그대로) |
| `feature/DL-15438` | `/api/pdf-to-image` API Route + Track 1 전용 PrintPdf |
| `feature/DL-15439` | `/api/pdf-to-image` API Route + 3트랙 체인 PrintPdf |

---

## Jira 서브태스크 구성 (DL-15436 하위) — 2가지 순위가 다름, 혼동 주의

### 솔루션 권장 순위 (Jira 티켓 제목의 [N순위])
DL-15439 [1순위] > DL-15438 [2순위] > DL-15437 [3순위]

| 티켓 | Jira 제목 | 방식 |
|---|---|---|
| DL-15439 | [1순위] [풀체인] 서버변환 → 브라우저 PDF.js → 프록시 | 가장 권장 (안전망 있음) |
| DL-15438 | [2순위] [서버] API Route 서버사이드 변환 | 서버 변환만, fallback 없음 |
| DL-15437 | [3순위] [브라우저] PDF.js 로컬 리소스 방식 | 가장 보수적 |

### 스테이징 테스트 순서 (Jira 댓글 기준)
DL-15437 먼저 → DL-15439 → DL-15438

**DL-15437 먼저 테스트하는 이유:** 변경 범위 가장 작음. 이것만으로도 CDN 의존 제거되어 원인 해결. 안정적이면 나머지 2개 불필요.
**DL-15439 두 번째 이유:** `@napi-rs/canvas`가 ECS 환경에서 실제 동작하는지 첫 검증. fallback 있어 서버 변환 실패해도 사용자 영향 없음.
**DL-15438 마지막 이유:** DL-15439에서 Track 1 안정성 확인 후에만 의미 있음. fallback 없어 실패 시 바로 에러 노출.

**통과 기준:**
- DL-15437: 텍스트 깨짐 없이 라벨 정상 출력
- DL-15439: `step: "server_track"` AMP 이벤트 정상 발생
- DL-15438: 정상 출력 + AMP 에러 이벤트 없음

---

## 인프라 유의사항 (ECS Fargate FE 서버)

- 스펙: 1 vCPU / 2GB RAM (BE의 절반)
- 헬스체크: `curl http://localhost:3000/` 30s interval / 5s timeout × 3회 실패 시 재시작
- **위험:** pdfjs-dist가 Node.js 이벤트 루프 블로킹 → 동시 요청 많으면 헬스체크 타임아웃 가능
- **위험:** 동시 변환 시 메모리 200~500MB/req → OOM Kill 가능성 (인메모리 캐시로 중복 요청 방어)
- **현실적 위험도:** 기공소 라벨 출력 특성상 동시 요청 몰릴 가능성 낮음 → 낮음
- **DL-15439 스테이징 확인 항목:** CloudWatch CPU Utilization, Memory Utilization, Container restarts

---

## 남은 작업

- [ ] **develop 브랜치 재생성** — 기존 원격 develop 삭제 → master 기준으로 신규 develop push
- [ ] **스테이징 배포 및 검증** — DL-15437 → DL-15439 → DL-15438 순서 (develop 향 PR)
- [ ] 검증 결과에 따라 머지할 브랜치 결정 (최종 타겟: master)
- [ ] (백로그) lab/clinic PrintPdf.tsx 코드 중복 공통화 (브랜치 선택 후)
- [ ] (백로그) Track 2, 3 및 public/pdfjs/ (6.8MB) 제거 검토 — Branch C 안정화 이후

---
name: project-pdf-print-work
description: 라벨 프린트 PDF 관련 작업 현황 — 공통 베이스 완성 + 3개 브랜치 준비 완료 (2026-07-02)
metadata: 
  node_type: memory
  type: project
  originSessionId: faec4704-b772-4c8b-a330-01e99c874fd0
---

# 라벨 프린트 PDF 작업 현황

**Why:** 기공소(lab)에서 배송 라벨 출력 시 텍스트 깨짐(아랍어) 현상 발생. CDN 리소스 로딩 실패가 원인.
**How to apply:** PDF 관련 작업 시 이 문서 먼저 참조. 브랜치 3개 로컬+원격 준비 완료. 스테이징 검증 후 머지 브랜치 결정.

---

## 핵심 개념

- **공통 베이스** = 결정과 무관하게 반드시 들어가야 할 모든 수정
- **3개 브랜치** = "서버사이드 변환을 추가할지, 어떤 구조로 할지"라는 하나의 결정만을 위한 분기

---

## 브랜치 상태 (2026-07-02 최종)

| 브랜치 | 역할 | 상태 |
|---|---|---|
| `fix/shipping-label-native-pdf-print` | 원본 PR #4214 (base: release/v1.75.0) | 보존, 건드리지 않음 |
| `fix/shipping-label-native-pdf-print-backup` | 원본 백업 | 보존 |
| `fix/pdf-label-common` | 공통 베이스 임시 브랜치 | **삭제됨** (내용은 3개 브랜치에 모두 포함) |
| `feature/DL-15437` | DL-15437 — 공통 베이스만 배포 | ✅ 로컬 + 원격 완료 |
| `feature/DL-15438` | DL-15438 — 서버 전용 | ✅ 로컬 + 원격 완료 |
| `feature/DL-15439` | DL-15439 — 3트랙 풀 체인 (권장) | ✅ 로컬 + 원격 완료 |

현재 체크아웃: `master`

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

## Jira 서브태스크 구성 (DL-15436 하위)

| 순서 | 티켓 | 제목 | 역할 |
|---|---|---|---|
| 1 | DL-15437 | [3순위] 공통 베이스 배포 | 서버 변환 없이 CDN 이전만으로 안정화 확인 |
| 2 | DL-15439 | [1순위] 3트랙 풀 체인 | 서버→브라우저→프록시 자동 fallback (권장) |
| 3 | DL-15438 | [2순위] 서버 전용 | Track 1만 사용, 안정 확인 후 fallback 제거 판단 |

**스테이징 검증 순서:** DL-15437 → DL-15439 → DL-15438
**이슈 해결 우선순위:** DL-15439 > DL-15438 > DL-15437

---

## 인프라 유의사항 (ECS Fargate FE 서버)

- 스펙: 1 vCPU / 2GB RAM
- 헬스체크: `curl http://localhost:3000/` 5s timeout × 3회 실패 시 재시작
- **위험:** pdfjs-dist가 Node.js 이벤트 루프 블로킹 → 동시 요청 많으면 헬스체크 타임아웃 가능
- **위험:** 동시 변환 시 메모리 200~500MB/req → OOM Kill 가능성
- **대응:** AMP step 이벤트로 트랙별 사용률 모니터링. 이슈 발생 시 BE에 ECS 스펙 상향 협의

---

## 남은 작업

- [ ] 스테이징 배포 후 기공소 실사용 환경 검증 (DL-15437 → DL-15439 → DL-15438 순)
- [ ] 검증 결과에 따라 머지할 브랜치 결정
- [ ] (백로그) lab/clinic PrintPdf.tsx 코드 중복 공통화 (브랜치 선택 후)
- [ ] (백로그) Track 2, 3 및 public/pdfjs/ (6.8MB) 제거 검토 — Branch C 안정화 이후

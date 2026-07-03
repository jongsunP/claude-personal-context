---
name: project-pdf-print-work
description: 라벨 프린트 PDF 관련 작업 현황 — Track 1 서버사이드 로컬 동작 확인, 비교 UI 추가, PR #4326 오픈 (2026-07-03)
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

### [N순위] = 테스트 순서이자 솔루션 권장도 (동일)
DL-15439 [1순위] → DL-15438 [2순위] → DL-15437 [3순위]

| 티켓 | Jira 제목 | 방식 |
|---|---|---|
| DL-15439 | [1순위] [풀체인] 서버변환 → 브라우저 PDF.js → 프록시 | 권장. fallback 체인으로 안전하게 먼저 검증 |
| DL-15438 | [2순위] [서버] API Route 서버사이드 변환 | Track 1 안정성 확인 후 fallback 제거 여부 판단 |
| DL-15437 | [3순위] [브라우저] PDF.js 로컬 리소스 방식 | DL-15439·DL-15438 모두 불안정 시 최후 대안 |

**통과 기준:**
- DL-15439: `step: "server_track"` AMP 이벤트 정상 발생
- DL-15438: 정상 출력 + AMP 에러 이벤트 없음
- DL-15437: 텍스트 깨짐 없이 라벨 정상 출력

---

## 인프라 유의사항 (ECS Fargate FE 서버)

- 스펙: 1 vCPU / 2GB RAM (BE의 절반)
- 헬스체크: `curl http://localhost:3000/` 30s interval / 5s timeout × 3회 실패 시 재시작
- **위험:** pdfjs-dist가 Node.js 이벤트 루프 블로킹 → 동시 요청 많으면 헬스체크 타임아웃 가능
- **위험:** 동시 변환 시 메모리 200~500MB/req → OOM Kill 가능성 (인메모리 캐시로 중복 요청 방어)
- **현실적 위험도:** 기공소 라벨 출력 특성상 동시 요청 몰릴 가능성 낮음 → 낮음
- **DL-15439 스테이징 확인 항목:** CloudWatch CPU Utilization, Memory Utilization, Container restarts

---

## Track 1 서버사이드 핵심 구현 (2026-07-03 세션에서 해결)

### 해결한 문제들
1. **`canvas.node` native binary 없음** → `canvasFactory`에 `@napi-rs/canvas` 직접 주입. pdfjs-dist가 node-canvas(`require("canvas")`)를 호출하지 않도록 차단
2. **텍스트 ☒ 박스 표시** → `disableFontFace: true`로 텍스트를 베지어 패스로 변환 (`@napi-rs/canvas`는 브라우저 FontFace API 미지원)
3. **배경만 보이고 텍스트 없음** → `cMapUrl`, `standardFontDataUrl`을 `path.join(process.cwd(), "public/pdfjs/...")` 파일시스템 경로로 전달

### 현재 `pdf-to-image.ts` 핵심 옵션
```ts
{
  canvasFactory: napiCanvasFactory,  // @napi-rs/canvas 직접 주입
  cMapUrl: path.join(process.cwd(), "public/pdfjs/cmaps/"),
  standardFontDataUrl: path.join(process.cwd(), "public/pdfjs/standard_fonts/"),
  useSystemFonts: true,      // 폰트 미임베드 시 OS 폰트 fallback
  disableFontFace: true,     // 텍스트 → 베지어 패스 변환
}
```

### 비교 UI 상태 (임시)
- `PrintShipmentLabelListItem.tsx`: Track 1(서버) / Track 2(브라우저) 수직 배치
- `PrintPdf.tsx`: `forceTrack?: "server" | "browser"` prop 추가
- **TODO**: 스테이징 검증 후 비교 UI 제거, `<PrintPdf src={labelUrl} />` 단일 렌더로 복원

---

## PR 현황

- **PR #4326**: `feature/DL-15439` → `develop` (스테이징 검증용)

---

## 남은 작업

- [ ] **스테이징 배포 후 Track 1 검증** — CloudWatch CPU/Memory/Container restarts 확인
- [ ] **비교 UI 제거** — Track 1 검증 완료 후 `PrintShipmentLabelListItem.tsx` 단일 렌더 복원, `PrintPdf.tsx` forceTrack prop 제거
- [ ] 검증 결과에 따라 develop → master 머지 브랜치 결정
- [ ] (백로그) lab/clinic PrintPdf.tsx 코드 중복 공통화 (브랜치 선택 후)
- [ ] (백로그) Track 2, 3 및 public/pdfjs/ (6.8MB) 제거 검토 — Branch C 안정화 이후

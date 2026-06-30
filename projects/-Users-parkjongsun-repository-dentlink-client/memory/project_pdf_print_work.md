---
name: project-pdf-print-work
description: 라벨 프린트 PDF 관련 작업 현황 — PR
metadata: 
  node_type: memory
  type: project
  originSessionId: b06eac75-8169-4948-b62d-9d907f868679
---

# 라벨 프린트 PDF 작업 현황

**Why:** PR #4214(fix/shipping-label-native-pdf-print)을 분석하고 연계 작업 목적으로 전체 구조를 파악함.
**How to apply:** 이 프로젝트에서 PDF 관련 작업 시 이 문서를 먼저 참조. 두 PDF 시스템이 완전히 다른 라이브러리를 쓰므로 혼동 주의.

---

## 두 가지 PDF 시스템

| 구분 | 운송사 라벨 (1페이지) | 주문 목록 (2페이지) |
|---|---|---|
| 하는 일 | 운송사가 만든 PDF를 화면에 표시 | 주문 데이터로 PDF를 직접 만듦 |
| 데이터 흐름 | BE → PDF 파일(S3) → FE가 렌더링 | BE → JSON → FE가 PDF 생성 |
| 라이브러리 | `pdfjs-dist` | `@react-pdf/renderer` |
| lab 파일 | `lab/src/components/PrintShipment/PrintPdf.tsx` | `lab/src/components/PrintShipment/label/ShipmentDetailsPDF.tsx` |
| clinic 파일 | `clinic/src/components/Print/PrintPdf.tsx` | `clinic/src/components/Print/PickupDetailsPDF.tsx` |
| 진입점(lab) | `PrintShipmentLabelListItem.tsx` | `ShipmentDetailsPDFDownloadButton.tsx` |
| 진입점(clinic) | `clinic/src/pages/pickup/print.tsx` | `PickupDetailsPDFDownloadButton.tsx` |

---

## PR #4214 — 라벨 프린트 PDF.js 리소스 로컬화

- **브랜치:** `fix/shipping-label-native-pdf-print`
- **base:** `release/v1.75.0` ← master가 아님 주의
- **작성자:** Tom(고인규), 2차 커밋은 Claude Opus 4.8 공동 작성
- **대상:** `PrintPdf.tsx` (lab + clinic 양쪽) — `@react-pdf/renderer` 쪽은 무관

### 해결한 것

| 문제 | 해결 방법 |
|---|---|
| CDN(cdnjs/unpkg)에서 worker/cmaps/fonts 로드 → 환경에 따라 텍스트 깨짐 | `public/pdfjs/`로 정적 파일 이전, 로컬 경로 사용 |
| 실패 시 무한 로딩 스피너 | `hasError` 상태 + 에러 메시지(`role="alert"`) |
| src 변경 시 race condition / 0x0 렌더 | `isActive` 플래그 + `loadImageSize()` Promise 래핑 |
| 에러 로그에 S3 URL 노출 | `has_src: Boolean(src)` 로 대체 |
| 빈 ArrayBuffer 통과 | `byteLength === 0` 체크 추가 |
| `any` 타입 | `getErrorTrackingFields()` 타입 가드 함수 도입 |

### 변경된 핵심 코드 패턴

```ts
// 기존 (CDN)
pdfjsLib.GlobalWorkerOptions.workerSrc = `https://cdnjs.cloudflare.com/.../pdf.worker.min.js`;
const cMapUrl = `https://unpkg.com/pdfjs-dist@${pdfjsLib.version}/cmaps/`;

// 변경 후 (로컬)
pdfjsLib.GlobalWorkerOptions.workerSrc = "/pdfjs/pdf.worker.min.js";
const cMapUrl = "/pdfjs/cmaps/";
```

### 2단계 로드 전략 (변경 후 유지되는 패턴)

1. 직접 URL로 PDF fetch 시도
2. 실패 시 → API 프록시(`API_PATHS.DOWNLOAD_FILES`) 통해 ArrayBuffer로 재시도
3. 그래도 실패 시 → `hasError = true` → 에러 메시지 표시

---

## 전체 현황 표

| 구분 | 내용 | 이 PR | 현재 상태 |
|---|---|---|---|
| 운송사 라벨 | CDN 의존 → 환경에 따라 깨짐 | ✅ 로컬 이전 | 해결 |
| 운송사 라벨 | 실패 시 무한 로딩 | ✅ 에러 메시지 | 해결 |
| 운송사 라벨 | race condition / 0x0 렌더 | ✅ isActive + Promise | 해결 |
| 운송사 라벨 | 에러 로그 S3 URL 노출 | ✅ has_src 로 대체 | 해결 |
| 이미지 라벨 | `usePrintImage` race condition 잔존 | ❌ 미처리 | **잔존** |
| 주문 목록 PDF | `@react-pdf/renderer` — CDN 의존 없음 | 해당 없음 | 문제 없음 |
| 코드 구조 | lab / clinic `PrintPdf.tsx` 로직 100% 중복 | ❌ 미처리 | **부채** |
| 운영 | `pdfjs-dist` 업그레이드 시 `public/pdfjs/` 수동 동기화 필요 | ❌ 미처리 | **부채** |
| 코드 품질 | `console.error` 2개 잔존 | ❌ 미처리 | **부채** |
| 브랜치 | base가 `release/v1.75.0` — master 연계 시 충돌 가능 | 해당 없음 | **확인 필요** |

---

## 잔존 이슈 상세

### 1. 이미지 라벨 race condition
- 위치: `lab/src/components/PrintShipment/label/PrintShipmentLabelListItem.tsx`, `clinic/src/pages/pickup/print.tsx`
- `usePrintImage` 훅(`lab/src/lib/PrintImage/usePrintImage.tsx`, `clinic/src/lib/PrintImage/usePrintImage.tsx`)이 여전히 사용됨
- 이 훅의 `setImageSize`는 `image.onload` 완료 전에 함수가 리턴되어 크기 0x0 상태에서 렌더 가능

### 2. pdfjs-dist 버전 고정 위험
- 기존 CDN 방식은 `${pdfjsLib.version}` 동적 참조 → 패키지 버전과 항상 일치
- 로컬화 이후 `public/pdfjs/` 파일이 고정 → 패키지 업그레이드 시 수동 교체 필요
- 강제 장치(postinstall 스크립트 등) 없음

### 3. lab/clinic PrintPdf.tsx 완전 중복
- 두 파일은 `@description` 주석과 `PrintImage` import 경로만 다름
- 로직 수정 시 양쪽 동시 수정 필요

---

## 관련 파일 경로 정리

```
lab/
  src/components/PrintShipment/
    PrintPdf.tsx                    ← pdfjs-dist, 이 PR 대상
    PrintImage.tsx
    label/
      PrintShipmentLabelListItem.tsx ← usePrintImage 훅 사용 중
      ShipmentDetailsPDF.tsx         ← @react-pdf/renderer
      ShipmentDetailsPDFDownloadButton.tsx
  src/lib/PrintImage/
    usePrintImage.tsx               ← race condition 잔존
  public/pdfjs/                     ← 이 PR에서 추가된 정적 자원

clinic/
  src/components/Print/
    PrintPdf.tsx                    ← pdfjs-dist, 이 PR 대상
    PrintImage.tsx
    PickupDetailsPDF.tsx            ← @react-pdf/renderer
    PickupDetailsPDFDownloadButton.tsx
  src/pages/pickup/print.tsx       ← usePrintImage 훅 사용 중
  src/lib/PrintImage/
    usePrintImage.tsx               ← race condition 잔존
  public/pdfjs/                     ← 이 PR에서 추가된 정적 자원

shared/ui/src/PdfUI/
  PdfConfig.tsx                    ← @react-pdf/renderer 공통 설정
  PDFHeaderUI.tsx, PDFTableUI.tsx 등
```

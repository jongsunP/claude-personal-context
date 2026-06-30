---
name: project-pdf-print-work
description: 라벨 프린트 PDF 관련 작업 현황 — PR
metadata: 
  node_type: memory
  type: project
  originSessionId: b06eac75-8169-4948-b62d-9d907f868679
---

# 라벨 프린트 PDF 작업 현황

**Why:** 기공소(lab)에서 배송 라벨을 출력할 때 텍스트가 아랍어처럼 보이거나 알 수 없는 글자로 깨지는 현상 발생. FE에서 원인 파악 및 해결 방향 수립.
**How to apply:** PDF 관련 작업 시 이 문서 먼저 참조. 최종 방향은 API Route 서버사이드 변환이며, 브라우저 PDF.js는 fallback.

---

## 문제 정의

- **증상:** 배송 라벨 PDF가 어쩔 때는 아랍어처럼, 어쩔 때는 알 수 없는 글자로 깨짐
- **원인:** "어쩔 때만" 깨진다는 것이 핵심 — 항상 깨지면 인코딩 문제지만 간헐적이므로 외부 리소스 로딩 실패가 원인
- **BE 책임 없음:** BE는 외부 운송사로부터 받은 PDF 파일 URL을 전달만 하는 역할. PDF 자체는 정상
- **FE 책임:** PDF.js가 브라우저에서 렌더링할 때 필요한 리소스(worker/cmaps/fonts)를 외부 CDN에서 가져오다 실패

---

## 시스템 구조

### 두 가지 PDF 시스템 (혼동 주의)

| 구분 | 운송사 라벨 (1페이지) | 주문 목록 (2페이지) |
|---|---|---|
| 하는 일 | 운송사가 만든 PDF를 이미지로 변환 후 표시 | 주문 데이터로 PDF를 직접 생성 |
| 데이터 흐름 | 운송사 → PDF 파일 → S3 → BE가 URL 전달 → FE 렌더링 | BE JSON → FE PDF 생성 |
| 라이브러리 | `pdfjs-dist` | `@react-pdf/renderer` |
| lab 파일 | `lab/src/components/PrintShipment/PrintPdf.tsx` | `lab/.../ShipmentDetailsPDF.tsx` |
| clinic 파일 | `clinic/src/components/Print/PrintPdf.tsx` | `clinic/.../PickupDetailsPDF.tsx` |
| 이번 작업 대상 | ✅ | ❌ |

### 실제 출력 흐름 (PrintPdf.tsx)

```
운송사 PDF (S3)
    ↓ fetch (직접 or CORS 실패 시 API 프록시)
PDF.js → canvas 렌더링 → canvas.toDataURL("image/png")
    ↓
PrintImage 컴포넌트 → <img> 태그 (회전/리사이즈 처리)
    ↓
프린트 출력
```

**핵심:** FE는 처음부터 PDF를 이미지로 변환해서 출력물로 쓰는 구조. PDF 뷰어가 아님.

---

## PR #4214 분석 (fix/shipping-label-native-pdf-print)

- **브랜치:** `fix/shipping-label-native-pdf-print`
- **base:** `release/v1.75.0` ← master가 아님 주의
- **작성자:** Tom(고인규), 2차 커밋은 Claude Opus 4.8 공동 작성
- **목적:** PDF.js CDN 의존 제거로 브라우저 렌더링 안정화

### 해결한 것

| 문제 | 해결 방법 |
|---|---|
| CDN(cdnjs/unpkg)에서 worker/cmaps/fonts 로드 → 깨짐 | `public/pdfjs/`로 정적 파일 이전 (lab/clinic 각 3.4MB) |
| 실패 시 무한 로딩 스피너 | `hasError` 상태 + 에러 메시지 |
| src 변경 시 race condition / 0x0 렌더 | `isActive` 플래그 + `loadImageSize()` Promise 래핑 |
| 에러 로그에 S3 URL 노출 | `has_src: Boolean(src)` 로 대체 |
| `any` 타입 | `getErrorTrackingFields()` 타입 가드 도입 |

### 잔존 부채

| 항목 | 내용 |
|---|---|
| 이미지 라벨 race condition | `usePrintImage` 훅 미수정 — `PrintShipmentLabelListItem`, `clinic/pages/pickup/print` |
| lab/clinic PrintPdf.tsx 코드 중복 | 주석만 다르고 100% 동일 |
| `console.error` 2개 잔존 | 컨벤션 위반 |
| pdfjs-dist 업그레이드 시 public/pdfjs/ 수동 동기화 필요 | 강제 장치 없음 |
| base가 release/v1.75.0 | master 연계 시 충돌 가능성 |

---

## 인프라 확인 결과

| 항목 | 내용 |
|---|---|
| FE 서버 | ECS Fargate (EC2 아님) |
| OS | Amazon Linux |
| 인스턴스 | 치과/기공소/어드민 각 1개씩 독립 |
| CPU/메모리 | 1 vCPU / 2GB |
| S3 쓰기 권한 | 없음 |
| 배포 방식 | GitHub Actions |
| 사용 서비스 | lab + clinic 양쪽 모두 |

---

## 최종 방향 결정 — 투트랙

### 목적 재정의
"PDF가 필요한 게 아니라 출력물(이미지)이 필요하다."
PR #4214의 접근(브라우저에서 PDF→이미지)은 방향이 맞지만 브라우저 환경 변수로 인해 100% 보장 불가.

### 투트랙 구조

```
1순위: Next.js API Route (서버사이드 변환)
  - ECS Fargate 컨테이너에서 PDF → PNG 변환
  - 브라우저 환경 무관, 항상 동일한 결과
  - @napi-rs/canvas 패키지 사용 (Dockerfile 수정 불필요, 사전 빌드 바이너리)
  - 인메모리 캐싱 (단일 인스턴스, S3 쓰기 권한 없으므로)
      ↓ 실패 시
2순위: 브라우저 PDF.js (PR #4214 방식)
  - 로컬 public/pdfjs/ 리소스 사용
  - CDN 의존 없으므로 기존보다 안정적
      ↓ 실패 시
에러 메시지
```

### 각 트랙의 역할

| | Track 1 (API Route) | Track 2 (PR #4214) |
|---|---|---|
| 목적 | 근본 해결 | 안전망 (테스트 기간) |
| 위치 | FE 서버 (ECS Fargate) | 브라우저 |
| 100% 보장 | 사실상 가능 | 불가 |
| 최종 상태 | 유지 | 안정화 후 제거 검토 |

### 추가 작업 필요사항

- `@napi-rs/canvas` npm 패키지 추가
- Next.js API Route 신규 작성 (lab, clinic 각각 또는 공통)
- `PrintPdf.tsx` fallback 로직 추가

---

## 관련 파일 경로

```
lab/
  src/components/PrintShipment/
    PrintPdf.tsx                    ← 이번 작업 대상 (pdfjs-dist)
    PrintImage.tsx                  ← 최종 <img> 렌더링 + 프린트 스타일
    label/
      PrintShipmentLabelListItem.tsx ← PDF/이미지 분기점
      ShipmentDetailsPDF.tsx         ← @react-pdf/renderer (별개)
  public/pdfjs/                     ← PR #4214에서 추가 (3.4MB)

clinic/
  src/components/Print/
    PrintPdf.tsx                    ← 이번 작업 대상 (pdfjs-dist)
    PrintImage.tsx
  src/pages/pickup/print.tsx       ← 프린트 페이지 진입점
  public/pdfjs/                     ← PR #4214에서 추가 (3.4MB)
```

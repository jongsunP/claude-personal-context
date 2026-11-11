---
name: project-pdf-print-work
description: 라벨 프린트 PDF 관련 작업 현황 — 최종 결정: 서버사이드(Track 1, DL-15438)만 배포
metadata: 
  node_type: memory
  type: project
  originSessionId: faec4704-b772-4c8b-a330-01e99c874fd0
---

# 라벨 프린트 PDF 작업 현황

**Why:** 기공소(lab)에서 배송 라벨 출력 시 텍스트 깨짐 현상 발생. 영어 텍스트가 아랍어처럼 보이는 증상.
**How to apply:** PDF 관련 작업 시 이 문서 먼저 참조. 최종 결정 확인 후 진행.

---

## 최종 결정 (2026-07-06)

**서버사이드(Track 1, DL-15438)만 배포.**
Track 2(브라우저 PDF.js), Track 3(풀 체인, DL-15439) 제외.

기존 PR #4326(DL-15439)은 이 결정으로 방향이 바뀜.

---

## 버그 원인 조사 결과 (2026-07-06)

### CDN 원인설 → 반박됨
- Production(master)과 staging 모두 Network에 unpkg.com 요청 없음
- DHL 라벨 PDF가 폰트를 내부 임베드 → 외부 cmap/font 요청 자체 안 함
- CDN 차단으로 버그 재현 불가

### 실제 원인 (유력)
```ts
useSystemFonts: true  // ← 원인
```
- PDF.js가 PDF 내장 커스텀 폰트 이름으로 OS 폰트를 찾아 렌더링
- Windows에 해당 폰트 없음 → 시스템 폰트 대체 → 글리프 ID 매핑 깨짐
- 결과: 영어 자리에 아랍어처럼 보이는 문자 출력
- macOS는 폰트 매핑 방식 달라 미발생 → Windows 특정 기기에서만 재현

### `useSystemFonts: true`를 제거하면 안 되는 이유
- PR #3730 "프린트 핫픽스" (2026-02-10)에서 **이전 버그를 고치려고 추가된 것**
- 이전 버그: 특정 PDF에서 폰트 미임베드 → 텍스트가 아예 안 보이는 문제
- 제거 시 그 이전 문제 재발 가능 → 단순 제거는 불가

### 재현 가능 여부
- 네트워크 조작으로는 재현 불가
- 버그 발생 기기(Windows) 또는 폰트 환경 조작 없이는 재현 어려움

### 서버사이드 fix가 맞는 이유
- `useSystemFonts` 딜레마 자체를 우회 (제거도 유지도 아닌 서버에서 처리)
- `@napi-rs/canvas + GlobalFonts.loadSystemFonts()`는 Skia 레벨에서 폰트 직접 등록 → 이전 핫픽스가 해결한 문제 + 현재 버그 동시 해결
- 클라이언트 환경 완전 우회

---

## 브랜치 상태 (2026-07-06 기준)

| 브랜치 | 역할 | 상태 |
|---|---|---|
| `fix/shipping-label-native-pdf-print` | 원본 PR #4214 (base: release/v1.75.0) | 보존 |
| `fix/shipping-label-native-pdf-print-backup` | 원본 백업 | 보존 |
| `feature/DL-15437` | Track 2 — 브라우저 PDF.js 로컬 | 제외 결정 |
| `feature/DL-15438` | Track 1 — 서버사이드 API Route | ✅ **최종 선택** |
| `feature/DL-15439` | Track 3 — 풀 체인 | 제외 결정, PR #4326 재검토 필요 |

---

## 공통 베이스에 포함된 수정 (3개 브랜치 모두 포함)

| 커밋 | 내용 |
|---|---|
| `281879737` | PDF.js CDN → 로컬 `/pdfjs/` 이전 |
| `d6a32d6d4` | PrintPdf 안정성 개선 (race condition, 에러 UI, 타입 안전성) |
| `945aadbd1` | console.error 제거 |
| `04539053b` | usePrintImage race condition 수정 (currentSrcRef) |

---

## 트랙별 구조

- **Track 1 (선택):** `/api/pdf-to-image` — 서버에서 PDF → PNG 변환 (@napi-rs/canvas + pdfjs-dist)
- **Track 2 (제외):** 브라우저 PDF.js — 로컬 `/pdfjs/` 리소스
- **Track 3 (제외):** `/api/download/files` (기존 프록시) + 브라우저 PDF.js

---

## Track 1 서버사이드 핵심 구현

### 해결한 문제들
1. **`canvas.node` native binary 없음** → `canvasFactory`에 `@napi-rs/canvas` 직접 주입
2. **텍스트 ☒ 박스** → `disableFontFace: true`
3. **텍스트 완전히 없음** → `GlobalFonts.loadSystemFonts()`로 Skia에 시스템 폰트 등록
4. **`useSystemFonts: true` 제거** — 폰트 이름 인식 못 하면 텍스트 통째로 사라짐
5. **TypeScript 에러** → `Canvas`, `SKRSContext2D` 명시

### 최종 핵심 옵션
```ts
import { Canvas, GlobalFonts, SKRSContext2D, createCanvas } from "@napi-rs/canvas";

(GlobalFonts as typeof GlobalFonts & { loadSystemFonts: () => void }).loadSystemFonts();

{
  canvasFactory: napiCanvasFactory,
  cMapUrl: path.join(process.cwd(), "public/pdfjs/cmaps/"),
  standardFontDataUrl: path.join(process.cwd(), "public/pdfjs/standard_fonts/"),
  cMapPacked: true,
  disableFontFace: true,
}
```

---

## 인프라 유의사항 (ECS Fargate FE 서버)

- 스펙: 1 vCPU / 2GB RAM
- **위험:** pdfjs-dist Node.js 이벤트 루프 블로킹 → 동시 요청 많으면 헬스체크 타임아웃 가능
- **위험:** 동시 변환 시 메모리 200~500MB/req → OOM Kill 가능성 (인메모리 캐시로 중복 요청 방어)
- **현실적 위험도:** 기공소 라벨 출력 특성상 동시 요청 몰릴 가능성 낮음

**CloudWatch 확인 항목 (배포 후):**
- CPU Utilization
- Memory Utilization
- Container restarts (0이어야 정상)

---

## PR 현황 (2026-07-06 기준)

- **PR #4336**: `feature/DL-15438` → `master` (Draft, 비교용)
  - 서버사이드 코드만 포함 (static 파일 없음)
  - `public/pdfjs/` 제거 → `require.resolve("pdfjs-dist/package.json")`으로 node_modules 경로 참조
  - 동시 요청 제한(MAX_CONCURRENT=2) 인라인 구현 완료
  - clinic/lab 양쪽 모두 적용

## 남은 작업

- [ ] PR #4336 리뷰 후 develop 타겟 PR로 전환 또는 재생성
- [ ] PR #4326 (DL-15439) 닫기
- [ ] 스테이징 배포 후 Track 1 검증 — CloudWatch CPU/Memory/Container restarts 확인
- [ ] 검증 완료 후 develop → master 머지
- [ ] (백로그) lab/clinic PrintPdf.tsx 코드 중복 공통화

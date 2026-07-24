---
name: project-i18n-progress
description: dentlink-client-i18n — Lab i18n 시스템 구현 현황 및 이어서 작업할 때 필요한 컨텍스트
metadata: 
  node_type: memory
  type: project
  originSessionId: 7af44387-e0c6-4bab-b140-732615ecd17e
  modified: 2026-07-24T09:07:49.075Z
---

## 작업 위치

- 워크트리: `~/Repository/dentlink-client-i18n`
- 브랜치: `feature/i18n`
- 기준 브랜치: `origin/master`

## 구현 완료된 것

### 핵심 스크립트
- `lab/scripts/i18n/sheets-client.js` — Google Sheets API 연동. 서비스 계정 키 우선순위: 환경변수 → 로컬 키 파일 → ADC
- `lab/scripts/i18n/generate-locales.js` — Sheets에서 읽어 en/ko JSON 생성. 스프레드시트 key 컬럼(namespace.key 형식)에서 직접 추출. `--check` 플래그로 최신 여부 검증 가능

### 스프레드시트 구조
- Google Sheets URL: https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0
- 시트명: `화면 문구 수집` (단일 시트)
- PM 입력 컬럼(6개): 서비스, 화면/기능, 위치·UI, 영문, 한글, 의미
- 개발자 입력 컬럼(1개): key — `namespace.key` 형식 (맨 오른쪽, 예: `orders.columns.orderStatus`)
- ID 컬럼 없음 (이전 설계에서 제거)
- 행 포함 기준: key·영문·한글 모두 채워진 행. key 미입력 행은 조용히 건너뜀

### namespace 구조 (4개)
- `common` — 공통 네비게이션, 계정, 언어 설정
- `dashboard` — 대시보드
- `orders` — 주문 목록·상세·생성
- `sharedUi` — shared/ui 공통 컴포넌트

### 생성되는 파일
- `lab/src/i18n/locales/{en,ko}/{common,dashboard,orders,sharedUi}.json`
- 현재 빈 파일(`{}`) — generate 실행 전까지 TypeScript 에러로 빌드 차단 (의도된 설계)

### i18n 런타임 설정
- `lab/src/i18n/i18n.ts` — i18next 초기화
- `lab/src/i18n/i18n.resources.ts` — JSON import + TypeScript 타입 추론
- `lab/src/i18n/i18next.d.ts` — `t()` 자동완성 타입 정의
- `lab/src/i18n/LocaleProvider.tsx` — 전역 Provider (localStorage 기반 언어 저장)

### 인증
- 서비스 계정: `i18n-reader@i18n-503406.iam.gserviceaccount.com`
- 로컬 키 파일: `lab/scripts/i18n/service-account.json` (gitignore됨)
- CI: `GOOGLE_SERVICE_ACCOUNT_KEY` 환경변수에 JSON 전체 내용 주입

### package.json 스크립트
- `pnpm generate:i18n` — 루트에서 실행 (lab/.env.local 사용)
- JSON check: `node --env-file=lab/.env.local lab/scripts/i18n/generate-locales.js --check` — CI 연결 전 직접 실행용

## 언어 추가 시 필요한 작업 (NOTE 주석으로 위치 표시됨)
1. `sheets-client.js` COLUMN_HEADERS에 `{ locale코드: "컬럼명" }` 추가
2. `generate-locales.js` SUPPORTED_LOCALES 배열에 locale 코드 추가
3. 스프레드시트에 해당 언어 컬럼 추가
4. `lab/src/i18n/i18n.resources.ts`에 새 locale JSON import 추가

## 코드 사용 패턴 (3가지)

```tsx
// 1. 기본
const { t } = useTranslation('orders');
t('title')

// 2. 변수 보간 — sharedUi는 defaultValue 필수 (clinic 등 미적용 서비스 대응)
t('pagination.showRows', { defaultValue: 'Show {{count}} rows', count: size })

// 3. <Trans> — React 컴포넌트 삽입 필요 시만 (현재 허용 태그: <highlight>)
// 스프레드시트: "Click <highlight>here</highlight> to continue"
<Trans i18nKey="someKey" ns="orders">
  Click <Highlight>here</Highlight> to continue
</Trans>
```

## 아직 안 된 것 / 향후 과제
- Clinic·Admin 서비스 i18n 확장 (현재 Lab만 구현)
- namespace 지연 로딩 (현재는 앱 시작 시 전체 로드 — 규모 커지면 검토)
- 서버 문구 현지화 (현재는 프론트 정적 문구만)
- React PDF 한글 폰트 등록
- CI 파이프라인에 check:i18n 연결

**How to apply:** i18n 관련 작업 시작 시 이 파일과 함께 `~/Repository/dentlink-client-i18n` 워크트리 상태 확인.

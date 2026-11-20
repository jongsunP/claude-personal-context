## 2026-11-19 작업 마감 (브레이크포인트 1)

- 사용자 지시: 여기까지 11/19 작업. 치과 PR354 e7bc78e1·기공소 PR50 dca6220 미머지, 웹 PR4903 머지·배포. CodePush 치과 STG v356/v355·DEV v153, 기공소 STG v72·DEV v50/v49.
- 남은 개발: DL-17535(검토 완료) → DL-17533(범위 정의부터). 다음은 11/20 작업 준비.

## 2026-11-19 밤 — 브레이크포인트(현재 상태)

- 치과 348b7fe0: STG iOS v356/Android v355, DEV v153/v153. 기공소 116f77f: STG v72/v72, DEV iOS v50/Android v49. 웹은 PR4903 머지본 배포 완료, 이후 변경 없음.
- PR #354·#50 본문에 11/19 카드(치과 17496·17501·17506·17521·17524·17529·17537, 기공소 17529·17537) 반영. PR 미머지.
- 이후 주석 커밋만 추가(동작 변경 없음, 배포 불필요): 기공소 dca6220·치과 e7bc78e1 = 현재 PR head.
- 다음(사용자 재개 지시 대기): DL-17535 Review Order 앱 연동 → DL-17533 결제 내역 화면(범위 정의부터).

## 2026-11-19 밤 — DL-17537 탭 랜딩(EXTRA_FEE) 앱 전달

- Lab 116f77f·Office 348b7fe0(feat/DL-16140) 푸시, 미배포. OrderDetailScreen이 딥링크 `tab`을 웹뷰 next(`/orders/{id}?tab=`, 인코딩)에 전달, DentlinkWebView 주문번호 파싱에서 쿼리 제거. 웹 수정 불필요. 랜딩 형식: 웹 `/orders/${orderId}?tab=EXTRA_FEE`, 앱 `dentlink-lab://order/${employerId}/${orderId}?tab=EXTRA_FEE`(기공소만, BE가 환경 스킴).

## 2026-11-19 밤 — DL-17529 링크톡 플로팅 버튼 폭 가변

- Lab 1d7e826·Office 6ea4e941(feat/DL-16140) 푸시, CodePush 안 함. FloatingActionButton이 보이지 않는 측정용 글자로 폭을 재서 44+글자폭+16, 측정 전 $width 사용. 디자인·패딩·접힘 애니메이션 유지. 기기 화면 확인 안 함.

## 2026-11-19 밤 — 대기 중인 검토: Review Order 앱 연동

- 웹 주문상세(웹뷰) 보류(PENDING_ORDER) Review Order → 앱 주문 수정 연동. 가능 판정, 작업은 사용자 지시로 대기. 앱 OrderScreen에 PENDING_ORDER 허용·옵션 단계부터 시작·뒤로가기 조정, 웹 OrderDetailBoxRequest 앱 메시지. 리메이크 제외 권장, DEV 보류 주문 데이터 필요. 상세는 codex-personal-context 프로젝트 파일.

## 2026-11-19 밤 — DL-17524 수정 푸시(Office 93b36b6a·6967366d, CodePush 안 함 — 사용자가 커밋·푸시까지만 지시, 스테이징 v355/v354 그대로 확인)

- 원인: 저장 직후 확인 GET이 가끔 이전 값 → 캐시 덮어써 되돌아감(에뮬 로그로 확인). My Only는 목록 재렌더 중 `!value` 갱신 전 값. 첫 터치 씹힘 후보는 24dp 높이·hitSlop 없음(실기기 확인 필요).
- 수정: 확인 GET 다르면 0/200/500/1000ms 재확인(알림 설정 방식), Auto-apply·My Orders Only·My Patients Only hitSlop 10, My Only 마지막 선택 기준. 프로필 무변경. 에뮬·시뮬·테스트 확인, 커밋·CodePush는 지시 대기.

## 2026-11-19 마감 — DL-17524만 대기

- 나머지 본인 카드 완료, DL-17488·17477은 READY FOR QA(할 일 없음). 웹 PR4903 release/v1.94.0 머지(최신 346741924 포함). Office PR354·Lab PR50 미머지. Office HEAD=PR head=7f43cd45=CodePush 소스, 프로필 파일 무변경.
- STG 최신: Office 2.2.5 iOS v355 / Android v354, Lab 1.0.6 iOS/Android v71. DEV: Office v152/v152, Lab v49/v48.
- DL-17524 실기기(STG) 증상: iOS v355는 모두 정상. Android v354 — Auto-apply: 첫 터치부터 씹힘·연속 시 돌아갔다 옴. 주문목록 My ~ Only(OrderSearchForm)·환자목록 My Patients Only(OrderPatientListSection): 첫 터치 괜찮고 연속 터치 시 더 버벅임. 프로필 정상(기준). 측정 시 토글별로 ①터치가 Switch에 도달하는지 ②도달 후 반영 시간 분리. 가설(미확인): My Only는 목록 재렌더 중 갱신 전 값으로 `!value` 계산, Auto-apply 첫 터치는 입력 전달 문제(ShadowedView·FlatList 머리·옆 설명 버튼·hitSlop 없음).
- 아직 DEV 데이터 세팅 안 됨(사용자 확인 11/19).
- DL-17524(치과앱 Android Auto-apply 반응 느림): 사용자가 DEV 데이터 세팅 알림 → iOS 시뮬·Android 에뮬 둘 다(사전 허락됨) 측정 → 원인 확정 → 프로필 해당 여부 검토만 → 수정·테스트·보고. 커밋·CodePush는 지시 시. 그전까지 대기.

## 2026-11-19 밤 — 대기 상태

- Android STG 2.2.5.354에서 유저 크레딧 Auto-apply 토글만 답답(iOS·Android 프로필은 정상). 로직은 프로필과 동일, 차이는 ShadowedView 카드·FlatList 머리·감싼 영역 색 변경. 원인 미확정 → 사용자 DEV 데이터 세팅 후 에뮬레이터 측정(측정 전 확인받기). 사용자가 카드 생성.
- 프로필 토글 추가 수정은 사용자 지시로 폐기. Office HEAD 7f43cd45 clean. 프로필 테스트 11개는 원래부터 낡아 실패(정리 미정).

## 2026-11-19 저녁 — DL-17501 3차 Office 7f43cd45 푸시(미배포)

- 유저 크레딧 Auto-apply 토글을 프로필 방식(즉시 표시·마지막 선택 순차 저장·토글 영역 분리·마지막 선택 기준 계산)으로 수정, feat/DL-16140에 push. 사용자 지시로 STG iOS v355/Android v354, DEV v152/v152 CodePush(활성 확인). 사용자 실기기 확인 대기.

## 2026-11-19 후속 — DL-17521·DL-17501 2차 (Office만, 푸시·미배포)

- 기존 PR 브랜치 feat/DL-16140(PR354 미머지)에 이어서 작업. Office ab89cdee(청구서 목록 헤더 Billing Statements), dcfe7aa3(유저 크레딧 Auto-apply 스위치 animateOnMount=false·저장 중 disabled 제거). 웹·Lab 변경 없음(해당 화면 없음). 연속 탭 최신값 저장은 미적용. 이후 사용자 지시로 Office STG iOS v354/Android v353, DEV v151/v151 CodePush(활성 확인). Lab·웹 조치 없음. 사용자 QA 대기.

## 2026-11-19 마감 — 양앱 STG·DEV CodePush, 사용자 QA 대기

- QA feat/DL-16140(PR 유지). Office 8209ebec: STG iOS v353/Android v352, DEV v150/v150. Lab bbf1d96: STG v71/v71, DEV iOS v49/Android v48. 전부 활성·mandatory·100%. 웹은 사용자가 배포.
- CodePush 스크립트는 변경사항 입력에 TTY 필요 → expect로 `node scripts/codepush.js <env> all --mute` 실행.
- 디자인 QA 4건 코드 완료(17496/17501/17505/17506). 다음은 사용자 QA 결과 대기, 폴링 없음.
- Jira: 본인 카드 17488/17496/17501/17506/17507 → 사용자가 READY FOR QA 이동, 17505는 웹 배포 후. 17470/17477 기존 READY FOR QA. 미작업 없음, 사용자 다음 요청까지 대기.

## 2026-11-19 디자인QA 3건 수정(푸시 완료·미배포: Office 6a0d1c2c·8209ebec, Web 0c22f659d)

- DL-17496 Payments 문구(Office 앱 2곳+테스트, 웹 공용 설정 문구), DL-17506 크레딧 Learn More 밑줄색, DL-17501 크레딧 화면 당겨서 새로고침 표시를 사용자 당김에만 연결. 모두 feat/DL-16140 작업트리에 있고 사용자 지시로 커밋·푸시 완료, 배포·CodePush 없음.
- DL-17501 원인: 토글 저장 뒤 invalidate로 isRefetching이 RefreshControl에 걸려 iOS 화면이 밀림. 대상은 알림설정이 아니라 User Credits 화면.
- Office Jest는 `npx jest --config jest.config.js __tests__`로 돌린다(package.json jest 키와 중복). 기존 실패 2건(App 네이티브모듈, useProfileMarketing) 무관.
- DL-17505: 웹만으로는 앱 네이티브 헤더 위 배치 불가(웹뷰는 헤더 아래 상자). 사용자 결정으로 웹 여백안 채택(디자이너 공유는 사용자가 함). 웹 Layout 사이드패널형이 헤더 숨김 시 배너 여백을 빼먹던 것을 수정, Web 346741924 푸시·미배포. 로컬 모바일 폭 확인 완료.

## 2026-11-17 마감 — 웹·양앱 스테이징 QA 대기

## 2026-11-17 사용자 해결 확인 · 지침 보완 · 마감

- 사용자가 최신 Staging CodePush 후 “이제 처리되었음”으로 해결 확인. 앞선 프로필 반응/애니메이션 개선 확인과 함께 사용자 확인으로 기록하며, 에이전트가 모든 서비스·기기를 재테스트한 것으로 확대하지 않는다.
- DL-17470(배경색), DL-17482(스위치/프로필)는 Jira 실조회 시 이미 **READY FOR QA**. 사용자 요청 상태와 같아 불필요한 재전환 없이 유지. Done 변경, 새 댓글/본문 수정 없음. 신규DL17488은 별도 미착수 유지.
- 사용자 필수 지침: **앱 신규 스크린 추가 시 반드시** 노치/상태바·safe area·헤더·본문색과 inset, 진입/뒤로가기/홈·프로필 복귀를 처리. 탭/중첩스택 구분, 기존 화면 회귀 및 부가 크레딧/청구서 포함. DEVELOPMENT_STYLE 및 AGENTS 명시; 관련 변경도 적용. 위험 기반 검증 및 명시적 실행 생략 요청은 유지, 전체 검수 강제 아님.
- 프로필 학습: 독립 PATCH 채널은 상호 대기하지 않되 같은 필드 순서·최신 대기 선택·실패복구·오래된 응답/계정 보호·서버 재대조 유지. 전체 객체 PUT/결합 설정에는 일반화 금지. DEVELOPMENT_STYLE 및 Claude 지침 메모리 동기화.
- 현재 배포/코드: Office2.2.5 STG iOSv352/Androidv351(22c3349), Lab1.0.6 STG 양OSv70(77881a6). QA feat/DL-16140, PR354/50 미머지 유지. 웹/DEV/제품코드/추가 배포 변경 없음.
- Git 개인컨텍스트와 Claude 메모리·Codex 로컬 지침/메모리 기록 후 대기. 다음 사용자 QA/신규카드 요청 전 자동 조사·테스트·배포·폴링 없음.

## 2026-11-17 하단 탭 배경색 보완 Staging CodePush 완료

- 사용자 명시 승인: 테스트 제외, 앞서 수정한 QA 브랜치 양앱 STG CodePush. 추가 코드 변경 없이 Office22c33497124f0f5553bfee07e15045dfe5e4c32d / Lab77881a6393bdac297aaf8bb9e266da5d62152f85를 게시했다.
- 게시 및 활성화 완료: **Office2.2.5 iOSv352 / Androidv351**, **Lab1.0.6 iOSv70 / Androidv70**. history 각1회로 source/label/target/enabled 확인. 기존 scripts/codepush.js staging all --mute 제품별 직렬 실행. Office 기존 isv.mp4 크기 경고는 게시 성공을 막지 않음.
- 배포 번들링 외 테스트·lint·타입검사·시뮬/에뮬·실기기 실행은 사용자 지시대로 생략. 실기기 해결/무회귀를 확인한 것은 아님. 사용자가 홈·프로필 노치와 본문색 일치, 알림함↔설정 및 크레딧·청구서 진입복귀를 확인할 차례.
- QA feat/DL-16140 및 기존 PR354/50 미머지 유지. 웹·Development·Jira·native 바이너리 변경 없음. 이전에 개선됐다고 보고한 프로필 저장/스위치 로직도 이번에 추가 변경하지 않음. 신규DL17488 미착수 유지. 기록 후 사용자 QA 피드백 대기, 자동 추가 조사/폴링 없음.

## 2026-11-17 STG v351 이후 피드백 · 하단 탭 배경색 추가 수정 (미배포)

- 사용자 실기기 보고: 알림 화면 전환 개선, Office 프로필 반응·애니메이션 자연스러움. 그러나 홈/프로필 노치가 흰색이고 본문 회색으로 남는 회귀. 새 크레딧·청구서 목록도 같은 처리가 필요한지, 프로필 독립 저장 API 영향 질문.
- 양앱 RootNavigator에서 일반 BottomTabNavigator의 안전영역 감싸기를 제외하고 BottomTabNavigator screenLayout에서 탭별 확정 색상을 직접 사용. 상위에서 중첩 leaf 상태를 추정하던 경로 제거. Office Home/Profile mono200, 다른 탭 white; Lab Home mono200·Profile 기존 본문 white 유지. Lab 밀링 탭은 기존 루트 처리 유지(별도범위).
- Office **22c3349**, Lab **77881a6**, QA feat/DL-16140 commit/push. 기존 PR354/50 유지. **추가 CodePush는 하지 않음**; 현재 배포는 Office iOSv351/Androidv350, Lab 양OSv69 그대로. 웹·DEV·Jira 변경 없음.
- CreditScreen/StatementListScreen은 RootStack의 ScreenSafeArea가 이미 감싸며 Layout 기본 배경 white와 동일. 중첩 탭 예외와 무관하므로 별도 중복 inset/래퍼를 추가하지 않음. 이번에는 해당 화면 코드 변경 없음.
- 프로필 API 확인: SMS /office/users/own/sms/marketing, Email /office/users/own/email/marketing 각각 PATCH; 전체 프로필 PUT이 아님. UI 선반영, 같은 채널 순차 처리, 실패 복구, 모든 저장 후 확인 GET·새 입력/계정 변경 응답 보호 유지. 서버 확인을 없앤 구조가 아니며 사용자 체감 개선 확인에 따라 코드 유지. BE 내부 동시성 구현까지 검증한 것은 아님.
- 사용자 직전 실행검증 생략 요청을 이번 연속 보완에도 유지: 코드 확인/포맷/diff만, 테스트·기기 실행 없음. 회귀 해결 실기기 확인은 미완료. 다음 사용자 승인 시 추가 QA 커밋 Staging CodePush 후 홈/프로필 상단색 및 크레딧/청구서 진입복귀 확인. 신규17488 보류 유지.

## 2026-11-17 실기기 재제보 후 재보완 · 실행검증 생략 · Staging 게시 완료

- 사용자: Office iOS STG 2.2.5.350에서도 알림함→홈·설정→알림함 상단 노치색 지연 및 프로필 Texts/Email 첫 클릭·연속 클릭 지연 재현. 이전 테스트 통과를 해결 증거로 확대하지 않는다. 이번에는 사용자가 코드수정·QA브랜치 STG CodePush를 승인하면서 테스트/기기검증을 명시적으로 생략하도록 지시했다. 이 생략은 이번 작업에만 적용한다.
- 코드: Office `feat/DL-16140` **77a4c639e20bd44bd416d49bd4ba677052aff239**, Lab **31be3ad9267987f48778c2a4230d42fd9450447f**, 각각 commit/push 완료. 기존 PR354/50 유지·미머지. 웹 cdf311cfc 및 DEV 변경 없음.
- DL-17470: 기존 Home/Profile은 탭 전환, 알림은 중첩 native stack이고 safe-area는 바깥 전역색을 사용했다. 색상 갱신 타이밍 보정만으로 충분하지 않았으므로 양앱 ScreenSafeArea 추가, Root/NotificationNavigator screenLayout에서 화면별 top inset·배경을 함께 전환하도록 변경. 이전 NotificationSafeAreaBackground와 이동 직전/beforeRemove 색상 패치 제거. 루트 렌더 View의 -top margin으로 기존 외부 inset 중복을 상쇄하고 화면 안에서 한 번 적용. 기존 색상 매핑·애니메이션 및 DesignConfirmation의 동적 배경 유지. **루트 JS 화면 레이아웃에도 영향이 있으며 기존 화면 무회귀는 실행검증하지 않았다.** App.tsx·네이티브·의존성 변경 없음.
- DL-17482: 사용자 프로필 의견은 참고사항으로 취급. Office useProfileMarketing을 SMS/Email 채널별 독립 저장으로 변경, 같은 채널은 순차 처리·최신 대기 선택 유지. 선택 즉시 UI 반영, 성공 시 해당 채널 캐시만 갱신, 실패 복구 및 계정/새 입력 보호 유지. 모든 저장이 끝나면 확인 GET을 비동기로 수행하고 그 사이 새 입력이 있으면 오래된 응답을 버림. 프로필 Switch 터치영역 hitSlop10 추가, 이번에는 공통 Switch 애니메이션 변경 없음. Lab에 같은 프로필 기능은 없어 추가하지 않음. 알림설정 입력 차단 정책은 유지.
- 사용자 요청에 따라 테스트·lint·타입 검사·시뮬/에뮬 실행 모두 생략. 코드 읽기/편집/포맷·Git·배포 번들링만 수행. 기존 테스트는 수정/실행하지 않아 이전 저장 순서 기대값과의 정합성은 검증되지 않음. 수정 완료와 실기기 증상 해결은 구분한다.
- Staging 게시/활성화 완료: Office2.2.5 **iOS v351 / Android v350**, Lab1.0.6 **iOS v69 / Android v69**. 기존 `node scripts/codepush.js staging all --mute` 제품별 직렬 실행, history로 target/label/source 확인. Slack 쓰기·PR머지·DEV배포·웹변경·네이티브빌드 없음. Office 기존 isv.mp4 용량 경고는 게시 성공을 막지 않음.
- 사용자 확인: 새 OTA 적용 후 알림함↔설정, 알림함→홈/프로필의 상단색·인셋, Office 프로필 첫 클릭과 Texts/Email 빠른 번갈아 선택/저장 유지. 이번 루트 JS 레이아웃 변경으로 다른 기존 화면의 상단 여백 이상도 있으면 제보 필요. 실행검증이 없어 크래시/회귀 없음 또는 완전 해결을 보장하지 않는다.
- Jira 상태/댓글 변경 없음. 신규 DL-17488 및 실제 푸시 발송은 미착수 유지. 다음은 사용자 실기기 QA 피드백; 자동 추가 테스트/리뷰/배포/폴링 없음.

- 사용자가 QA 작업 브랜치 기준 웹 스테이징 재배포 완료를 보고했다. 앞선 release 정본 배포에는 DL-17471/17475 웹 수정이 빠졌으나, 이후 재배포 완료는 사용자 확인으로 기록한다. 에이전트가 재배포 이후 Actions/실화면을 다시 조회한 것은 아니다.
- 현재 QA 대상: 웹 Clinic·Lab 및 Office·Lab 앱 iOS/Android 모두 스테이징. 앱 게시 확인은 Office2.2.5 iOSv350/Androidv349(a099f6c6), Lab1.0.6 iOS/Androidv68(c153db1). 이제부터 Development는 그대로 두고 스테이징만 다룬다.
- 기존 QA DL-17470/17471/17472/17475/17477/17482는 해당 제품 구현·검증·푸시·STG배포 기준 Ready for QA에 해당한다. 최종 QA 통과를 뜻하지 않는다. 마지막 Jira 조회상 17470/17471/17482는 CHECK REQUEST, 17472/17475/17477은 READY FOR QA, 17474는 완료. 이번 마감에서는 상태/댓글을 변경하지 않았다. 사용자 요청 없이 모두 Done 또는 실제 상태가 이동됐다고 주장하지 않는다.
- 신규 DL-17488 [앱] 푸시 클릭으로 서비스 진입 시 알림 읽음 처리 안됨은 해야 할 일. 목록에서 존재/제목만 확인했으며 상세 조사·수정·배포하지 않았다. 사용자가 나중에 진행한다고 명시했으므로 보류.
- 기존 QA PR 웹4903·Office354·Lab50 유지. 추가 코드·배포·리뷰·폴링·기기 실행 없음. 사용자 스테이징 QA 및 실기기 배경색/스위치/프로필 연속 선택 피드백을 기다린다. 다음 재개는 사용자의 QA 결과나 신규 카드 처리 요청을 기준으로 한다.

## 2026-11-17 추가 QA 스테이징 CodePush 완료·웹 배포 포함 여부 정정

- 사용자 승인: 이제 Development는 그대로 두고 Staging만, PR 미머지 QA `feat/DL-16140` 기준 양앱 CodePush. Office a099f6c695ce149f4b1b134d67d605a8af28d8bf, Lab c153db1aaa201207209bec6a42732e2b18d954e1. 각각 원격 일치·clean, package/Android/Xcode 2.2.5/1.0.6 검증 및 이전 배포 대비 JS/TS만 확인.
- 게시·활성화 완료: Office 2.2.5 Staging iOS **v350**, Android **v349**; Lab 1.0.6 Staging iOS/Android **v68/v68**. 4건 mandatory=true, disabled=false, rollout100%, history 각 1회로 target/branch/SHA 확인. 기존 scripts/codepush.js staging all --mute 직렬 실행, Slack 쓰기 없음. Development·웹·PR·릴리즈·native 바이너리 변경 없음.
- DL-17470/17482 추가 수정 이제 Staging 포함. 직전 최종 코드 양OS 로컬 검증/테스트 재사용, 새 기기 실행 없음. 검증 범위 새 앱 크래시 미발견; 실기기 OTA 수신과 배경색/스위치/Office 프로필 연속입력 최종 체감은 사용자 확인. Office 기존 isv.mp4 크기 경고는 기존 force 옵션으로 게시 성공.
- 사용자 Jira 상태 확인 요청: DL17472는 사용자 승인에 따라 Ready for QA로 이동, 17475/17477은 조회 당시 이미 Ready for QA. 17470/17482는 작업·푸시 완료이며 미작업이 아니었음. 그 이후 사용자가 지라를 그대로 두고 의견만 요청해 추가 상태/댓글 변경 없음. 새로운 QA는 조회/작업하지 않음.
- **웹 정정:** 사용자가 웹 STG를 이미 배포했다고 하여 처음에 17471도 포함됐다고 답했으나 실제 대조 결과 미포함. origin/stage 56d96f97cb64cf46d858bea8ad40f1cd384914b2 (release/v1.94.0 -> stage PR4905)의 Clinic run44054600919·Lab run44054600971 성공. 그러나 해당 소스 USERS는 filters.user/User이며 QA의 catalog.general/General 변경 없음; 17475 otherEmployersLabel 수정도 없음. PR4903 OPEN·미머지. 웹 QA cdf311cfc는 별도 feat/DL-16140에 있음. 배포 성공과 QA 수정 포함 여부를 구분해야 함.
- 사용자에게 17471/17475는 앱 배포 완료·웹 배포 대기이므로 Ready for Deploy 의견 전달, 상태는 그대로 둠. 사용자가 웹 STG를 **QA 작업 브랜치 기준으로 다시 직접 배포**하겠다고 함. 이번 세션에서는 그 후 배포 완료를 확인하지 않았음.
- 다음: 사용자가 웹 QA 배포 확인 및 양앱 실기기 QA. PR354/50/4903 유지, 추가 리뷰/신규QA/배포 자동 진행 없음.

## 2026-11-17 추가 QA — 앱 스위치·프로필 응답·배경색 재보완 (미배포)

- 사용자 추가 제보: 웹 스위치는 해결된 것으로 보고 코드 흐름만 1회 확인 후 변경하지 않음. 앱 스위치 잔여 깜박임, 치과앱 프로필의 첫 클릭/연속 클릭 지연, DL-17470 알림함→설정 및 다른 화면 복귀의 상단색 지연을 다시 처리. 기존 QA 누적 PR 유지, 이번 추가 배포/머지 없음.
- Office `feat/DL-16140` **a099f6c6** (스위치·프로필 `5e76b3c`, 배경색 `a099f6c`), Lab **c153db1** (스위치 `e52efbb`, 배경색 `c153db1`). 모두 push·clean·origin 일치. PR354→release/v2.2.5, PR50→release/v1.0.6 본문 최신화, OPEN·미머지 유지. 웹 cdf311cfc 그대로.
- DL-17482: 양앱 Switch 기존 RN Animated를 유지하면서 위치/색상의 분리된 400/500ms 애니메이션을 단일 native progress 200ms로 통합. memoized interpolation, 기존 위치·크기·색상·초기 애니메이션 옵션 유지. 설치 RN의 NativeAnimatedAllowlist에서 color 지원 확인; 네이티브 파일·의존성 변경 없음.
- 치과앱 프로필: 기존 첫 클릭 draft는 즉시였으나 PATCH+확인GET/일반 isFetching 동안 다음 클릭을 버림. 사용자 추가 설명에 따라 입력은 즉시 받고 요청은 직렬화, 채널별 최신 대기 선택만 유지. 이전 완료/실패가 더 최근 선택을 지우지 않도록 보호. 확인GET, 실패복구, 사용자/서비스 변경 stale 보호 유지. Lab에 동일 marketing profile 화면은 없어 기능을 새로 만들지 않음. 알림설정 자체의 저장 중 입력차단은 유지.
- DL-17470: 기존 root navigationRef가 늦게 갱신될 수 있어 렌더 state 우선 및 내부 Notification navigator layout 연동. 이것만으로 Android 영상에서 약 1초 이상 지연이 남아, 기존 피드백 이력 c205fe07의 tabPress 선갱신 방식을 확인해 벨/설정 이동 및 beforeRemove 복귀에서 먼저 색상 갱신. 루트 색상 매핑·기존 전환 애니메이션 유지, App.tsx·전역 native/UI 구조 변경 없음.
- 사용자가 추가로 요청한 치과앱 크레딧/청구서 화면: 본문·헤더 흰색 유지, 홈/프로필 등으로 돌아가는 beforeRemove 경로 포함. 양OS `dentlink-dev://credit?employerId=86`, `dentlink-dev://billing/statement?employerId=86` 실제 진입·복귀 확인. 처음 production scheme으로 실행한 로컬 점검은 dev 앱에 연결되지 않아 수정한 테스트 경로로 재확인; 제품 랜딩 계약 변경 아님.
- 검증: Office 관련 Jest 2 suites/15 tests(지연·실패·연속 선택·계정 변경 포함) 통과, lint 오류0 기존 root 경고3씩. 타입 baseline/current Office6/6, Lab5/5 신규0. Office iOS/Android 프로필 두채널 변경·원상복구·화면복귀 후 값 유지, 양앱 알림함/설정/복귀 및 Lab LinkTalk off/on 복구 확인. Android 영상 /tmp/notification-color-final2.mp4·color-frames2.log에서 상단색이 늦게 따라오지 않고 이동 시작에 갱신됨 확인. 완벽한 실기기 체감 또는 실제 FCM QA로 확대하지 않음.
- 개발중 hook 구조 변경 Fast Refresh에서 render error가 있었고 앱 완전 재시작 후 최종 경로에 재발 없음. Android Lab은 스냅샷의 이전 실행이 남아 최초 화면 selector 실패, 해당 앱 종료·새 소스 연결 확인 후 양OS 검증 완료. 마지막 crash buffer에는 emulator Bluetooth 시스템 오류만 있으며 앱 native crash 미발견. 이 과정을 제품 크래시 해결 또는 실기기 무결함 보장으로 기록하지 않음.
- FCM 테스트 사용자 질문: 양앱 __tests__/utils/fcmHandler.test.ts는 알림센터 본체 Office0a131041/Labdfb3051에서 최초 추가, QA d77d8e5/db332cc에서 배너 대기분리 검증 보강. 사용자 기준에 따라 기존 변경 유지, 이번 추가 보완에서는 수정하지 않음.
- Jira 결과 댓글 DL-17470 **45124**, DL-17482 **45125** 추가. 상태/원본문 변경 없음. 이번 미배포 명시. 새 CodeRabbit 리뷰 조회/폴링 없음.
- 지침: 공유용은 결과+필요한 근거만 쉬운 말로 한 번에 복사; 불필요한 결론 반복 금지. 실제 연속입력 지연은 가상 트래픽 대비와 구분해 범위 내 대기 선택 처리 가능. 타이밍 QA는 최종 스크린샷만으로 완료 단정 금지. SESSION_WORKFLOW·DEVELOPMENT_STYLE 갱신 및 Claude 메모리 동기화.
- 다음: 이번 QA 커밋 배포는 사용자 승인 후에만. 새 버전 실기기에서 프로필 연속 선택·스위치 체감·알림함↔설정↔홈/프로필 배경색 전환 재확인. 현재 배포본은 Office75dd7fd6/Lab667dce2의 DEV/STG OTA 그대로. 이번에 연 검증용 Metro·기기는 종료하고 사용자 작업창/웹은 건드리지 않음.

## 2026-11-17 배포 후 사용자 QA 확인·결과 댓글 정리

- DL-17477: 사용자가 iOS·Android에서 팝업의 설정으로 가기→OS 허용 요청→허용 후 알림 설정 항목 생성/활성화를 확인했다고 보고. 해당 최초권한 경로 정상 처리로 판단. 사용자 직접 댓글용 문구만 제공, 이 카드에는 대신 게시/상태변경하지 않음. 어느 제품·OS버전까지 확인했는지는 추가 추정하지 않음.
- DL-17474: 제목을 [QA][치과·기공소앱] 포그라운드 푸시 배너 간헐적 미표시 점검·보완으로 변경. 원본문 유지. 댓글45121에 코드보완·DEV/STG배포 완료, 기존 채팅억제/중복방지 유지, 원래간헐증상 실푸시재현/중복수정과 연관성 미확인 명시.
- DL-17470: 원본문·제목 유지. 댓글45122에 상단배경색/수동새로고침 분리 수정·양OS로컬검증·DEV/STG배포 완료, 실기기최종확인은 별도라고 기록. 두카드 상태는 변경하지 않음.
- DL-17482: 사용자 실기기에서 스위치가 일부 개선됐으나 아직 완전히 해소됐다고 보기 어려운 추가 피드백. 1~3 정리부터 하고 세부증상은 다음에 알려주겠다는 지시로 **추가 조사·코드수정 보류**. 다음 요청에서 해당 QA 이어 검토, 완료로 단정하지 않음.
- 이번 작업은 Jira 제목/댓글 및 기록만. 코드·PR·배포 추가변경 없음.

## 2026-11-17 QA 브랜치 양앱 Development·Staging CodePush 완료

- 사용자 명시 승인: 릴리즈가 아닌 **QA feat/DL-16140**로 양앱 DEV/STG 모두 배포. 웹은 사용자가 배포할 예정이며 이번 실행에서 웹/PR/리뷰/머지는 변경하지 않았다.
- 소스: Office `75dd7fd69899e6bb9318352c196feceb0b7e03e5`, Lab `667dce2223fdae300dc7e4c0ad2028f93a92fd1b`. QA 수정6건 포함, clean·origin 일치. 릴리즈 이력 포함 확인(Office release/v2.2.5 대비0뒤/5앞, Lab release/v1.0.6 대비0뒤/5앞, Web release/v1.94.0 대비0뒤/2앞). 이 확인 이후 별도 최신 fetch/병합은 하지 않음.
- **게시·활성화:** Office2.2.5 Development iOS/Android **v149/v149**, Staging **v349/v348**. Lab1.0.6 Development **v48/v47**, Staging **v67/v67**. 8건 모두 mandatory=true/disabled=false/rollout100%, 해당 환경 history1회 조회로 branch+SHA+targetVersion 검증.
- 기존 scripts/codepush.js dev|staging all --mute를 OfficeDEV→OfficeSTG→LabDEV→LabSTG 순서로 직렬 실행. Slack 발송 없음. 제품/OS 공통 tmp 경합 방지. Office 기존 isv.mp4 용량경고는 기존 --force 옵션으로 게시 성공; 새 자산 변경 아님.
- 호환성: package/Android/Xcode 버전검증 통과. 직전QA 대비 native/package/lock/patch 변경0. 앞서 최종 코드로 완료한 양OS 설정·OS권한 검증과 관련 테스트 근거 재사용, 불필요한 반복 기기검증 없음. 게시 성공은 단말 OTA수신·실제푸시·최종QA 통과와 구분.
- 사용자 재확인: 새 OTA 적용 후 알림설정/프로필/MyOnly 스위치 떨림·색상, 최초OS권한 요청 및 설정복귀, 실제 foreground푸시 표시. 양앱 로컬검증에서 새앱크래시 미발견. 간헐푸시 원래증상 실제발송 재현은 아직 없음.
- PR4903/354/50 및 Jira 개발완료 상태 유지. 리뷰는 사용자가 나중에 처리할 예정이므로 이번조회/처리/폴링 없음. 네이티브 Fastlane·AppTester 업로드/스토어심사/운영배포 없음. 다음 사용자QA/리뷰/배포요청까지 대기.
- 별도 확인 질문: DL17208 가입체크박스는 폼값 즉시변경·가입제출시전송이므로 이번 switch애니메이션/저장중disabled색상과 별개. 앱프로필은 즉시draft·입력차단·실패복구이며 기존 관련테스트통과, 이번공통Switch수정 적용. 이 질문에서 추가 제품코드변경 없음.


## 2026-11-17 QA 6건 구현·PR 준비 완료 — 미배포

- 사용자 승인: 알림센터 QA(디자인 포함) 처리, 관련 범위 교차검토, 검증·커밋푸시·PR 완성. 배포/머지 금지. DL-17474는 코드 위험만 최소 보완, 실제 재현 없는 무한 조사 금지. DL-17482 및 Android STG 치과앱 설정 스위치 떨림 제보를 중간 추가. OS 권한 관련 테스트 보강 명시 허용.
- 코드/PR 모두 푸시·clean·remote 일치: Web `cdf311cfc` (92ade37da 포함) `feat/DL-16140` → release/v1.94.0 [PR4903](https://github.com/Innvoaid/dentlink-client/pull/4903) 신규. Office `75dd7fd6`(fa326d5,c57af4b,d77d8e5) 같은 QA브랜치 [PR354](https://github.com/Innvoaid/dentlink-app/pull/354) → release/v2.2.5. Lab `667dce2`(692355a,3e500b0,db332cc) [PR50](https://github.com/Innvoaid/dentlink-lab-app/pull/50) → release/v1.0.6. 세 PR OPEN/non-draft/MERGEABLE 확인; 리뷰 승인 또는 새 리뷰완료를 뜻하지 않음. 자동 리뷰 폴링 없음.
- DL-17471: 인박스 카드 USERS 분류 General/일반으로 웹·양앱 정정. 설정 User 탭과 별개. 크레딧/결제 특수분류 유지.
- DL-17472: 양앱 서포트 헤더 아이콘 mono600. Office 실제 홈 ChannelTalkButton까지 확인·수정(DentlinkSupportButton만 고치면 홈에 반영 안 됨). Lab 실제 홈 회색 확인.
- DL-17475: 치과 웹 배너가 모달 title을 쓰던 오류 수정, 웹·Office 배너 `Unread notifications at other offices.`; 모달 제목 유지.
- DL-17477: 양앱 공통 사용자 동작 시 최초 requestNotifications, 이미 거절/차단되면 기존 OS 설정 이동. Android12/13+ 구분, 최초 거절 뒤 불필요한 즉시 설정 이동 없음, native prompt AppState 변화 중복처리 방지. 권한만 허용한 banner/popup은 서버 수신값 자동변경 안 함, 선택 target이 있는 경우 그 항목만 반영. context/unmount stale callback 방지 유지. JS만 수정, native/dependency/build 변경 없음.
- DL-17474: fcmHandler foreground에서 pending/linkTalk summary invalidate 응답을 await하던 연결을 분리하고 실패 처리. 조회 지연/거절이 배너를 막지 않도록 테스트 확인. 현재 채팅 알림 억제, 이미 연 messageId 중복방지 유지. **실제 원격 푸시를 발송·간헐증상 재현한 것은 아님**; 실기기 FCM 재확인 필요.
- DL-17482: 양앱 공통 mid Switch는 OFF left3 / ON left0 변경과 native translate0→20이 겹쳐 켜질 때 3px 반대방향 점프. left3 고정·translate17로 최종 위치 유지, animateOnMount=false 초기값도 실제값 반영. Office 신규 회귀테스트가 기존 소스에서 실패·수정 후 통과. 해당 컴포넌트를 사용하는 My Only/프로필/알림설정 공통 적용. 웹 프로필 SMS/Email 저장 중 disabled 색상 변경을 제거하고 capture+기존 hook guard로 입력차단 유지. 웹 목록 URL필터 흐름은 유지; 모든 신고화면의 주관적 체감지연까지 실제 재현·완치 주장 금지.
- 검증: Office Jest8suite115tests, Lab6suite94tests, 웹Clinic22/Lab4tests 통과. 앱 변경lint 오류0(기존warning). 전체 앱타입은 baselineOffice6/Lab5 유지·추가0. 웹Clinic/Lab/Admin 타입 통과, 정상 push hook lint/단위검사 통과. shared UI 단독 root eslint는 기존 storybook plugin중복 한계. 실데이터 E2E 사용자 지시 제외 및 guardSKIPPED. 새 Storybook 없음, 번역Sheet/사용처메타 작업 없음.
- Runtime: 같은 QA source/Development로 제품별 iOS17Pro(iOS26.5)·AndroidAPI36 순차 검증. Office 양OS 설정 OFF→ON 복구, Android 최초허용창·배너제거 확인. Lab iOS 최초허용창→허용→배너제거, Android OS알림설정→권한허용복귀→배너제거 및 양OS 설정OFF→ON 복구. 저장계정/서버값 복구. 실제 STG 바이너리·OTA·원격FCM 검증으로 확대하지 않음. 테스트 도구 selector/한국어 버튼 선택 실패는 수정해 최종 flow통과; 앱 크래시로 보고하지 않음. Android crash버퍼는 Bluetooth시스템프로세스 기록뿐, 이번앱 crash확인 없음. 종료 시 이번 작업에서 시작한 Metro8081/8082·에뮬·시뮬만 종료.
- Jira 17471/17472/17475/17477/17474/17482 **Ready for Deploy(개발완료)**. 각 댓글45114~45119에 사용자 관점 결과·PR·미배포/검증한계 기록. 기존 원문/첨부/부모/SP 유지. Done/최종QA완료 아님. 기존17470은 앞선 배포 상태 유지.
- 현재 영향: 이번 추가6건은 모두 미배포. 기존 STG Office iOSv348/Androidv347, Labv66 및 Fastlane 바이너리 상태는 변경 안 함. 실기기에 아직 떨림이 보이는 것은 이번 수정 OTA 전 상태일 수 있음. 배포 요청 전까지 누적QA branch/PR만 유지.
- 다음: 사용자 검토/신규QA/명시 배포 요청 기다림. 배포하면 최초OS권한·설정복귀, 신고된 스위치화면의 체감과 실제foreground푸시를 재확인. 모든 제보화면 전수검수나 무한reviewpolling 없음. 밀링/기존카메라·사진 권한/본체외Home·email은 이번 QA 제외.


## 2026-11-17 치과앱 주문 상세 WebView 롤백 통합 완료

- 사용자 추가 지시: release/v2.2.5의 주문 상세 롤백부터 반영하고 기록된 알림센터 본체 미완 개발만 확인. 검증된 롤백 자체의 전수검사/긴 기기검증은 반복하지 않음. 네이티브 상세에 대응하려고 추가한 보완은 WebView 기준으로 정리.
- Office release/v2.2.5 `dd587043`(#352)을 feature/DL-17059에 통합, 충돌6곳 해결. 네이티브 orderDetail 디렉터리·전용 타임라인 유틸/OfficeTimelineDto를 제거하고 queries/service/types는 릴리즈 정본 채택. SVG index 재생성으로 알림 에셋 유지. OrderDetailScreen 및 관련 기존 테스트는 릴리즈와 동일.
- 알림에서 병원 활성화를 끝낸 뒤에는 WebView 상세가 같은 활성화를 중복 호출하지 않도록 준비된 경로만 내부 employerId 전달을 생략. 실제 URL과 BE/시트 값은 그대로. 준비하지 않은 링크 파싱은 employerId 유지. 읽음/소속검증/인박스복귀/실패보호 공통 로직 유지.
- 관련 WebView 상세·내비게이션·딥링크 3suite82tests 통과, 변경 lint 오류0, 전체 타입은 기존6개 진단 유지. 이 검증을 실제 기기/FCM/전체 QA로 확대하지 않음. 추가 기기 테스트는 사용자 지시로 생략.
- Office `8748a66d` 커밋·푸시, PR346→release/v2.2.5 본문 현재 WebView 기준 최신화·mergeable 확인. Web127b9b4f7/Lab9455c27 변경 없음. 배포/PR병합/CodePush 없음.
- 남은 개발 대조: 최신 API/권한·알림함/설정·소속/읽음·URL/푸시 deliveryId·OS 설정·배지 현행유지·이벤트·새 디자인 반영 완료. 현재 확정된 본체의 독립 FE 미완 개발은 발견하지 못함. 리뷰대기/병합/배포/QA는 개발누락과 구분. Home3건(DL17062/17065/17068)·이메일·배지개선은 별도. 과거 native-detail 대기 기록은 이 상태로 대체.

## 2026-11-17 최신 웹 릴리즈 통합·새 설정 디자인 반영 완료, 미배포

- **사용자 승인 범위:** 웹 최신 release/v1.94.0 통합/충돌 해결, 확인한 새 Figma를 웹·양앱 반영, 검증·커밋푸시·기존 PR 최신화·메모리. 배포/PR병합/CodePush 금지. 밀링은 릴리즈 정본, 알림센터 기능 유지.
- **최종 코드:** Web `127b9b4f7`(병합 `b9ab8ae4c`, 디자인 `5e6177e4f`, 기존 번역키 보완 `127b9b4f7`), Office `b2bb0946`, Lab `9455c27`. 각 기존 feature/DL-17058·17059·17060과 PR4862→release/v1.94.0 / PR346→release/v2.2.5 / PR42→release/v1.0.6 유지. PR 설명은 현재 범위·검증·미배포 중심으로 정리.
- **웹 통합:** release/v1.94.0 `4248a9e469`(master e03a72700/1.93.0 포함)을 실제 fetch·merge. 밀링 Production/Operation/관련 타입은 릴리즈 정본 그대로, 공통 상세 헤더는 정본 레이아웃에 알림 진입만 유지. data-contracts의 과거 MfgParameterInputDto 중복 정의를 제거하고 릴리즈 union 정의 및 알림 설정 DTO 유지. 해당 밀링 전용 경로의 릴리즈 대비 diff 없음. 밀링 자체 재개발/별도 QA 소유는 아님.
- **새 디자인:** 치과 웹·앱 Office/User 탭(기본 Office), User 안내, 병원명 PC 숨김/모바일·앱 표시, 범위 선택 위치·회색 설명·Assigned Orders, User Credit/Payment 문구. 기공소는 기존 단일 설정 목록 유지. 양앱 OS 안내 배너를 26px 아이콘·한 본문·기존 CTA로 압축. Lab 한/영 로컬 리소스만 갱신, 번역 Sheet 작업 없음.
- **계약 유지:** 탭은 표시만 분리. categories/channels의 서버 배열 순서 유지(디자인 예시의 Payment/Office Credit 순서나 PM 예시를 하드코딩하지 않음). channels[0] 상위·platforms/displayAuthorities·전체 PUT·다른 범위 값 보존·상위 전체 ON/OFF·즉시 표시/저장 차단/실패복구/확인GET·OS복귀 동작 불변. Assigned Orders 설명으로 기존 서버 선택값을 초기화하지 않음.
- **Figma 근거:** web637:28890(User),637:29261(Office), app626:28455/626:28483, OS안내642:28528/606:39212. 댓글2010620506/2010622582/2010624441과 제목 유지 후속2010625389 반영. 구 node167:24944는 현시점 찾을 수 없어 실제 새 프레임으로 대조.
- **검증:** 웹 관련41tests, Clinic/Lab/Admin 타입 및 정상 커밋/푸시 훅 통과(config49/hooks89/Admin guard9, lint 오류0·기존경고). 임시 외부 Chromium 하네스로 Office/User 분리·정확한 변경 대상·PC/모바일 병원명·Lab 탭 없음 확인. 제품 Storybook/임시페이지 추가 없음. 실데이터 E2E는 기존 사용자 지시로 SKIPPED.
- **앱 검증:** Office 설정/화면 2suite66tests, Lab 설정18tests·변경 lint 통과. iOS/Android를 제품별 같은 소스로 순서대로 실행, Office 실제 DEV GET 화면에서 양탭·병원명·범위 표시 확인. Lab 양OS 실제 설정 진입, OS OFF 새 배너 및 기존 Push 차단 표시 확인. Android Lab OS권한은 테스트 후 원래 허용으로 복구. 실제 설정 PUT/FCM/OTA/전체 기능 QA는 이번에 하지 않음. 전체 앱 타입은 기존 Office6/Lab5만 남음; 잘못된 Jest 인자로 실행된 전체 suite의 기존 native mock 실패는 별도이며 전체검사 통과라고 주장하지 않음.
- **실행 정리:** 이번 검증용 Metro8081/8082·headless Android·iOS simulator·임시 하네스 서버 종료. 사용자 직접 preview 요청 아님. Windows/사용자 브라우저 변경 없음.
- **배포/다음:** 이번 작업은 PR에만 반영, DEV/실기기 배포는 이전 상태 그대로. 확인한 새 디자인 대기 항목은 해소. 현재 요청 범위의 추가 FE 미완 없음. 이후 사용자 승인 시 배포/QA, 실제 새 리뷰가 오면 최소 범위 대응. 별도 홈·이메일·OS배지 개선 및 실제 발송/실기기 검증은 별개. Swagger 상위OFF 설명 정합성은 기존 문서 확인사항이며 신규 구현/API 대기로 확대하지 않음. 자동 리뷰 폴링/강제 리뷰 요청 없음.


## 2026-11-16 최종 마감·사용자 재개 대기

현재 구현분의 머지 전 FE 준비(기준브랜치통합/리뷰검토·수정·근거답변/resolve/검증/커밋푸시/기존PR본문정리)를 마쳤다. Webf6e1a86dc·Officef71ad0b0·Lab2f4c4f0 세 작업트리 clean, 원격추적대비0/0 확인. PR4862→release/v1.94.0, PR346→release/v2.2.5, PR42→release/v1.0.6 유지. 마지막 확인 기준 세PR미해결thread0(Web별도밀링은범위사유로닫은것이며코드해결주장아님). 최근 치과 리뷰영향10suite190tests통과, 실제기기전체QA/모든봇최종head승인으로확대하지않음.

사용자는 위범위가 준비되면 정리·브리핑후대기하도록 요청했다. 추가리뷰조회/자동폴링/코드수정/병합/배포/CodePush를 종료하고 새요청이 있을때만 재개한다. 최근 API·리뷰보완은 PR에만 있고 기존DEV배포는 그대로다. 다음 재개시 미배포분/새리뷰·기준브랜치변경 여부를 필요범위로 확인하며, 새설정디자인대조는 기존별도잔여로 유지한다. 사용자승인에따라머지·배포·QA를진행하고 자동진행하지않는다. 본체밖이메일/홈후속은별도.

## 2026-11-16 웹 별도 밀링 리뷰 범위 사유 답변·Resolve

사용자가 남아 있던 웹 PR4862의 별도 밀링 스레드도 이유를 남기고 Resolve하도록 명시 요청했다. PRRT_kwDOJnA7-8627lWn(원댓글4559061326)에 알림센터가 아닌 별도 밀링 작업/관련PR4866 범위이며 계약·실응답 확인사항은 기록을 유지한다는 댓글4585309703을 작성하고 Resolve=true를 확인했다. 코드수정·실제동작검증으로 결함이 해소된 것이라는 표현은 하지 않았다. 변경 전 웹 미해결은 이1건뿐이었으므로 처리 후 웹도 미해결0. 기존 치과/기공소 마지막 확인도0이나 두앱을 추가조회하지는 않았다. 제품코드/병합/배포/추가폴링없음. 이전의 ‘밀링1건 미해결유지’는 이사용자최종요청으로대체된다.

## 최신: 치과앱 리뷰 대응·제한된 회귀 재검토 마감 — 2026-11-16 20:43 KST

- **최종 사용자 범위:** Draft 해제 이후 리뷰 대응 코드를 기존 기능에 문제가 없도록 안전하게 정리. 이미 올린 대응분도 실제 사용 흐름으로 재검토하되 새 기능/정책/무한 개선·폴링은 제외. 타당한 리뷰는 최소수정, 미적용은 근거답변 후 resolve. 사용자 최종 마감 지시에 따라 다음15분조회 예약 취소, 상시자동화 없음.
- **Office 완료:** `f71ad0b0977be1497024fdcc9ed96d1373486606` 커밋·푸시/clean·원격일치. PR346→release/v2.2.5 유지·본문최신화. 마지막20:42조회에서 미해결reviewthread0, 새의견추가없음. 봇의최신head전체재검토완료나인간승인으로확대하지않음.
- **수정:** URL 후보/실제 주문상태 처리의 병원ID 일치, 초기/일반 중복링크 소속구분·쿼리생략재전달, 사용자변경후이전pendingURL반영차단, 저장소읽기실패의큐보존(Error/non-Error), OS복귀ref의커밋이후갱신. 기존OS OFF선택→설정안내정책은유지했고반대제안은근거답변후Bot철회. 신규native/새UX/새정책/주문상세본체변경없음. 공통asyncStorage.get은non-Error도errorHandler로전달하는1줄만수정.
- **누락과 재검토:** 중간매처수정에서후단의단독후보재해석을같이맞추지못한불일치가있었음. 실제구handler에서주문ID가병원ID로store에쓰이는실패를재현하고전체후보를공유하도록수정. 저장소예외도실제래퍼를통과시켜검증. 이기록은‘모든수정이처음부터완전했다’는설명이아님.
- **최종 검증:** Draft전환후현재까지리뷰영향경로(링크/소속전환·유지/계정변경/읽음큐/설정캐시·권한/OS안내/인박스)를묶어10suite190tests통과. 정상교차소속6종과읽음실패→재시도성공회귀추가. 화면테스트fixture2곳에이미확정된displayAuthorities가빠져있어5건실패하던것을데이터만최신계약으로정정;기대동작/제품UI는변경하지않음. 관련lint오류0(실소스기존경고),diff검사통과. 전체타입은기존범위밖6진단;최종코드전체타입통과라하지않음. 실제기기/FCM/APNs/전체QA는이번에반복하지않았으며이단위·통합hook검증을실기기증거로표현하지않음.
- **다른제품/배포:** 이번15분사이클은Office만. Webf6e1a86dc/PR4862→release/v1.94.0, Lab2f4c4f0/PR42→release/v1.0.6 유지(새조회/수정없음). 기존Web밀링1스레드는명시별도소유. 세PR병합·개발배포·CodePush없음. 최근준비코드는PR에만있고기존DEV배포그대로.
- **다음:** 현재달린치과리뷰는수정/근거답변및resolve완료로이번회차종료. 새설정디자인대조는기존별도잔여이며이번리뷰작업과합치지않음. 사용자의새요청/실제새리뷰가있을때해당범위만재개. 자동추적없이대기.

## 2026-11-16 20:37 치과앱 후속 리뷰 대응(최종 확인 대기)

- 사용자는 치과앱 PR346만15분간격으로 확인/처리하도록 재승인. Web/Lab PR 조회·수정·배포는 이번 사이클에서 하지 않음. 장기 자동화 없음.
- 20:17조회에서 새review6건 발견. 5건 수정, OS OFF의 PUSH off변경 허용제안1건은 기존확정UX(OS안내→허용복귀선택ON, 취소PUT0)와달라미적용답변resolve. Bot도철회확인4585078232.
- Office commits3a99fc8/642850b/cf272274/753daa77/be54b38/b44707e9 모두푸시, PR346본문갱신. 최신b44707e9. 경로·쿼리혼합시단일주문ID를병원ID로오해석하지않도록후보우선순위/실제주문상태처리연결; legacy단일주문경로의선택적employerId도검증. 일반이벤트의쿼리생략재전달dedup, 로그인사용자변경후이전pendingURL반영차단, pending읽음큐저장소읽기실패시보존, 권한복귀ref는커밋이후갱신.
- 20:32확인시resolvedthread내추가의견2건(실제주문상태처리에서단독후보재해석/저장소non-Error예외)을추가검증·보완했다. 최종관련5suite119tests통과, lint오류0(기존경고),전체타입은이전6건만. 실제handler구코드에서employerId=7000006403쓰기실패재현→최종통과. non-Error는실제asyncStorage래퍼를통과시켜set/remove0검증. native변경없음/기기전체QA재실행없음.
- 사용자우려에답변: 리뷰를무조건반영하지않음. 중간matcher수정에서실제후단사용처와불일치가남은것은확인범위누락이며후속에서고쳤다. 최종테스트통과를모든실기기/원래기능무영향보장으로확대하지않음. 수정헬퍼뿐아니라실제소비경로와예외분기를함께검증해야함. 현재코드를고정하고새로운실제결함만최소보완; 개선제안으로범위확장안함.
- 공통asyncStorage.get의non-Error도errorHandler에전달하도록1줄수정; set/remove/clear의미·네이티브·정책은변경없음. 이사용처필요최소JS수정임을명시.
- 다음20:47치과PR만15분간격확인예약(인턴타이머),새리뷰없으면완료. 머지·배포없음. 새디자인대조는별도기존잔여이며이번리뷰완료와합치지않는다.

## 최신: 현재 달린 리뷰 처리 완료·추가 폴링 중단 — 2026-11-16 밤

- 사용자 최종 지시: CodeRabbit 리뷰가 없으면 굳이 기다리지 않고 넘어간다. 새로 달린 리뷰는 처리하되 봇 응답 부재를 PR 준비의 미완료 사유로 잡지 않는다. 예약 중이던 다음 10분 조회를 실제 취소했고 자동화/상시 모니터링은 만들지 않았다. Lab 연결 여부 질문도 더 이상 진행 차단 조건으로 삼지 않는다.
- **Web f6e1a86dc / PR4862→release/v1.94.0:** 최신 head 리뷰 완료 근거 확인. displayAuthorities 누락 시 숨기는 동작 지적은 실제 Swagger/권한 가드·PUT 값 보존·기존 테스트 근거로 답변하고 resolve. 알림센터 미해결 리뷰0. 기존 밀링 FILE START 미해결1건은 사용자 지정 별도 소유이므로 임의 수정·resolve하지 않았다.
- **Office d6856f3e / PR346→release/v2.2.5:** 초기 링크의 경로만 비교해 다른 병원 credit 링크까지 무시하던 문제를 cfc5fc66/d6856f3e에서 수정·푸시. 같은 병원 및 SDK가 쿼리를 생략한 중복 재전달 방지는 유지. 기존 코드에서 회귀 실패 재현 후 최종 관련2suite44tests/lint 통과. PR본문/리뷰 답변 갱신, 현재 미해결thread0. 최신 full review는 마지막20:02조회에서 진행 중이었고 최종head 검토완료로 표현하지 않는다. 새 리뷰가 실제 달렸을 때 대응한다.
- **Lab 2f4c4f0 / PR42→release/v1.0.6:** 기존 리뷰 처리 상태 유지. review/full review 요청에 봇 응답/실행 근거가 없어 새 리뷰 없음으로 기록한다. 봇 검토 완료/연동 해제라고 추정하지 않는다. 사용자 지시로 추가 확인·대기 없이 넘어간다.
- 최신master/main·각release는 이번 재개 시 이미 포함됨을 확인했다. 세 PR은 정식 상태/기존 target 유지, 제품변경은 Office 위 보완뿐. 네이티브변경·전체기기QA반복·PR병합·개발배포·CodePush 없음. 기존 DEV 배포는 그대로다.
- 현재 달린 알림센터 리뷰 대응은 완료. 리뷰 준비와 실제 승인/병합/배포는 구분한다. 기존 새설정디자인 대조·후속범위는 이번 리뷰 작업에 포함하지 않았고 완료로 확장하지 않는다. 재개 시 새로운 실제 리뷰나 사용자 요청만 필요한 범위로 처리한다.


## 2026-11-16 19:53 리뷰 재개 체크포인트(진행 중)

- 사용자: PR3개 머지 전 준비, 지금조회 후 필요시10분간격만 확인. 실제머지/배포금지. 최신master/main·각release 포함확인, 추가통합불필요.
- Office cfc5fc66/d6856f3e 커밋푸시: 초기 credit 링크 중복판정에 병원ID 추가. 명시적으로 다른ID면처리, 같은ID/SDK의ID생략재전달은기존중복방지유지. 기존코드회귀실패재현→최종44tests+lint통과. JS조건변경·기기전체QA반복없음. 기존thread 답변및PR본문갱신.
- Web f6e1a86dc 최신리뷰완료. displayAuthorities 누락노출지적4584764227은Swagger선택메타/권한없으면미노출·PUT보존이라는명시처리및회귀검증근거로답변resolve. 기존밀링FILE1건은별도소유유지.
- Office full review요청은추가보완push중head변경으로중단, d6856f3e최종고정후재요청6914378977. 20:02경10분후1회조회예정(인턴타이머이며자동화아님).
- Lab2f4c4f0은review/full review요청모두bot응답/체크없음. 실행·완료추정금지. 사람기존리뷰resolved이나현재head승인아님. 봇연동원인확인안됨, 불필요재요청반복안함.
- 현재3개모두리뷰완료로단정하지않음. 새디자인대조반영·기존별도항목과실제배포/QA도분리.


## 최신: Swagger 권한 노출 후속 완료·미배포 — 2026-11-16 저녁

- **완료:** Web `f6e1a86dc` / Office `39b8629b` / Lab `2f4c4f0` 커밋·푸시, 각 작업 트리 clean·원격 동일. 기존 정식 PR4862→release/v1.94.0, PR346→release/v2.2.5, PR42→release/v1.0.6 유지·본문 최신화. Jira17415/16/17 본문을 실제 계약명으로 정리했으며 상태 해야 할 일·SP 불변(새 디자인 대조·반영 별도).
- **계약:** 최신 DEV Swagger의 실제 키는 category `displayAuthorities`이며 기존 협의명 configurableAuthorities가 아님. OWNER/PAYMENT_MANAGER/EDITOR/MEMBER와 현재 소속 프로필 권한을 대조해 노출/변경을 제한한다. 누락·빈 권한목록은 미노출, 손상메타는 응답실패. 숨긴 카테고리는 전체 PUT에 기존 값 보존, readonly 메타는 저장값에서 제외하고 낙관 표시에는 유지한다. 첫채널 상위·전체ON/OFF·OS안내·확인GET 등 기존흐름 불변.
- **검증:** Web 관련57 + 정상훅 config49/hooks89·Clinic/Lab/Admin타입·lint 통과. Office 관련61·lint, 실제DEV GET OWNER8항목/mapper일치 및 다른권한fixture 확인. Lab 관련50(타입보완후영향23 재통과)·lint. 앱 전체타입은 기존Office6/Lab5만 남음. 순수노출/저장가드 변경으로 전체화면·기기검증 반복 안 함. 실제모든권한계정·FCM·실기기QA로 확대하지 않음.
- **현재 영향:** 변경은 feature/기존PR에만 있고 배포·CodePush·PR병합 없음. 이전 DEV 배포 유지. 신규네이티브/라이브러리/불필요한테스트파일 추가 없음.
- **다음 재개:** 사용자는 새 자료 제공을 알렸으나 이번은 Swagger 우선범위. 새설정디자인 대조/반영은 별도. 내일 요청 시 새 CodeRabbit/개발자리뷰 대응; Office cold-start 다른병원credit링크 중복판정 추가의견1건도 포함. 새리뷰·Swagger자동조회/재요청/폴링 없이 오늘마감·대기. Swagger 하위값보존 문구와 사용자 전체ON/OFF 합의 차이는 기존확인사항으로 유지.


---
name: 통합알림센터 11/16 현황 확인
description: 웹·양앱 정식 PR 전환 및 최신 기준 통합 완료, 미배포·리뷰 승인 대기
type: project
---

2026-11-16 사용자 최종 변경: 앱 코드 변경마다 시뮬/에뮬 검증을 필수로 반복하지 않는다. 최초 기능 개발·사용자 요청·크래시/랜딩/권한/네이티브 등 구체 위험이 있을 때 필요한 범위만 실행한다. 저위험 리뷰/타입/문구 정리는 관련 테스트·정적검사 중심이고 미변경 동작의 기존 근거를 재사용한다. 단순 SHA/PR base 변경만으로 기기 재검증하지 않는다. 기존 공통 지침의 일괄 필수 문구를 정본에서 교체했고 제품코드/배포 변경은 없다. 이번 준비는 마감, 추가 리뷰·BE 후속 대기.

## 최신: 릴리즈 추가분 통합·리뷰 보완 완료, 추가 리뷰/BE 대기 — 2026-11-16

- **완료:** Web `fed97af3f`(release/v1.94.0의 f0e180fe0 포함), Office `ef29e3e6`(main851c7889·release/v2.2.5 b1121e72 포함), Lab `916610e`(main/release/v1.0.6 a6e18282 포함) 커밋·푸시. 기존 정식 PR4862/346/42 대상 유지·본문 최신화. 사용자 추가 웹/Office 마케팅 수신 동의 통합, 기공소 최신 기준 포함. 릴리즈 PR 병합·배포·CodePush 없음.
- **리뷰 보완:** Office 새 inline6건 수정·답변·resolve. 실패 푸시 읽음 큐 보존, 읽음 후 settings 재조회 제외, 소속 전환 중 직원 조회 보존, 지연 주문조회 탐색 가드, 소속별 금융 랜딩 중복 구분, 크레딧 날짜 시간대 일치. Lab은 공통2건(읽음 실패 큐·설정 재조회)만 맞췄다. 주문상세 본체/기존 상세 테스트·밀링은 별개 소유로 유지.
- **검증:** 웹 알림59+정상훅(type/lint/config49/hooks75), Clinic PC/모바일 실제 프로필·알림 설정 공존 확인. Office 영향 기존60+외부35, Lab14 tests. Office2.2.5/Lab1.0.6 양OS 최종JS에서 관련 화면·랜딩·재시도 검증, LogBox0. 기존 타입오류 Office6/Lab5는 그대로이며 전체타입통과로 표현하지 않는다. 실제 FCM/APNs·OTA·전체 QA는 별도.
- **현재 리뷰 상태:** Web은 수동1회 요청 후 Review triggered, 결과 재조회하지 않음. Office 기존6건 해결 후 수동1회 요청은 Incremental review skipped(봇: 이미 검토한 커밋은 재검토하지 않으며 review 명령은 자동 리뷰 일시중지 때 적용); 최신 head의 별도 새 리뷰 완료로 단정하지 않음. Lab은 요청1회 후 봇응답 미확인. 요청/진행과 완료 구분, 무한 폴링 없음. Web 기존 밀링FILE 미해결1건은 범위 밖 유지.
- **다음:** 사용자는 추가 CodeRabbit 결과와 BE 후속이 남음을 알고 이번 준비를 마감하도록 했다. 재개 시 현재 head/리뷰를 한 번 확인해 유효한 새 지적만 처리하고, 사용자 전달 BE 명세·새 설정 디자인을 해당 범위에 반영한다. 현재 알려진 이유만으로 양앱 대규모 재수정/전수검수를 반복하지 않는다. configurableAuthorities는 사용자가 현 범위에서 제외했고 새명세 안내 후 대응. 본체외 Home·이메일·OS배지 개선은 별개. 자동 조회·병합·배포 없이 대기.

**2026-11-16 18:29 KST CodeRabbit 상태 확인(읽기 전용):** 사용자 질문은 진행 여부·확인 위치이며 새 리뷰 실행/설정 변경 승인이 아님. Web4862 최신558a36df0의 commit status는 success이나 description은 **Review paused**, 봇대표댓글6759115058도 최신커밋미검토로표시. 오늘11:14완료된수동증분review는a67e1e2대상이라최신검토로합치지않는다. Office346은대표댓글6759052807의 ‘Currently processing new changes’와851c7889~987dbdd3범위로최신head검토중확인(댓글18:17:42갱신); 완료submission은0. Lab42 최신dbcd1ad는CodeRabbit댓글/리뷰/status/check모두없어진행근거없음; combinedpending은statuses0이라실행중증거아님. GitHub목록초록체크는검토완료보장이아니며CodeRabbit댓글과status description을확인. **정식PR준비완료와봇리뷰완료를구분.** 웹은리뷰재요청,Lab은연동/실행여부확인이후속후보이나이번엔변경/댓글/폴링없이상태만보고했다.

**2026-11-16 웹·양앱 정식 PR 준비 완료(미배포):** 사용자 승인으로 [웹4862](https://github.com/Innvoaid/dentlink-client/pull/4862) → `release/v1.94.0`, [Office346](https://github.com/Innvoaid/dentlink-app/pull/346) → `release/v2.2.5`, [Lab42](https://github.com/Innvoaid/dentlink-lab-app/pull/42) → `release/v1.0.6` 모두 Draft 해제·DRAFT라벨/[WIP]제거·본문최신화했다. 새 기준 변경도 승인에 따라 반영: Web `558a36df0`(release3852aca7f통합), Office `987dbdd3`(main851c7889변경없음), Lab `dbcd1ad9`(새main/release a6e18282통합). 세 제품 clean·원격일치·PR충돌없음. Lab의 생성타입 충돌은 기검증 새설정DTO와 main밀링isRemake계약을 각각 보존해 해결했고, 양OS실제설정GET/렌더를 짧게 확인했다. Web관련59tests 및 정상훅의3서비스타입/lint/tests, Lab76tests/lint/기존TS5유지. 전체검수는반복하지않음. **정식리뷰준비와리뷰승인/병합/배포는별개이며이번병합·배포·CodePush없음.** 웹기존밀링FILE리뷰1건은범위밖으로강제resolve하지않음. 추가리뷰/기준코드변경이생기면해당영향만검토;자동폴링없음. 상세는 11/16 재개기록 마지막 「정식 리뷰 PR 전환·후속 기준 브랜치 동기화」.

**2026-11-16 양앱 최신 main 통합·릴리즈 PR 준비 완료(미배포):** Office `feature/DL-17059@987dbdd3`에 main851c7889, Lab `feature/DL-17060@27032b4`에 main691c012를 병합·충돌 해결·커밋푸시했다. 양앱 clean·원격0/0. 기존 [PR346](https://github.com/Innvoaid/dentlink-app/pull/346)은 `release/v2.2.5`, [PR42](https://github.com/Innvoaid/dentlink-lab-app/pull/42)는 `release/v1.0.6` 대상으로 변경했고 Draft/DRAFT/[WIP] 유지·본문 최신화했다. 양앱 iOS/Android 신규 빌드, 실제 DEV 인박스/읽음/상세/뒤로/설정 원복과 관련 OS 안내를 검증했다. Office는 기존 `dentlink://order/{employerId}/{orderId}` 그대로 native 상세 연결(시트/BE URL 변경 불필요), Lab은 WebView 유지. Office의 교차소속 진입 시 이전 상세 조회로403/로그아웃 및 정상 인박스 재마운트 오판을 재현해 **알림 연결부만** 보완했다. 상세 화면·기존 상세 테스트는 main 그대로이고 최소 타입 충돌만 해결했다. 관련 테스트 Office159+외부회귀21/Lab76 통과, 전체tsc 기존6/5 및 주문상세 native mock 제약은 별도 기록. main의 네이티브 패치는 수용했으나 main 대비 새 native/package 차이 없음. **배포·CodePush·PR 병합 없음**. 기존DEV2.2.4/v147 및Lab1.0.5/v46·v45 불변. 새설정디자인·명세후속과 이후배포/실기기QA는 분리하며 추가자동작업없이대기. 정본 projects/dentlink-unified-notification-center-resume-2026-11-16.md 마지막 통합 섹션 참조.

**2026-11-16 사용자 후속 결정 — configurableAuthorities 제외:** BE가 실수로 누락했다고 사용자에게 전달했고, 사용자는 이 키를 우선 현재 작업 범위에서 제외하라고 했다. 현 Web/Office/Lab 코드는 해당 키를 사용하지 않으므로 코드 추가 수정은 없다. 기존 권한 제한은 유지하며 기능 완료·배포의 필수 대기 조건으로 분류하지 않는다. 사용자가 수정된 명세를 알려주면 그때 후속 반영한다. 자동 Swagger 조회·BE 재질문 없음. 새 디자인 후속 및 별도 상하위 설명 정합성 확인은 그대로이고 배포 금지도 유지한다. Jira17415/16/17의 작업 정의와 기존 PR 설명에서 현재 미완료 사유처럼 보이는 부분만 정리한다.

**2026-11-16 새 알림 설정 API 연결 완료·미배포:** 사용자 승인으로 Web Clinic/Lab `3878e774f`, Office 앱 `91b8531b`, Lab 앱 `cfa1022`에 새 channels 계약을 연결했다. 원본 첫 채널 상위·platforms 노출·값만 전체PUT·같은category 전체ON/OFF·타영역 보존·즉시표시/실패복구/확인GET·OS안내/이벤트를 대응했다. 기존 PR4862/346/42 유지, 배포 없음. 웹 실제양서비스와 양앱 양OS의 실제 GET/PUT·원복 확인, Android양앱 OS권한거부/복귀 확인, 새 앱크래시 없음. 관련tests43/73/22통과; 앱전체tsc는기존6/5진단. `configurableAuthorities`는 명세/실응답에 없어 기존권한 유지하며 제공시연결; 새디자인 후속. Lab현계약은 user빈목록·scope없음으로UI임의추가없음. Swagger의하위값보존설명과사용자확정전체ON/OFF는문구정합성확인만남김. Jira17415/16/17은완료기능댓글+남은디자인/권한정보때문에해야할일. 이번일반작업스타일(권장안/이유/필요한선택협의,승인된실행반복질문안함)을공통지침·Claude메모리에반영. 정본 projects/dentlink-unified-notification-center-resume-2026-11-16.md 새API연결 섹션 참조.

11/16 16:00 KST Jira정리완료: 사용자승인으로 DL17415웹/17416Office앱/17417Lab앱 제목·본문만 새설정계약 범위로갱신. 모두해야할일, SP쓰기없음·전체customFields/담당자/parent 재조회동일. Swagger먼저기존UI GET/PUT·channels상하위·platforms/configurableAuthorities연결, 새디자인후속. Office개인/병원영역, Lab개인영역없음·수신범위계약확인. 새계약미구현/기존미배포보완유지. 제품코드/PR/배포/상위댓글변경없음. 사용자Swagger안내까지자동조회없이대기. 정본16:00기록참조.


11/16 15:49 최종대기: Swagger사용자안내후새계약FE연결/검증시 user/employee모두서버항목·순서+platforms/configurableAuthorities노출기준으로기존UI표시/저장가능. 옛toggleChannel숨김은교체,문구FE매핑활용. 디자인은개인/병원구역구성마무리이며데이터연결공동선행조건아님. 서버배포만으로현코드자동대응아님. 지금구현/배포/자동조회없음,기존미배포보완/PR유지. 정본15:49기록참조.

11/16 15:35 최종대기정정: 현재추가FE구현없음(기존미배포보완유지). 기다릴것은알림설정새디자인과새GET/PUT계약두가지. **둘을함께기다릴필요없고Swagger가먼저면기존user/employee카드UI로데이터연결부터가능**, 디자인은개인/병원영역제목·설명·배치마무리. 개인알림발송/읽음/집계는BE처리·추후검증이지세번째FE개발대기로넣지않음. Lab범위도같은설정계약확인. 필터분리완료/본체외범위분리. 새Swagger/디자인사용자안내전구현·배포·자동조회없음. 정본15:35마감참조.

11/16 15:20 KST Slack4개동기화조사만: 부모4+답글53끝까지·첨부3이미지·현웹양앱대조. UserCredit제외→포함방향변경,11/23포함목표이며개인/소속영역새UI는아직FE없음(매핑/user→employee순서는기존). Lab개인알림없음. PM13:26개인알림인박스unread포함/다른소속제외확정;FE각서버카운트직접사용기존구현. 조회필터/알림설정분리는기존완료. Mina15:12치과Member조회·알림내주문고정,LabMember알림담당or책임고정·조회는기본본인필터해제해전체가능. Lab현재앱알림orderScopeUI없고웹hostauthorityType미전달이라서서버선택지추가만으로UI나오지않음;새정책/명세에따른FE후속판단. Kyle등담당자필터작업은별도,그브랜치완료여부미검증. PM은StudioQA용PRD정정+Notion정본이동예고;user_push_setting/CasePreference/idempotency등옛문구로코드변경금지. 최신Artifact본문접근불가,Slack첨부Lab설정과정책표만확인;Notion/Sheet/최종Figma전체확인아님. Swagger사용자안내대기/새구조미구현/기존미배포상태유지. 정본resume문서'지정Slack4개동기화'근거/제약참조.

11/16 15:12 KST 최신 방향(이전 toggleChannel 유지권고보다 우선): 사용자 BE 역제안은 category.enabled/toggleChannel 제거, channels[0] 상위·나머지하위, 모든channel에enabled/platforms. NOTIFICATION이정식예시키. 단독PUSH도첫channel로OS처리가능. 원본첫순서고정·GET전체보존+UI필터·숨긴항목포함전체PUT·부모변경시같은category자식전체연동·다른category/scope보존. 기존user/employee/orderScope/권한유지. configurableAuthorities:[ADMIN,MEMBER] 권한별노출추가예정; 적용위치/누락/role대응은최종Swagger대기. DL16140#45070공유는사용자보고(원문재조회안함). **지금메모리만,사용자가Swagger알려주기전구현/배포/자동조회금지.** 기존Web8374225c1/Officee8ee7018/Lab27a521f clean·추적원격0/0,최근보완미배포. 구구조가현재코드이며새계약구현완료가아님; 재개시타입/GET/PUT/OS/이벤트영향검증. 정본11/16재개기록의설정새구조섹션참조.

11/16 추가 조사(제품 수정 없음): toggleChannel은 GET readonly 상위 채널 메타. 양앱 상위PUSH OS권한/안내 및 웹앱 분석에 필요, PUT은제외·parent/child cascade무관. 웹은 PUSH카테고리전체숨김에도 임시사용(하위MAIL까지숨김위험); 앱노출필터에는사용안함. **DEV Swagger CategorySettingDto에 platforms(WEB/APP)[] readonly 신규존재 확인**, 현웹/양앱DTO·코드미반영. DL17114 댓글44994 새답변은없음; 실제인증GET의platforms값/생략정책은이번미검증. 다음구현승인시실응답대조후platforms노출분리, toggleChannel은OS/분석용유지. 이신규명세발견은아래FE완료체크포인트이후후속. 현재Web8374225c1/Officee8ee7018/Lab27a521f clean, 배포없음. 상세정본 projects/dentlink-unified-notification-center.md 최상단.

11/16 최종 사용자 마감: 웹·양앱에서 현재 확정된 본체 범위의 배포 전 FE 보완 완료. Web8374225c1/Officee8ee7018/Lab27a521f clean·원격0/0 재확인. 기존 PR 유지, 최신 보완 미배포. 사용자 재요청 전 배포/추가개발/자동조회 금지, 대기. 배포 후 QA·기존 BE/디자인 별도 확인을 완료로 합치지 않음.

최신 후속: 사용자 승인으로 양앱 employeeId 누락 보완 완료·미배포. Officee8ee7018/Lab27a521f 원격일치clean, PR346/42 유지·본문최신화. ID 우선/생략때만 employerId가 일치하는 유일한 기존 소속으로 연결, 모순·중복·미소속 제외. OfficeJest26/Lab27, Lab 소스경계13, 실제 최종 양OS 화면에서 Office8/Lab10조건씩 fixture·대상 ID 전달·전환 실패복구 확인. 실제 누락 응답/서버전환성공 증명 아님. Office실가입소속·Lab추가소속fixture, 서버쓰기0·fixture원복·LogBox0·앱crash없음. typecheck는기존6/5오류. 네이티브/권한/전환API변경없음. 자체기기/Metro종료. Web8374225c1도미배포이며 DEV기존그대로;다음승인된배포/QA대기. 아래 앱미수정 기록은 승인 전 이력. 정본의 양앱 소속 ID 누락 후속 섹션 참조.

- 조회전용: Weba67e1e215/Officea6ee48c7/Lab2c638fa 원격동일clean,PR4862/346/42 OPEN Draft유지. 제품코드/PR/Jira/배포/기기변경없음.
- WebDEV7c8eef28c 양Actions success1회확인;최종Messages/스타일정리미배포. OfficeDEVv147both(target2.2.4),Labv46iOS/v45Android(target1.0.5),history최신source일치·활성. 실기기QA새로안함.
- Jira22건=ToDo10/개발완료11/완료1,11/13이후변경없음. BE44994/45009 후속답변없음. PM45036은11/17STGQA예정,fixVersion1.94.0/11월23일unreleased.
- Office native상세ca259592/PR341은release/v2.2.5에포함,main/알림feature미포함. 1.93배포완료단정금지,DL17436유지·치과만대상.
- PR본문3건전달기록은후속사용자승인으로최신화완료. 본체외Home3/배지2/별도E2E와설정계약3분리. 번역시트후속없음.
- 정본: codex-personal-context/projects/dentlink-unified-notification-center-resume-2026-11-16.md. 자동배포/폴링없음.

- 후속 완료: 웹4862·Office346·Lab42 본문만 최신화/재조회. 최신 DEV 라벨·즉시 반응/실패 복구·실API 확인 GET·최종 검증/실기기 QA 경계 반영. 제목/base/Draft/head 유지, 제품3개 clean·배포/Jira/Notion 변경 없음. 현 DEV로 기능 QA 유지, 웹 a67e1e215 미배포·앱 추가 CodePush 불필요. PR 설명은 남은 일 아님. 기록 후 자동 배포/감시 없이 대기.
- 웹 CodeRabbit 후속 완료: paused 상태에서 일회성 review 요청 후11:14 KST 새4건. Web8374225c1에서 저장성공 전 stale조회취소+문맥재검사, inert후focus안전복원, disabledDropdown닫힘, 선택employeeId생략시유일한기존employerId매칭 보완·푸시. 관련49tests/Chromium11조건/type3서비스/정상push훅 통과. 새4건 답변·resolve, 밀링FILE1건은범위밖유지. PR본문미배포보완명시, DEV7c8eef28c와양앱DEV불변. 앱도employeeId생략경계는읽기전용확인됐지만실제누락응답관측아님/코드미수정, 다음앱작업시대조후속. 정본 후속 섹션 참조.

## 2026-11-17 재개 동기화·PR 리뷰 일회 확인

- 사용자 범위: 동기화 후 웹·양앱 새 리뷰를 한 번만 조회하고 머지 전 남은 것 보고. 코드수정·머지·배포·폴링 없음.
- 개인 정본 및 세 feature pull --ff-only 완료. 모두 clean/추적원격0:0, head는 Web f6e1a86dc / Office f71ad0b0 / Lab 2f4c4f0 그대로.
- 세 PR 모두 정식/open/충돌 없음. 웹·치과앱 연결 도구, 기공소앱은 연결 도구404로 로컬 gh 인증을 사용하여 확인. 새 리뷰 없음, 미해결 스레드 Web0/Office0/Lab0. Web/Office CodeRabbit status success; Lab status rollup success이나 새 CodeRabbit 실행 증거로 해석하지 않음.
- 양앱 main 및 각 release 모두 포함. Web release/v1.94.0도 포함하지만 origin/master가 e03a72700(1.93.0 release merge)로 갱신되어 feature에 없는 커밋14개 존재. 다음 코드 작업은 웹 최신master 통합 및 영향범위 검증이며 이번에는 병합하지 않음. 밀링 기능 자체는 다른 소유자 범위.
- 기존 별도 잔여: 알림설정 새 디자인 대조·반영, 승인/병합 및 배포/QA. 최근 수정 미배포 상태 유지. 이번 새 리뷰 처리 작업은 없음.

## 2026-11-17 Figma 새 설정 디자인·멘션 3건 확인(조사만)

- 본체 구현을 막는 BE/기획 대기는 현재 없음. channels/platforms/displayAuthorities 연결과 기존 PR 리뷰는 완료. Swagger 상위 OFF 설명 정합성은 기존 확정 전체ON/OFF 동작을 막는 신규 API 대기가 아님. 본체외 홈/이메일/배지 후속은 구분.
- Figma QLIzKYWzFFlptCYzN36Iq4 최신댓글20개와 해당 프레임/이미지·현재 코드 대조. 새 멘션 정확히3건: 2010620506(11/17 09:41 KST,642:28528) 치과앱 스크롤 이슈에 따른 OS알림배너 압축, 2010622582(09:44,637:29429) PC는 병원명 숨김/모바일 표시, 2010624441(09:47,부모2006939011,node606:39212) 기공소 배너 동일 확인.
- 배너는 기존 굵은 제목+설명 별도 줄에서 한 본문과 CTA로 변경, 아이콘26px. 치과 영문 Notifications are turned off. 삭제 제안은 후속 디자이너 답변2010625389에서 유지로 정리됨. 기공소 새 본문은 ‘알림이 꺼져있어요. 중요한 알림을 놓치지 마세요.’, CTA알림켜기. 기존 OS권한 동작 변경 요청으로 확대하지 않음.
- 기다리던 치과 설정 Office/User탭 디자인 실제 확인(웹167:24944,앱642:28528). 현재는 user/employee항목 연속 목록으로 탭 UI 미반영. PC/모바일 병원명 차이, 범위 위치, User탭 모든권한 노출 설명 확인. 기본범위 Assigned Orders 설명은 저장된 서버값을 덮으라는 의미로 적용하지 않으며 현재 계약 기준 유지.
- 추가 PM댓글2010663738(10:43,node97:29217): 화면별 순서불일치 지적. LinkTalk → Order(Design Confirm/Order Updates/Shipping/Feedback) → Office Credit → Payment 순서 제시. 실제 일부프레임은 Payment가먼저라 디자인/서버순서 대조시 챙길 것. FE임의 재정렬·BE신규요구 확정 없음.
- 결론: 더 기다리는 상태가 아니라 새 디자인 반영 범위가 확인된 상태. 이번은 확인 요청만이므로 제품코드·Figma·PR·배포 변경 없음. 웹 최신master(1.93.0) 통합은 앞선 별도 준비잔여.


## 2026-11-17 릴리즈 병합 확인·양앱 Development CodePush 완료

- 사용자 요청: 각 PR 릴리즈 병합 후 양앱 Development만 CodePush. 웹 DEV는 사용자가 추가 배포했다고 알려줌(사용자 확인 기록); 웹 스테이징 PR과 양앱 Staging은 대기. 이번 턴 웹 배포/PR변경/병합/Slack 쓰기 없음.
- 실제 GitHub 확인: Web PR4862→release/v1.94.0 병합 cac11aa9, Office PR346→release/v2.2.5 병합 0a131041, Lab PR42→release/v1.0.6 병합 dfb3051c. 양앱 fetch 후 feature HEAD와 해당 병합 release의 tree diff 없음.
- Office source 8748a66d / target binary 2.2.5: Development iOS v148, Android v148 게시·활성화 완료.
- Lab source 9455c27 / target binary 1.0.6: Development iOS v47, Android v46 게시·활성화 완료.
- 4건 모두 mandatory=true, disabled=false, rollout=100을 배포 후 history 한 번으로 확인. Revopush release-react를 제품/OS별 직렬 실행하여 공통 임시 번들 경합 방지. 기존 릴리즈 스크립트와 같은 옵션 사용, Slack 발송 없음.
- 호환성: 양앱 package/Android/Xcode 버전 검증 통과. 최신 origin/main 대비 ios/android/package.json/patches 변경 없음. 이전 Office2.2.4/Lab1.0.5에는 이번 OTA가 적용되지 않음. 기존 Office 영상 isv.mp4 크기 경고는 기존 배포 옵션 --force로 완료됐으며 기능 실패 아님.
- 이번은 번들 생성·게시·활성화 검증. 앞선 설정 디자인/권한/내비게이션 테스트 근거 재사용; 실기기 OTA 수신·FCM·전체 QA를 이번에 했다고 주장하지 않음. 제품 코드 추가 수정 없음, 양앱 작업트리 clean.
- 다음: 사용자가 해당 버전 Development 앱에서 치과 Office/User 설정 탭·설정 변경, 알림→주문 WebView 상세→뒤로가기, 기공소 설정/OS 안내 배너를 확인. 새 문제/리뷰 발생 시 필요한 범위 대응. 스테이징·운영은 별도 승인까지 대기, 자동 폴링 없음.


- 사용자 최종 대기 지시(2026-11-17): Development 배포 상태 유지. 웹 Staging은 사용자가 직접 배포하고, 치과·기공소앱 Staging CodePush는 사용자가 다음에 명시적으로 요청할 때 진행한다. 지금은 추가 배포·코드작업·리뷰 폴링 없이 대기한다.


## 2026-11-17 Staging 배포·지라 정리 브레이크포인트

- 사용자 확인: 웹 Staging은 사용자가 직접 배포 완료. 에이전트는 웹 재배포/PR병합/운영 배포를 하지 않음.
- 앱 Staging CodePush 완료: Office 2.2.5 iOS **v347**, Android **v346** / Lab 1.0.6 iOS·Android **v65**. 네 건 모두 게시 성공 후 history 한 번으로 enabled·mandatory·rollout100·target 확인. source는 앞선 Development와 동일(Office8748a66d / Lab9455c27), 각 merged release와 tree diff 없음. 양앱 버전 검증 통과 및 main 대비 네이티브/패키지/패치 diff 없음. 직렬 빌드, Slack 쓰기 없음.
- 현재 효과: 새 설정 API·displayAuthorities·서버 순서·새 설정 디자인·OS 안내, 치과 WebView 상세 정본에 맞춘 알림 랜딩까지 릴리즈 병합 및 DEV/STG 반영. 확정 알림센터 본체의 알려진 독립 FE 미완 없음. 기존 검증을 재사용했으며 이번은 배포/활성화 확인으로 실기기 OTA 수신·실제 FCM·최종 QA 완료를 뜻하지 않음. 구 Office2.2.4/Lab1.0.5에는 이번 OTA 미적용.
- Jira: DL17415/17416/17417의 후속 표시·디자인 대기 문구를 현재 범위에 맞춰 정리하고 **Ready for Deploy(개발완료)** 전환. DL17436은 **Office 앱 릴리즈 주문 상세(WebView) 기준 알림 랜딩 정합성**으로 제목/본문 수정·개발완료 전환. 현재 자체 상세를 기다리는 카드가 아님. SP/담당자/부모 불변.
- 지라 결과 댓글: DL17058#45100(웹 사용자배포),17059#45101(Office),17060#45102(Lab),17415#45103,17416#45104,17417#45105,17436#45106. 기존 개발완료 본체 카드 상태 유지. 상위·BE·디자인·QA 타인 카드 변경 없음. 최종 QA/운영완료로 임의 전환하지 않음.
- 그대로 남는 본체 외/별도 후속: Home3(DL17062 웹 시스템 메시지,DL17065 Office 홈 필터·최초안내,DL17068 Lab 서포트 최근 메시지), OS배지 개선2(DL17418/17419), E2E(DL17426). 이메일/SES는 DL17183·FE17187의 별도 범위이며 이번 배포에서 변경하지 않음. 미정 디자인/정책 및 별도 착수 승인 뒤 진행.
- 문서: 개인 정본·주문 상세 후속 기록·Claude 메모리 동기화. 공유 정책/이벤트 명세 변경은 없어 Notion 내용을 임의 변경하지 않음. 중복 배포 문서를 새로 만들지 않고 현재 체크포인트에 통합.
- 다음: 사용자가 스테이징 웹·실기기 QA 후 문제를 알려주면 영향 범위만 대응. 치과 Office/User 설정 저장·재진입 및 알림→주문 상세/복귀, 기공소 설정·OS 안내가 이번 주요 확인 대상. 실제 푸시·OS권한 실기기 제한은 기존 QA 기록에서 챙김. 운영 배포는 별도 승인; 추가 폴링/코드변경 없이 대기.


- 추가 정리(2026-11-17): DL-17202 치과앱 크레딧·청구서 목록은 이 세션 구현·검증 및 PR346 병합/STG 배포에 포함된 작업. 사용자 지시에 따라 본문 범위·구 Draft 링크를 정리하고 댓글45107 후 Done(완료) 전환. SP/담당자/부모 유지. 실제 푸시 통합 QA/운영배포, 메뉴·PDF·결제·상세 View 확장은 별도이며 이 카드의 FE 미완으로 두지 않음.

- 사용자 상태 정리(2026-11-17): 알림센터 FE 개발 카드 중 Ready for Deploy에 있던 카드들을 사용자가 직접 Done으로 전환했다고 알림. 이 카드들은 FE 구현 업무를 추적하므로 개발 완료 후 닫고, 이후 발견되는 QA 이슈는 별도 QA 카드로 관리한다. 사용자 확인 기록이며 이번 턴 Jira 재조회/변경은 하지 않음. Done은 전체 QA·운영 배포 완료를 의미하지 않는다. 본체 외 미착수 후속은 그대로 별도 To Do이며 실제 QA 발견 전 빈 QA 카드를 만들지 않는다.


## 2026-11-17 사용자 Jira 본체·백로그 분리 확인 및 QA 대기

- 실제 Jira 읽기 확인: DL-16140 `[치과/기공소] 알림센터`는 진행 중(PM 담당), 하위 Frankie 소유 FE 카드는 전부 완료. 전체 QA/운영 완료 선언과 구분한다.
- DL-17469 `알림센터 백로그`는 Frankie 담당·해야 할 일. 사용자 이동을 실제 확인한 하위 6건은 Home3(DL-17062/17065/17068), OS 배지 개선2(DL-17418/17419), E2E(DL-17426)이며 모두 해야 할 일. 과거 이 카드들이 DL-16140 하위라는 기록은 이 현재 구조로 대체한다.
- DL-17202 앱 크레딧·청구서 작업도 직전 Done 정리 완료. Development·Staging 배포 상태는 직전 체크포인트 유지.
- 이번 요청은 확인·기록만: Jira/Notion/코드/PR/배포 변경 없음. 사용자 QA 결과 전달 전까지 추가 조사·자동 리뷰 조회·폴링·백로그 구현 없이 대기한다. 재개 시 전달된 QA만 해당 제품/영향 범위로 대응하며, 기존 개발 카드를 다시 미완료로 묶지 않고 필요하면 별도 QA 카드로 관리한다.


## 2026-11-17 알림센터 공통 UI 연결부 한정 점검 — 수정 전

- 사용자 요청: Safe Area/노치 배경 전환 지연을 계기로 기존 UI 방식과 어긋난 연결부를 웹·Office·Lab에서 점검. 이번은 조사만이며 제품 코드·PR·Jira·배포는 변경하지 않았다.
- 우선 수정 대상: 양앱 App.tsx의 navigator 바깥 top SafeAreaView 색상을 RootNavigator.onStateChange에서 바꾸므로 native 화면 전환과 별도 타이밍이다. Office 기존 하단 탭은 tabPress에서 선반영한다. 사용자 관찰 증상과 맞는 코드 구조이며, 기존 전역 구조 자체는 알림센터 이전부터 존재하지만 새 알림 화면과의 전환 연결 검증이 부족했다. 해당 전환부터 기존 UX에 맞춰 보완하고 전역/네이티브를 광범위하게 바꾸지 않는 방향을 추천한다. 이번 턴 기기 재현은 하지 않았다.
- 추가 보완 후보: 양앱 NotificationCenterScreen의 inbox refreshing이 isRefetching 전체(다음 페이지 제외)에 연결되어 있다(Office443/Lab409). 따라서 focus/read 등 자동 재조회도 수동 pull-to-refresh 표시를 켤 수 있다. 기존 Home/LinkTalk는 수동 새로고침용 local isRefreshing을 사용한다. 자동 갱신은 유지하고 수동 표시 상태만 분리하는 것을 추천. 시각적 발생 정도는 런타임 미확인이며 실제 발견 크래시로 취급하지 않는다.
- 나머지 확인 범위: 공통 토스트 경로/위치, 웹 병원선택 공통모달·중첩 Escape/포커스, 앱 공통 bottom sheet/뒤로가기, 소속 전환 중 중복입력·blur 취소, 설정 저장 중 화면 유지. 확인한 범위에서 추가로 명확한 기존 UI 이탈/결함은 발견하지 않았다. 디자인에 근거한 스크롤 높이 차이는 임의 통일 대상이 아니다.
- 기존 집중 테스트: Office NotificationCenterScreen 26개, Lab useNotificationLabSwitch 24개, Web Clinic NotificationCenter 12개 = 62개 통과. 화면 전환 애니메이션/네이티브 시각적 품질을 증명하는 테스트는 아니다. 제품 Git은 기존 SHA 유지·clean.
- 다음: 사용자 구현 요청 시 두 앱의 전환/새로고침 표시를 좁게 보완하고 해당 동작만 시뮬·에뮬 확인. 현재 스테이징은 이전 배포 그대로다. 전체 재검수/폴링/재배포 없음.


## 2026-11-17 DL-17470 알림 화면 전환 QA 보완 — PR까지 완료·미배포

- 사용자 승인: 새 Jira 카드를 사용해 지적한 Safe Area/노치 배경색 지연과 점검된 새로고침 표시를 수정·검증·커밋푸시·PR까지. 제목/본문 정리 허용, 배포 금지.
- Jira DL-17470 `[QA][치과·기공소앱] 알림 화면 전환 배경색·새로고침 표시 보완`으로 제목/본문 정리. 진행 중 → Ready for Deploy(개발완료), 결과 댓글45109. 부모 DL-16140/담당자/SP 유지. 이번은 QA 수정 카드이며 실제 사용자 재확인 완료·운영 완료로 Done 처리하지 않음.
- 브랜치: 두 기존 checkout 재사용, 각 배포된 릴리즈에서 `feat/DL-17470` 생성. Office origin/release/v2.2.5(0a131041), Lab origin/release/v1.0.6(dfb3051). 최신 main에는 다른 변경이 있으므로 이번 STG QA 범위로 가져오지 않음. 이전 feature/DL-17059·17060 보존.
- Office `/Users/parkjongsun/Repository/dentlink-app` 5239f3be push, PR353 → release/v2.2.5. Lab `/Users/parkjongsun/Repository/dentlink-lab-app` 85e56f5 push, PR49 → release/v1.0.6. 두 PR non-draft/open·실제 base/head 확인, 제품 checkout clean. Office는 GitHub connector, Lab은 connector404로 기존 gh 인증 사용.
- 수정: 각 3파일(NotificationSafeAreaBackground 신규, NotificationCenterScreen, RootNavigator). RootStack layout에서 실제 중첩 탭까지 포함한 root state를 읽고 알림 진입·설정·복귀 시 layout effect로 기존 안전 영역 색상을 선반영한다. 다른 화면의 전역 색상 기준/기존 onStateChange는 유지. Native 코어·FCM·API 계약·웹 변경 없음. API 자동 갱신과 별도로 수동 isRefreshing을 추적하며 소속 변경/해제 뒤 오래된 완료가 새 표시를 끄지 않도록 request ID 사용. 진행 중 동일 조회는 재시작하지 않는다.
- 검증: 양앱 Development Debug + iOS26.5 iPhone17Pro / Android16 API36에서 홈→알림함→설정→알림함→홈·수동 새로고침 성공. Office Android 및 Lab Android 시스템 뒤로가기, Lab iOS 가장자리 스와이프 취소/완료 성공. Office iOS 전환 녹화/스크린샷 및 두 앱 store의 색상 선반영 순서 확인. Lab 실행 중 자동 재조회4건 동안 목록 spinner false, 수동 refresh true→false 직접 관찰; Office도 수동 true→false 확인. 설정 저장/실제 FCM·새 전체 QA는 하지 않음.
- 기존 집중 테스트 Office26/Lab24=50개 통과. 변경파일 lint 오류0(기존 Root console 경고3개씩). 전체 tsc는 기존 오류로 통과하지 않는다. 원본 HEAD의 변경 전 소스를 compiler host에서 읽은 baseline과 현재 진단을 비교해 동일함 확인(Office8/Lab7 diagnostics, compiler API 전역 진단 포함). 기존 Icon/Tooltip/MessageText/OrderAddProduct 또는 order types 범위이며 이번 변경 오류 없음. 테스트 파일을 새로 만들거나 수정하지 않음.
- runtime 참고: Android crash buffer에는 기존/이번 부팅의 시스템 Bluetooth 프로세스 기록만 보였고 Dentlink 앱 크래시는 발견하지 않음. 실제 실기기·모든 전환의 무결함을 뜻하지 않는다. 사용한 기기·Metro는 작업 전 종료 상태로 정리. 영상/스크린샷/실행로그는 /tmp/dl17470-* 로컬 검증 자료(개인정보 업로드 없음).
- 배포: 이번 수정 머지·CodePush·웹배포 없음. 기존 STG Office iOSv347/Androidv346, Labv65와 웹은 그대로. 웹은 점검 결과 수정 필요 없어 PR 없음.
- 다음: PR353/49 리뷰·머지 및 배포는 사용자 지시 후. 배포 전에는 사용자의 기존 STG 화면에서 이번 수정이 보이지 않는다. 불필요한 새 리뷰 폴링/전수 QA 없이 대기.


## 2026-11-17 통합알림센터 QA 누적 운영 — 현재 적용 기준

- **이 프로젝트 한정 사용자 결정:** Jira는 QA 건별 카드로 유지하되, 수정 코드는 제품별 QA 누적 브랜치/PR 하나에 계속 쌓는다. 에이전트/세션이 바뀌어도 이 기준을 유지한다. 건마다 브랜치·PR을 새로 만들거나, 개별 카드 완료를 누적 PR 머지/배포 승인으로 해석하지 않는다.
- 브랜치 명명은 기존 feat/<Jira> 규칙에 맞춰 상위 알림센터 키를 사용한 `feat/DL-16140`. Office·Lab은 별도 저장소에서 각각 같은 이름 사용. 이후 알림센터 웹 QA도 처음 발생할 때 제품 저장소의 누적 QA 브랜치/PR을 준비하고 같은 방식으로 쌓는다. 지금 웹은 수정 사항이 없으므로 빈 브랜치/PR은 만들지 않음. 일반적인 다른 기능/프로젝트 전체의 QA 규칙을 변경한 것은 아니다.
- 앞으로 승인된 QA 수정은 해당 누적 브랜치에 커밋·푸시하고 PR의 포함 Jira/검증 내역을 갱신한다. 사용자가 QA 브랜치를 올리라고 명시하기 전에는 자동 머지·배포/CodePush하지 않는다. 이번 사용자는 다음에 **PR 미머지 상태의 작업 브랜치로 앱 CodePush**할 예정이며, 현재는 준비만 하고 대기하라고 명시했다. 배포 환경·대상 바이너리·정확한 SHA는 실제 배포 지시 때 확인한다.
- 현재 Office: `/Users/parkjongsun/Repository/dentlink-app`, `feat/DL-16140` → origin/feat/DL-16140, HEAD5239f3be, QA 누적 PR354 → release/v2.2.5. https://github.com/Innvoaid/dentlink-app/pull/354
- 현재 Lab: `/Users/parkjongsun/Repository/dentlink-lab-app`, `feat/DL-16140` → origin/feat/DL-16140, HEAD85e56f5, QA 누적 PR50 → release/v1.0.6. https://github.com/Innvoaid/dentlink-lab-app/pull/50
- 기존 `feat/DL-17470`을 로컬에서 이름 변경하고 새 원격으로 동일 커밋을 푸시했다. 새/구 원격 diff0 및 새 PR head/base/non-draft 확인 후 기존 Office PR353·Lab PR49를 대체 링크/이유와 함께 close(merge 아님), 구 원격 feat/DL-17470 삭제. 기존 리뷰 이력은 닫은 PR에 남고 새 PR References로 연결. 원래 알림센터 feature/DL-17059/17060은 보존. PR353/49가 현재라는 이전 기록은 이 단락으로 대체한다.
- 포함 QA: DL-17470 상단 배경색 전환·새로고침 표시 보완. Jira 상태/본문은 건별로 유지하고 결과 댓글45109의 링크를 누적 PR354/50으로 갱신. 본체/백로그 상위 카드 변경 없음.
- 이번 변경은 Git/PR 운영 정리뿐이며 제품 소스/커밋·검증 결과는 직전과 동일. 재빌드·기기 전수 테스트·리뷰 폴링 없음. 배포하지 않았고 기존 STG Office iOSv347/Androidv346, Labv65 및 웹은 유지.
- 다음: 새 QA 요청은 누적 PR에 추가하거나, 사용자 배포 요청 시 아직 머지하지 않은 해당 QA 브랜치의 확정 SHA로 지정 환경 CodePush. 현재 대기.


## 2026-11-17 QA 누적 작업 브랜치 → 양앱 Staging CodePush 완료

- 사용자 명시 승인으로 **릴리즈가 아닌 미머지 `feat/DL-16140`** 에서 Staging 배포. Office `5239f3beb0d1d6e8d58ed44671acc405b1bcadf6`, Lab `85e56f5023a6be8fe5ef0f9ecc208d165725c977`. PR354/50은 OPEN·미머지 유지, base release/v2.2.5·release/v1.0.6 그대로. 코드·PR·릴리즈 브랜치 변경 없음.
- 완료 라벨: **Office 2.2.5 iOS v348 / Android v347**, **Lab 1.0.6 iOS·Android v66**. 각 게시 성공 및 history 1회로 isDisabled=false, isMandatory=true, rollout=100, target version, 설명의 QA branch/SHA 확인. 이전 STG Office v347/v346·Lab v65를 대체했다. 웹·Development·Production 변경 없음.
- 양앱 버전 검증 통과(package/Android/Xcode), QA branch local/remote 동일·clean. 기존 STG release source 대비 각 3파일의 DL-17470 JS/TS 변경뿐이며 native/package/lock/patch 차이 없음. 기존 검증된 동일 커밋이므로 기기 전수검사 반복하지 않음. 제품·플랫폼 순차 `node scripts/codepush.js staging all --mute` 실행, Slack 쓰기 없음.
- 영향: 홈↔알림함↔알림설정의 Safe Area/노치 배경색 전환 보완, 자동 재조회와 사용자가 당겨서 하는 새로고침 표시 분리. 직전 양OS 검증 범위에서 새 크래시/동작 문제를 찾지 못함. 이번에는 게시·활성화까지만 확인했고 실기기 수신/OTA 적용/사용자 최종 QA는 아직 확인하지 않음.
- 사용자 확인: 업데이트 적용 후 양앱 홈→알림함→설정→뒤로 이동의 상단색 전환 및 당겨서 새로고침 표시. 자동 재조회 때 불필요한 뺑글이가 생기지 않는지. Office 기존 isv.mp4 1.48MiB 자산 경고는 기존 force 배포 옵션으로 게시 성공; 이번 추가 자산 아님.
- Jira DL-17470은 기존 건별 QA 카드 유지(이번 상태/댓글 변경 없음). 향후 알림센터 QA도 제품별 같은 누적 branch/PR에 쌓고 명시적 승인 때만 배포/머지. 이번 배포는 PR 머지 승인이 아니다. 다음: 사용자 실기기 QA 결과나 다음 요청까지 대기, 자동 모니터링/리뷰 폴링 없음.


## 2026-11-17 IDE Fastlane 실행 경로 보완

- 사용자가 IDE task `yarn fastlane-android:dev` 실행 시 `command not found: fastlane`(127) 보고. Fastlane2.228.0은 mise Ruby3.2.2에 이미 설치되어 있었으나, `.zshrc`의 mise activate가 non-interactive login shell `zsh -l -c`에 적용되지 않아 system Ruby2.6으로 실행되는 것이 원인.
- 로컬 `~/.zprofile`에 mise shims PATH를 추가하고 정확히 같은 `zsh -l -c`로 Ruby3.2.2/Fastlane2.228.0 인식·version 실행 성공, Lab checkout에서도 경로 확인. 기존 파일은 존재 시 타임스탬프 백업 보존. 제품 소스/브랜치 변경 없음. 빌드·Firebase 업로드·CodePush는 실행하지 않음.
- 사용자 설명: Android `fastlane-android:dev`는 Development APK, `fastlane-android:staging`은 Staging APK를 Firebase App Distribution에 빌드/업로드하므로 App Tester 새 설치 파일 제공 용도. CodePush는 기존 설치 앱 JS 업데이트라 App Tester 새 바이너리를 생성하지 않음. 사용자가 실행 시 실제 branch 확인 필요: 이 확인 시 Office checkout은 사용자가 변경한 release/v2.2.5(원격보다7커밋뒤), Lab은 feat/DL-16140였음. 원격동기화/branch 변경은 이번 PATH 수정에서 하지 않음.

## 2026-11-17 Android Fastlane 로컬 실패 조사·실행 준비 보완

- 사용자 첨부 STG 로그: Office validateSigningStagingRelease 실패는 android/app/release.keystore 누락. Lab react-native-vision-camera:clean 실패는 삭제 중 새 Kotlin build 파일 생성. 동시 쓰기/빌드 경합 가능성은 있으나 정확한 실행 주체는 미확정. 단독 `./gradlew :react-native-vision-camera:clean --no-parallel --console=plain`은 10초 성공. 동일 앱의 DEV/STG Fastlane은 순차 실행 권고.
- 사용자 실행준비 조치 승인으로 Office 충돌 태그 office-v2.2.3.74를 /tmp/dentlink-office-tag-before-sync-20261117.bundle에 보존 후 원격 정본으로 로컬만 교체(e0f4d5dd→74037211 peeled commit). 원격 태그 변경 없음. 현재 사용자가 체크아웃한 release/v2.2.5를 origin과 fast-forward(4519d81b→0a131041), 7개 누락 커밋 포함. QA branch/PR 미머지 유지; branch 전환 없음. Lab feat/DL-16140은 원격 동일.
- 양앱 `zsh -l -c` Fastlane 경로 정상, Android bundle check 및 fastlane lanes 정상(개발/STG lanes 로딩). 환경파일·Firebase 서비스계정 파일 존재 여부만 확인, 내용 변경 없음. 양앱 및 알려진 Office worktree에 release.keystore 없음; Repository/Downloads/Documents/Codex worktrees 파일명 검색에서도 기존 keystore/jks 발견 안 됨.
- 사용자에게 설명: release.keystore는 프로젝트 android/app에 놓되 Git ignore된 기존 앱 서명 비밀키. Git clone/pull로 내려오지 않음. 앱개발자에게 기존 배포 키와 두 앱 공용 여부를 확인해 받아야 함. 임의 새 키 생성·debug 키 대체 안 함. 파일을 받으면 양앱 서명 task로 먼저 확인 후 사용자가 IDE Fastlane 실행; APK 빌드/Firebase 업로드 완주까지 검증한 상태는 아님.
- 이번 제품 소스 수정/커밋/푸시/PR머지/Firebase 업로드/CodePush 없음. 이전 QA STG CodePush는 유지. 사용자가 Android DEV/STG 새 바이너리 업로드 뒤 명시 요청하면 STG만 QA 작업 브랜치에서 CodePush 예정; 자동으로 실행하지 않음.

- 후속 확인(2026-11-17): 사용자가 release.keystore를 앱 개발자에게 요청함. 양앱 git fetch --dry-run --tags 오류 없음, 작업트리 clean·upstream 0/0, IDE login shell Fastlane/Ruby3.2.2 인식 재확인. 서명 파일 외 현재 확인된 추가 수정 없음. Office는 최신 release/v2.2.5, Lab은 QA feat/DL-16140 유지. 사용자 파일 수령 후 서명검증이 재개점이며 실제 Firebase 업로드 성공은 아직 미검증.

- 서명 파일 수령·검증 완료(2026-11-17): 사용자가 양앱 android/app/release.keystore 배치. 두 파일 존재·nonempty·Git ignore 확인. keytool로 기존 Gradle storePassword를 메모리/하위프로세스 환경에서만 사용해 열기 및 설정된 alias 존재 확인(키/비밀번호 출력 없음). 양앱 각각 validateSigningDevelopmentRelease + validateSigningStagingRelease 성공(Office7초/Lab12초). 누락 blocker 해소. 실제 APK 전체 빌드/개인키 서명/기존 설치 인증서 일치/Firebase 업로드는 아직 미검증. 사용자 IDE Fastlane DEV/STG 순차 실행 재개 가능, 배포/CodePush는 실행하지 않음.

## 2026-11-17 OS 알림 권한 QA 범위 검토 — 수정 전

- 사용자: iOS 신규 설치 후 최초 알림 요청을 건너뛴 상태에서 Go to Settings가 알림 항목 없는 일반 앱 설정(백그라운드 새로고침/셀룰러)으로 이동. 양앱/iOS·Android 및 연관 OS 경로 검토 요청. 이번은 코드·설치 라이브러리와 Apple/Android 공식 계약 검토이며 기기 재현/코드수정/배포 없음.
- 양앱 NotificationPermissionNotice 및 useNotificationPermissionRequest는 OS 미요청/거절을 구분하지 않고 iOS Linking.openSettings, Android notifee.openNotificationSettings 호출. iOS RNPermissions4.1.5 native mapping: NotDetermined→denied, Denied→blocked. 신규 알림센터는 둘을 한 그룹으로 취급해 최초 권한 요청 경로 누락. 팝업뿐 아니라 알림설정 배너·Push 토글 안내가 같은 영향. Office 현재 release/v2.2.5와 QA feat/DL-16140 사이 이 파일 차이 없음.
- 기존 가입 NotificationSettingScreen의 Allow notification은 공통 requestForNotificationPermission을 호출하며 iOS messaging.requestPermission/Android13+ POST_NOTIFICATIONS request/12이하 Notifee 상태 확인 분기가 있음. 신규 알림센터 경로는 이 요청 절차를 타지 않음. Android 설정 직접 열기는 유효하며 iOS와 동일한 막힘을 확정하지 않음; Android13+ 미요청/재요청 가능/차단을 고려한 요청 우선 권고. checkNotifications만으로 Android13+ blocked를 구분할 수 없다는 공식 라이브러리 계약 유의.
- 양앱 AppState 복귀 권한 재조회·선택한 Push 항목에 한정해 허용 후 저장·소속/context 변경 방어는 존재. 권한 요청 팝업을 새로 연결하면 외부 설정 복귀뿐 아니라 request 반환 후 refresh/선택항목 적용 및 중복 방지 검증 필요. 서버 전체 알림 설정 자동ON/변경 금지.
- iOS Linking.openSettings는 일반 앱 설정 경로. Apple 별도 notification settings URL 지원 존재하나 현재 react-native-permissions4.1.5 openSettings는 일반 앱 설정만 지원하며 Notifee openNotificationSettings는 iOS no-op. Android용 함수를 iOS에 그대로 대체하거나 최신 라이브러리 signature를 현재 설치본에 적용하면 안 됨. 최초 요청 누락은 기존 설치된 request 기능을 JS에서 활용해 수정 가능; 직접 알림설정 딥링크는 별도 호환 확인사항.
- 카메라/사진은 request 후 blocked에서 일반 앱 설정을 여는 점은 적절하나, 공통 requestForPermissionAlert가 설정 이동 직후 onPressAllow를 호출하고 실제 소비자는 카메라/사진 picker를 여는 기존 코드상 위험 발견. 설정복귀/실제 허용 전 기능 실행 가능. 이번 알림 신규 코드가 아닌 별도 범위, 기기 재현 전 확정 크래시로 말하지 않음. Lab 밀링 카메라 request/설정 분기는 별도 구현, 이번 변경으로 묶지 않음. Lab 구 ProfileNotificationSection/useProfileNotification과 양앱 NotificationBanner는 검색상 현재 화면 caller 없어 활성 경로 수정 범위에서 제외.
- 권고 수정 범위: 알림센터 권한 진입 공통 처리(양앱) + 최초요청/차단설정/취소/복귀/선택토글 적용 회귀검증. 네이티브 SDK/앱 모든 OS권한 전면개편은 불필요. 새 사용자 승인 전 QA branch 소스 변경 없음.

## 2026-11-17 DL-17477 OS 알림 설정 QA 등록 확인 — 구현 대기

- 사용자가 https://innovaid.atlassian.net/browse/DL-17477 을 이번 알림 권한 건의 카드로 지정. 이번 요청은 확인·검토·메모리만이며 카드/코드 수정 금지.
- Jira 실조회: 제목 `[앱 IOS 기공소] 기기 알림 설정 할 수 있는 화면으로 랜딩 안됨`, 하위 작업, 담당 Frankie, 상태 해야 할 일, 우선순위 Medium. 재현은 최초 실행→알림 ON 유도 팝업→앱 접근 권한 설정에 도착하지만 알림 항목 없음. 앞선 사용자 증상과 코드 검토 결과에 부합한다. 다만 카드에는 실제 OS 권한값이 없으므로 단말 NotDetermined 상태까지 측정된 것으로 주장하지 않는다.
- 카드의 신고 범위는 기공소 iOS. 코드상 같은 최초 요청 누락이 치과앱에도 있으며, 사용자 요청대로 향후 양앱의 팝업/배너/Push 토글 및 iOS·Android 분기를 함께 검증해야 함. Android의 알림설정 직행은 유효하므로 iOS와 동일한 결함으로 확정하지 않음. 기존 가입 안내·설정복귀 처리는 보존. 카메라·사진 기존 공통 권한 위험은 DL-17477과 별도이며 이번 카드에 섞지 않음.
- 다음 사용자 구현 승인 시 제품별 기존 QA 누적 feat/DL-16140 / Office PR354·Lab PR50에 수정분을 쌓는 기존 운영 원칙 적용. 이번 코드는 수정/커밋/배포하지 않았고 Jira 제목·본문·상태·댓글도 변경 없음. 현재 구현 승인 대기.


## 2026-11-17 Firebase 실제 Android 릴리즈 조회

- 사용자 승인: 양앱 Development/Staging 실제 버전·업로드시각 읽기전용 조회만. Fastlane 기존 서비스계정으로 App Distribution releases.list GET(각 최신3개) 4건 HTTP200. 키/토큰 출력·배포/테스터변경 없음.
- 최신 Firebase 등록(createTime, KST): Office Development2.2.5(135) 2026-11-17 15:30:35 / Office Staging2.2.5(135) **2026-11-12 10:32:20** / Lab Development1.0.6(10) 2026-11-17 15:01:47 / Lab Staging1.0.6(10) 2026-11-17 15:45:35. updateTime도 각각 같은 시각대. 따라서 오늘 신규 릴리즈 등록 확인은 Office DEV·Lab DEV/STG이며 Office STG는 오늘 신규 등록 확인 안 됨. 사용자 'Office STG만 실행' 인식과 실제 결과가 다름을 보고. 누가 실행했는지나 바이너리의 Git SHA는 API 버전·시각만으로 단정하지 않음.
- 실제 등록 확인과 테스터 초대/배포대상/단말 설치/OTA 적용은 별도. Firebase 바이너리 등록 기록이며 CodePush 라벨 아님. 이후 명시 요청 전 추가 업로드/CodePush 없이 대기.

## 2026-11-17 사용자 운영 지침 — 요청 시 Fastlane도 대행

- 앞으로 사용자가 요청하면 CodePush 외에 Fastlane도 앱/환경/소스/기존 서명 확인 후 실행하며 Android Firebase 실제 등록을 API 1회로 확인한다. 사용자가 직접 실행한 건은 요청에 따라 조회만. 개발/STG 같은 checkout 동시 빌드는 피하고, 키/토큰 출력 금지.
- 기본 앱 버전(네이티브 바이너리)과 CodePush 버전을 구분한다. 현재 치과2.2.5·기공소1.0.6 기반 앱은 DEV/STG에 존재하며 호환 QA JS는 별도 승인 시 CodePush. Fastlane 요청을 CodePush/PR머지/운영배포 승인으로 확대하지 않는다. 공통 정본 SESSION_WORKFLOW.md Deployment Result Checks에 반영. 이번은 지침/메모리만 변경, 실행 없음.

**2026-11-19 사용자 현황:** BE 답변(45009·44994)은 댓글 없어도 BE 코드에 이미 적용된 것으로 봄(대기 아님). 실기기 푸시 테스트는 사용자가 QA와 함께 진행 중. 남은 것은 신규 카드(DL-17488 등)와 진행 중 QA(feat/DL-16140, PR4903/354/50), QA 완료 후 머지·배포(지시 시).

**2026-11-19 DL-17488 FE 검토(조사만):** 탭 경로·대기열·유저 기준 읽음 API는 정상. 유력 원인은 읽음 PATCH 실패 시 다음 계기(복귀·다음 탭·토큰 변경)까지 재시도 없음 + 알림함 즉시 진입 시 PATCH 전 GET. 조치안: 제한 자동 재시도 + 알림함 진입 시 flush(양앱 동일, 소규모). 범위 밖: payload deliveryId 유무·BE 커밋 타이밍·조회 지연. 수정은 승인 시 feat/DL-16140. 정본 codex 최상단.

**2026-11-19 DL-17488 보완 push(미배포):** Office feat/DL-16140@f72285e5, Lab @bbf1d96 — 읽음 실패 시 3·10·30초 최대 3회 재처리 요청, 알림함 포커스 시 남은 읽음 처리 요청, 계정 변경 시 정리. PR354/50 본문 갱신, 배포·Jira 변경 없음. 웹은 앱 푸시 미수신이라 무관. tsc 기준선 Office7·Lab6(직전 QA 커밋 RootNavigator 타입 경고, 미수정).

**2026-11-19 DL-17488 추가 점검(수정 불필요):** 웹 알림 클릭은 읽음 PATCH 후 같은 사이트 경로로 SPA 이동이라 요청 유지(dev landingUrl 55건 모두 /orders 상대경로), 실패 시 토스트. 앱 알림함 클릭은 읽음 대기 후 랜딩·실패해도 랜딩·토스트·재탭 재시도. 코드 변경 없음.

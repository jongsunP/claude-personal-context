---
name: dentlink-notification-center-status-20261110
description: Dentlink 통합알림센터 2026-11-10 마감 상태 — iOS 배너 수정 v142/v40, Android 패치 PR 완료, 웹 노출 페이지 현황
metadata:
  type: project
---

2026-11-10 마감 기준(정본: `codex-personal-context/projects/dentlink-unified-notification-center.md` 상단).

1. **iOS 푸시 탭 후 배너 재표시:** 원인은 iOS 알림 탭을 Notifee가 먼저 받는데(링크 순서상 최상위 delegate) 1차 수정이 Firebase 탭 경로만 처리한 것. 2차 JS 수정(Notifee PRESS·getInitialNotification에서 `remote.messageId` 기록)을 치과앱 `feature/DL-17059@d4de608`, 기공소앱 `feature/DL-17060@e9108b8`에 push, Development CodePush 치과앱 2.2.4 v142·기공소앱 1.0.5 v40. Draft PR #346/#42 본문·상태 불변. **2026-11-10 사용자가 iOS 실기기(CodePush v142/v40)에서 해결 확인 — 완료.** Android·debug 추가 확인 불필요.
2. **Android Notifee ReactHost 호환 패치:** 알림센터와 분리해 dentlink-app#348(→release/v2.2.5), dentlink-lab-app#44(→release/v1.0.6) PR까지 **완료**. 반영·심사는 앱 개발자. PR 본문 맨 위 요약(필요 이유·위험도 낮음~보통) 포함. 사용자가 앱 개발자에게 Slack(https://innovaidhq.slack.com/archives/C09613TBE5A/p1794289794684319)으로 공유 완료. 앱 개발자 요청으로 PR 브랜치 재설치·빌드 후 실기기(Galaxy S23) 테스트 완료: 치과·기공소 모두 Notifee 알림을 백그라운드/완전 종료 후 탭 → 주문 상세 이동 성공, logcat 오류 없음. PR 검증 표 갱신. 설치 APK를 폰에서 추출해 디버그 서명·NotifeeReactUtils의 ReactHost 패치 코드 포함을 dex로 재확인. 폰에는 테스트용 디버그 개발앱이 남음(기존 개발앱 재설치 필요). 다니엘 요청으로 PR #348/#44 제목을 `[QA] Android Notifee 알림 탭 ReactHost 호환 패치`로 변경. 다니엘도 기공소 브랜치 확인·문제 없음. Slack 실기기 결과 회신은 사용자 결정(미전송). 이 패치는 Jira 카드 없음. 실기기 대조(패치 없는 release 빌드): 두 앱 모두 백그라운드 탭 실패(홈/멈춤), 완전 종료 탭은 getInitialNotification 경로로 이동 → 실제 문제는 백그라운드 탭이고 패치가 해결. PR 문구를 백그라운드 기준으로 정정. 이 건 마무리: 앱 개발자에게 사용자가 직접 시연·공유, PR 요약의 위험도 문장까지 대조 결과로 정정, 로컬 PR 브랜치·worktree·임시 로그 정리(원격 PR 브랜치와 /tmp 증거 폴더는 유지), 폰 정리는 사용자.
3. **웹 알림센터 서비스별 노출 페이지 현황:** **완료**(기획자 공유, 결정 후 변경 또는 현행 유지). master `bafb0b1`·develop `d76c85f` 동일. 치과 웹: 미노출 없음. 기공소 웹 미노출: 주문상세 `/orders/[order_id]`, 주문 승인, `/mc/*`, `/milling/*`(데스크톱·모바일), `/pickup`·`/pickup/[id]`·`/shipping/[id]`·`/shipping/scan`·`/members`·`/my` 계열(모바일만). 상세는 codex-personal-context `projects/dentlink-unified-notification-center-web-visibility-2026-11-10.md`.
4. 루트 `patches/`(iOS Notifee 등) 새 설치 미적용 발견은 사용자 결정으로 **고려하지 않음**.
5. **같은 날 앞서 Codex가 한 작업에서 남은 것(사용자 결정 대기, 내가 먼저 착수하지 않음):** 웹 CodeRabbit 수정 `feature/DL-17058@38ca4ed`은 release PR #4862에만 있고 develop(개발서버)에는 미포함 — 반영하려면 별도 develop PR·배포 승인 필요. CodeRabbit Docstring Coverage 경고는 사용자 결정으로 추후 검토. 웹 개발서버·앱 실기기 사용자 QA(알림함 읽음·랜딩, 설정·권한·소속 전환, 실제 deliveryId 푸시)와 앱 개발자 PR(#346/#42) 리뷰 대기. 홈 연관 3건(DL-17062/17065/17068)은 본체 외.

**Why:** 다음 세션이 같은 조사를 반복하지 않고 남은 일(iOS 실기기 확인 결과 대응)만 이어가기 위함.
**How to apply:** 재개 시 위 정본과 live Git을 대조하고, 사용자 실기기 결과에 따라 다음을 정한다. 관련: [[dentlink-app-fix-approval-scope]], [[record-to-both-claude-and-codex-context]].

**갱신(2026-11-12):** PR #348/#44는 11-11 앱 개발자가 release에 머지 → 다니엘 머지 대기는 해소. 알림 설정 라벨 매핑 push(Office 8d9dfd5·Lab 2f6cb2d·Web 0b4cbab4f), 개발 CodePush·웹 develop 반영은 추가 개발 후로 보류(사용자 결정). 상세는 [[dentlink-notification-settings-render-audit-20261110]].

**메인 세션 마감(2026-11-10 19:05):** 이 세션 요청 모두 완료·대기. 남은 작업은 별도 세션 “알림 설정 목록 서버 데이터 의존 여부 조사”(displayName 제거·매핑 정리 범위 승인 대기). 대기: 다니엘 머지·심사, 기획 결정, 사용자 폰 정리.

**2026-11-12 dev 스웨거 재생성(commit 없음, 작업 트리 수정 상태):** 알림 설정 GET `/office|lab/notifications/settings` 응답이 `{view, setting}`→`NotificationSettingDto`로 바뀜(카테고리에 domain·toggleChannel·enabled·channels[{channel,enabled}], employee에 orderScopeOptions 코드 배열, view·OrderScopeDto 삭제). 세 제품 설정 코드는 옛 구조를 읽음(앱은 별도 `src/models/NotificationApi.ts`) → 사용자가 예정한 "알림 설정 목록" 추가 작업의 핵심. 그룹 규칙 차이·USER 표시도 그 작업에서 함께 다룸. appLandingUrl은 인박스 필드로 정식 반영, 앱은 이미 사용 중. Api.ts 전체 갱신은 알림 외 타입 오류(Office 6→315 주문 옵션, Lab 5→9·웹 lab 0→11 밀링)를 내므로 그대로 commit하지 않음. DL-17235는 사용자 카드가 아니라 남은 일에서 제외(사용자 지시). 로컬 Android 에뮬(Dentlink_API_36) 설치본(Office dev 2.2.4/134, Lab dev 1.0.5/9, 11-10 설치)은 Notifee 호환 패치 미포함. 패치는 release/v2.2.5·v1.0.6에만 있음.
같은 날 사용자 요청으로 release/v2.2.5·v1.0.6 developmentDebug를 에뮬에 설치(Office 2.2.5/135, Lab 1.0.6/10, 패치 클래스 확인, FATAL 없음, Metro 필요·알림 탭 미검증). 저장소는 feature 브랜치·스웨거 수정 상태로 복구.

**2026-11-12 브랜치 최신화·스웨거 반영(로컬 커밋, push 전):** 하위 세션 noti-sync-swagger가 앱 origin/main merge(충돌 없음), dev 스웨거 생성 결과 커밋, FE 가공 계층 수정. Office `cfa55ec`(스웨거 스키마 이름 충돌로 덮인 카탈로그 타입 5개를 `src/services/catalog.types.ts`로 유지), Lab `7cb252d`·Web `27c549f79`(밀링 parameterValues 요청 타입). 메인 재검증 tsc Office 6·Lab 5·웹 0, clean. 웹 DL-17195(release/v1.93.0)와 나중 merge 시 밀링 파일 충돌 가능. 다음은 알림 설정 API 추가 작업.

**2026-11-12 알림 설정 API 작업 근거:** Jira DL-17114 Leo 11-10 댓글(구조 변경 안내, PUT 일괄 교체·생략 시 초기화, MEMBER는 MY_ORDERS_ONLY 고정, 저장 시 읽기 전용 메타 제거), dev 스웨거 NotificationSettingDto, Slack PM 스레드 C04T5SU6A2U/p1794306299283819(11-12 매핑 유지, user credit 제외 예정, 숨김 주체 BE/FE 미정). 상위 DL-16140 댓글에는 옛 초안만. 디자인 카드 DL-17035 비어 있음.
**2026-11-12 방향(사용자):** BE 응답을 그대로 그리고 표시명만 FE 매핑. 유저 크레딧 숨김은 당장 안 함. 웹·앱 같은 규칙으로 맞추는 것이 작업에 포함(FE 고정 묶음 예외 제거).
**2026-11-12 노션 기획서(설정 절만) 대조:** 기획은 웹 PUSH 설정 없음(11-10 사용자 지시로 웹 PUSH 복원과 다름, 개발 협의로 바뀌었을 수 있음), 단일 카테고리 도메인은 단독·여러 개면 묶음, 도메인 전체 토글은 API에 없음. 기획 링크 https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd
**2026-11-12 PUSH·용어:** PUSH는 앱 전용(웹은 PUSH 채널·PUSH 토글 항목 미표시, 11-10 웹 PUSH 복원 되돌림). Figma 62:19720 기준 기획서 '도메인 전체 토글'은 실제 카테고리 토글(category.enabled, toggleChannel=NOTIFICATION) — 의도 같고 용어만 다름. 도메인 단위 토글은 없음.
**2026-11-12 Figma 2:6 대조:** 디자인은 참고(데이터 맞춤 미완). 채널 없는 항목(LinkTalk·덴트링크 서포트)은 같은 도메인이어도 단독 카드 → 규칙 '채널 없는 항목 단독, 채널 있는 항목은 연속 도메인 묶음, 1개면 단독'. 디자인에만 있는 항목(Case Preference, 기공소 Feedback/밀링 결제, Credit Email)은 응답대로 안 나옴. 기공소 밀링 단독 시 라벨 확인 필요. 디바이스 OFF 안내 흐름(173:28434)은 기존 구현 점검 대상.
**2026-11-12 최종 기준:** 우선순위는 알림센터 설정. BE 구조·배열 순서 그대로, 디자인 참고, 표시명은 PM 승인 매핑표(Slack 스레드 첨부 F0CFYPDJ8UF)대로 영/한 다국어. 그룹 제목은 ORDERS=Order/주문, MANUFACTURING=Milling Center Order/밀링센터 주문, CHAT=Chat/채팅(웹만)만 → 그 도메인만 묶고 나머지는 단독 카드. PUSH 앱만.

**2026-11-12 알림 설정 새 API 이전 완료(로컬 커밋, push 전):** Office `0947399`·Lab `901cfa1`·Web `75ac63b90`. 세 제품 공통 규칙(서버 순서, 그룹 제목 매핑 도메인만 묶음, options 2개 이상일 때만 범위, 저장은 GET 전체에서 읽기 전용 제거, 웹 PUSH 숨김·값 유지). 앱 NotificationApi.ts 삭제→생성 타입. 다국어: Office 앱 영어 고정(i18n 미초기화), Lab 앱 ko 고정, Web Clinic 영어, Web Lab ko. 라이브 PUT 왕복·화면 6종 확인, 원복 완료. 남은 것: push·배포는 사용자 지시 대기, Office 팝업 제목 "Lab" 문구 확인 필요. 정본 codex 프로젝트 파일 상단.

**2026-11-12 후속(사용자 지시):** 영역 순서는 **user를 먼저**(이후 바뀔 수 있음) — Office `23966fc`·Lab `e64b61d`·Web `7891e21c2`. 사용자 지시로 세 브랜치 push 완료(웹은 E2E 가드 NO_IMPACT 기록 후). 배포(웹 develop·앱 CodePush)는 아직.

**2026-11-12 기기 OFF 안내(사용자):** 디자인과 같으면 유지 → Office 팝업 제목 "Get Lab Updates Instantly"(Figma 동일) 유지, 앱 진입 팝업은 기기당 1회(AsyncStorage `NOTIFICATION_PERMISSION_NOTICE_SHOWN`)라 디자인과 같음. 코드 변경 없음.

**2026-11-12 재점검(보고만, 메인 경유 요청·사용자 직접 요청 아님, 목록은 참고·진행은 사용자 결정 전):** 이미 push 상태. 리뷰 지적: 웹 settingCategories 조회 단계 누락(내 회귀), CodeRabbit categories 누락 방어·channels 생략 정책·밀링 FILE 계약, Lab PR #42 리뷰(배열 원소 null 검증·StyleSheet→styled, Office도 동일). 상세는 codex 정본 최상단.

**2026-11-12 저녁 마감(사용자 지시로 최소 단계에서 멈춤):** Web 로컬 커밋 `7968ad66b`(channels 생략=토글만·categories 누락 차단·null 항목 조회 실패·설정 표시명 조회 복구) **push 전** — E2E 가드 재실행 필요. Office·Lab은 같은 응답 검증·null 처리·인박스 StyleSheet→styled 변경이 **미커밋 상태**(검증 완료: Office 테스트 50·tsc 6, Lab 53·tsc 5), 패치 백업은 side-session-notes `pending-app-patches-2026-11-12/`. 남은 일: 웹 가드·push, 앱 커밋·push·리뷰 resolve·화면 재확인, BE 노출 키 오면 웹 PUSH 숨김 교체, 밀링 FILE 계약은 범위 밖, QA 요청. 정본 codex 최상단 "오늘 마감 상태".

**2026-11-12 리뷰 대응 push 완료(위 저녁 마감의 Git 상태 대체):** Office `4ed34bf`, Lab `0f03901`, Web `7968ad66b` push, 웹 E2E 가드는 사용자 지시로 SKIPPED. 남은 일: Lab #42 리뷰 resolve·인박스 화면 재확인·BE 노출 키 반영·QA.

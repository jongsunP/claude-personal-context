---
name: 알림 설정 즉시 반응 보완 및 로컬 확인 대기
description: 11/13 설정 즉시 반응 UX 개선·사용자 로컬 확인 후 개발 전달 완료, 실기기 QA 대기
type: project
---

- 사용자 요청: 깜박임이 없어져도 UI가 서버 확인까지 기다리면 답답하다. 일반적인 방식으로 즉시 표시·성공 유지·실패 복구, API 과잉 설계 없이 처리. 작업/검증/커밋푸시 승인, 배포 금지·로컬 확인 뒤 별도 승인.
- 기존 최신 GET→전체 PUT→제한된 확인 GET을 유지하고 현재 mutation 선택값만 화면에 합성. 서버 캐시는 확인값만, 상하위 연동/메타/숨겨진 다른 범위/OS권한 유지. 저장 입력 차단·소속/계정 늦은 응답 보호·성공 분석 이벤트 유지. 새 API/큐/debounce/native 없음.
- 최종 Web feature/DL-17058@542b0c4e8969ac6a3443631fd3a15811fdc1cf71, Office feature/DL-17059@a6ee48c7f51555bbfb5dfcebae91b6342184d7da, Lab feature/DL-17060@2c638fa0d7424aac44f4578e636be70e7dd35cde. 모두 원격 동일·clean, 기존 PR4862/346/42 head 자동 반영, 배포 없음.
- 검증: Web tests24/실제렌더15조건, Office65/Lab16 tests 및 최종 iOS·Android 실제 화면 지연/성공/실패복구·중복차단·새LogBox/crash없음. 통제된 지연/실패fixture·실제설정쓰기/분석송신0. 앱tsc기존6/5건 유지·신규0. 최종root독립리뷰/대표캡처확인.
- 배포 유지: WebDEVb8ce6c6ae(featureb6cffe2f8), Office Developmentv146/v146(2.2.4), Labv45/v44(1.0.5). 신규 수정은 미포함.
- 공통 DEVELOPMENT_STYLE 보완: 깜박임과 반응성 둘 다 점검. 승인된 일반 설정은 안전한 즉시 표시·확정/복구, 성공 전 저장성공 주장 금지, 비동기 중복 최소 가드, 제품별 동일요구 함께 최종 검증. 사용자 선택을 다음 방문까지 거짓 저장값으로 남기지 않음.
- 사용자가 로컬 확인 환경 요청: Office 양OS 같은 최종 DEV코드·외부실행터미널·Reactotron 두연결/선택기, 웹은 실행하지 않고 worktree/서비스 위치 안내. 준비 완료: Officea6ee48c7/Metro8081 외부Terminal 실제실행, iOS17Pro26.5+AndroidDentlink_API_36 같은DEV, Reactotron두연결/선택기펼침·fixture없음·LogBox0. 지속터미널2개와앱켜둠. 종료생존시험은아니며process ancestry검증. 사용자 창 보존, 별도 배포 승인 전 자동배포/감시 없음.

정본: /Users/parkjongsun/Repository/codex-personal-context/projects/dentlink-unified-notification-center-settings-response-2026-11-13.md

## 후속 최종 배포·마감
- 사용자가 로컬에서본것괜찮음확인후 배포승인. 웹 DEVPR4891→develop7c8eef28c(source542b0c4e8와tree동일),16:59:23KST Clinic43389706697/Lab43389706714 in_progress1회확인. 완료/서버폴링안함.
- Office Development iOS/Androidv147(target2.2.4/sourcea6ee48c7), Lab iOSv46/Androidv45(target1.0.5/source2c638fa) 게시·활성확인. native/asset변경0·4번직렬/TMPDIR격리. 원PR4862/346/42유지·앱소스clean. 위 미배포기록은승인전이력.
- 본인 Jira17058/59/60 댓글45032/45033/45034반영,ReadyforDeploy유지. Notion배지정책문서이번변경없어무수정. 개인/Claude/Codex기록마감. 사용자LocalOffice양OS/외부Terminal/Reactotron유지.
- 사용자질문PUT뒤GET2회: 정상후확인1회·구응답이면제한재확인. 웹focus재조회OFF, 세제품현재scope성공중복invalidate없음. 네트워크원본없이사용자가본두요청원인단정안함. 현재코드수정필요발견없어그대로정리. 사용자가실기기QA후이상시알려주기로했으므로추가작업/모니터링없이대기.

- 오늘 최종 브리핑은 사용자 프롬프트 기준으로 정본의 오늘 요청 대비 마감 요약 표에 기록했다. 과거 크레딧/청구서·구필터 API 제거를 오늘 신규작업으로 중복 집계하지 않는다. Figma/구API확인/범위정리/DEV검증/깜박임/즉시반응/Amplitude/API중복/iOS제보/개인count정책/미리보기·지침·배포마감으로 구분. 로컬Codex DEVELOPMENT_STYLE/PROJECTS 복사본도 백업후동기화 완료.

## 마감 후 실제 API 검증 요청
- 사용자에게 이전은코드/fixture검증이었음을설명한뒤 이번에는 실제로 양웹(local3030/3035)·Office대표iOS·Lab대표Android에서 실제DEV설정1개변경/원복을직렬관찰. API응답대체없음.
- PUT모두200/code0001/data:null. postGET 변경/원복횟수 Clinic웹2/1, Lab웹1/2, Office2/1, Lab앱1/2. GET2인경우 첫응답구값→약200ms후변경값. 첫응답정상이면추가GET없음. 웹CDP저장mutation동일initiator·앱focus변경없는mutation경로확인. 저장확인GET유지타당·추가수정없음.
- 정상검사전체설정원복exact/hash확인·관찰/SDK복원·최종idle/LogBox0. Office초기service계측wrapper오류400거절은근거제외,초기전체hash미수집한계정본기록;이후Axios-only정상시도에서전체원복확인. 제품버그아님.
- 자체웹/Lab서버종료, 사용자Office8081외부실행/양기기/Reactotron두연결복원·유지. 코드/Git/PR/배포변경없음,당일최종DEV그대로. 실제요청개수와범위·한계는Git정본추가실API절에보관. 다시대기.

## 조회 필터 저장 방식 유지 및 Jira 경계

- 사용자 확인: 현재 저장 방식은 그대로 유지하고 메모리만 남긴다. 기존에 [Slack 스레드](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794363519212339)에 공유했다고 다시 알려주었다. 이번에는 Slack 내용을 재조회하거나 쓰지 않았다.
- 치과 웹은 주문목록 `myOrderOnly`, 환자목록 `myPatientOnly`를 URL 쿼리로 관리한다. 쿼리가 없는 메뉴로 재진입하면 기본값이다. 근거: `clinic/src/lib/OrderList/useOrderList.tsx`, `clinic/src/lib/PatientList/usePatientList.tsx`의 현재 코드.
- 치과앱 주문목록·링크톡은 이전 서버 push-preferences 연동을 제거하고 기존 useOrderStore/AsyncStorage만 사용한다. 환자목록은 이전부터 AsyncStorage였다. 저장 방식이 같아진 것이며 주문 필터와 환자 필터가 동일한 하나의 값이라는 뜻은 아니다. 알림 수신 설정은 새 API의 별도 서버 값이다.
- 앱에도 navigation/route params가 있다. 로컬 저장을 택한 이유는 라우터 부재가 아니라 조회 필터와 알림 수신 설정의 분리 및 재실행 때 선택 유지다. AsyncStorage는 웹 localStorage에 대응하는 영속 저장이며 로그아웃으로 자동 삭제되는 저장소가 아니다. 앱의 로그아웃·토큰 만료·소속 전환 등 기존 명시적 초기화가 해당 값을 지운다. 재설치 전까지 무조건 유지한다고 설명하지 않는다.
- 기존 Jira 대조: `parent = DL-16140 AND assignee = currentUser()`로 본인 하위 **21건 전부**의 제목·본문·상태를 조회, 다음 페이지 없음 확인. 기존 주문목록·링크톡 조회 필터의 로컬 저장 전환을 미완료로 둔 독립 카드는 없다.
- 이름이 비슷한 **DL-17065(해야 할 일)**는 `[본체 외] Office 앱 홈 ‘나의 주문만 보기’ 필터·최초 안내 추가`다. 홈 신규 적용/최초 안내와 그 범위의 저장 정책을 정하는 별도 작업으로, 이번 기존 목록 필터 전환 완료와 합치거나 완료 처리하지 않는다. DL-17415/16/17은 수신 설정의 플랫폼 노출·개인 설정 계약이므로 이 필터 저장 방식과 별개다.
- 제품 코드·PR·배포·Jira 생성/수정/상태 변경 없음. 개인 컨텍스트와 Claude/Codex 보조 기억만 정리한 뒤 대기한다.

## 후속: 미착수 카드 대기 조건 정리 (2026-11-13 18:08 KST)

- 사용자 승인으로 DL-16140 본인 미착수9건 본문에 대기 사유·재개 조건을 기록하고 live 재조회 검증. 모두 해야 할 일 유지, 제목/담당자/부모 유지·SP 수정 없음. 제품 코드/PR/배포/로컬 화면 변경 없음.
- DL-17065는 PRD에 홈 필터·앱 최초1회 안내가 있으나 Figma 홈2:2920/페이지metadata/댓글143개 대조에서 해당 배치·안내 디자인 확인 안 됨. 디자인 전 구현 대기. 웹·앱 독립저장/재로그인유지/MEMBER고정·토글숨김/앱최초1회는 확정 기준. Track your orders의 기존 API필터 활용 가능, Action Required 포함 시 집계 API 지원 확인. 기존 로그아웃 초기화와 홈 정책 적용은 구분. 기존 Orders/LinkTalk 로컬저장 전환 완료와 별개.
- DL-17068 디자인·세부기획 대기, 기존 SupportAPI 최근1건 재사용 우선.17062는 홈 메시지 제외대상/서버목록·집계 대조 후 별도착수, 디자인없어불가라고 단정하지 않음.
- 17415/16/17 설정노출·개인설정 계약대기(해결된 개인알림카운트정책과별개),17418/19 향후배지정책·BE대기(현행푸시수+0초기화유지),17426 별도E2E착수/데이터준비대기. 신규디자인 없는 UI를 임의구현하지 않고 기존 승인디자인 재사용까지 일괄중단하지 않음.
- 상세정본: codex-personal-context/projects/dentlink-unified-notification-center-settings-response-2026-11-13.md 의 미착수 후속 작업 절. 기록 후 추가 작업 없이 대기.

## 웹 문구·스타일 정리 및 Office 주문 상세 후속 (11/13 추가 요청)

- 사용자 승인으로 Copy 의미를 명확히 한 `useNotificationMessages`로 변경, Inbox/Settings 별도 styles.ts 2개를 제거하고 기존 컴포넌트 하단 스타일 패턴으로 정리. 의미 있는 UI 단위5개 분리·각200줄이하. 화면/문구/API/권한/동작 변경 없음. 드문 styles.ts 사례를 주된 팀 규약이라고 단정하지 않는다.
- Web feature/DL-17058@a67e1e215c49f21c3139df6edd5df8d901771294 커밋·푸시·원격일치/clean. PR4862 release/v1.94.0 대상/Draft 유지. 개발 배포·앱 코드·CodePush 없음. 기존 개발 전달 상태와 구분.
- styles39개 AST 동일·hook 이름외동일·기존tests9개·Clinic/Lab/Admin tsc·정상pre-push 통과. 최종 Clinic/Lab 실제브라우저 인박스/설정/읽음/범위/토글/복귀·영한표시 검증, 새pageerror0. 알림API는fixture, 실제서버쓰기/분석0. 자체검증서버3030/3035만종료·사용자화면보존.
- i18n 문구/키/도달범위 불변. **11/11 최신 사용자 지침으로 시트 및 사용처 메타데이터 동기화는 중단**되었다. 43개키 사용처ID를 다음 동기화 대상으로 남긴 것은 옛 절차 적용 오류로 11/13 정정. 코드 ko/en만 관리·검증하고 시트 작업을 잔여로 남기지 않는다. 실제 시트쓰기없음. 기존Signin unknown literal은별도이며전체audit clean주장금지.
- 사용자추가안내: 1.93.0에서 치과앱만 주문상세가 WebView→자체화면으로 전환예정. 1.94.0 알림센터준비시 1.93배포후 실제screen/appLandingUrl/pushdeeplink 대조. URL유지+내부라우팅우선, 필요시만PM시트·BE저장값변경공유. 기공소앱제외. DL-17436 본인하위ToDo 생성·재조회;SP미지정. 현재앱코드/시트변경없음.
- 상세정본: codex-personal-context/projects/dentlink-unified-notification-center-web-convention-2026-11-13.md 및 dentlink-unified-notification-center-office-native-detail-followup.md. 다음재개시 미배포코드/Office후속을 챙기고 자동배포·폴링없음.

- 11/13 최종대기: 번역시트갱신후속철회·코드ko/en만검증, 웹a67e1e215 push완료/미배포 유지. 시작·재개 및 업데이트안내/규칙충돌시 관련정본 자동재확인 규칙보완. 제품추가작업/배포/폴링없이대기.

- 오늘마감/재개요청: 다음재개시 배포상태와남은일 먼저브리핑. Weba67e1e215 push/PR반영완료·미배포,이번앱변경없음. BE/디자인·QA대기와Office-onlyDL17436(1.93후)을구분. 번역시트후속없음. 전체지침필요시자동확인·반영,무조건전수조회아님. 브리핑자체로배포승인추정금지·추가작업/감시없이대기.

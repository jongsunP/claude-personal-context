# 알림센터 실제 설정 저장·이전 리뷰 확장 감사 (2026-11-12 22시대)

> 최신 상태: [11/13 DEV 배포·후속 수정 정본](notification-center-dev-delivery-20261113.md). 웹 DEV/양앱 Development 게시·검증 이후 Webe34325468/Office3fe716a/Labcc41f03으로 새 디자인·설정 저장 표시를 보완하고 push했다. 이 후속 커밋은 미배포이며 사용자 다음 지시까지 대기한다. 아래는 당시 감사/배포 이전 상태의 이력이다.

## 2026-11-13 사용자 범위 정정 — 밀링은 이 세션 업무가 아님

- 알림센터는 2주 뒤 1.94.0, 밀링 등은 다음 주 1.93.0 배포 예정. 1.93.0이 master에 들어온 뒤 알림센터 브랜치에서 그대로 수용한다. 이 세션은 밀링 구현·검증·API 질문·리뷰를 선행하거나 책임지지 않는다.
- 아래 FILE 통합/리뷰1건은 과거 기록이며 알림센터의 잔여/완료조건에서 제외. 범위를 과도하게 넓힌 것으로 정정. 이미 push된18e64650c/9c873941f를 이번에 원복한 것은 아니다.
- 직전 분리 요청으로 DL17420 범위제외·1.93정본수용으로 제목/본문/댓글45019 정정하고 불필요한 추적 종료로 완료 전환했다. 사용자 추가 명시 후 범위 밖 코드·지라에 더 조치하지 않는다.
- 본체 확정FE 구현/push완료, 남은 외부확인은44994 플랫폼노출과45009 실제발송적용. 승인된 재배포·실기기 최종FCM/설정QA는 별도. 신규코드/배포/타세션전달없음.

## 2026-11-13 최신 Figma·확정 FE 후속 완료, 웹 FILE 조회 계약 1건 대기

- 최신 정본: codex-personal-context/projects/dentlink-unified-notification-center.md 최상단. 아래 '조사만/미반영' 기록은 과거 상태다.
- Web feature/DL-17058 9c873941f, Office feature/DL-17059 ca8a6f0, Lab feature/DL-17060 f5de5f4 원격 동일·clean. 기존 Draft PR4862(release/v1.94.0)/346·42(main) 유지·본문 최신화. **배포·develop/release merge·CodePush 없음.**
- Figma 최신 확정: 일반 병원선택 소제목 Your Other Offices(Clinic웹/Office앱); 웹·양앱 알림숫자 최대999(999+아님),0숨김·All무숫자·실제서버집계유지. 앱 접근성은실제수유지.
- 추가 사용자 링크2006849946(11/13 11:36~37): Office 주문알림범위 하단sheet 중복 Orders to notify me about 제목만제거(ca8a6f0). 설정화면행/권한/옵션/저장유지,웹대상아님/Labscope창없음. 일반소제목·숫자는f78f7a0.
- 일반 병원선택은 기존소속조회,알림용은별도 /office|lab/notifications/inbox/employers/unread(이미DEV제공),단순히배지만다르거나같은API가아님.
- 구 push-preferences 호출제거/조회필터AsyncStorage·상위하위동시ONOFF/channels[]단독·누락/null방어는직전완료재확인이지오늘새구현으로중복집계하지말것.
- 웹 master9c4418a8f통합 f14cd24ad, 기존FILE완료코드만18e64650c에통합(생성DTO손수정없음), 저장중파일추가삭제경합재현/기존pending차단9c873941f. FILE52+알림29테스트·3제품type/훅/최종guardSUCCESS.
- CodeRabbit 기존7스레드resolved,새1건 START조회계약은미해결. 문서에완료전parameterValues={}인데시작값병합설명혼재,실GET은테스트계정밀링권한없음(400/26012). 사용자질문: 공정시작저장값(파일포함)이완료전GET에도오는가,내부/외주동일한가. 기존문자열START에도보충입력조건존재. 임의정책수정안함. 봇4559100162도실제BE오류단정정정/확인대기동의.
- Jira17058#45018/17059#45013/17060#45014/17063#45017완료기록. DL17420정의정리·45019진행기록,BE확인남아진행중유지. 상위댓글/타인카드/스토리포인트/Slack/Figma쓰기없음.
- Office기존관련12tests/lint·tsc기존6,Lab lint·tsc기존5. 양앱양OS 최종렌더경계0/1/999/1000,소속sheet·접근성/복구/GET확인. Office추가sheet제목도양OS검증. 임시cache/fixture복구·실서버쓰기0·새LogBox/crash없음. CDP핸들러+캡처이며물리탭전수/실기기/FCMQA아님. iOS26.5/iPhone17Pro+Dentlink_API_36.
- 검증용프로세스/이번부팅기기종료,사용자창보존. Office기존yarn start의 --experimental-debugger는현CLI거절이나외부command는이미정상 npx react-native start. 본체밖기존script부채로기록만.
- 대기: 위FILE1건,기존44994플랫폼노출키/45009실발송적용. Promotion후보는11/10'디자인무시·확정후공유'유지. Home3/이메일/SES/native/OS배지후속은본체밖. 재개시이결과부터대조,배포별도승인. 자동모니터링없음.

## 2026-11-13 오전 재개 + Figma/Jira 추가 검토(코드 수정 전)

- Web17699c5e6/Officef152f6c/Labdd1368c 원격동일·clean, PR유지, 새BE답변없음. 최신필터/토글수정은 아직미배포.
- Office구push-preferences GET/PATCH 활성src호출0(생성Api제외); My Orders Only는usePersonalOrdersPreference→useOrderStore/AsyncStorage, 새알림orderScope와분리. UI·권한·MEMBER·Home값유지, logout/token만료/소속전환성공시bool초기화. 원격코드는완료/구배포앱호출은별개.
- Figma1995951639의11/13 10:32 디자인변경답글+실제48:12796/596:32755+WF490:25079일반/알림웹앱대조. 공통카드·현재카드·scroll/maxheight는반영. 차이는배지뿐아님: 일반다른소속전체/알림미읽음다른소속, 일반앱Payment·웹AddNewOffice유지.
- **새미반영2건:** PM2002979261(11/11 09:16) 일반소제목Your Other Offices가Clinic OfficeSelectListModal:69/Office EmployeeSelectList:55에아직Change Office. 알림제목/소제목은일치. 1995457432(11/13 10:30) 알림숫자999까지표시+399:23417주석3자리추가, 현재웹/양앱Unread·소속숫자raw출력상한없음. LinkTalk기존경로도raw여서자동으로충족된다고말하면안됨. 표시만보완/서버집계유지; 제품구현아직안함.
- 프로필Promotion토글후보2001066057는11/10후속'아직디자인무시·확정되면공유'라보류유지. Figma최신50댓글+미읽음+지정스레드읽기전용,쓰기없음.
- Jira11/13 10:59 parent16140/17114/본인하위19개최신순변경없음,45009실제발송/44994노출키대기. 알림함직접도구없어이슈댓글/메일검색보완,알림함전수직접확인아님.
- 개인정본 projects/dentlink-unified-notification-center.md 최상단이최신. 이번은조사/기록만,다음승인시디자인2건반영·비례검증. 기존FILE/실FCM/본체밖범위유지.

## 사용자 마감 확정 — 2026-11-13

- 사용자 요청한 작업/기록 모두 마감, BE 답변을 사용자가 전달할 때까지 대기. 후속 배포 금지·자동 조회/감시/폴링 금지.
- 최종 Web17699c5e6/Officef152f6c/Labdd1368c clean·원격추적일치 재확인. 기존 PR 유지. 이 후속 수정들은 기존 DEV배포와 다름.
- 남은 BE: DL16140#45009의 실제발송차단/재개(동시저장 자체는 실API검증완료), DL17114#44994의 플랫폼노출키. channels[]단독·생략/null 리뷰는 해결완료라 미정으로 재등록하지 않음.
- 다음은 답변/최신정본/Git 대조부터, 추가FE 필요시승인범위만. 배포/실기기최종FCM은별도. FILE통합17420·Home3·이메일·native/배지후속·선택주석커버리지 기존분리경계유지. 구 API 삭제는 구배포앱호출/배포범위와별개.

## 최신 정정 완료 — 11/12 요청, 11/13 자정 이후 마감

- 사용자 재확정: 기존 Figma UX는 부모OFF→부모와해당자식전부false, 부모ON→전부true. 과거개별OFF도재ON시true, 그뒤자식개별조작가능. API주석의 자식보존가능을 FE의 필수UX로 오해했던 아래 판단은 폐기.
- Web feature/DL-17058 `17699c5e64034a74a2a0ac1e3cb4bd6e6fbfcd0a`, Office feature/DL-17059 `f152f6cd44cc152f659f94ec888f7c94abd995d7`, Lab feature/DL-17060 `dd1368c104922413e89c85bbb0e15cd6bf2a2454` push/원격일치/clean. PR4862/346/42 유지, 배포없음.
- 같은category의웹숨긴PUSH도함께바꾸지만 다른category/employee-user영역/다른숨긴항목은보존. 실제PUT기대한각child가GET에있고값같아야저장확인성공. UI문구·생성API·OS권한flow·플랫폼노출정책은변경없음.
- 실제Clinic/Lab웹 및양앱양OS PUT/GET·하위개별변경·전체정확원복. 관련tests Web29/Office57/Lab14, 웹3서비스type통과·앱기존6/5타입진단. 관찰된관련오류없음,실제발송/물리탭전수QA아님. 검증용실행만종료.
- channels[]리뷰원문정정: 정상빈배열이문제가아님. Web CodeRabbit4547672179는channels키생략을조회실패시키던검증,4547672172는categories누락을[]로전체PUT해설정초기화위험. Lab개발자4547596560은channels:[null]등손상원소크래시. 기존수정/resolve확인. 정상[]는단독토글이고BE추가작업필요없음.
- 사용자JiraDL16140#45009(11/12 23:50) 공유원문확인, 직접쓰기는없음. 실API검증으로동시저장가능확인. 실제발송반영은45009의BE답변범위. 별도플랫폼키44994답변대기유지. 질문중복전달금지. 아래 'enabledfalse/PUSHtrue시발송차단질문'을새로반복하지말고최신45009기준으로대조.
- 개인정본최상단/감사마지막절이최신. 다음재개시이결과와BE답변/기존잔여확인후별도승인배포. 이전DEV에는새부모동시변경/Office로컬필터분리/금융보완미포함.

## 후속 승인 작업 완료 — 2026-11-12 23시대

- Office 구 GET/PATCH push-preferences 활성 사용을 제거하고 주문목록·LinkTalk My Orders Only를 기존 useOrderStore/AsyncStorage 로컬값으로 분리했다. 새 알림 설정 employee.orderScope와 독립이며 이관/기기간동기화는 하지 않는다. 초기화·기기간차이는 사용자 허용.
- Office feature/DL-17059 `9d3b54ecf5a49e2339def991e9d46f9f280c0895` push·원격일치·clean. PR346 유지, 배포없음. 이전 DEV v143에는 이번 수정/94334d2a 금융보완 없음. Web2a65e8eec/Labd018b85는 활성 구API 호출 없어 변경불필요.
- 계정logout/빠른전환/토큰만료/소속전환 성공은 해당bool만 초기화, 늦은AsyncStorage 복원이 새선택을 덮지 않게 보완. MEMBER 제한·Home myOrderOnly:false 유지. 고아Profile설정/구wrapper 정리, 생성Api.ts미수정.
- 관련6 suites29 tests/lint오류0/diff통과, tsc기존6진단. 양OS 실제OWNER Orders→LinkTalk/미읽음/재실행유지, 제어MEMBER 숨김/강제범위 확인. 구API0·settings쓰기0·실GET전체동일. 모든검증wrapper/role/local원복, 정상설정화면확인. 물리탭전수·실제MEMBER계정QA아님. 이번실행만종료.
- 설정 질문: channels:[]는 BE가 정의한 정상 단독토글, UI깨짐/임의보정/BE추가요청대상 아님. 플랫폼노출키44994 답변대기는 그대로.
- 상위OFF는 이미 enabled:false로 저장하지만 자식선택값은 보존. PRD는 상위OFF 때 해당항목 전채널발송중단을 요구. BE가 enabled:false에서 PUSH/MAIL:true도 발송차단하는지 1건확인필요. GET/PUT/UI확인을 실제발송차단확인으로 확대하지 않음. 부모OFF 보존과 다른카테고리/영역보존을 혼동하지 말 것. 답변전 하위값을임의일괄false/true로바꾸지않음.
- 다음재개: 이번결과와 플랫폼키·상위OFF발송조건·기존FILE통합/실기기QA 잔여부터 보고. 아래22시대 미구현/연동정책미정 기록은 이결정으로대체됨. 구배포앱 호출은 남을수있어 서버즉시삭제를 승인한것아님.

정본: `/Users/parkjongsun/Repository/codex-personal-context/projects/dentlink-unified-notification-center-settings-audit-2026-11-12.md`.

- 이번 사용자의 핵심: 이전 리뷰에서 기본 규약/크래시 방어를 놓쳤으므로, resolved 댓글만 확인하지 말고 feature 전체 변경에 같은 누락이 있는지 검토. 공통 DEVELOPMENT_STYLE Feedback And Completion에 반영.
- Clinic/Lab 웹과 Office/Lab 양OS의 실제 DEV 설정 GET→표시→최소 토글 PUT→GET 확인→전체 초기값 원복 완료. 웹은 localhost의 정확한 feature 코드, 앱은 기존 DEV Debug+해당 Metro. 사용자 실기기/실제 FCM QA와 다름.
- `channels:[]`는 부모 enabled 단독 토글, hidden값/부모OFF 자식값 및 전체 PUT 보존 확인. `toggleChannel`은 노출 플랫폼이 아님. 현재 데이터 PUSH 부모는 자식[]여서 MAIL 동반 손실은 없지만 미래 계약까지 보장하지 않음. DL17114 사용자44994의 노출키 질문에 아직 답변 없음, 중복문의 금지.
- 확장 감사에서 Office 추가 Credit/Statements 서비스의 null 행 통과를 발견. 서비스 거절→기존 Retry로 수정하고 전용 임의 오류 설명 제거. 양OS 실제 데이터/HTTP 경계 null 주입/Retry/실제 데이터 복구 검증 완료. Office94334d2a push.
- Web테스트563줄을 설정427/읽음260줄로 나눠 규약 준수, 기존12테스트·3서비스type·훅 통과,2a65e8eec push. 제품 동작 변경 없음. Labd018b85는 추가수정불필요·clean.
- 인박스 빈 목록 helper는 Figma Clinic앱29:11711/웹48:11209에 실제 존재. Lab138:21126은 제목만. 이전 출처미확인 해소.
- 기존 앱/CodeRabbit 리뷰를 실코드로 재대조. FILE통합 DL17420만 여전히 별도 미완. Office PR346 inline0은 bot승인을 뜻하지 않음. 모든공용/전체제품QA 완료라고 확대하지 않음.
- 새 배포 없음. 기존 PR4862/346/42 유지. 앞선 OfficeDEV v143에는94334d2a가 아직 없음. 이번 검증용 실행만 종료, 다음 재개 시 이 결과와 플랫폼키/FILE통합/실기기FCM 등 남은 일 보고 후 진행.

개인 정본 마감 commit `a9c11ba69c3d9906fe248c829375bcdb9f0e56e5`, origin/main 동일·clean 확인.

후속 Slack1794488063: BE가 legacy GET/PATCH push-preferences 신규API 교체/화면정책 질문. 현 소비는 주문목록·LinkTalk 조회/미읽음/하단탭배지이며 **Home주문목록은 myOrderOnly:false 고정**(과거Home소비표현정정). 새 orderScope는 알림 수신 범위. 단순통합하면목록필터와수신범위가서로바뀌므로연동정책만확인필요. 답변초안만, 구현/Slack쓰기없음.

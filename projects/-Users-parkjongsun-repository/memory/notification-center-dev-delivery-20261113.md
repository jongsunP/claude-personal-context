# 알림센터 개발 배포 및 개발환경 검증 — 2026-11-13

상태: **웹 DEV 배포·양앱 Development CodePush 및 가능한 DEV 검증 완료. 기존 검토 PR 유지.** 이후 새 디자인과 설정 저장 중 화면 깜박임/위치 이동은 별도 후속 수정으로 구분한다. 후속 변경은 재배포하지 않는다. 별도 DEV QA 위젯 모바일 클릭 겹침, 실제 OTA 적용·iOS 실기기 권한 전환·실푸시 E2E·MEMBER 실계정은 아래 한계로 분리한다.

## 승인 범위

- 기존 검토 PR Web4862·Office346·Lab42 유지.
- 웹 작업 브랜치를 개발서버에 반영하고 양앱 Development CodePush 게시 후 접근 가능한 DEV 웹/앱을 실제 API와 대조한다.
- 테스트에서 확인한 알림센터 FE 문제는 수정·검증한다. 실제 푸시 발송 E2E, 미정 BE/기획, 밀링 기능 개발은 제외한다.
- 제품별 테스트 계정의 소속 전환·설정 저장은 웹/앱 사이에 순차 실행하고 설정을 원복한다. 배포본과 로컬 Debug의 검증 증거를 구분한다.

## 웹 배포 경로

- 사용자는 원격 develop 삭제 → 최신 origin/master 기반 재생성 → 원 알림 feature를 DEV PR로 반영하는 기존 절차를 재확정했다.
- 기존 develop `e72bbafbee803bac973ea8e5015731c7407b2df8`를 기록하고 삭제, master `9c4418a8f`에서 재생성했다.
- [DEV PR4885](https://github.com/Innvoaid/dentlink-client/pull/4885): feature/DL-17058 `9c873941f` → develop, 병합 후 `06f519aa6fd4394d9250c2340c4977615662e61c`.
- Clinic [43361847274](https://github.com/Innvoaid/dentlink-client/actions/runs/43361847274), Lab [43361847130](https://github.com/Innvoaid/dentlink-client/actions/runs/43361847130)가 12:52:49 KST 같은 develop SHA에서 자동 시작했다. 수동 workflow_dispatch는 실행하지 않았다.
- 13:07:49 KST 이후 첫 결과 확인에서 양 workflow 성공을 확인했다. Clinic workflow의 served BUILD_ID 확인도 통과했다. 이 결과 이후 실제 DEV 웹 화면 테스트를 시작했다.
- 처음 준비하던 기존 develop 보존/선별 전달은 사용자의 정정으로 폐기했다. 그 중간 전달 커밋은 배포하지 않았다. 검토 PR4862는 병합하지 않았고 release/v1.94.0·Draft를 유지한다.

## 문서 범위 정리

- 과거 11/12 delivery/review/settings-audit 문서 앞부분에 밀링 담당 범위 정정을 추가했다. 과거 증거는 보존하며 현재 필수 잔여로 읽히지 않도록 했다.
- 밀링1.93.0 구현/검증은 별도 담당자 책임이며 알림센터1.94.0은 해당 변경이 master에 반영된 뒤 수용한다.
- 별도 밀링 카드/코드를 추가 수정하지 않는다. 알림센터 본체의 BE 노출 기준44994와 실제 발송 적용45009 답변 대기는 유지한다.

## 후속 결과

### 앱 게시 확인

| 제품 | 소스 | iOS | Android | 대상 바이너리 |
| --- | --- | --- | --- | --- |
| Office | ca8a6f0809fde4f0e58663c093c9a8d7700c859e | v144 | v144 | 2.2.4 |
| Lab | f5de5f425c2cf236d39ccb43ece07cab18bd93f7 | v43 | v42 | 1.0.5 |

- 모두 Development 활성·mandatory·rollout100. 제품별 별도 TMPDIR를 사용하고 네 플랫폼을 순차 게시했다. 네 플랫폼의 asset hash는 직전 안전한 배포와 일치했다.
- 현재 양OS 설치본은 Debug이며 `__DEV__`에서 CodePush를 건너뛰므로 이후 화면 확인은 **최종 배포 SHA + 실제 DEV API** 검증이다. 맞는 대상 버전의 기존 Release artifact가 없어 OTA 적용을 직접 확인했다고 하지 않는다. 별도 네이티브 릴리즈·타깃 확장 없음.
- Office 실제 설정 API에서 상위 OFF/ON·하위 동시 변경, 하위 개별 변경, channels:[] 단독 토글, 전체 원복 확인. Android 실제 OS OFF·앱복귀·배너, OFF 유지 복귀 시 PUT 없음, 항목 선택→OS ON→복귀 시 해당 항목만 저장·원복 확인.
- iOS 시뮬레이터의 알림 설정 링크는 Settings 홈으로 열려 실제 OS 알림 OFF/ON 조작은 제한됐다. Android 검증으로 iOS까지 확인한 것으로 확대하지 않는다.

### 앱 검증 완료

| 항목 | Office | Lab |
| --- | --- | --- |
| DEV 응답과 설정 화면 | employee7/user1, orderScope MY_ORDERS_ONLY·2옵션, User/Office Credits·LinkTalk·Order·Shipping·Payments 매핑 일치 | employee5/user0, orderScope null/options[], LinkTalk·Support·Order·Manufacturing 일치, scope 선택 UI 없음 |
| 상위·하위 저장 | 양OS에서 상위 OFF/ON 시 하위 동시 변경, 다른 카테고리/user 보존, 개별 채널·정상빈배열 단독토글 PUT→GET | 양OS 상위/하위 동시 변경, Android 개별 Push·단독토글 PUT→GET. iOS의 Push ON은 OS denied이므로 실기기 확인 필요 |
| 개별 읽음 | 2건 PATCH200/code0001, 미읽음14→12, Unread 제외·All 유지 | 2건 PATCH200/code0001, 미읽음12→10 |
| 랜딩/뒤로가기 | 양OS 실제 appLandingUrl→DEV 주문상세 WebView 렌더→알림함 복귀 | 양OS 동일 |
| OS 권한 | Android 실제 OS OFF·복귀 배너, OFF 유지 복귀 PUT0, 선택→OS ON→복귀 시 선택 항목만 저장/배너 사라짐 | Android 동일. iOS는 실제 denied 응답에 맞는 지속 배너·회색 Push 표시 확인 |
| 소속 전환/권한 표본 | 실제 일반 소속8개 모두 OWNER. 양OS 일반선택→다른소속→알림선택으로 원래213/86 복귀·인박스/설정정합 확인 | OWNER employer85/employee212, 일반소속1개·다른소속unread GET0. 불가능한 다중기공소를 필수미완료로 잡지 않음 |

- 모든 설정은 최초 full payload로 PUT하고 fresh GET이 같은지 확인해 원복했다. Android 두 앱의 OS권한도 최초 granted로 원복했다. 자동권한안내 팝업은 기존 표시이력을 강제초기화하지 않았고, Push항목으로 여는 안내 팝업/OS왕복을 확인했다.
- 읽음은 Office116966/116958, Lab116959/116951의 최소2건씩을 사용했고 원복 API가 없어 읽음 상태는 유지된다. 일괄 읽음·삭제·실푸시 발송은 하지 않았다. 웹 테스트에서도 각 1건을 읽었으며 최종 카운트는 아래 원복 절에 기록했다.
- 앱 화면 캡처·실응답을 대조했고 다수 UI 조작은 Hermes/CDP로 렌더된 실제 onPress를 호출했다. Android OS 설정 토글은 실제 OS 화면을 ADB 터치했다. 물리탭 전수 QA라고 하지 않는다.
- 최종 양앱·양OS LogBox0, Android crash buffer 비어 있음, lastanr=no ANR since boot, 최근 iOS Dentlink/SpringBoard 진단보고 신규 없음. 초기 에뮬레이터 부팅 때 메모리 부족/System UI 응답없음 팝업1회를 관찰했으나 테스트 중 재발하지 않았다. 앱 크래시로 단정하거나 원인을 확정하지 않는다.
- 추가 FE 결함은 재현되지 않아 제품 코드 커밋/재배포는 추가하지 않았다. 양앱 Git은 clean·upstream0/0이며 기존PR 유지. 이번 Metro8081/8082·앱·부팅한 기기는 종료했고 사용자 창을 보존했다. 계정 lock2개 해제 완료.
- Office의 최초 다른소속unread GET0만으로 전환 불가라고 끝내지 않고 일반 소속8개를 확인해 추가 검증했다. iOS213→387/145→알림선택213, Android213→1889/1409→알림선택213. 다른 소속에서 원래213의 group unread12가 실제 반환됐다. Android 목록행은 ADB 실제 터치했고 전환 토스트도 캡처했다. 원래 소속·full settings GET이 일치함을 확인하고 웹 마지막 읽음 검사에 lock을 넘겼다.
- 남은 실기기 확인은 실제 OTA label/hash 적용, iOS OS권한 OFF/ON·복귀, 요청에서 제외한 실제 FCM/APNs 발송/클릭이다. MEMBER는 이번 계정의 소속에 없어 실계정 검증하지 않았다. Office 다중소속 기본 흐름은 확인했지만 존재하지 않는 Lab 다중소속이나 모든 역할 조합 QA를 완료했다고 하지 않는다.

### 게시 패키지 식별

| 앱 | package hash |
| --- | --- |
| Dentlink-Office-iOS v144 | d0955384b642ccdd9786b423a503079e705500195cf8c2e9b809c9ab0519fa99 |
| Dentlink-Office-Android v144 | 6c34e4bda49490b893b1870acb59041440e116f2b76d02a3fb12001ab31dc432 |
| Dentlink-Lab-iOS v43 | d99f7a38ba3dc3c970cdc5ec1c3734df04d9cb9e2b4b300bd7fa7ac8fc858e0d |
| Dentlink-Lab-Android v42 | c312222c612b30e23cc296da7e21e8c9f4c1abd034c3035607fc1d75e712150e |

임시 상세 근거: `/tmp/apps-dev-delivery-test-1113.md`, `/tmp/apps-dev-delivery-1113/`의 publication summary·제품별 설정/OS/인박스 결과 JSON과 네 플랫폼 화면 캡처. 토큰·비밀번호는 정본에 기록하지 않는다.

## 웹 실제 개발서버 검증 완료

검증 주소는 `https://dev-portal.dentlink.io`, `https://dev-lab.dentlink.io`이며 별도 Chrome for Testing/CDP9331에서 기존 로그인 세션을 재사용했다. 로컬 페이지나 응답 mock을 실제 배포 검증으로 대체하지 않았다.

- Clinic은 배포 artifact의 source SHA와 served BUILD_ID `bivBiVC3xY9Ky8huszZnn` 일치를 확인했다. Lab은 자동 workflow 성공과 DEV HTML BUILD_ID `rZPYfnnfMKAgl6AJAUUoE`를 확인했지만 같은 source↔served manifest가 없어 동일한 직접 대조를 했다고 하지 않는다.
- 양웹 설정: 상위OFF/ON→모든 하위값OFF/ON, 다른 카테고리/영역 보존, 새로고침·재진입 후 저장값 유지. Clinic Email 개별OFF는 상위/PUSH 보존, User Credits 행 변경은 해당 숨겨진 PUSH도 함께 변경. OWNER orderScope MY_ORDERS_ONLY↔ALL_ORDERS 실제저장. Lab null scope/options[]/user[]에 임의 선택UI를 만들지 않음.
- 실제 웹 응답에서 User Credits는 channels=[]가 아니라 숨겨진PUSH 자식1개다. 빈배열은 LINKTALK/Support 등 웹미노출PUSH행이므로 다른저장때 보존을 확인했다. 존재하지 않는 visible 빈배열행을 만들어 실데이터 검증했다고 하지 않는다.
- Clinic 실제8개소속 중 현재제외7개를 일반선택에서확인, 213→387 후 알림용API에는213/group unread12만 반환하고 선택창에도1개만노출. 알림선택으로213복귀→홈+인박스자동열기+전환토스트 확인.
- 양웹 각1건 읽음: Office116950은12→11, Lab116943은10→9. 각 주문9000009965 랜딩→브라우저back→인박스 재진입, All 항목유지·무숫자 및 Unread 실제수 일치. Lab All 목록20→스크롤추가30개조회 정상.
- 390/desktop 설정→뒤로 인박스→닫기 확인. Lab 일반주문/기존 밀링주문 헤더의 알림버튼각1개·설정진입 확인이며 밀링 기능 자체 QA가 아니다.
- 테스트 스크립트의 즉시 setChecked 검사·반응형교체/애니메이션·페이지크기 기대치로 발생한 초기실패는 안정된viewport·API GET대기로바로잡아 재확인했다. 제품버그를 수정한 것으로 기록하지 않는다.

### 별도 DEV 도구 문제

- Lab 모바일390px에서 기존 `#qa-widget-container`의 투명60px영역이 하단 알림버튼중앙실클릭을 가로채는 것을 실제pointer hit-test로 재현했다.
- 읽기 근거: `shared/qa-widget/src/QAWidget.tsx`의 fixed60x60·zIndex10000 triggerZone과 기본bottom-right 위치. 내부버튼이투명해도 부모영역pointer event는남는다.
- 별도 QA도구코드는 수정하지 않았다. 테스트브라우저에서만 pointer-events:none 임시style을넣어 알림흐름을분리검증하고 reload로제거했다. **원래 DEV 모바일 상태의 클릭문제가 해결됐다고 하지 않는다.** 별도 담당 범위로 기록하며 알림센터의 신규 미구현이나 밀링 필수업무로 합치지 않는다.

## 원복·최종 상태·남은 것

- 최종 독립 GET: Office employee213/unread11, Lab employee212/unread9. 양쪽 알림설정은 앱검증 시작전 전체 원본과 정확히 일치(HTTP200/code0000).
- 이번 전체읽음변경은 앱 각2건+웹 각1건=제품별3건. Office14→11, Lab12→9이며 이 개별읽음은 원복API가없어유지된다. 일괄읽음·삭제·실제푸시발송은 실행하지 않았다.
- 모든 account lock 해제. 임시QA위젯스타일제거, 본인TestChrome/Metro/부팅기기만종료. 기존사용자브라우저/IDE/창배치보존.
- 세feature 최종SHA는 상단표그대로clean·upstream0/0임을root도재확인했다. 이번검증으로제품코드추가수정/커밋은없고 승인된기존코드배포만완료했다.
- PR4862→release/v1.94.0, 앱346/42→main의Draft/기존PR유지. 본문에이번DEV검증과배포단계/한계를갱신했다. 본인제품카드17058#45022·17059#45021·17060#45020에결과기록, Ready for Deploy상태유지(DEV검증을Staging/운영QA완료로승격하지않음). 상위/스토리포인트/타인카드·밀링카드추가변경없음.
- 다음확인: BE44994 플랫폼노출·45009 실제발송적용 답변, 실제기기OTA적용·iOS권한OFF/ON, 사용자예정실푸시E2E/테스트데이터세팅, 실제MEMBER표본. Lab단일소속은기존서비스조건이며추가개발차단사항아님. DEV QA위젯모바일겹침은별도범위.
- 알림센터1.94.0은1.93.0 반영뒤master정본수용. 이번에밀링개발/독자BE질문/미해결review를다시시작하지않음. 배포후자동모니터링/폴링예약없이브레이크포인트로마감한다.

웹 상세 임시 증거: `/tmp/web-dev-delivery-test-1113.md`, `/tmp/dentlink-web-dev-1113/`의 responsive/final-read/lab-inbox-followup 결과 및 화면. 임시자료가소실돼도 위 배포·검증·한계를Git정본으로복구할수있게기록했다.

## 배포 후 추가 요청 — 13:23 디자인 반영 댓글 검토

- 사용자 요청: [Slack 변경사항 문의 스레드](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794533798159559)의 최신 댓글을 확인하고 반영. 이미 완료된 배포는 유지하며 **후속 코드 변경을 재배포하지 않는다**.
- 13:23:02 KST의 디자이너 답변은 디자인 파일 반영 완료와 기공소 모달 한글 문구 검토 요청이다. [Figma 댓글2006835298](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=603-33659#2006835298)을 직접 확인했으며 PM 답글은 없었다. 임시 한글 제목/소제목을 확정 문구로 적용하지 않는다.
- 확정 항목: Clinic Case Preference 삭제, Credit→Office Credit, Lab 주문 Feedback 삭제, Manufacturing 하위는 Order Updates만. 현재 실제 DEV 응답은 이미 해당 항목 구성을 제공하고 FE는 그대로 그린다. 별도 강제 삭제 필터나 고정 행을 추가하지 않는다. 새 Figma603:36396/PRD에 맞춰 설정의 employee 크레딧 표시만 Office Credits→Office Credit으로 조정한다. 인박스/금융 목록/User Credits로 범위를 넓히지 않는다.
- 새 Lab 선택창 디자인은 앱603:33659, 웹603:33734를 각각 고해상도 context·스크린샷으로 확인했다. 현재 기공소 카드·아래 목록 분리·카드 테두리/간격 구조는 확정 디자인에 대응하되, 기존 제목·안내 문구는 유지한다. 현재 기공소 정보는 기존 프로필을 재사용하므로 신규 API/소속 정책을 만들지 않는다.
- 노션 PRD는 최종 편집11/11 13:56:09 KST 자료로 확인했다. 명시된 최신 사용자 결정(배지 현행 유지, 조회 필터 로컬 저장, 상하위 동시 변경 등)을 오래된 PRD/TC 설명으로 되돌리지 않는다.
- 같은 Slack의 피드백 개수/CP 질문 선택지 추가(DL-17368)는 다른 업무이므로 이번 코드 작업에 포함하지 않는다. 설정의 Manufacturing 표시 확인은 밀링 FILE 개발 재개를 뜻하지 않는다.

### 앱 디자인 후속 완료 — 미배포

- Office `e2024f91192cc14150ae5b348c45cac77fe563d8`: 설정의 employee 크레딧 이름만 `Office Credit`으로 변경. User Credits/인박스/금융 목록은 유지. 양 OS 실제 DEV 설정 화면 확인, 추가 설정 PUT 없음.
- Lab `cc41f037752e4b15b663b4ec681d86bac51998f4`: 현재 기공소 카드와 제목/안내 고정, 하단 목록만 최대 300px(테두리 포함) 스크롤, 둥근 테두리·이름 옆 숫자·이동 화살표 반영. 현재 프로필이 활성 employee/employer와 일치할 때만 카드 표시. 기존 미읽음 조회·전환·권한 유지.
- 기존 흰색 기공소 아이콘을 임의로 다시 그리지 않고 Figma 보라색 원본 SVG 한 개를 추가했다. 원본 16.666px 크기를 바꾸지 않고 40px 아이콘 박스 중앙에 표시한다. 기존 화살표·Typography·theme 재사용.
- Lab 실제 단일 소속 프로필 카드 확인. 다중 목록은 런타임 props fixture 9행/긴 이름/1000→999로 검증했다. Android 실제 스와이프·행 터치로 callback 도달·바깥 터치 닫기, iOS 렌더 ScrollView/행 handler 및 화면을 확인했다. 실제 다중 기공소 서버 전환으로 주장하지 않는다. 종료 시 props override 제거, 저장소 실행용 mock/스토리북 추가 없음.
- 변경 파일 lint, 기존 Lab hook 테스트 24개 통과. Lab 전체 tsc의 기존 5개 진단은 남았으며 변경 파일 신규 진단은 없다. 최종 LogBox0/Android crash·ANR 없음. 자체 실행을 종료하고 기존 PR346/42 유지·commit/push했다.
- 증거: `/tmp/apps-design-followup-1113.md`, `/tmp/apps-dev-delivery-1113/lab-sheet-*-final.png`와 `office-credit-label-*.json/png`. 이후 설정 저장 표시 보완이 있으면 그 커밋/검증을 아래에 추가한다.

## 사용자 추가 제보 — 설정 저장 중 화면 변동

- 웹: 사용자가 DEV에서 채널 한 개를 바꿔도 설정 전체가 깜박이는 현상을 보고했다. 앱: 저장할 때 위쪽 스피너가 생겨 화면 전체가 새로 고쳐지는 것처럼 보인다고 추가 보고했다. 두 요청 모두 이미 배포한 버전은 유지하고 후속 코드만 수정한다.
- 최초 DEV 기능 검증 통과를 이 시각적 문제가 없다는 근거로 사용하지 않는다. 실제 재현 후 최초 조회/저장 상태를 구분하고, 저장 경합 방지·실패 처리·원래 설정 보존은 유지하는 범위로 보완한다.
- 웹 DEV 재현: Email 한 항목 저장에서 전체 10개 입력이 disabled 0→10→0으로 바뀌며 색상이 함께 변했다. 전체 화면 재마운트나 전면 스피너는 아니었다. 치과앱은 저장 중 스피너 삽입으로 목록 위치가 이동하는 별도 원인이 확인됐다.

### 치과앱 저장 표시 보완 완료

- Office 최종 `3fe716a782522f33ab2c19bc47e338beb073b7cb`: settings.isLoading에서 saveMutation.isSaving만 분리했다. 최초 조회/소속 정보 확인 로딩, 저장 중 입력 차단과 중복 방지, GET/PUT/readback 및 실패 처리는 유지한다. 기존 PR346에 반영했고 Development v144에는 아직 포함하지 않았다.
- 양 OS에서 저장 중 spinner0/section5/disabled 유지, 성공·실패 전후 첫 항목 y좌표 동일을 확인했다. 재현/실패 주입은 메모리상 서비스 pending/rejection으로 실제 PUT 없이 진행했고 종료 시 제거했다.
- 별도로 양 OS에서 실제 UI handler→GET→PUT→GET을 실행했다. 해당 MAIL 한 항목만 변경, 원복 후 전체 응답 일치. Office PUT4회(각 OS 변경+원복), Lab PUT2회(Android PUSH 변경+원복) 외 서버 변경은 없다. 이전 읽음 카운트를 추가로 변경하지 않았다.
- Lab `cc41f03`은 저장 중 전체 로딩을 표시하지 않아 추가 코드 변경이 필요 없었다. Android 실제 저장 중 spinner0/groups4/disabled 유지·원복 확인, iOS 화면은 초기 spinner0 확인. iOS의 기존 OS 차단 때문에 이 후속 Push 저장은 Android에서만 확인했다.
- 최종 양앱 LogBox0, 기능 검증 중 앱 crash/ANR 재현 없음. 기존 Android bootanimation SIGABRT는 시스템 부팅 프로세스이며 앱 크래시로 합치지 않는다. Office 변경 파일 ESLint/diff-check 통과. 계정 lock/런타임 주입/자체 실행을 정리했다.
- 상세 임시 근거: `/tmp/apps-settings-loading-followup-1113.md`와 `/tmp/apps-dev-delivery-1113/office-loading-*`, `lab-loading-*`. 이 결과는 기존 배포 검증과 별도의 **최종 로컬 소스 + 실제 DEV API 검증**이다.

### 웹 디자인·저장 깜박임 보완 완료

- 디자인 `0f80cdbba906b78502d3e11db6787855789d9828`, 저장 표시 `e343254686314cfcd20e539ef21fe2779aee72c1` 커밋·푸시. 기존 PR4862/Draft/DRAFT/[WIP]/release/v1.94.0 유지. develop `06f519aa6`과 개발서버는 변경하지 않았다.
- Lab 선택창은 기존 공통 OfficeSelectionModal/Item을 재사용했다. 현재 기공소의 실제 이름·주소·Lab 아이콘을 표시하고, 프로필이 없을 때 빈 카드를 만들지 않는다. 기존 Clinic 아이콘이 기본값이며 원래 병원 선택/닫기 동작도 확인했다. 미정 Lab 문구는 기존 문구를 유지한다.
- Clinic 설정의 Office Credit 단수 표기는 기존 번역 호출을 유지하며 product별 기본값만 변경했다. Lab 리소스·번역 시트, User Credits, 인박스, 금융 화면의 문구는 변경하지 않았다.
- Lab 실제 프로필 카드와 6행 테스트 응답의 카드·숫자·스크롤을 확인했다. 실제 계정은 단일 소속이므로 다중 기공소 서버 전환 QA로 확대하지 않는다. 임시 응답/브라우저 상태를 제거한 뒤 원래 단일 소속 상태로 복구했다.
- 웹 전체 깜박임은 저장·재조회 중 모든 입력이 disabled 색상으로 바뀌는 문제였다. 오류 disabled는 유지하고 임시 busy는 본문 aria-busy/DOM inert로 입력만 막는다. React18 호환을 위해 ref에서 DOM 속성을 설정한다. 화면 색상·위치, 헤더 뒤로/닫기는 유지한다. 전체 PUT 직렬화·저장 확인 GET·실패 처리는 변경하지 않는다.
- 양 웹 최종 로컬 코드+실제 DEV 계정에서 저장 중 색상/좌표 유지, 추가 마우스·키보드 조작에도 PUT1회, 제어된 HTTP500에서 기존 값 유지 확인. 실제 DEV PUT은 제품별 한 항목 변경+원복 2회씩, 최종 full GET이 기준값과 일치했다. 후속 검증에서 읽음/삭제/푸시 발송/소속 활성화는 하지 않았다.
- Clinic/Lab/Admin TypeScript, 정식 pre-push의 세 서비스 lint·Admin guard·shared coverage, 기존 hook 테스트61개, shared/ui 정식 config 단독 lint, diff-check 통과. 전체 i18n audit는 이전 HEAD에도 있는 account.auth.actions.logIn 누락으로 실패하므로 관련 외 코드/번역 시트는 수정하지 않았다. 새 Storybook/영구 fixture/불필요한 테스트 파일 없음.
- 실제 DEV 배포 검증과 이번 로컬 소스+DEV API 후속 검증을 분리했다. 자체 Chrome/서버3030·3035 종료, 계정 lock 해제·원복 완료. 상세 근거는 `/tmp/web-figma-followup-1113.md`와 `/tmp/web-settings-stable-*-1113.json`에 있다.

## 최종 브레이크포인트

| 제품 | 배포된 소스/버전 | 현재 원격 feature | 후속 상태 |
| --- | --- | --- | --- |
| Clinic/Lab 웹 | feature9c873941f → develop06f519aa6, 두 DEV 배포 성공 | e343254686314cfcd20e539ef21fe2779aee72c1 | 모달·표기·저장 깜박임 수정은 미배포 |
| Office 앱 | ca8a6f0 → Development iOS/Android v144, target2.2.4 | 3fe716a782522f33ab2c19bc47e338beb073b7cb | Office Credit·저장 스피너 수정은 미배포 |
| Lab 앱 | f5de5f4 → Development iOSv43/Androidv42, target1.0.5 | cc41f037752e4b15b663b4ec681d86bac51998f4 | 기공소 선택 시트 수정은 미배포 |

- 세 checkout은 clean·upstream0/0 확인. 기존 PR4862/346/42의 head와 본문을 현재 코드·배포 구분으로 정리했다. 검토 PR merge·추가 배포는 하지 않았다.
- Jira의 본인 세 제품 카드에는 앞선 DEV 배포·검증 결과를 기록했고 Ready for Deploy를 유지한다. 이번 후속은 같은 카드/PR 범위이며 별도 의미 없는 새 카드는 만들지 않았다.
- 알려진 독립 FE 후속은 완료했다. 다음 재개 시 **이 후속 커밋들이 아직 개발서버/CodePush에 없다는 점**부터 알린다. 재배포는 다음 사용자 지시에 따른다.
- 남은 확인: Lab 모달 문구 PM 답변, 기존 BE44994 플랫폼 노출 계약·45009 발송 적용, 실제 기기 OTA/iOS OS 왕복/실푸시·MEMBER 표본. 실제 발송은 이번에 요청대로 실행하지 않았다. 별도 DEV QA 위젯 모바일 겹침은 그대로이며 알림센터 코드에서 우회하지 않았다.
- 밀링1.93.0, Home3, 이메일/SES, OS 배지 개선·별도 native 작업을 본체 미개발로 합치지 않는다. 다음 정본 통합은 1.93.0 반영 이후 최신 master 기준이다. 자동 모니터링 없이 대기한다.

## 사용자 확인 체크리스트와 대기 지시

2026-11-13 사용자 확인: 위 검증 범위와 한계를 이해했고 실기기는 직접 확인한다. 한계로 직접 확인하지 못한 항목은 기록으로 남기되 지금 반복 설명하지 않는다. 추가 디자인·저장 UX 수정은 커밋·푸시된 상태로 유지하고 **추가 배포하지 않는다**. 이 정리 후 다음 추가 요청까지 대기한다.

### 에이전트 확인 완료

- **실제 DEV 웹(Clinic/Lab):** 설정 API와 표시 대조, 상위·하위 변경/저장/재진입, 다른 설정 보존, 읽음·랜딩·복귀, 가능한 소속 전환. OWNER 표본 기준이며 MEMBER까지 확대하지 않는다.
- **앱(Office/Lab, 양 OS):** 배포한 소스의 Debug 실행 + 실제 DEV API로 설정·읽음·랜딩·복귀 확인. 실제 설치 바이너리의 OTA 수신 검증과 구분한다.
- **Android OS 권한(양앱):** 실제 OS OFF→앱 복귀 배너, Push 항목 안내, OFF 유지 시 저장 없음, OS ON→복귀 시 선택한 항목만 저장. 권한과 서버 설정은 원복했다.
- **iOS 확인 범위:** 실제 허용/차단 응답에 맞는 표시 확인. Lab 차단 배너·회색 Push 확인. OS 설정에서 OFF/ON하는 전체 왕복은 제한돼 미확인으로 남긴다.
- **미배포 후속 최종 코드:** 웹 모달·Office Credit·저장 중 깜박임, Office 저장 스피너/목록 위치, Lab 선택 시트 표시 검증 완료. 실제 DEV API 저장·전체 원복과 실패 시 기존 값 보존도 확인했다. 이 개선을 현재 개발 배포본에서 확인한 것으로 기록하지 않는다.

### 사용자가 이후 확인할 항목

| 항목 | 확인할 동작·기대 결과 | 확인 시점/범위 |
| --- | --- | --- |
| 실제 배포본 적용 | 대상 버전 실기기에 Office Development v144, Lab iOS v43/Android v42가 실제 적용됐는지 구분하고 알림함·설정·개별 저장·랜딩/뒤로가기 확인 | 사용자가 실기기 확인. 이후 새 배포 시 해당 버전으로 기준 갱신 |
| iOS OS 알림 전환 | 양앱 OS OFF→복귀 배너, 항목 선택→OS ON→복귀 시 선택 항목만 ON, 켜지 않고 복귀하면 설정 미변경 | 실제 iPhone 필요. Android 동일 흐름은 이번 확인 완료 |
| 최초 권한 안내 | 신규 표시 이력 환경에서 최초 안내와 이후 반복 노출 정책 확인 | 이번 검증은 기존 이력을 강제 초기화하지 않음. 테스트 환경 준비 시 확인; 사용자 앱 재설치를 지금 요구하지 않음 |
| 실제 푸시 | 수신·클릭→지정 랜딩 및 deliveryId 기반 읽음, 기존 배지 동작 유지 | 이번 실제 발송은 명시적으로 제외. 사용자 예정 후속 실푸시/E2E 단계 |
| MEMBER 권한 | 실제 해당 역할 계정의 메뉴·알림 설정 노출/조작 범위 확인 | 현재 OWNER 표본만 있음. 계정 준비 시 관련 QA에서 확인 |
| 미배포 추가 수정 | 웹 저장 중 전체 깜박임 없음, Office 저장 중 상단 스피너/목록 밀림 없음, 변경 모달·표기 확인 | 별도 재배포 승인 후에만 배포본에서 확인 가능. 현재 배포본에 남은 이전 현상을 신규 회귀로 혼동하지 않음 |

- 위 체크리스트는 구현 미완료 목록이나 지금 사용자에게 다시 요구할 작업 목록이 아니다. 사용자 결과를 받으면 확인한 환경·버전·항목만 완료로 갱신한다.
- 실제 Lab 다중 소속은 현재 서비스/계정 조건상 없으므로 필수 미확인 항목을 만들지 않는다. 다중 목록 레이아웃은 fixture로 확인한 범위 그대로 유지한다.
- 별도 DEV QA 위젯의 Lab 모바일 클릭 겹침과 BE44994·45009, Lab 모달 미정 문구는 앞선 기록대로 유지한다. 이번 마감에서 해결되었다고 바꾸거나 범위 밖 작업을 시작하지 않는다.
- **다음 시작점:** 사용자 추가 요청을 먼저 처리한다. 배포/QA 재개 시 미배포 후속 커밋과 실제 실기기 확인 결과를 대조한다. 자동 배포·모니터링·중복 테스트 없음.

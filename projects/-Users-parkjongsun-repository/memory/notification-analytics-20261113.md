# 2026-11-13 DL-17425 분석 이벤트·Figma 확정 문구 — 미배포

## 요청과 결정

- 사용자 요청: Figma606:39212#2006939011과 DL-17425를 확인하고 가능한 작업을 구현. **배포하지 않는다.** 기존 PR을 유지한다.
- 사용자는 분석 문서를 PM·디자이너의 참고 자료로 보며 개발 API와 모든 표현을 일치시킬 필요는 없다고 확인했다. 요구 의도가 가능한 항목은 구현하고 실제 불가능한 부분만 설명한다. 이 해석은 분석 필드에 한정되며 UI/BE 계약을 임의로 바꾸는 권한이 아니다.
- Notion의 All/Unread에 붙은 Boolean은 실제 선택 문자열로 정리했다. ON/OFF 의도를 위해 `enabled: boolean`을 보완했고, 현재 화면의 User Credits·Payments·밀링 주문 업데이트를 대응시켰다. 추가 BE API나 화면 정책 변경 없음.

## 확인한 근거

- [DL-17425](https://innovaid.atlassian.net/browse/DL-17425), [디자이너 요청](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794545683428169?thread_ts=1794533798.159559&cid=C04T5SU6A2U).
- [Amplitude 명세](https://app.notion.com/p/405ce072e82f80d093a4c38fa643febe), 수정2026-11-13 13:54:12KST. 상세 이벤트13개와 속성7개를 대조했다. main의 othernotification 링크 오류는 실제 상세40fce072e82f80d0b30ace4482b60073으로 해소했다.
- [Lab 권한 배너](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=606-39212#2006939011): 실제 화면+PM/디자이너13:49~13:55 댓글. `알림이 꺼져 있어요.` / `중요한 주문 알림을 놓치지 마세요.` 적용. CTA `알림 켜기`·배치·기능 유지.
- [Lab 선택창](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=603-33659): PM13:46~13:47 댓글2006938307/2006938705/2006938905와 실제 디자인. 제목 `다른 기공소 알림` 유지, 소제목 `안 읽은 알림` 확정. Web/App에 반영했으므로 이전 문구 대기는 해소됐다. 번역은 로컬 리소스만 갱신, Google Sheet 미수정.

## 구현된 분석 동작

| 이벤트 | 기록 시점·속성 |
| --- | --- |
| notification_click | 헤더 알림 아이콘 실제 클릭 |
| notification_inbox_view | 인박스 표시/focus, entryPoint `header icon` 또는 `app push` |
| notification_item_click | 항목 클릭, content(알림 본문) |
| notificationscope_click / notificationscope_filter_click | 기존 범위 선택 UI 열기/선택, notificationScopeFilter `["All"]` 또는 `["My Orders"]` |
| othernotification_banner_click | 다른 병원/기공소 알림 배너 클릭 |
| notification_setting_click / notification_setting_view | 설정 아이콘 클릭 / 설정 화면 표시 |
| notification_readall_click | 모두 읽음 클릭 |
| notification_tab_click | 실제 All/Unread 선택, notificationStatus 문자열 |
| notification_setting_changed | 실제 설정 저장·재조회 확인 성공 후 한 번. domain/category/channel 및 enabled |
| notification_pushalert_popup_cilck / notification_pushalert_banner_cilck | 앱 OS 권한 안내 팝업의 CTA / 배너 클릭. 표시·취소와 구분 |

- `cilck`는 두 명세의 동일한 이벤트명이므로 그대로 사용한다. Lab에는 없는 범위 선택 UI나 웹 OS 안내를 새로 만들지 않는다.
- 분석용 domain: Order, MC Order, LinkTalk, Dentlink Support, Office Credit, User Credits, Payments. category: Design Confirmation, Order Update, Shipping, Feedback. 독립 카드에는 없는 category를 만들지 않는다.
- 채널: PUSH→App Push, MAIL→Email, NOTIFICATION/IN_APP→Notification. 상위 토글은 명시 toggleChannel 우선, 일반 상위는 Notification으로 기록한다. 하위 연쇄 변경을 추가 사용자 클릭으로 여러 번 기록하지 않는다.
- 동일값/중복 저장/실패는 changed 이벤트 없음. 분석 전송 실패가 실제 저장 성공을 실패로 바꾸지 않도록 격리했다. 독립 코드 리뷰에서 웹의 이 경로를 찾아 수정하고 예외 주입으로 검증했다.
- 기존 자동 screen_view 계열과 이번 인박스 이벤트는 별개다. 재조회나 단순 rerender는 새 view로 집계하지 않고 화면 복귀는 실제 focus로 기록한다. 푸시의 landBy를 사용하며 헤더 진입은 이전 push 값을 비운다.

## 검증과 경계

- Web: Clinic/Lab 최종 코드 타입·변경 ESLint·기존38tests, 실제 로컬 화면에서 이벤트 포착. 저장 성공1·실패0·동일값0, scope 배열, header닫기/view중복, 뒤로/자동소속 재열기,390px/desktop을 확인했다. 서버 변경은 fixture로 차단. 개발용 QA 위젯의 기존 모바일 가림은 임시 브라우저 스타일로만 분리했고 제품 수정에 넣지 않았다.
- Lab: 최종 코드 동일 checkout을 iOS17Pro/Android API36에서 실행. DEV 실응답으로 화면을 표시하고 SDK track을 로컬 포착했다. 헤더/인박스/탭/설정·복귀/landBy push, 부모 저장 성공1·빠른 중복저장1회·동일값0·실패0, 본문 클릭/모두읽음 이벤트 확인. iOS 차단 배너의 새 문구 및 banner2회/cancel후CTA1회/OS이동 호출1회 확인. 설정 저장·읽음은 일시 service fixture이며 실제 서버 쓰기0. SDK/서비스/OS열기 대체는 런타임에만 존재하고 앱 종료로 제거. LogBox0/Android crash buffer0. 기존settings+switch35tests/i18n3tests/변경lint 통과. 전체tsc는 기존5진단(변경파일 신규0)이므로 전체 성공이라고 표현하지 않는다.
- Office: 최종 코드 iOS·Android에서 13종 이벤트, header/app push 진입, 탭 문자열/범위 배열, 재조회 view추가0, 설정 성공1·중복저장1회·동일값0·실패0, 권한 배너/팝업 CTA를 확인했다. 실제 DEV 화면에 SDK 포착·렌더된 콜백·일시 service fixture를 사용해 서버 쓰기/분석 전송/OS 변경0. 임시 대체 원복, 양OS LogBox0·Android crash0·새 Office iOS crashreport0. 기존 관련81tests·lint·diff 통과. 전체tsc 기존6진단과 별도 기존 설정 테스트의 Office Credits 기대값 불일치는 이번 수정 범위 밖으로 기록하며 전체 tests/tsc 성공으로 확대하지 않는다.
- 새 Storybook/영구 mock/테스트 파일·generated API·native 설정 없음. 실제 Amplitude 서버 수신을 확인한 것이 아니라 최종 화면 핸들러→SDK 이벤트 경계를 포착한 검증이다. 실제 수신은 추후 승인 배포/확인 시 구분한다. 실제 푸시 발송 없음.

## 코드와 전달

| 제품 | 브랜치·커밋 | PR |
| --- | --- | --- |
| Web | feature/DL-17058 · 2484bd91a17e9a477e5624712469bdd7b010101e | 기존4862→release/v1.94.0 |
| Office | feature/DL-17059 · 0b19ce6fe5908b28d9ab49b0d9014236364629f2 | 기존346→main |
| Lab | feature/DL-17060 · c31f3117fe2c0e801067916029a7799ca882cf8b | 기존42→main |

모두 커밋·푸시 및 기존 Draft PR 반영. PR merge·develop 변경·CodePush·재배포 없음. DL-17425는 작업 정의를 정리하고 Ready for Deploy(개발완료)로 전환했다. 스토리포인트·상위 이슈·외부 원문은 변경하지 않았다.

## 다음 시작점

- 이번 요청의 FE 구현은 완료. 앞선 디자인·저장 UX 수정과 이번 이벤트/문구가 모두 미배포임을 유지한다. 다음 사용자의 추가 작업/배포 지시부터 이어간다.
- 기존 BE44994 플랫폼 노출·45009 실제 발송 적용 답변과 사용자의 실기기 확인 체크리스트는 앞선 정본대로 유지한다. 새 질문/배포 차단 조건으로 확대하거나 자동 재조회하지 않는다.
- Lab 새 문구는 확정/반영됐으므로 다음 브리핑에 다시 미정으로 넣지 않는다. 밀링1.93·이메일·별도 홈/배지/native 범위는 이번 작업에 포함하지 않는다.

검증 상세: `/tmp/dl17425-lab-evidence/`, `/tmp/dl17425-lab-*-settings.png`, `/tmp/dl17425-lab-tests.log`, `/tmp/dl17425-lab-typecheck.log`, `/tmp/web-analytics-17425-report.md`, `/tmp/web-analytics-runtime-17425.json`, `/tmp/dl17425-office-{ios,android}-runtime.json`. 자체 웹 서버3030/3035·테스트브라우저9332·Metro8081/8082·양 기기 종료 확인. 기존 사용자 창과 로그인 보존. 자동 폴링 없이 대기.

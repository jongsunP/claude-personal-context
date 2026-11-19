---
name: 알림센터 제품별 누락 보완·API 중복·iOS 제보
description: 2026-11-13 오후 수정 및 Development 전달, 웹 미배포와 iOS 아이콘 실행 배너 미확정 구분
type: project
---

- 사용자 요청은 Lab 설정 깜박임 수정→알림센터 전체의 같은 동작 누락→Amplitude 최신 이벤트→전역 진입 API 중복 조사로 확장됐다. 같은 요구는 제품별 타당한 차이가 없으면 함께 맞추고 최종 화면까지 검증한다. 공통 DEVELOPMENT_STYLE 지침 보완.
- Web feature/DL-17058 `b6cffe2f8`: 초기 unread응답 지연 시0→All 최초1회, 사용자 선택 유지. open시 진행 중 조회 취소/재시작 제거. Clinic/Lab 각7조건·기존tests/type/정상훅 통과. **16:05:57 KST DEV PR4890→develop b8ce6c6ae로 전달**, Clinic43383288547/Lab43383288546 시작1회확인. 최종성공/서비스QA별도. PR4862→release/v1.94.0 Draft 유지.
- Office feature/DL-17059 `1eaa023`: 저장 중 범위 선택 입력만 차단·색/위치 유지, 페이지 동일ID 중복 제거, focus진입 조회공유. 양OS 저장성공/실패·랜딩/복귀·새프로세스 확인, 관련33tests통과. 전체tsc기존6진단.
- Lab feature/DL-17060 `3a6624e`: 저장busy와오류/권한disabled색상분리, 다른소속은서버양수미읽음∩실제가입소속만, 헤더dot은현재또는다른소속미읽음, focus조회공유. 양OS 저장전/pending픽셀차이0·입력/실패복구·소속/dot분기·최종4GET각1/abort0 확인. 전체tsc기존5진단. 최종LogBox0, 새앱crash미관찰.
- Development 전달: Office iOS/Android **v146** 대상2.2.4/source1eaa023, Lab iOS **v45**/Android **v44** 대상1.0.5/source3a6624e. 직전과native/package/asset변경0·assetHash동일. 직렬·TMPDIR격리·Slack쓰기없는직접Revopush, 게시/활성1회확인으로종료. 실기기uptake미추적. 원PR346/42 main Draft 유지.
- Jira 본인17058/17059/17060 댓글45027/45028/45029에결과기록. 부모/타인/스토리포인트미변경. PR본문은최종기능/검증/전달로정돈.
- Amplitude DL17425 최신Jira·Notion본문/댓글·13event/7property 재대조: 새요청/누락없음. Clinic웹11/Lab웹9/Office13/Lab11의차이는UI비대상. 실제수집검증아님.
- API: singleton동일키/inflight공유, 렌더마다호출아님. 웹헤더재마운트시count2GET은실시간없는상태의최신화로유지. 읽음/저장/복귀갱신유지,TTL임의변경없음. 실제QueryObserver warmcache중복start2/abort1→1/0. Office설정은인박스범위에도필요해defer제안철회; Lab설정사전조회/숨긴inbox분리/초기필터전요청지연은선택적구조개선으로보류.
- **새 iOS 제보:** 사용자 Office2.2.4.145를**앱아이콘으로실행**한뒤OS배너표시. v145에이전tap-ID방지fab7708/d4de608포함, 현재까지FCM/Notifee/native변경0. 앱active전환자체표시0, onMessage가오면탭기록없는과거/동일ID도표시가능(JS분기재현). 실제중복/지연첫수신은미확정. 이번v146으로해결됐다고하지않음. Android별도심사와구분.
- iOS다음확인: 알림종류·messageId/sentTime·수신/AppState·OS기존표시·로컬표시호출을같은재현에서대조. getDisplayedNotifications remoteID대조는후보일뿐. sentTime만으로정상지연푸시를버리는임의수정없음,실제발송미실행.
- 자체서버/테스트브라우저/앱/Metro정리,사용자창·기기유지. 최신11/13 비표시브라우저우선지침수용·하위전달,새창시험/메인회신없음. 사용자재요청까지추가개발/배포/폴링없이대기.

Git 정본: `/Users/parkjongsun/Repository/codex-personal-context/projects/dentlink-unified-notification-center-parity-2026-11-13.md` 및 메인 체크포인트. 임시 근거 `/tmp/notification-{web-parity,web-api-lifecycle,app-api-lifecycle,push-replay}-1113.md`, `/tmp/apps-dev-ux-api-delivery-1113.md`.

## 후속 분석·범위 확정
- 사용자: 이번 기능 변경으로 생긴 문제는 수정, 기존 네이티브/핵심 공통 코드는 우선 기록만 하고 알림센터에 집중. iOS onMessage→Notifee 경로는 Office 최초 전7f58679/Lab5144103부터 존재, notifee표시함수도 당시와 동일. 이번 탭중복방지에 비활성1초대기는 있으나 제보와 인과관계 미확정. 새회귀로 확정/해결 선언하지 않고 기록만, 코어/네이티브 수정 없음.
- PM Slack1794551958.923939(11/13 15:39:18KST) 확정: 다른 병원 전환 안내·목록 숫자는 employee만, 개인(user) 제외. 인박스는 개인+현재소속. 숫자차이보다 불필요전환방지우선. 첨부3병원은 모두 다른병원목록. 11/6 미정은 이제 확정, OS배지정책과 별개.
- live DEV Swagger Office/Lab 모두 이미 같은 계약이다. 현재 웹·양앱도 employers/unread와 inbox/unread를 분리 사용하므로 개인수차감/새API 없이 호환. BE의 집계·공통개인읽음이 명세대로 동작하면 FE추가계산불필요. 실제개인알림 생성/읽음 공유 완료를 이번 문서대조로 증명한 것은 아님.
- 말미 Leo QA기간 유저알림 작업·Oli 디자인은 후속예고이며 담당/완료/배포/새FE요구 확정아님. 사용자는 본인도 BE/FE구분을 못봤으므로 분석부터 요청. 제품수정/배포하지 않음. 새디자인이 오면 현코드와대조, 지금불필요질문없음.
- 백로그 후속정리: 카운트 개인포함 여부 질문은 해결 완료이며 FE별도개발대기로남기지않음. Jira본인하위21건에 count전용카드없음. DL17415/17416/17417은 설정플랫폼노출키·개인설정항목/채널의계약반영이라 ToDo유지. User Credits 설정제외여부/담당 및 17114#44994플랫폼키답변은 count댓글로해소되지않음. PM소유17235도 MAIL/Promotion/Benefits/디자인이포함되어미변경. Jira전체완료로확대하지않고개인카운트질문만닫음.
- 최신개발배포: 사용자승인으로원격develop삭제→최신master9c4418a8f재생성→PR4890feature반영. 병합b8ce6c6ae=feature트리, clinic7/lab31경로로양workflow시작. 원PR4862전달문구만수정,Draft/base유지. 앱liveGit/history각1회로현재소스/활성라벨같아재배포안함(Officev146both/Labv45iOS,v44Android). 남음은최종웹배포결과·사용자개발서버/실기기QA·별도실푸시E2E. 의도된후속/BE대기를미완료FE로반복보고하지않음. 자동추적없음.

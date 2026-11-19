---

후속: 같은 날22시대 추가 감사/금융수정은 `notification-settings-live-review-20261112.md` 참고. 이 문서의 DEV 배포에 그 후속94334d2a는 포함되지 않음.
name: notification-center-dev-delivery-20261112
description: 11/12 재개 감사 이후 DEV 전달 완료와 후속 Jira, CodePush 임시폴더 충돌 복구, 사용자 확인 대기
metadata:
  type: project
---

정본: `/Users/parkjongsun/Repository/codex-personal-context/projects/dentlink-unified-notification-center-delivery-2026-11-12.md` 및 주 체크포인트 최상단. 이전 같은 날 감사의 배포 없음은 이후 승인으로 대체됐다.

- 사용자 승인: 웹 DEV·양앱 Development CodePush, 기존 검토 PR 유지, 본인 Jira 정리/미완료 실제작업 카드, 기억 후 대기. Slack 읽기전용.
- Web original feature7e23e709b/PR4862→release1.94 유지. 최신develop의 FILE/밀링QA를 보존하는 전달 feat/DL-17058-develop@b248516dc, PR4884 merged→develop e72bbafbee. Clinic43211888815/Lab43211888799 해당SHA in_progress1회 확인후추적종료. 완료확인아님. 정식Swagger생성·FILE소비type이전,3서비스tsc/73tests/대표5화면pass. 직접E2E SKIPPED, 기존배포후CI E2E자동연동은미변경.
- Office feature/DL17059 a624b598: Development iOS/Androidv143 target2.2.4. Lab feature/DL17060 d018b85: iOSv42/Androidv41 target1.0.5. enabled/mandatory/100%. PR346/42불변, 소스clean/remote동일. 이전배포대비native/package/patch/entry변경0. 실제기기수신미확인.
- 배포사고: Office/Lab공용os.tmpdir()/CodePush 동시사용. Office업로드전Hermes실패후전용TMPDIR순차재시도성공. Lab초기iOSv41 asset혼입→정상Lab hash의v42로56초내교체. v41롤백금지·수신여부미확인. 기본CodePush순차, 병렬시제품OS별TMPDIR실제출력검증필수. SESSION_WORKFLOW정본반영.
- Jira기존설정17061/63/66본문최신화, 본인제품/설정/계약하위결과기록. 기존개발완료ReadyforDeploy유지(DEV를Staging/QA완료로올리지않음), SP/상위/타인무변경. 후속ToDo:17415/16/17 웹/Office/Lab플랫폼·개인설정정책,17418/19양앱향후배지,17420웹1.94기존FILE통합. 질문용API카드안만듦. Home17062/65/68·이메일17187ToDo그대로. 추가앱목록17202개발완료·후보17179완료그대로. 선택적주석커버리지보류기억유지.
- BE44994플랫폼키답변대기(이미사용자문의), Office구push-preferences GET/PATCH는Home/주문/채팅필터실사용으로삭제금지. 현재OS배지현행유지, 이메일등자동확대금지.
- 기존AndroidNotifee PR348/44는release2.2.5/1.0.6병합됨. 이번OTA타깃과다르며스토어심사완료는미확인. iOS중복배너는11/10사용자실기기확인완료를유지.
- 로컬세팅/양OSReactotron/외부실행/개인·팀지침동기화정리됨. 검증서버·기기종료, 재개때현재source/환경/연결만확인. 별도OpenAI명로컬Gitrepo없어현재Codex설정/기억/채팅으로대조. 사용자는앞으로알림작업에집중하려는의도.
- 다음: 사용자개발서버/실기기설정저장재진입·병원전환·실제푸시한번이동/읽음. 실제FCM/서버쓰기/배포바이너리QA는기존최종로컬검증과구분. 자동감시없이요청까지대기.

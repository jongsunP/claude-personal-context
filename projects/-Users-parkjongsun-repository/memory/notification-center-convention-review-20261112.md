---
name: notification-center-convention-review-20261112
description: 11/12 전체 알림센터 규약·요구사항 감사 및 수정 push, 최종 웹/양OS 검증, 배포 없음
metadata:
  type: project
---

**후속 DEV 전달 완료:** [[notification-center-dev-delivery-20261112]]가 현재 정본이다. 아래 배포 없음은 사용자 승인 전 감사 단계 기록이다.

2026-11-12 20시대 사무실 Codex가 사용자 명시 승인으로 팀 컨벤션/프로젝트 AGENTS·CLAUDE/개인 지침과 현재 요구사항 기준 전체 feature 변경을 재검토했다. 다른 에이전트의 설정 API 이전을 수용·검증하고 필요한 후속만 수정했다.

정본: `/Users/parkjongsun/Repository/codex-personal-context/projects/dentlink-unified-notification-center-review-2026-11-12.md` 및 주 체크포인트 최상단.

- Web `feature/DL-17058@7e23e709b`, Office `feature/DL-17059@a624b598`, Lab `feature/DL-17060@d018b85`: 원격 일치·clean. 기존 Draft PR4862→release/v1.94.0, PR346/42→main 유지. 본문 최신화, merge/배포 없음.
- 남은 앱 StyleSheet 정리, 웹 presentation을 UI로 이동(도메인/PUT은 models 유지), 새 오류 문구는 기존 공통 문구로 통일. 확정 Clinic 선택 문구 반영. Lab 웹 별도/밀링 헤더 누락 보완, 기존 mobile 하단진입 유지. Office 시트P120:P121 employerId 포함 shipping 딥링크 등록누락 수정.
- DL17114 BE44978 새설정 계약은 이미 선행 구현됨. user우선/서버순서/전체PUT/메타제외/생략·null 검증을 대조. 사용자44994 플랫폼키 요청은 답변없음. 임의키/유저설정/배지정책 추가금지.
- 웹 관련36 tests·3서비스tsc, prepush shared59 tests; Office190/Lab50 tests 통과. 앱tsc기존6/5진단 그대로. 양앱동일소스 양OS와 로그인웹 최종검증완료. 서비스실패/권한/미읽음카운트는 제한적 제어주입과복구를 포함; 실제서버쓰기/모든권한/실제FCM QA로확대금지.
- Office Maestro 종료때 앱/SpringBoard XCTest내부crash발생, 재실행후대체검사재발없음. Lab새crash/양제품최종Android오류없음. native빌드SHA는미확인,release호환성증거아님.
- Lab개발자리뷰3건 답변·resolve완료, Officeinline0. 웹밀링FILE1건은PR4866/release1.93완료코드가현재target에없어열어둠. 20:12KST 최신Web7e23e709b 단회CodeRabbit검토완료·새actionable지적없음. FILE1건만미해결.
- BE구API삭제10개중 Office push-preferences GET/PATCH는Home/주문/채팅담당필터에서현재사용. 즉시삭제승인금지. Admin별도namespace도실사용. 선언/고아코드를사용으로혼동하지않음.
- 팀에원래models/styled규칙이있었으나적용누락이었다. 개인앱경계/최종diff검토/플레이북보완완료. 웹models수동API타입규칙은앱과구분. 개인정본·Codex로컬동기화, 양메모리기록유지.
- 본인Metro8081/8082·웹3000/3005와이번검증양기기종료. 기존사용자창/Reactotron유지. 다음은BE답변/별도FILE통합판단/승인후DEV재배포, 임의개발배포금지.

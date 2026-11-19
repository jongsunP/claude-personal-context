---
name: 알림센터 후속 개발 재배포 2026-11-13
description: Web DEV 배포 시작, Office v145와 Lab v44/v43, 사용자 QA 대기 기준
type: project
---

# 2026-11-13 후속 변경 개발 재배포 — QA 기준

## 승인과 범위

- 사용자의 첫 ‘재배포하는 게 어때’는 의견 요청이었다. 에이전트가 실행 의도로 앞서 해석했고, 사용자가 ‘하라고 한건 아니었는데 아무튼진행해줘’로 명시 승인한 뒤 실제 배포했다. 앞으로 ‘어때’만으로 배포 승인으로 확대하지 않는다.
- 앞서 검증·푸시된 모달/문구·설정 저장 UX·DL-17425 분석 이벤트 후속을 개발환경에 반영한다. 이번에는 새 개발/전수조사/전체 재검토를 추가하지 않는다.
- 기존 검토 PR Web4862→release/v1.94.0, Office346/Lab42→main은 유지하며 merge하지 않는다. 개발 배포용 웹 PR만 별도로 생성/병합했다.

## 웹 전달

- 최신 master `9c4418a8fb4b18cbadb5afb25fa32503b59febae`, feature/DL-17058 `2484bd91a17e9a477e5624712469bdd7b010101e` clean·원격일치, master가 feature 조상임을 확인했다.
- 기존 develop `06f519aa6fd4394d9250c2340c4977615662e61c`; 열린 develop 대상 PR 없음·브랜치 protected=false. 예상 SHA lease로 삭제하고 비존재 lease로 위 최신 master에서 재생성했다. 임의 backup branch/worktree·수동dispatch·빈커밋 없음.
- 사용자 E2E 제외를 유지하여 정식 SKIPPED marker/check를 실행했다. 일반 pre-push 훅 lint·Admin guard·shared coverage 통과. 이전부터 있던 경고 유지, 제품 코드 추가 변경 없음.
- [DEV PR4888](https://github.com/Innvoaid/dentlink-client/pull/4888)의 실제 base/head/파일 목록에 Clinic7경로·Lab31경로가 포함돼 develop push의 clinic/**·lab/** 조건을 만족하는지 확인했다.
- 예상 head2484bd91a를 고정해 PR4888을 merge. develop **f9d5fde66dce8c24f614ffb9a0e354e62976bafb**, feature와 tree 동일 확인.
- **14:32:11 KST 배포 시작 정상**: [Clinic43372654130](https://github.com/Innvoaid/dentlink-client/actions/runs/43372654130), [Lab43372653965](https://github.com/Innvoaid/dentlink-client/actions/runs/43372653965). 기대SHA·push·in_progress를 한 번 확인했다. 최종 성공/served revision을 확인한 것으로 표현하지 않으며 이후 자동 polling하지 않는다.
- 사용자 확인 주소: https://dev-portal.dentlink.io / https://dev-lab.dentlink.io. GitHub 배포 완료 후 이 버전으로 QA한다.

## 앱 전달

| 앱 | iOS | Android | 대상 바이너리 | 소스 |
| --- | --- | --- | --- | --- |
| Office | v145 | v145 | 2.2.4 | 0b19ce6fe5908b28d9ab49b0d9014236364629f2 |
| Lab | v44 | v43 | 1.0.5 | c31f3117fe2c0e801067916029a7799ca882cf8b |

- 네 건 모두 **Development 게시·활성**, mandatory/rollout100. 각 history를 한 번 읽어 대상·label·소스·활성을 확인했다. 실제 단말 수신/설치 완료와 구분한다.
- 직전 Office ca8a6f0 / Lab f5de5f4는 각 최종 HEAD의 조상이다. package/lock/native/patch/Metro/Babel/entry/배포 script 변경 없음. package·iOS·Android version은 위 target과 일치한다.
- Lab 신규 SVG는 기존 transformer가 JS로 변환한다. 네 플랫폼 모두 직전 배포와 assetHash가 동일하며, packageHash는 이번 새 패키지 값으로 변경됐다. source SVG 추가를 native 변경으로 해석하지 않는다.
- Office iOS→Android→Lab iOS→Android 직렬 게시, 제품·플랫폼별 TMPDIR 분리. 기존 배포 script의 Slack 전송을 피하려고 같은 release-react 옵션으로 직접 게시했으며 Slack 쓰기는 하지 않았다.
- 제품 소스·기존 PR state/base·Git tag·native build·스토어는 변경하지 않았다. 기존 PR346/42 본문에 최신 전달 버전을 기록했다. 최종 코드 양OS 검증은 앞선 증거를 재사용했고 이번에는 재실행하지 않았다.

| 패키지 | packageHash |
| --- | --- |
| Office iOS v145 | fdda43bc666decf26ac7b9d6855bd34ebaf233a50be3ac752c7b8381578744e1 |
| Office Android v145 | 3fd94a7ce1cde98e305c78bae433da906e1423b8db06e4b49b502019e76fcd92 |
| Lab iOS v44 | cc8c40b01a64b345d5fce28e90b6dbfb163cc2d4e0b5a40b8aab767b4a7d25fa |
| Lab Android v43 | f0383daf92d7161683d0538b25f8323e753476d6ef25507fcc939f489a979a5f |

확인한 최종 코드의 관련 화면에서는 새 크래시/회귀가 관찰되지 않았다. 이는 실제 단말의 OTA 적용이나 전체 제품 무위험 보장이 아니다. 사용자 예정 QA에서 실제 적용 버전을 기준으로 확인한다.

## 지금부터 QA할 기준

이번 후속 변경과 기존 기본 흐름을 최신 배포본에서 함께 확인한다. 이미 수행한 최종 로컬 검증과 이번 실제 배포본 QA는 구분한다.

1. **설정 저장:** 채널 하나 변경 시 전체 깜박임/상단 스피너로 목록이 움직이지 않고 저장 후 다시 열어도 선택 유지. 상위 ON/OFF 시 같은 항목 하위도 함께 변경.
2. **소속 선택:** 일반/알림용 선택창의 현재 소속 카드·목록·스크롤, 선택 후 전환/안내와 알림함 유지. Lab 단일 소속을 불가능한 다중소속 QA의 미완료로 만들지 않는다.
3. **앱 알림 흐름:** 인박스 항목→지정 화면→뒤로 복귀. OS 알림 OFF 안내·팝업 및 ON 후 복귀 시 선택 항목만 적용. 기존 사용자 확인 체크리스트를 이어 사용한다.
4. **분석 확인:** Amplitude에서 알림/설정 진입·탭·범위 선택과 저장 성공 이벤트를 확인. 실제 서버 수신은 이번 로컬 SDK 경계 검사와 별도다. 저장 실패/동일값/중복 입력을 성공 변경으로 집계하지 않아야 한다.

- 실제 푸시 발송/E2E는 이번에 추가 실행하지 않는다. 별도로 계획된 실제 발송 확인 단계와 기존 BE44994/45009 답변은 계속 분리한다.
- 사용자 실기기/웹 QA 결과를 받으면 환경·배포버전·재현절차와 함께 이어 처리한다. 이번 재배포 요청을 새로운 전수 QA/감시 승인으로 확대하지 않는다.
- 새 코드 변경 없음. 개인 정본·Claude memory와 기존 PR에 최신 전달 기준을 기록했다. 자동감시 없이 대기.

증거: `/tmp/notification-redeploy-web-workflow-start-1113.json`, `/tmp/notification-redeploy-develop-create-1113.log`, `/tmp/apps-dev-redeploy-1113-dl17425.md`.

## 사용자 QA 인계·최종 대기 — 2026-11-13

- 사용자가 웹 개발서버와 앱 실기기를 직접 확인하고 QA 중 문제가 생기면 이 세션에 전달하기로 했다. 이 시점부터 추가 구현·배포·서버/워크플로/기기 수신 추적·외부 댓글 폴링 없이 대기한다. 웹 배포 최종 성공을 확인한 것으로 바꾸지 않는다.
- 본인 Jira 카드 DL-17058/17059/17060/17425의 현재 상태가 모두 Ready for Deploy(개발완료)임을 확인하고 유지했다. 운영 완료/QA 완료 전환은 하지 않았다. 최신 재배포와 사용자 QA 기준을 각 댓글45023/45024/45025/45026에 기록했다. 상위 카드·타인 카드·스토리포인트 변경 없음.
- PR 본문과 개인 정본의 최신 전달 상태가 일치함을 확인했다. 팀 기획/정책 문서에 새 결정이 없어 Notion/Figma/Sheet를 중복 수정하거나 다시 조사할 필요는 없다. 기존 미확인 체크리스트·BE 답변은 다음 관련 요청 때 이어 참고한다.
- 다음 시작점: 사용자 제보의 제품·OS·실제 적용 버전·화면/재현 경로를 위 배포 기준과 대조하여 필요한 부분만 확인한다. 지금 자동으로 새 작업을 시작하지 않는다.

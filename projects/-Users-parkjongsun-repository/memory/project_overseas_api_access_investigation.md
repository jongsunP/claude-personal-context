---
name: project-overseas-api-access-investigation
description: 해외 사용자 포털 접속/API 실패의 원인·대응·관측 방안 조사 전용 세션
type: project
---

2026-11-13 사용자가 Slack `C04T5SU6A2U/p1794356148497849` 관련 조사 전용 세션을 요청했다.

**최종 마감 — 2026-11-13:** 사용자 요청으로 노션을 한 번 더 읽고 최종 점검했다. 간결한 이슈 접근·상황표 3행·정상 사용자 보호·FE 작업표 5행·기존 GET 3개·사전 검토 결론이 있어 추가 수정하지 않았다. 취소·수정 후 목록 항목은 개발 시 확인 후 필요할 때만 보완한다. 사용자가 삭제한 담당 구분·별도 확인 목록·Slack 링크 등을 되살리지 않는다. Git·Claude·Codex에 기록 후 **개발·실행 검증·추가 조사·노션 수정·자동 모니터링 없이 다음 요청까지 대기**한다. 아래는 진행 이력이며 현재 문서는 이 최종 상태를 따른다.

**최종 문안·사전 검토 정리:** 사용자가 간소화한 노션 본문을 보존하고 API 실패 시 잘못된 ‘병원 없음’ 표시 가능성/이번 고객 경로 미확정을 상단에 짧게 기록했다. FE 표에 같은 계정·병원 정보만 사용/늦은 응답 방지, 실제 요청 취소·중복 방지, 취소·수정 후 목록 갱신(필요 시)을 포함했다. 마지막 항목은 개발 시 확인 후 필요할 때만 보완하며 추가 개발 확정이 아니다. 사전 검토에서 대응 방식 자체를 바꿀 문제는 발견하지 않았고, 구현 시 보호 조건과 구분한다. 제품 개발·실행 검증은 하지 않았다. 이 문서처럼 간결하게 쓰고 사용자 직접 게시용은 완성본 한 블록으로 주는 공통 지침을 feedback_notion_format 및 Git 정본에 반영했다. 새 지시 전 대기.

**최신 추가 요청 반영:** 비개발자용 상단 요약을 유지·축약하고 같은 노션 하단에 FE 작업 범위를 추가했다. index.tsx 홈 소속 분기, _app Auth 홈 최초 대기, DashboardNonEmployee/DashboardCertification의 목록 로딩·오류 전달, 관련 query/API 재시도 연결을 4행으로 정리. 기존 GET 3개·인증/전역 정책 유지·최소 검증 항목 포함. 코드 링크는 FE 표에만, 긴 분석 부록은 Git 기록에 유지. 위치·FE/Issue 태그 유지, 문서 update 성공. 구현 전 후보이며 제품 개발 없이 다음 지시를 기다린다.

**최신 문서 표현 — 2026-11-13 간소화 완료:** 사용자가 재검토된 노션이 너무 복잡하고 이해 어렵다고 하여 같은 페이지를 쉬운 문안으로 줄였다. 상황→대응 3행(홈 정보 실패·가입/신청 목록 실패·첫 응답 지연), 정상 사용자 보호, FE/BE·인프라 담당, 원인 미확정·개발/실행 검증 전 상태만 남겼다. 내부 API·코드·접기 근거·수정 이력은 공유 페이지에서 제거하고 Git 조사 기록에 보존했다. 독립 분석 결론은 유지하며 두 API 한정안으로 되돌린 것이 아니다. 위치·FE/Issue 태그·표 너비·제목 유지, 본문 update 성공 확인. 실제 개발·추가 조사 없이 문서만 수정했으며 다음 사용자 피드백을 기다린다.

**최신 상태 — 2026-11-13 독립 재검토·노션 내용 수정 완료:** 사용자는 두 API 중심 최소안은 제안이지 무조건 따르라는 확정 요구가 아니라고 정정하고, 위치·태그는 유지한 채 내용만 심도 있게 재검토하라고 요청했다. 재분석 결과 **홈의 소속 분기·별도 가입/신청 목록의 없음 표시·최초 상위 Auth 대기**가 우선 보완 지점이다. 빠졌던 `GET /office/users/own/employee?type=all` 경로를 확인해 같은 노션 페이지 본문과 접기 근거를 수정했다. 정적 분석 권고안이며 실제 장애 재현·안전성 실행 검증은 하지 않았다. **실제 개발 금지 유지**, 제품 코드·QA·PR·배포·추가 자동 모니터링 없이 다음 요청을 기다린다. **“개발과 관련있는 자료나 공유용 문서들”**의 기본 위치는 DEV Team → Development Documents, 태그는 내용에 맞는 기존 값을 사용한다.

- 정본: `/Users/parkjongsun/Repository/codex-personal-context/projects/dentlink-overseas-api-access-investigation.md`.
- 세션 `01a1d352-b346-7872-b537-6fe5ffaf4f87`, 기존 메인 프로젝트/사무실 Mac local, gpt-6-astra / ultra 실제 적용과 전달·시작 확인. 메인은 이후 폴링하지 않는다.
- 제품 코드/branch/worktree/외부 변경/배포 없이 현재·사건 당시 코드와 관련 Slack/자료를 읽어 원인 후보 및 가능한 조치만 분석한다.
- 사용자는 토큰 보유 해외 사용자의 BE만 막혀 Find your office/미승인 상태처럼 보였다고 추정한다. 토큰 유효성·이번 로그인 성공·해외 차단은 아직 사실이 아니다. FE _app.tsx 대응이 정상 사용자에게 로딩/흰화면을 늘리는 부작용을 우려하며, 서버/인프라 대안과 독립 관측/로그 가능성도 원한다.
- 접수 당시 Slack에는 원인 미확정, API/RUM 기록 공백과 내부 로그인 테스트, Seoul LB 앞 CloudFront 검토가 있었다. `2026/11/11 09:03:35` 이후 내부 테스트 로그 제외 지시의 본문 시간대는 아직 미확인이다.

## 2026-11-13 Codex 1차 조사 완료

- 원 제보·개발 논의·과거 별개 방화벽 사례 전체 스레드와 첨부 2개를 읽었다. 고객은 모바일 정상/PC 실패 및 근무처 해외 사이트 제한 가능성을 말했고, 평소 자동 진입과 달리 월요일 로그인 화면이 나타났다고 했다. 실제 차단/토큰 유효성/이번 POST login 성공은 미확정. 모바일 앱/웹·같은 Wi-Fi인지 미상.
- 제품 checkout `feat/DL-17141-delay-cleanup`/`a4f70d33`를 clean 상태로 유지. pull/checkout 대신 origin/master fetch 후 git show로 읽음. master는 `9c4418a8`, 실제 최신 Clinic PRD run은 `prd/clinic/v1.92.0`/`1948696376a92410671ac42ee7c32f4f6e28bdec`(11/9 Seoul·Ohio success). 직전 `046c5143`와 최신 master까지 핵심 인증/홈/State/RUM/Amplitude 파일 차이 없음. 사건 브라우저의 실제 build는 미확인.
- 코드상 user query 오류 후 token이 남으면 Auth gate 통과 가능, user/activeEmployee 부재가 Find Your Office/No Office Yet로 이어질 수 있음. `/office/users/own`, `/office/employee/own`은 병렬. 실제 대기 판정은 성공한 소속 응답의 employee/employer status로 구분해야 함.
- State `GET /codes/state-code`의 data 부재를 []로 표현하고 UI가 pending/error를 사용하지 않아 로딩/실패/성공-empty/검색불일치가 No Result로 보일 수 있음. publicApi도 저장 auth/employee-id·zone-id를 붙임. No Result는 서버 미도달 증거가 아님.
- RUM init은 user API와 독립(production/설정 조건), setUser는 user/activeEmployee 결과에 의존. sessionSampleRate100/replay0/telemetry0을 구분. 해당 회원 ID로 11/10 말까지 최신 event 조회 결과 11/3 14:23 UTC였음. 사건 추정 시각의 익명 좁은 조회는 attribution 불가; 전체 RUM 미수집 증명 아님. 원본 PII/URL payload는 기록하지 않음.
- Amplitude 원본 replay는 인앱 브라우저 로그인 화면으로 막힘. 직접 커넥터 연결을 먼저 제안. SDK의 이전 userId 복원 때문에 회원 연결·클릭·화면 전환으로 로그인 성공 확정 불가.
- 우선 가설은 PC/병원망의 목적지 정책·프록시/네트워크 문제. DNS/TLS/CORS/preflight/확장프로그램, WAF/LB, auth/refresh를 증거별로 분리. BE/ALB/WAF 원본 로그는 미조회. CloudFront는 글로벌 edge이며 Ohio 미국인식/차단우회 보장 아님; auth 캐시/headers/method/CORS/timeout/upload 검증 필요.
- FE 최초 오류·State 필드 상태를 분리하는 안은 전역 isFetching/!activeEmployee gate와 다름. 현재도 user 첫 pending은 null이므로 실패 처리만 추가한다고 대다수 정상 사용자 대기가 필연적으로 늘지는 않음. 기존 데이터 보존·bounded retry·독립 최소 진단 아이디어와 부작용을 정본에 상세 기록.
- 다음 자료: 정확한 시각/시간대와 PC·모바일 망, 민감정보 제거된 실패 status/code/timing·OPTIONS, edge/app 로그와 RUM 조회 필터. 개발/재현/로그인/설정변경/외부게시/자동 모니터링 없이 이 조사 세션 사용자 후속 질문을 기다림. 별개 앱 주문상세 403 사건과 묶지 않음.

## 2026-11-13 비개발자 공유용 대응 구분

- 두 API 중심으로 좁힌 이전 문안은 **사용자의 제안을 확정 범위로 오인한 설명이어서 정정**했다. 사용자 요구는 최소 변경·정상 사용자 리스크 최소화이며 API 두 개라는 한계가 아니다. 코드 근거상 소속 분기 + 가입/신청 목록 오인 방지 + 최초 무응답 복구가 우선. 로그인 전체 개편·모든 카드 개선을 필수로 볼 근거는 없다. 정본의 현재 권고안과 조합별 근거를 우선한다.
- 노션 [홈 진입 오류 최소 대응안](https://app.notion.com/p/417ce072e82f811a974ec11daca8dec5), page ID `417ce072-e82f-811a-974e-c11daca8dec5`. 최초 개인 초안으로 만들었다가 사용자 지시로 DEV Team → Development Documents DB `c7d0f110-577a-430d-bf54-5038cee73b11` / data source `26366594-1ec5-423c-b7c3-35abe1e047f2`로 같은 페이지 이동 완료. 부모 경로·본문 보존 readback 확인, `FE`·`Issue` 태그 적용 성공. 같은 유형 Dentlink 문서는 이 DB를 기본으로 쓰도록 Git 공통 지침과 feedback_notion_format.md/MEMORY.md 보완. 후속 수정은 같은 페이지에 한다.
- 사용자는 상황→조치 예시로 쉽게 설명하고, 인프라/백엔드 협의 사항은 담당 표시를 붙여 기록·공유할 수 있게 요청했다. 정본 상단에 상황별 표를 추가했다. 추가 조사·개발 승인 아님.
- FE 후보: 최초 병원조회 실패 안내, State 로딩/실패/빈 결과 분리, 단순 재조회 실패 시 기존 화면 유지, 장기지연 안내/제한 재시도, 로그인 연결오류 구분, 기존 Amplitude/RUM 최소 오류기록. 정상 성공 흐름에 새 전역 대기를 추가하지 않는 방향이며 첫 필수정보 부재에는 해당 부분의 안내가 필요함. 만료/권한변경 확인 시 이전 데이터 유지로 무시하지 않음.
- 협의: 실제 차단 복구는 인프라·병원IT; 응답만으로 상태구분이 안 되는 부분은 BE 확인 후 필요시 보완; 새 오류수집 경로는 인프라; 브라우저/edge/BE 기록의 요청 연결은 선택적 BE·인프라 강화. 기존 응답·수집서비스 활용이면 새로운 BE 변경이 필수인 것은 아님.
- 문구는 설명 예시이며 구현·검증 전 검토안. 정상·지연·실패·복구/미소속/대기 검증 및 과도한 재시도·중복저장·과한 로그 전송 방지가 필요하다.

## 2026-11-13 홈 엣지 케이스 추가 정적 조사

- 정본에 홈 전용 14개 상황→조치→담당 표와 코드 근거·검증 범위 추가. `ls-remote`상 master는 여전히 `9c4418a8`; 추가 조사 홈 Dashboard/hook/query·핵심 인증 파일은 사건 인근 PRD `19486963` 대비 차이 없음. 실제 사건 build·장애 재현은 확인하지 않음. 제품 변경·실험·로그인·외부게시 없음.
- 우선 후보는 실패/미확인과 실제 소속 없음·0건·미설정을 구분하고, 홈 진입 실패·장기 대기 안내/제한된 수동 재시도를 제공하며, 같은 계정·같은 병원의 마지막 정상 내용 유지. 실제 만료/권한 상실은 기존 정책을 따름. 전역 추가대기·추가 health 요청·짧은 timeout·전체 cache 삭제·강제 logout·자동 reload를 넣지 않는 방향.
- 상위 `_app` Auth가 user pending에 null을 반환하므로 홈 내부 안내만으로는 부족하고 홈 경로에 한정한 상위 접점이 필요. 직원/권한 미준비로 enabled되지 않은 조회나 오프라인 paused를 실제 네트워크 요청 대기와 구분. 현재 여러 카드 중 하나라도 loading이면 Dashboard 전체 skeleton이라 카드별 로딩 분리는 정상 등장 순서 영향 때문에 별도 검증.
- 주문 data 부재→0건→첫 주문/샘플 안내, LinkTalk 부재→count0, 픽업 부재→미표시, 설정 부재→false, category error 뒤 undefined→spinner 가능. 실제 malformed 응답은 미확인이나 row/null 접근에 FE 방어 후보. 정상 optional/null까지 과하게 거절하거나 오류를 빈 정상 데이터로 덮지 않음.
- 일반 logout은 이미 query 취소/삭제·atom 초기화, 직원 query key에도 직원 ID 포함. 이를 없는 방어로 설명하지 않음. 병원 선택은 서버 전환 성공 전 ID 선반영·user query key 고정·cancel signal 미전달 경로가 있어 전환/늦은 응답 정합성은 검증 후보. 공통 전환·토큰 갱신 구조 변경은 첫 홈 대응과 분리. 기존 403/code2131 특수 처리 보존.
- BE만 실패하거나 이미 홈 실행 후 FE 자산+API가 함께 끊긴 경우 오류 표현·기존 화면 보존 가능. 최초 HTML/JS 자체 미로딩이면 홈 코드는 실행 못 하므로 인프라 보완 필요; 전체 인터넷 단절이면 서버 장애 페이지도 못 받음. 영속 오프라인 캐시는 별도 설계. React 오류 경계도 하위 렌더 오류만 범위 내 처리하며 모든 비동기/SSR/코드 미로딩 해결책 아님.
- 브라우저 online은 참고 신호이지 API 정상 보장 아님. 재연결/탭복귀는 기존 Query 동작과 중복하지 않음. 배너 실패 격리·Amplitude init/replay 실패 비차단 동작은 이미 있어 보존. 기존 도구의 최소 비동기 오류기록은 FE, 별도 수집경로는 인프라, 서버 로그 연결은 BE/인프라 협의. 리스크 0·완전 원인 확정·구현 완료로 보고하지 않음.

## 2026-11-13 사용자 지적 후 독립 재검토의 핵심 정정

- NonEmployee는 별도 `GET /office/users/own/employee?type=all`을 조회한다. data 부재 → filterAffiliatedEmployeesForDisplay의 [] → DashboardCertification의 No Office Yet. 로딩/실패도 실제 없음처럼 보일 수 있어 두 API 한정안은 직접 관련 경로를 빠뜨렸다.
- user 실패 + 현재 직원 응답 반영 성공이면 Dashboard 가능. user 성공 + employee 배열 nonempty면 employee/own 실패라도 Dashboard 분기/fallback 가능. user 실패 + 직원 정보 미확보면 직원 요청이 아직 늦는 경우에도 NonEmployee 가능. 따라서 ‘둘 다 실패해야 발생’이나 ‘현재 병원 API 실패면 소속 없음’으로 일반화하지 않는다.
- user 최초 pending은 직원 응답과 무관하게 상위 Auth null. 홈 내부 안내만으로 해결 못 하므로 홈 경로에 한정해 상위 접점 검토. 정상 미소속/대기 응답 계약, 선택 병원 일치, 기존 fallback·401·특수403 유지 확인 필요. 세 조회 전체 성공을 새 필수조건으로 만들지 않는다.
- 정상 응답 후 화면 흐름은 유지하지만 미확인 구간의 ‘없음’을 ‘확인 중’으로 바꾸는 표시 변화는 필요. 영향 0 주장 금지. 이미 보던 같은 계정/병원 내용은 단순 재조회 실패로 삭제하지 않되 확인된 만료/권한 상실은 기존 처리.
- 재시도는 실패 종료·진행 중·offline paused 구분이 필요. 핵심 queryFn/API에 signal 전달이 없어 버튼만 추가해 실제 진행 요청이 정리·재시작된다고 단정하지 않는다. 전역 timeout/retry/캐시 초기화는 필수 변경 근거 없음.
- master 9c4418a8 재확인, 추가 조사 home/Auth/NonEmployee/query/filter/UI는 사건 인근 PRD 19486963과 diff 없음. 기존 제품 checkout clean 유지. 실제 고객 build·원인·실행 재현은 미확인. 노션 같은 페이지의 본문을 수정하고 표 너비·위치·FE/Issue 태그 유지, 코드/공식 문서 근거는 접기 영역에 추가.
- 사용자 기술 제안은 가설/예시와 확정 요구를 구분해 독립 검토한다. 문안 작성 완료를 최소 범위 충분성·구현/실행 검증 완료로 확대하지 않는다.

---
name: app-guidelines-recheck-from-app-dev-review
description: 다음 앱 작업 전 먼저 — 앱 개발자 리뷰(Lab PR #42) 기준으로 기공소앱·병원앱 작업 지침 자체를 재점검 (2026-11-12 사용자 지시, 아직 미처리)
metadata:
  type: feedback
---

Lab PR #42(알림센터)에 앱 개발자(myungjael)가 남긴 리뷰는 원래 기본으로 지켰어야 할 내용이다. 코드 수정만이 아니라 **앱 작업 지침 자체**에 빈틈이 있을 수 있으니, 다음에 기공소앱·병원앱 작업을 맡으면 기능 코드보다 먼저 지침을 재점검한다.

기준(리뷰 내용):
1. `src/models/`에는 생성 파일(`Api.ts`, `http-client.ts`)만 둔다. 손으로 만든 모델 파일 금지(`NotificationApi.ts`가 위반이었음) → FE 타입은 `configs/types` 등 가공 계층에.
2. 스타일은 styled-components. `StyleSheet.create` 쓰지 않는다.
3. API 응답은 배열 원소·하위 목록의 null까지 서비스에서 검증해, 렌더 TypeError(릴리스 크래시) 대신 쿼리 실패·재시도 UI로.
4. 공용 로직을 건드리면 QA 때 기존 기능까지 앱에서 함께 테스트.

**Why:** 사용자 지시(2026-11-12): "앱개발자가 말한건 반드시 기본으로 했어야는 거"라 지침부터 다시 확인해야 한다.

**How to apply:** 앱 작업 시작 전 Office·Lab의 `CLAUDE.md`·`AGENTS.md`, codex `DEVELOPMENT_STYLE.md`·앱 플레이북을 위 기준으로 대조·보완(팀 저장소 문서 변경은 사용자 확인 후), 알림센터 앱 코드의 남은 같은 유형(다른 컴포넌트 StyleSheet 등) 확인. 전달 기록: codex `AGENT_INBOX.md` "모든 에이전트", 정본 `projects/dentlink-unified-notification-center.md` 최상단. 처리하면 이 메모와 inbox 상태를 갱신. 관련: [[dentlink-app-pr-team-rules]], [[swagger-generated-files-as-is]].

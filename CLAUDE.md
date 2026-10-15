# 개인 설정

항상 한국어 존댓말로 답변한다.

## 세션 시작 시 자동 실행

새 대화 세션이 시작되면 반드시 아래 명령어를 실행하여 최신 메모리를 동기화한다.

```bash
cd ~/.claude && git pull
git -C ~/Repository/codex-personal-context pull --ff-only
```

pull 후 변경사항이 있으면 "메모리 동기화 완료 (N개 파일 업데이트)" 와 같이 한 줄로 알려준다.
변경사항이 없으면 별도 언급 없이 넘어간다.

**누락 방지:** 첫 번째 응답을 작성하기 전에 pull을 실행했는지 반드시 확인한다. 만약 pull을 빠뜨린 채 대화가 진행됐다면, 발견 즉시 pull을 실행하고 "세션 시작 시 pull을 빠뜨렸습니다. 지금 실행했습니다." 라고 고지한다.

## 이전 에이전트(Codex) 작업 이어받기

`~/Repository/codex-personal-context`는 이전 에이전트가 쓰던 작업 지침·프로젝트 기록의 정본이다. Dentlink(dentlink-client / dentlink-app / dentlink-lab-app) 작업 지시를 받으면 이전 에이전트가 하던 방식 그대로 이어서 한다.

1. 작업 전 `PROJECTS.md`와 해당 `projects/<project>.md` 맨 위 "현재 상태"를 읽고, 제품 repo의 live Git(branch·HEAD·원격 차이·dirty·worktree)과 대조한다. 현재 사용자 지시와 live 상태가 기록보다 우선한다.
2. 작업 규칙은 그 repo의 `AGENTS.md`·`SESSION_WORKFLOW.md`·`AI_WORKFLOW.md`·`DEVELOPMENT_STYLE.md`를 따른다. 해당 프로젝트를 처음 다루는 세션이면 관련 절을 직접 읽는다.
3. 의미 있는 마감 시 기존 형식(프로젝트 파일 상단 "현재 상태" + `MEMORY_CHANGELOG.md`, 필요 시 `PROJECTS.md`·`HANDOFF.md`)으로 기록하고 commit·push한다. 제품 repo commit·push는 명시 요청 시에만.

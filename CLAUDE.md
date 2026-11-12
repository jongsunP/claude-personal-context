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

1. 작업 전 `PROJECTS.md`와 해당 `projects/<project>.md` 맨 위 "현재 상태"를 읽고, 제품 repo의 live Git(branch·HEAD·원격 차이·dirty·worktree)과 대조한다. 현재 사용자 지시와 live 상태가 기록보다 우선한다. 기록상 "대기"(PR 머지 대기 등)는 GitHub로 다시 확인한다.
2. 작업 규칙은 그 repo의 `AGENTS.md`·`SESSION_WORKFLOW.md`·`AI_WORKFLOW.md`·`DEVELOPMENT_STYLE.md`를 따른다. 새 세션이 Dentlink 작업을 처음 맡으면 `BOOTSTRAP.md`의 Read Order(BOOTSTRAP → SESSION_WORKFLOW → PROFILE → AI_WORKFLOW → DEVELOPMENT_STYLE → PROJECTS → 해당 프로젝트 파일)를 따른다.
3. Codex 고유 절차(세션 모델 지정, 원격 PIN, `~/.codex` 등)는 `AI_WORKFLOW.md`의 **Claude Code Mapping** 표대로 바꿔 적용한다. 규칙 자체는 그대로 따른다.
4. 기록은 Claude 메모리와 codex-personal-context **양쪽**에 남긴다(2026-11-10 사용자 지시). 시점은 요청받은 작업이 끝날 때이며, 요청이 없어도 남길 가치가 있는 결정·상태·지침 변경은 넣는다(2026-11-12). 동기화는 새 세션 시작·재개 시 필요한 범위를 자동으로 맞춘다.
5. 동기화할 때 codex-personal-context `AGENT_INBOX.md`에서 내 섹션(사무실 Claude Code / 집 Claude Code)과 "모든 에이전트"의 `열림` 항목을 확인해 적용하고 완료 표시한다. 사용자가 "다른 에이전트도 이렇게 하래"라고 하면 그 에이전트 섹션에 항목을 남긴다. 다른 에이전트 항목은 처리하지 않는다. 의미 있는 마감 시 기존 형식(프로젝트 파일 상단 "현재 상태" + `MEMORY_CHANGELOG.md`, 필요 시 `PROJECTS.md`·`HANDOFF.md`)으로 기록하고 commit·push한다. 제품 repo commit·push는 명시 요청 시에만.

## Dentlink FE 메인세션 (에이전트별 1개, 2026-11-12 확정)

- 에이전트(사무실/집 × Codex/Claude Code, 이후 추가분)마다 메인세션은 하나이고 각자 따로 운영한다. 서로 통제하지 않으며 공통 기록은 codex-personal-context에만 둔다. `~/.claude`에는 Claude 실행에 필요한 것만 둔다.
- Claude 메인: 사무실 Mac "Dentlink FE 메인세션 (사무실 Claude)"(폴더 `~/Repository`), 집 Mac "Dentlink FE 메인세션"(폴더 `~/repository`). 둘 다 저장소들이 모인 일반 폴더이며 같은 메모리 폴더 키를 쓴다. 정본은 codex-personal-context `projects/dentlink-fe.md`의 Session Ownership.
- 메인은 접수·분류·조율·기록·마감만 맡고, 구현은 기능별 하위 세션에 맡긴다(작은 작업도 기본은 하위 세션). 넘긴 뒤에는 폴링하지 않는다. 메인세션은 보관하지 않는다.
- 하위 세션: 브랜치·worktree는 Git으로 직접 `feat/<Jira>`로 만들고, `start_session`에 `cwd`=그 worktree, `use_worktree: false`, `model`·`effort`는 생략(메인 상속)해서 만든다. 만든 뒤 `get_session`으로 실제 모델을 확인한다.

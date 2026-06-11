---
name: project-worktree-context
description: 이 폴더는 dentlink-client의 git worktree — E2E 전용 작업 공간 (feature/DL-14805-1-3)
metadata:
  type: project
---

이 폴더(`dentlink-client-e2e`)는 git worktree로 생성된 E2E 전용 작업 공간이다.

## 구조

```
/Repository/dentlink-client/       ← 메인 폴더 (master) — 일반 개발
/Repository/dentlink-client-e2e/   ← 이 폴더 (feature/DL-14805-1-3) — E2E 전용
```

- 레포는 하나 (`.git`은 `dentlink-client/` 안, 이 폴더는 포인터로 연결)
- 커밋/푸시 → 동일 GitHub origin, `feature/DL-14805-1-3` 브랜치에 반영
- PR: `feature/DL-14805-1-3` → `release/v1.75.0` (#4200)

## 워크트리 제거 방법 (나중에 원래대로)

```bash
# dentlink-client 메인 폴더에서 실행
git worktree remove /Users/parkjongsun/Repository/dentlink-client-e2e
```

폴더 삭제 + git 등록 해제 완료. 앱 코드·모노레포 구조 영향 없음.

**Why:** E2E 작업 브랜치(feature/DL-14805-1-3)와 master를 병행 작업하기 위해 2026-06-09 세팅.
**How to apply:** 이 세션은 E2E 작업 전용. master 관련 작업은 `dentlink-client` 폴더의 별도 세션에서.

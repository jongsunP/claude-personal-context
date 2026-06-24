---
name: reference_stg_deploy_tag
description: 코드 변경 없이 스테이징 배포를 트리거할 때 사용하는 태그 push 형식
metadata: 
  node_type: memory
  type: reference
  originSessionId: d306c7c9-7dcd-4f5d-acaf-aae2ba84e6da
---

스테이징 clinic 배포를 코드 변경 없이 트리거할 때 태그 push를 사용한다.

## 태그 형식

```
stg/clinic/[브랜치명]
```

예시: stage 브랜치를 배포할 경우
```bash
git tag stg/clinic/stage <commit-hash>
git push origin stg/clinic/stage
```

## 트리거 조건 (clinic_stg_build_and_deploy.yml)

- `stage` 브랜치 push + `clinic/**` 경로 변경
- `stg/clinic/**` 태그 push → 코드 변경 없이 가능
- GitHub Actions 수동 실행 (`workflow_dispatch`, jira-key 필수)

**How to apply:** 스테이징 배포 요청 시 코드 변경 없이 재배포가 필요하면 태그 push 방식 사용. 태그명은 `stg/clinic/[브랜치명]` 패턴으로 만들고, 대상 브랜치의 최신 커밋 해시를 지정한다.

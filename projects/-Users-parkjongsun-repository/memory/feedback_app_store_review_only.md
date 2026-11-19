---
name: feedback_app_store_review_only
description: 앱 작업 논의 시 스토어 심사가 필요한 네이티브 변경만 알림, CodePush 시차·옛 앱 버전 언급 금지
metadata:
  type: feedback
---

앱 작업을 논의할 때는 **스토어 심사가 필요한 변경**(새 네이티브 의존성·권한·네이티브 설정·바이너리)만 챙겨 알린다. CodePush 반영 시차, 아직 업데이트 안 된 사용자, "옛 앱 버전" 과도기 동작은 언급하지 않고 대비 코드도 넣지 않는다(사용자가 물을 때만).

**Why:** 2026-11-19 DL-17505 논의에서 사용자 지시 "그건 개발중에 생기는거니까 말할필요없어. '심사'가 필요한것만 챙기면되. 이건 지침이야 항상." 옛 앱 버전 우려를 반복 제기한 것이 불필요한 확인 요청이 됐다.

**How to apply:** 앱 변경 검토·계획 시 네이티브 빌드(심사) 필요 여부만 판단해 필요할 때만 알린다. 정본은 codex-personal-context DEVELOPMENT_STYLE "Dentlink App Implementation Boundaries". [[dentlink-app-fix-approval-scope]]

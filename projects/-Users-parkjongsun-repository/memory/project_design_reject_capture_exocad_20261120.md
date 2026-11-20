---
name: project-design-reject-capture-exocad-20261120
description: 웹 디자인 컨펌 Reject→Capture & annotate에서 exocad HTML 모델이 빠지는 제보 원인 확정(11/20), 수정은 사용자 승인 대기
metadata:
  type: project
---

2026-11-20 Slack 제보(New York DMD Sandra Low, Thomas→Tom→Frankie) 조사. 단독 세션 "디자인 reject Capture&annotate exocad 화면 오류 조사"(메인에서 분리).

- 원장님 환경: Amplitude 이벤트 속성상 **Windows Firefox 160**, 승인 /orders/1000068762/approvals/24066. 캡처 클릭 2초 안에 Screenshot 모드 진입(화면 공유 창 없음) → `captureHtmlIframePreview`(iframe DOM 복제 + SVG foreignObject) 경로 성공. 이후 그림 그리기·Delete screenshot·재캡처 반복.
- exocad webview HTML은 3D를 WebGL canvas(preserveDrawingBuffer false)로 그림 → DOM 복제 시 canvas 내용 없음 → 캡처에 치아 모델 없이 보라 배경만 남음(로컬 승인 1834로 재현 이미지 확인).
- Chrome 158에서는 blob URL foreignObject SVG가 canvas를 오염시켜 HTML 복제 캡처가 항상 실패 → getDisplayMedia(화면 공유 "허용") 경로로 넘어가 모델이 정상 캡처됨. data URL로 바꾸면 Chrome도 복제 경로가 성공해 같은 버그가 생기므로 단순 data URL 전환은 금지.
- Amplitude 리플레이는 canvas를 녹화하지 못해 화면 판단 근거로 못 씀(이벤트 속성·타이밍은 유효).

**Why:** 수정 방향(iframe 안 canvas 있으면 화면 공유 경로로 보내기 등)은 사용자 승인 후 구현. Firefox 화면 공유 경로(preferCurrentTab·CropTarget 미지원) 결과는 미검증.
**How to apply:** 이어서 작업 시 위 사실에서 시작, 로컬 데이터는 주문 9000010104/승인 1834(exocad HTML).

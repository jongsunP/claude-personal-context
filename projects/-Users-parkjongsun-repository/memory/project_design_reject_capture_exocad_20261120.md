---
name: project-design-reject-capture-exocad-20261120
description: 웹 디자인 컨펌 Reject→Capture & annotate exocad 모델 누락(Firefox) 조사·노션 공유 마감(11/20), 다음 진행은 사용자 팀 회의 결정 대기
metadata:
  type: project
---

**현재 상태(11/20 마감):** 조사·재현·노션 공유 완료. 코드 수정·커밋·배포 없음. 다음 진행은 사용자가 팀 회의 후 결정해 지시할 때까지 대기(먼저 진행하거나 추적하지 않음).

2026-11-20 Slack 제보(New York DMD Sandra Low, Thomas→Tom→Frankie) 조사. 단독 세션 "디자인 reject Capture&annotate exocad 화면 오류 조사"(메인에서 분리).

- 원장님 환경: Amplitude 이벤트 속성상 **Windows Firefox 160**, 승인 /orders/1000068762/approvals/24066. 캡처 클릭 2초 안에 Screenshot 모드 진입(화면 공유 창 없음) → `captureHtmlIframePreview`(iframe DOM 복제 + SVG foreignObject) 경로 성공. 이후 그림 그리기·Delete screenshot·재캡처 반복.
- exocad webview HTML은 3D를 WebGL canvas(preserveDrawingBuffer false)로 그림 → DOM 복제 시 canvas 내용 없음 → 캡처에 치아 모델 없이 보라 배경만 남음(로컬 승인 1834로 재현 이미지 확인).
- Chrome 158에서는 blob URL foreignObject SVG가 canvas를 오염시켜 HTML 복제 캡처가 항상 실패 → getDisplayMedia(화면 공유 "허용") 경로로 넘어가 모델이 정상 캡처됨. data URL로 바꾸면 Chrome도 복제 경로가 성공해 같은 버그가 생기므로 단순 data URL 전환은 금지.
- Amplitude 리플레이는 canvas를 녹화하지 못해 화면 판단 근거로 못 씀(이벤트 속성·타이밍은 유효).

- 11/20 사용자 실제 Mac Firefox 159로 같은 승인 재현 확인(모델 누락). 원장님은 08:34 스크린샷 없이 사유만 반려 제출.
- 팀 공유 노션: DEV Team/Development Documents "디자인 컨펌 Reject 캡처 시 exocad 3D 모델 누락 (Firefox)" https://app.notion.com/p/41ece072e82f816c8172eb1abe39a91f (FE·Issue, 재현 사진·Amplitude 근거·후보 방향). 수정 방향은 사용자가 팀 회의 후 결정.

**Why:** 수정 방향(iframe 안 canvas 있으면 화면 공유 경로로 보내기 등)은 사용자 승인 후 구현. Firefox 화면 공유 경로(preferCurrentTab·CropTarget 미지원) 결과는 미검증.
**How to apply:** 이어서 작업 시 위 사실에서 시작, 로컬 데이터는 주문 9000010104/승인 1834(exocad HTML).

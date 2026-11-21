  GNU nano 8.7.1                                    docs/incident-report.md *                                           #장애 보고서 : DB 중지로 인한 서비스 상태 오류

- 발생 일시 : 2026-11-


# 장애 보고서: DB 중지로 인한 서비스 상태 오류

- 발생 일시: 2026-11-22 03:28 (테스트 환경)
- 영향 범위: /health 요청 시 503 오류, DB를 사용하는 기능 사용 불가

## 1. 증상
- `curl localhost:8000/health` 요청 시 503 응답
- 응답 메시지: `failed to resolve host 'db': Name or service not known`

## 2. 원인
- `docker compose ps` 확인 결과 db 컨테이너가 목록에서 사라짐 (중지 상태)
- 앱 로그에서 정상 시 200, 장애 발생 후 503 응답 확인
- 결론: DB 컨테이너가 중지되어 도커 내부 네트워크에서 `db` 호스트를 찾지 못함

## 3. 조치
- `docker compose start db`로 DB 컨테이너 재시작
- `curl localhost:8000/health` 재확인 결과 `"status":"ok"` 정상화

## 4. 재발 방지
- 컨테이너 자동 재시작 정책(`restart: unless-stopped`) 적용
- 상태 점검 스크립트로 서비스 상태 주기 확인

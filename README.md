# Mini Solution: 구축형 서비스 설치·운영 실습

Nginx, FastAPI, PostgreSQL을 Docker Compose로 구성하고
설치, 장애 대응, 모니터링까지 직접 해본 실습 프로젝트입니다.

## 구성
브라우저 → Nginx(8000번 포트) → FastAPI 앱 → PostgreSQL

| 구성 요소 | 역할 |
|---|---|
| Nginx | 외부 요청을 받아 앱으로 전달 (리버스 프록시) |
| FastAPI | 서비스 앱, `/health`로 DB 연결 상태 확인 |
| PostgreSQL | 데이터베이스 |

## 설치 방법
1. Docker, Docker Compose 설치
2. 실행: `sudo docker compose up -d --build`
3. 상태 확인: `sudo docker compose ps`, `curl localhost:8000/health`
4. 정상 응답: `{"status":"ok","db":"connected"}`

## 운영 설정
- 모든 컨테이너에 `restart: unless-stopped` 적용 (비정상 종료 시 자동 재시작)

## 모니터링
- `scripts/check.sh`: 서비스 상태, 디스크, 메모리 사용률 점검
- cron으로 1분마다 실행, 결과는 `logs/check.log`에 기록

## 장애 대응
- DB 중지 상황을 재현하고 원인 분석 및 복구
- 보고서: `docs/incident-report.md`

## 실습 환경
- Windows + WSL2 (Ubuntu)
- 환경 구성 중 가상화 비활성 오류를 BIOS 설정(Intel VT-x)으로 해결

※ DB 비밀번호는 실습용 예시 값입니다.

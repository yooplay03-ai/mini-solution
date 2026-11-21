#!/bin/bash
LOG_DIR=/home/yuna/mini-soluction/logs
mkdir -p "$LOG_DIR"
NOW=$(date '+%Y-%m-%d %H:%M:%S')

DISK=$(df -h / | awk 'NR==2 {print $5}')
MEM=$(free -m | awk 'NR==2 {printf "%d%%", $3/$2*100}')

if curl -s -f -o /dev/null http://localhost:8000/health; then
  STATUS="OK"
else
  STATUS="FAIL"
fi

echo "$NOW | service=$STATUS | disk=$DISK | mem=$MEM" | tee -a "$LOG_DIR/check.log"

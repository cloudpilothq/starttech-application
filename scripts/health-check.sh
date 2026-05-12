#!/bin/bash
# health-check.sh
ALB_URL=${ALB_URL:-"localhost"}

echo "Checking health endpoint..."
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" http://$ALB_URL/health)

if [ "$HTTP_STATUS" -ne 200 ]; then
  echo "Application is DOWN (HTTP $HTTP_STATUS)"
  exit 1
else
  echo "Application is UP (HTTP 200)"
  exit 0
fi

#!/bin/bash
# deploy-backend.sh
set -e

ASG_NAME=${ASG_NAME:-"starttech-asg-prod"}

echo "Starting rolling update (instance refresh) for ASG: $ASG_NAME"
aws autoscaling start-instance-refresh \
    --auto-scaling-group-name $ASG_NAME \
    --preferences '{"MinHealthyPercentage": 50, "InstanceWarmup": 300}'

echo "Instance refresh started. Monitor via AWS console or CI/CD."

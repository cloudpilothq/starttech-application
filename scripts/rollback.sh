#!/bin/bash
# rollback.sh
set -e

ASG_NAME=${ASG_NAME:-"starttech-asg-prod"}

echo "Cancelling instance refresh for ASG: $ASG_NAME"
aws autoscaling cancel-instance-refresh --auto-scaling-group-name $ASG_NAME

echo "Rolling back Auto Scaling Group to previous configuration is generally handled by reverting the launch template in Terraform and triggering a new instance refresh."

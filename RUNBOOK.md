# Operations Runbook

## Deployment Issues

### Backend Deployment Fails / Hangs
**Symptom**: GitHub Action for Backend CI/CD is stuck on "Wait for Instance Refresh" or fails.
**Resolution**:
1. Check AWS Console -> EC2 -> Auto Scaling Groups -> `starttech-asg-prod` -> Instance Refresh tab.
2. If instances are failing health checks, look at the Application Load Balancer target group `starttech-tg-prod`.
3. Check CloudWatch Logs for the new instances to see why the application is crashing.
4. To rollback, run `./scripts/rollback.sh` locally or revert the commit in Git to trigger a deployment of the last known good image.

### Frontend Not Updating
**Symptom**: New changes merged to main are not visible on the website.
**Resolution**:
1. Check the GitHub Actions frontend pipeline to ensure it completed successfully.
2. Verify that the CloudFront invalidation step succeeded.
3. If necessary, manually run the invalidation:
   `aws cloudfront create-invalidation --distribution-id <ID> --paths "/*"`

## Application Errors

### High ALB 5xx Errors
**Symptom**: CloudWatch Alarm `starttech-alb-5xx-errors-prod` triggers.
**Resolution**:
1. Check CloudWatch Logs Insight for exceptions:
   ```
   fields @timestamp, @message
   | filter @message like /error|Exception/
   | sort @timestamp desc
   ```
2. Verify Database connectivity (MongoDB Atlas).
3. Verify ElastiCache Redis connectivity.

### Unhealthy Hosts
**Symptom**: CloudWatch Alarm `starttech-unhealthy-hosts-prod` triggers.
**Resolution**:
1. Check ASG capacity and EC2 instance statuses.
2. If an instance is continuously failing health checks, terminate it manually to let the ASG replace it.
3. Review `/var/log/messages` or Docker logs on the instance for underlying OS/Docker daemon issues.

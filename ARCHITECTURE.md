# System Architecture

## Overview
The StartTech application is a scalable, highly available full-stack application hosted on AWS.

## Components

### Frontend (React)
- **Hosting**: AWS S3 Bucket (Static Website Hosting)
- **CDN**: Amazon CloudFront
- **Description**: The React application is built into static HTML/CSS/JS assets. CloudFront serves these assets globally with low latency and caches them at edge locations.

### Backend (Golang API)
- **Compute**: Amazon EC2 instances managed by an Auto Scaling Group (ASG).
- **Load Balancing**: Application Load Balancer (ALB) routes incoming traffic to healthy EC2 instances.
- **Scaling**: The ASG scales based on CPU utilization and handles rolling updates via Instance Refresh.

### Data Layer
- **Caching**: Amazon ElastiCache (Redis) is used for session management and fast data retrieval.
- **Database**: MongoDB Atlas (or self-hosted MongoDB) serves as the persistent data store.

### Monitoring & Observability
- **Logs**: Amazon CloudWatch Logs centralizes application and system logs.
- **Metrics & Alarms**: CloudWatch monitors ALB 5xx errors and unhealthy hosts, alerting the team if thresholds are breached.

# StartTech Application

This repository contains the full-stack application code and CI/CD pipelines for StartTech.

## Architecture
See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed architecture documentation.

## Operations and Troubleshooting
See [RUNBOOK.md](RUNBOOK.md) for operational procedures and troubleshooting guides.

## CI/CD Pipelines

### Frontend Pipeline
The frontend is a React application deployed to AWS S3 and distributed globally via CloudFront.
- Trigger: Push to `main` branch with changes in `Client/`
- Build: Node.js, `npm ci`, `npm run build`
- Deploy: `aws s3 sync`, `aws cloudfront create-invalidation`

### Backend Pipeline
The backend is a Golang API deployed to an Auto Scaling Group on EC2 behind an Application Load Balancer.
- Trigger: Push to `main` branch with changes in `Server/`
- Build: Go tests, Docker build, push to Amazon ECR
- Deploy: AWS Auto Scaling Instance Refresh (Rolling update)

## Local Development

### Frontend
```bash
cd Client
npm install
npm start
```

### Backend
```bash
cd Server
go run .
```

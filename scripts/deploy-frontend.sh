#!/bin/bash
# deploy-frontend.sh
set -e

S3_BUCKET=${S3_BUCKET:-"starttech-frontend-bucket"}
CLOUDFRONT_DIST_ID=${CLOUDFRONT_DIST_ID:-"EXXX"}

echo "Building React app..."
cd ../Client
npm install
npm run build

echo "Syncing to S3..."
aws s3 sync ./build s3://$S3_BUCKET/ --delete

echo "Invalidating CloudFront cache..."
aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DIST_ID --paths "/*"

echo "Frontend deployment complete."

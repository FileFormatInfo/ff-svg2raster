#!/bin/bash
#docker login -u oauth2accesstoken -p "$(gcloud auth print-access-token)" https://gcr.io

set -o errexit
set -o pipefail
set -o nounset

docker build -t ff-svg2raster .
docker tag ff-svg2raster:latest gcr.io/ff-svg2raster/ff-svg2raster
docker push gcr.io/ff-svg2raster/ff-svg2raster:latest

gcloud beta run deploy ff-svg2raster \
	--allow-unauthenticated \
	--image gcr.io/ff-svg2raster/ff-svg2raster \
	--platform managed \
	--project ff-svg2raster \
	--region us-central1 \
	--update-env-vars "COMMIT=$(git rev-parse --short HEAD),LASTMOD=$(date -u +%Y-%m-%dT%H:%M:%SZ)"

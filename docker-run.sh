#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset


docker build -t ff-svg2raster .
docker run -p 4000:8080 ff-svg2raster

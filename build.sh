#!/bin/bash

set -e
if [ ! -d "app" ]; then
    innoextract -e setup_nwn_diamond_*.exe
fi
docker build -t nw-build .
image_id=$(docker create nw-build)
docker cp $image_id:/tmp/Neverwinter/nwn .

#!/usr/bin/env bash

set -euo pipefail

./build-mac-post-npm.sh

### textile-pb
(
    cd go-textile
    mkdir -p mobile/dist/ios/protos
    protoc --proto_path=./pb/protos --objc_out=./mobile/dist/ios/protos ./pb/protos/*
)

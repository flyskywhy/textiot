#!/usr/bin/env bash

set -euo pipefail

## android
### textile-pb
(
    cd go-textile
    mkdir -p release/PBProject/pb/src/main/java
    protoc --proto_path=./pb/protos --java_out=./release/PBProject/pb/src/main/java ./pb/protos/*
    cd release/PBProject
    ./androidx2android.sh
    ./gradlew pb:build
    mv pb/build/outputs/aar/pb-release.aar dist/android/pb-android.aar
    ./android2androidx.sh
    ./gradlew pb:build
    mv pb/build/outputs/aar/pb-release.aar dist/android/pb-androidx.aar
)

./build-post-npm.sh

## react-native
### js-types
npm install --no-package-lock
(
    cd node_modules/protobufjs
    sed -i -e "s/\"jsdoc\": \".*\"/\"jsdoc\": \"3.5.5\"/" package.json
    cd cli
    npm install jsdoc@3.5.5

    # ref to https://github.com/textileio/protobuf.js/commit/40a20a28e980c17cc3e9c199660c18a5c2a42f2c
    sed -i -e "s/\"|null\"/\"\"/" targets/static.js
    sed -i -e "s/field.optional.*: prop/prop/" targets/static.js
    sed -i -e "s/\"|null|undefined\"/\"\"/" targets/static.js
)
./node_modules/protobufjs/bin/pbjs -t static-module -w es6 -o go-textile/release/@textile/js-types/dist/index.js go-textile/pb/protos/*
./node_modules/protobufjs/bin/pbts -o go-textile/release/@textile/js-types/dist/index.d.ts go-textile/release/@textile/js-types/dist/index.js
### react-native-sdk
(
    cd react-native-sdk
    npm install --no-package-lock
    npm run build
    rm -fr node_modules
)
rm -fr node_modules

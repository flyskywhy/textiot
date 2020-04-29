#!/usr/bin/env bash

set -euo pipefail

## setup go-textile
(cd go-textile; make setup)

## x64-linux
(cd go-textile; make textile)

## x64-windows
(cd go-textile; make textile-win)

## arm-linux
(cd go-textile; make textile-arm)

## android
### textile-mobile
(
    cd go-textile
    mkdir -p ~/go/src/github.com/textileio
    rm -f ~/go/src/github.com/textileio/go-textile
    ln -s `pwd` ~/go/src/github.com/textileio/go-textile
    go mod vendor
    make android
)
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
### android-textile
(
    cd android-textile
    ./androidx2android.sh
    ./gradlew androidDependencies
    ./gradlew textile:build
    mv textile/build/outputs/aar/textile-release.aar dist/textile-android.aar
    ./android2androidx.sh
    ./gradlew androidDependencies
    ./gradlew textile:build
    mv textile/build/outputs/aar/textile-release.aar dist/textile-androidx.aar
)

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
# .npmignore include bellow actions
#rm -fr node_modules

## js-http-client
## The `tsc` in `npm run build` will failed if there is some parent `node_modules/` as
## described in https://github.com/microsoft/TypeScript/issues/29808#issuecomment-604190036
## And refer to js-ipfs, maybe we should develop in pure javascript directly?
(
    cd js-http-client
    npm install
    npm run build
    rm -fr node_modules
)

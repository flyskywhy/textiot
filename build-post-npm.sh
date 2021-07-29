#!/usr/bin/env bash

set -euo pipefail

## setup go-textile
(cd go-textile; make setup)

## x64-linux
(cd go-textile; rm -f textile; make textile)

## x64-windows
(cd go-textile; rm -f textile.exe; make textile-win)

## arm-linux
(cd go-textile; rm -f textile-arm; make textile-arm)

protocVersion=`protoc --version | sed "s/libprotoc //"`
sed -i -e "s/com.google.protobuf:protobuf-java:3.6.1/com.google.protobuf:protobuf-java:$protocVersion/" go-textile/release/PBProject/pb/build.gradle
sed -i -e "s/com.google.protobuf:protobuf-java:3.6.1/com.google.protobuf:protobuf-java:$protocVersion/" android-textile/textile/build.gradle
sed -i -e "s/com.google.protobuf:protobuf-java:3.6.1/com.google.protobuf:protobuf-java:$protocVersion/" android/build.gradle

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

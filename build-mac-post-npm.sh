#!/usr/bin/env bash

set -euo pipefail

## setup go-textile
(cd go-textile; make setup)

## x64-macos
(cd go-textile; make textile-mac)

## ios
### textile-mobile
(
    cd go-textile
    mkdir -p ~/go/src/github.com/textileio
    rm -f ~/go/src/github.com/textileio/go-textile
    ln -s `pwd` ~/go/src/github.com/textileio/go-textile
    go mod vendor
    make ios
    cd mobile/dist/ios/Mobile.framework/Versions
    rm -fr Current
    ln -s A Current
    cd ..
    rm -fr Headers Mobile Modules Resources
    ln -s Versions/Current/Headers Headers
    ln -s Versions/Current/Mobile Mobile
    ln -s Versions/Current/Modules Modules
    ln -s Versions/Current/Resources Resources
)

# textiot
A framework for building web and native (IoT) Dapps on the IPFS network.

An only one textiot.git was combined with https://github.com/textileio/go-textile and related git repos for easier development.

## Usage
### react-native
Add bellow into `android/settings.gradle`

androidx not android:
```
include ':textile-pb'
project(':textile-pb').projectDir = new File(rootProject.projectDir, '../node_modules/textiot/android-textile/pb-androidx')
include ':textile-mobile'
project(':textile-mobile').projectDir = new File(rootProject.projectDir, '../node_modules/textiot/android-textile/mobile')
include ':android-textile'
project(':android-textile').projectDir = new File(rootProject.projectDir, '../node_modules/textiot/react-native-sdk/textile-androidx')
include ':textile-react-native-sdk'
project(':textile-react-native-sdk').projectDir = new File(rootProject.projectDir, '../node_modules/textiot/react-native-sdk/android')
```
and `cd node_modules/textiot/react-native-sdk; ./android2androidx.sh`

android not androidx:
```
include ':textile-pb'
project(':textile-pb').projectDir = new File(rootProject.projectDir, '../node_modules/textiot/android-textile/pb-android')
include ':textile-mobile'
project(':textile-mobile').projectDir = new File(rootProject.projectDir, '../node_modules/textiot/android-textile/mobile')
include ':android-textile'
project(':android-textile').projectDir = new File(rootProject.projectDir, '../node_modules/textiot/react-native-sdk/textile-android')
include ':textile-react-native-sdk'
project(':textile-react-native-sdk').projectDir = new File(rootProject.projectDir, '../node_modules/textiot/react-native-sdk/android')
```
and `cd node_modules/textiot/react-native-sdk; ./androidx2android.sh`

    require('textiot/react-native-sdk').default;

### web

    require('textiot/js-http-client').default;

## Docs
### textile
[tour of Textile](docs/docs/a-tour-of-textile.md)

## Develop
### Install tools
```
golang 1.12
android sdk
android ndk r20
nodejs 10
suod apt install gcc-arm-linux-gnueabihf
```
### Setup tools

    go get golang.org/x/mobile/cmd/gomobile

if `unrecognized import path "golang.org/x/mobile/cmd/gomobile` , then

    cd ~/go/src/github.com/golang
    git clone https://github.com/golang/mobile
    git clone https://github.com/golang/tools
    gomobile init

and also

    export GO111MODULE=on
    export GOPROXY=https://goproxy.io

### Build

    ./build.sh

results:
```
go-textile/textile
go-textile/textile-arm
android-textile/pb-androidx
android-textile/pb-android
android-textile/mobile
react-native-sdk/textile-androidx
react-native-sdk/textile-android
react-native-sdk/dist/index.js
js-http-client/dist/index.js
```

## TODO
ios

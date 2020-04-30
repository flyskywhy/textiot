#!/usr/bin/env bash

# [symlinks are deliberately not included by npm](https://npm.community/t/how-can-i-publish-symlink/5599/2)
# so we need this post-install.sh

set -euo pipefail

## react-native-sdk
ln -s react-native-sdk/android android
ln -s react-native-sdk/ios ios
ln -s react-native-sdk/textile-react-native-sdk.podspec textile-react-native-sdk.podspec

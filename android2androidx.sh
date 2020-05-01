#!/usr/bin/env bash

set -euo pipefail

sed -i -e "s/appcompatVersion = '28.0.0'/androidxAppcompatVersion = '1.0.2'/" android/manifest.gradle
sed -i -e "s/lifecycleVersion = '1.1.1'/androidxLifecycleVersion = '2.0.0'/" android/manifest.gradle
sed -i -e "s/uploadServiceVersion = '3.5.4'/uploadServiceVersion = '3.5.5'/" android/manifest.gradle

sed -i -e "s/android.support.test.runner.AndroidJUnitRunner/androidx.test.runner.AndroidJUnitRunner/" android/build.gradle
sed -i -e "s/com.android.support:appcompat-v7:\$appcompatVersion/androidx.appcompat:appcompat:\$androidxAppcompatVersion/" android/build.gradle
sed -i -e "s/com.android.support:support-v4:\$appcompatVersion/androidx.legacy:legacy-support-v4:1.0.0/" android/build.gradle
sed -i -e "s/    \/\/ implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/    implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/" android/build.gradle
sed -i -e "s/android.arch.lifecycle:extensions:\$lifecycleVersion/androidx.lifecycle:lifecycle-extensions:\$androidxLifecycleVersion/" android/build.gradle
sed -i -e "s/android.arch.lifecycle:compiler:\$lifecycleVersion/androidx.lifecycle:lifecycle-compiler:\$androidxLifecycleVersion/" android/build.gradle
sed -i -e "s/com.android.support.test:runner:\$testRunnerVersion/androidx.test.ext:junit:1.1.1/" android/build.gradle

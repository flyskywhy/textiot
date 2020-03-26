#!/usr/bin/env bash

set -euo pipefail

sed -i -e "s/androidxAppcompatVersion = '1.0.2'/appcompatVersion = '28.0.0'/" android/manifest.gradle
sed -i -e "s/androidxLifecycleVersion = '2.0.0'/lifecycleVersion = '1.1.1'/" android/manifest.gradle
sed -i -e "s/uploadServiceVersion = '3.5.5'/uploadServiceVersion = '3.5.4'/" android/manifest.gradle

sed -i -e "s/androidx.test.runner.AndroidJUnitRunner/android.support.test.runner.AndroidJUnitRunner/" android/build.gradle
sed -i -e "s/androidx.appcompat:appcompat:\$androidxAppcompatVersion/com.android.support:appcompat-v7:\$appcompatVersion/" android/build.gradle
sed -i -e "s/androidx.legacy:legacy-support-v4:1.0.0/com.android.support:support-v4:\$appcompatVersion/" android/build.gradle
sed -i -e "s/    implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/    \/\/ implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/" android/build.gradle
sed -i -e "s/androidx.lifecycle:lifecycle-extensions:\$androidxLifecycleVersion/android.arch.lifecycle:extensions:\$lifecycleVersion/" android/build.gradle
sed -i -e "s/androidx.lifecycle:lifecycle-compiler:\$androidxLifecycleVersion/android.arch.lifecycle:compiler:\$lifecycleVersion/" android/build.gradle
sed -i -e "s/androidx.test.ext:junit:1.1.1/com.android.support.test:runner:\$testRunnerVersion/" android/build.gradle

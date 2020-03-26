#!/usr/bin/env bash

set -euo pipefail

sed -i -e "s/^android.enableJetifier=false/# android.enableJetifier=false/" gradle.properties
sed -i -e "s/^android.useAndroidX=true/# android.useAndroidX=true/" gradle.properties

sed -i -e "s/androidx.test.runner.AndroidJUnitRunner/android.support.test.runner.AndroidJUnitRunner/" pb/build.gradle
sed -i -e "s/androidx.appcompat:appcompat:1.0.0/com.android.support:appcompat-v7:28.0.0/" pb/build.gradle
sed -i -e "s/androidx.test.ext:junit:1.1.1/com.android.support.test:runner:1.0.2/" pb/build.gradle
sed -i -e "s/androidx.test.espresso:espresso-core:3.1.0/com.android.support.test.espresso:espresso-core:3.0.2/" pb/build.gradle

sed -i -e "s/androidx.test.platform.app.InstrumentationRegistry/android.support.test.InstrumentationRegistry/" pb/src/androidTest/java/io/textile/pb/ExampleInstrumentedTest.java
sed -i -e "s/androidx.test.ext.junit.runners.AndroidJUnit4/android.support.test.runner.AndroidJUnit4/" pb/src/androidTest/java/io/textile/pb/ExampleInstrumentedTest.java

#!/usr/bin/env bash

set -euo pipefail

sed -i -e "s/^android.enableJetifier=false/# android.enableJetifier=false/" gradle.properties
sed -i -e "s/^android.useAndroidX=true/# android.useAndroidX=true/" gradle.properties

sed -i -e "s/androidxAppcompatVersion = '1.0.2'/appcompatVersion = '28.0.0'/" manifest.gradle
sed -i -e "s/androidxLifecycleVersion = '2.0.0'/lifecycleVersion = '1.1.1'/" manifest.gradle
sed -i -e "s/uploadServiceVersion = '3.5.5'/uploadServiceVersion = '3.5.4'/" manifest.gradle

sed -i -e "s/':pb-androidx'/':pb-android'/" textile/build.gradle
sed -i -e "s/androidx.test.runner.AndroidJUnitRunner/android.support.test.runner.AndroidJUnitRunner/" textile/build.gradle
sed -i -e "s/androidx.appcompat:appcompat:\$androidxAppcompatVersion/com.android.support:appcompat-v7:\$appcompatVersion/" textile/build.gradle
sed -i -e "s/androidx.legacy:legacy-support-v4:1.0.0/com.android.support:support-v4:\$appcompatVersion/" textile/build.gradle
sed -i -e "s/    implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/    \/\/ implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/" textile/build.gradle
sed -i -e "s/androidx.lifecycle:lifecycle-extensions:\$androidxLifecycleVersion/android.arch.lifecycle:extensions:\$lifecycleVersion/" textile/build.gradle
sed -i -e "s/androidx.lifecycle:lifecycle-compiler:\$androidxLifecycleVersion/android.arch.lifecycle:compiler:\$lifecycleVersion/" textile/build.gradle
sed -i -e "s/androidx.test.ext:junit:1.1.1/com.android.support.test:runner:\$testRunnerVersion/" textile/build.gradle


sed -i -e "s/androidx.test.platform.app.InstrumentationRegistry/android.support.test.InstrumentationRegistry/" textile/src/androidTest/java/io/textile/textile/TextileTest.java
sed -i -e "s/androidx.test.ext.junit.runners.AndroidJUnit4/android.support.test.runner.AndroidJUnit4/" textile/src/androidTest/java/io/textile/textile/TextileTest.java

sed -i -e "s/androidx.lifecycle.Lifecycle/android.arch.lifecycle.Lifecycle/" textile/src/main/java/io/textile/textile/Textile.java
sed -i -e "s/androidx.lifecycle.LifecycleObserver/android.arch.lifecycle.LifecycleObserver/" textile/src/main/java/io/textile/textile/Textile.java
sed -i -e "s/androidx.lifecycle.OnLifecycleEvent/android.arch.lifecycle.OnLifecycleEvent/" textile/src/main/java/io/textile/textile/Textile.java
sed -i -e "s/androidx.lifecycle.ProcessLifecycleOwner/android.arch.lifecycle.ProcessLifecycleOwner/" textile/src/main/java/io/textile/textile/Textile.java

sed -i -e "s/androidx.test.runner.AndroidJUnitRunner/android.support.test.runner.AndroidJUnitRunner/" app/build.gradle
sed -i -e "s/androidx.constraintlayout:constraintlayout/com.android.support.constraint:constraint-layout/" app/build.gradle
sed -i -e "s/androidx.appcompat:appcompat:\$androidxAppcompatVersion/com.android.support:appcompat-v7:\$appcompatVersion/" app/build.gradle
sed -i -e "s/androidx.legacy:legacy-support-v4:1.0.0/com.android.support:support-v4:\$appcompatVersion/" app/build.gradle
sed -i -e "s/    implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/    \/\/ implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/" app/build.gradle
sed -i -e "s/androidx.lifecycle:lifecycle-extensions:\$androidxLifecycleVersion/android.arch.lifecycle:extensions:\$lifecycleVersion/" app/build.gradle
sed -i -e "s/androidx.lifecycle:lifecycle-compiler:\$androidxLifecycleVersion/android.arch.lifecycle:compiler:\$lifecycleVersion/" app/build.gradle
sed -i -e "s/androidx.test.ext:junit:1.1.1/com.android.support.test:runner:\$testRunnerVersion/" app/build.gradle

sed -i -e "s/androidx.test.platform.app.InstrumentationRegistry/android.support.test.InstrumentationRegistry/" app/src/androidTest/java/io/textile/textileexample/ExampleInstrumentedTest.java
sed -i -e "s/androidx.test.ext.junit.runners.AndroidJUnit4/android.support.test.runner.AndroidJUnit4/" app/src/androidTest/java/io/textile/textileexample/ExampleInstrumentedTest.java

sed -i -e "s/androidx.appcompat.app.AppCompatActivity/android.support.v7.app.AppCompatActivity/" app/src/main/java/io/textile/textileexample/MainActivity.java

sed -i -e "s/androidx.constraintlayout.widget/android.support.constraint/" app/src/main/res/layout/activity_main.xml

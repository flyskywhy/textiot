#!/usr/bin/env bash

set -euo pipefail

sed -i -e "s/^# android.enableJetifier=false/android.enableJetifier=false/" gradle.properties
sed -i -e "s/^# android.useAndroidX=true/android.useAndroidX=true/" gradle.properties

sed -i -e "s/appcompatVersion = '28.0.0'/androidxAppcompatVersion = '1.0.2'/" manifest.gradle
sed -i -e "s/lifecycleVersion = '1.1.1'/androidxLifecycleVersion = '2.0.0'/" manifest.gradle
sed -i -e "s/uploadServiceVersion = '3.5.4'/uploadServiceVersion = '3.5.5'/" manifest.gradle

sed -i -e "s/':pb-android'/':pb-androidx'/" textile/build.gradle
sed -i -e "s/android.support.test.runner.AndroidJUnitRunner/androidx.test.runner.AndroidJUnitRunner/" textile/build.gradle
sed -i -e "s/com.android.support:appcompat-v7:\$appcompatVersion/androidx.appcompat:appcompat:\$androidxAppcompatVersion/" textile/build.gradle
sed -i -e "s/com.android.support:support-v4:\$appcompatVersion/androidx.legacy:legacy-support-v4:1.0.0/" textile/build.gradle
sed -i -e "s/    \/\/ implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/    implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/" textile/build.gradle
sed -i -e "s/android.arch.lifecycle:extensions:\$lifecycleVersion/androidx.lifecycle:lifecycle-extensions:\$androidxLifecycleVersion/" textile/build.gradle
sed -i -e "s/android.arch.lifecycle:compiler:\$lifecycleVersion/androidx.lifecycle:lifecycle-compiler:\$androidxLifecycleVersion/" textile/build.gradle
sed -i -e "s/com.android.support.test:runner:\$testRunnerVersion/androidx.test.ext:junit:1.1.1/" textile/build.gradle

sed -i -e "s/android.support.test.InstrumentationRegistry/androidx.test.platform.app.InstrumentationRegistry/" textile/src/androidTest/java/io/textile/textile/TextileTest.java
sed -i -e "s/android.support.test.runner.AndroidJUnit4/androidx.test.ext.junit.runners.AndroidJUnit4/" textile/src/androidTest/java/io/textile/textile/TextileTest.java

sed -i -e "s/android.arch.lifecycle.Lifecycle/androidx.lifecycle.Lifecycle/" textile/src/main/java/io/textile/textile/Textile.java
sed -i -e "s/android.arch.lifecycle.LifecycleObserver/androidx.lifecycle.LifecycleObserver/" textile/src/main/java/io/textile/textile/Textile.java
sed -i -e "s/android.arch.lifecycle.OnLifecycleEvent/androidx.lifecycle.OnLifecycleEvent/" textile/src/main/java/io/textile/textile/Textile.java
sed -i -e "s/android.arch.lifecycle.ProcessLifecycleOwner/androidx.lifecycle.ProcessLifecycleOwner/" textile/src/main/java/io/textile/textile/Textile.java

sed -i -e "s/android.support.test.runner.AndroidJUnitRunner/androidx.test.runner.AndroidJUnitRunner/" app/build.gradle
sed -i -e "s/com.android.support.constraint:constraint-layout/androidx.constraintlayout:constraintlayout/" app/build.gradle
sed -i -e "s/com.android.support:appcompat-v7:\$appcompatVersion/androidx.appcompat:appcompat:\$androidxAppcompatVersion/" app/build.gradle
sed -i -e "s/com.android.support:support-v4:\$appcompatVersion/androidx.legacy:legacy-support-v4:1.0.0/" app/build.gradle
sed -i -e "s/    \/\/ implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/    implementation \"androidx.lifecycle:lifecycle-common-java8:\$androidxLifecycleVersion\"/" app/build.gradle
sed -i -e "s/android.arch.lifecycle:extensions:\$lifecycleVersion/androidx.lifecycle:lifecycle-extensions:\$androidxLifecycleVersion/" app/build.gradle
sed -i -e "s/android.arch.lifecycle:compiler:\$lifecycleVersion/androidx.lifecycle:lifecycle-compiler:\$androidxLifecycleVersion/" app/build.gradle
sed -i -e "s/com.android.support.test:runner:\$testRunnerVersion/androidx.test.ext:junit:1.1.1/" app/build.gradle

sed -i -e "s/android.support.test.InstrumentationRegistry/androidx.test.platform.app.InstrumentationRegistry/" app/src/androidTest/java/io/textile/textileexample/ExampleInstrumentedTest.java
sed -i -e "s/android.support.test.runner.AndroidJUnit4/androidx.test.ext.junit.runners.AndroidJUnit4/" app/src/androidTest/java/io/textile/textileexample/ExampleInstrumentedTest.java

sed -i -e "s/android.support.v7.app.AppCompatActivity/androidx.appcompat.app.AppCompatActivity/" app/src/main/java/io/textile/textileexample/MainActivity.java

sed -i -e "s/android.support.constraint/androidx.constraintlayout.widget/" app/src/main/res/layout/activity_main.xml

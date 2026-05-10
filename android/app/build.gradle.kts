import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use {
        keystoreProperties.load(it)
    }
}

android {
    namespace = "com.rihlaty.rihlaty_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "26.1.10909125"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    defaultConfig {
        applicationId = "com.rihlaty.rihlaty_app"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode()
        versionName = flutter.versionName()

        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias", "androiddebugkey")
            keyPassword = keystoreProperties.getProperty("keyPassword", "android")
            storeFile = file(
                keystoreProperties.getProperty(
                    "storeFile",
                    "${System.getProperty("user.home")}/.android/debug.keystore"
                )
            )
            storePassword = keystoreProperties.getProperty("storePassword", "android")
        }
    }

    buildTypes {
        release {
            // استخدام debug keystore مؤقتًا حتى ينجح build
            signingConfig = signingConfigs.getByName("release")

            isMinifyEnabled = false
            isShrinkResources = false

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }

        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    lint {
        disable.add("MissingTranslation")
        checkReleaseBuilds = false
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.0.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("androidx.multidex:multidex:2.0.1")
}

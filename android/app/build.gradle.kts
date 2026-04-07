plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

import java.util.Properties
        import java.io.FileInputStream

val keystorePropertiesFile = rootProject.projectDir.resolve("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.hopegainltd.winitagent"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

   /* compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }*/
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.hopegainltd.winitagent"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }


    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }

        getByName("release") {
            // This is the VAPT fix
            isMinifyEnabled = true
            isShrinkResources = true

            // SAFE CHECK: This tries to find "release", but falls back to "debug"
            // if you haven't set up your production keystore yet.
            signingConfig = signingConfigs.findByName("release") ?: signingConfigs.getByName("debug")

            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
//        debug {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            signingConfig = signingConfigs.getByName("debug")
//            proguardFiles(
//                getDefaultProguardFile("proguard-android.txt"),
//                "proguard-rules.pro"
//            )
//        }
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            /*signingConfig = signingConfigs.getByName("debug")
//            proguardFiles(
//                getDefaultProguardFile("proguard-android.txt"),
//                "proguard-rules.pro"
//            )*/
//            isMinifyEnabled = true
//            isShrinkResources = true
//
//            // Ensure this points to your release config, not debug
//            signingConfig = signingConfigs.getByName("release")
//
//            proguardFiles(
//                getDefaultProguardFile("proguard-android-optimize.txt"),
//                "proguard-rules.pro"
//            )
//        }
    }
}

flutter {
    source = "../.."
}

dependencies{
    implementation(platform("com.google.firebase:firebase-bom:34.6.0"))
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.2")

}



repositories {
    google()
    mavenCentral()
    mavenLocal()
    maven {
        url = uri("https://jitpack.io")
    }
    maven {
        url = uri("https://repo.qoreid.com/repository/maven-releases/")
    }
}

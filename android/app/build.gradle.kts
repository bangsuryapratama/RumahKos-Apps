plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")  // ← TAMBAHKAN BARIS INI
}

android {
    namespace = "com.example.rumahkosapps"
    compileSdk = 34  // ← UBAH dari flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.rumahkosapps"
        minSdk = flutter.minSdkVersion  // ← UBAH dari flutter.minSdkVersion
        targetSdk = 34  // ← UBAH dari flutter.targetSdkVersion
        versionCode = 1  // ← UBAH dari flutter.versionCode
        versionName = "1.0"  // ← UBAH dari flutter.versionName
        multiDexEnabled = true  // ← TAMBAHKAN BARIS INI
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// ← TAMBAHKAN SECTION INI
dependencies {
    implementation("com.android.support:multidex:1.0.3")
}

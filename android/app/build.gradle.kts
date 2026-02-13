plugins {
    id 'com.android.application'
    id 'kotlin-android'
    id 'dev.flutter.flutter-gradle-plugin'
    id 'com.google.gms.google-services' 
}

android {
    namespace = "com.example.rumahkosapps"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.rumahkosapps"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
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

dependencies {
    implementation "androidx.multidex:multidex:2.0.1"
    implementation "com.google.android.gms:play-services-auth:20.7.0" // Google Sign-In
}

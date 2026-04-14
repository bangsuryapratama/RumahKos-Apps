plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.rumahkosapps"
    // SDK 36 dibutuhkan oleh plugin flutter_plugin_android_lifecycle, google_sign_in, dll.
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.rumahkosapps"
        minSdk = flutter.minSdkVersion
        targetSdk = 36 
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true
    }

    compileOptions {
        // AGP 8.x ke atas mewajibkan Java 17
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        // Menyesuaikan dengan Java 17
        jvmTarget = "17"
    }

   buildTypes {
        release {
            // Jika isMinifyEnabled false, maka shrinkResources juga HARUS false
            isMinifyEnabled = false
            isShrinkResources = false 
            
            signingConfig = signingConfigs.getByName("debug")
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        
        // Tambahkan ini jika belum ada untuk memastikan mode debug aman
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("com.google.android.gms:play-services-auth:20.7.0")
    
    // Kadang butuh eksplisit jika ada error browser
    implementation("androidx.browser:browser:1.8.0") 
}
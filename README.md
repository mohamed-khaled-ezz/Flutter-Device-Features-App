# Flutter Device Features App

A comprehensive Flutter application demonstrating native mobile device capability integrations step-by-step.

## 📱 Features & Implementation Phases

### Phase 1 — Device Info: Show Device Model and OS Version
* **Description:** Retrieves runtime device hardware model and operating system version.
* **Package:** `device_info_plus`
* **Screen:** `lib/screens/device_info_screen.dart`

### Phase 2 — Media Access: Image Picker Gallery
* **Description:** In-app gallery allowing users to select multiple images from the device gallery and display them in a list.
* **Package:** `image_picker`
* **Screen:** `lib/screens/image_gallery_screen.dart`

### Phase 3 — Google Maps and GPS: Display Map with Marker
* **Description:** Displays a full-screen Google Map with a red marker placed on Cairo Governorate, Egypt (`30.0444, 31.2357`).
* **Package:** `google_maps_flutter`
* **Screen:** `lib/screens/google_map_screen.dart`

### Phase 4 — Biometric Authentication: Fingerprint Profile Access
* **Description:** Secure profile access triggered from the profile icon on the home screen `AppBar`. Prompts for fingerprint/biometric authentication before granting access to the user profile page.
* **Package:** `local_auth`
* **Service:** `lib/services/biometric_service.dart`
* **Screen:** `lib/screens/profile_screen.dart`

### Phase 5 — Audio: Record and Playback Voice
* **Description:** Voice audio recorder and player with a "Record Audio" toggle button and a "Play Audio" button that appears once a voice recording exists.
* **Packages:** `record` & `audioplayers`
* **Screen:** `lib/screens/audio_recorder_screen.dart`

---

## 🔒 Permissions Used by the App

### Android Permissions (`android/app/src/main/AndroidManifest.xml`)

| Permission | Purpose |
| :--- | :--- |
| `android.permission.INTERNET` | Required for Google Maps tile downloads and network calls |
| `android.permission.ACCESS_NETWORK_STATE` | Network state inspection for map loading |
| `android.permission.ACCESS_FINE_LOCATION` | GPS location access for Google Maps |
| `android.permission.ACCESS_COARSE_LOCATION` | Approximate location access for Google Maps |
| `android.permission.READ_EXTERNAL_STORAGE` | Gallery access for picking images on Android 12 and below |
| `android.permission.READ_MEDIA_IMAGES` | Gallery access for picking images on Android 13+ |
| `android.permission.WRITE_EXTERNAL_STORAGE` | Temporary storage for recorded audio files |
| `android.permission.CAMERA` | Camera photo capture access |
| `android.permission.USE_BIOMETRIC` | Biometric / Fingerprint authentication prompt |
| `android.permission.USE_FINGERPRINT` | Fingerprint authentication fallback for older Android versions |
| `android.permission.RECORD_AUDIO` | Microphone access for recording voice audio |

### iOS Permissions (`ios/Runner/Info.plist`)

| Key | Description / Purpose |
| :--- | :--- |
| `NSPhotoLibraryUsageDescription` | "This app allows you to choose images from your gallery." |
| `NSCameraUsageDescription` | "This app needs camera access to let you take photos." |
| `NSMicrophoneUsageDescription` | "This app needs microphone access to record voice audio." |
| `NSFaceIDUsageDescription` | "This app uses Face ID / Biometrics for secure profile authentication." |
| `NSLocationWhenInUseUsageDescription` | "This app uses location to display your position on Google Maps." |

---

## 🛠️ Setup & Configuration Instructions

### 1. Google Maps API Key
Replace `YOUR_GOOGLE_MAPS_API_KEY` in `android/app/src/main/AndroidManifest.xml` with your valid Google Maps API Key:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
```

### 2. Biometric Authentication
On Android, `MainActivity` extends `FlutterFragmentActivity` to support biometric prompts:
```kotlin
class MainActivity : FlutterFragmentActivity()
```

---

## 📂 Project Architecture

```
lib/
├── main.dart
├── screens/
│   ├── audio_recorder_screen.dart
│   ├── device_info_screen.dart
│   ├── google_map_screen.dart
│   ├── home_screen.dart
│   ├── image_gallery_screen.dart
│   └── profile_screen.dart
├── services/
│   └── biometric_service.dart
└── widgets/
    ├── feature_card.dart
    └── profile_header.dart
```

Each screen and custom widget resides in its own Dart file following clean code principles, descriptive variable names, and clear comments explaining device integration logic.

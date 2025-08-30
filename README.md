# 🎬 Shartflix - Modern Flutter Film Uygulaması

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.2.3-blue?style=for-the-badge&logo=dart)
![BLoC](https://img.shields.io/badge/BLoC-8.1.3-purple?style=for-the-badge)
![Dio](https://img.shields.io/badge/Dio-5.3.2-green?style=for-the-badge)

**Temiz mimari ile modern, ölçeklenebilir Flutter film streaming uygulaması**

[Özellikler](#-özellikler) • [Mimari](#-mimari) • [Teknoloji Stack](#-teknoloji-stack) • [Başlangıç](#-başlangıç) • [Uygulama İkonu](#-uygulama-ikonu) • [Analytics Kurulumu](#-analytics-kurulumu) • [Proje Yapısı](#-proje-yapısı)

</div>

---

## 📱 Özellikler

### 🎯 Temel Özellikler

- **🎬 Film Keşfi**: Zengin detaylarla filmleri keşfedin
- **❤️ Favori Sistemi**: Filmleri favorilere ekleyin/çıkarın, gerçek zamanlı senkronizasyon
- **👤 Kullanıcı Kimlik Doğrulama**: JWT token yönetimi ile güvenli giriş/kayıt
- **📸 Profil Yönetimi**: Profil fotoğrafı yükleyin ve kullanıcı verilerini yönetin
- **🎨 Modern Arayüz**: Pürüzsüz animasyonlarla güzel koyu tema
- **📱 Duyarlı Tasarım**: Tüm ekran boyutları için optimize edilmiş

### 🔧 Teknik Özellikler

- **🔄 Gerçek Zamanlı Durum Yönetimi**: Reaktif UI için BLoC pattern
- **🌐 API Entegrasyonu**: Dio HTTP client ile RESTful API
- **🔐 Güvenli Depolama**: JWT token'ları ve kullanıcı verisi şifreleme
- **🖼️ Görsel Önbellekleme**: CachedNetworkImage ile verimli görsel yükleme
- **📦 Bağımlılık Enjeksiyonu**: Temiz service locator pattern
- **🎨 Özel Tema**: Özel fontlarla tutarlı tasarım sistemi
- **📊 Analytics & Monitoring**: Firebase Analytics ve Crashlytics entegrasyonu (Opsiyonel)

---

## 🏗️ Mimari

### Clean Architecture

### 🎯 Mimari Prensipleri

- **Sorumluluk Ayrımı**: Her katmanın belirli bir sorumluluğu var
- **Bağımlılık Tersine Çevirme**: Yüksek seviyeli modüller düşük seviyeli modüllere bağımlı değil
- **Tek Sorumluluk**: Her sınıfın değişmek için tek bir nedeni var
- **Açık/Kapalı Prensibi**: Genişletmeye açık, değişikliğe kapalı

---

## 🛠️ Teknoloji Stack

### 📱 Temel Framework

- **Flutter 3.19.0**: Cross-platform UI framework
- **Dart 3.2.3**: Programlama dili

### 🎯 Durum Yönetimi

- **flutter_bloc 8.1.3**: BLoC pattern implementasyonu
- **equatable 2.0.7**: Değişmez nesneler için değer eşitliği

### 🌐 Ağ ve API

- **dio 5.3.2**: Interceptor'larla HTTP client
- **http 1.1.0**: Ek HTTP yardımcıları
- **json_annotation 4.8.1**: JSON serileştirme

### 💾 Depolama ve Güvenlik

- **flutter_secure_storage 9.0.0**: Şifrelenmiş key-value depolama
- **get_it 7.6.4**: Bağımlılık enjeksiyonu için service locator
- **injectable 2.3.2**: DI için kod üretimi

### 📊 Analytics ve Monitoring (Opsiyonel)

- **firebase_core 2.24.2**: Firebase temel servisleri
- **firebase_analytics 10.8.0**: Kullanıcı davranış analizi
- **firebase_crashlytics 3.4.8**: Hata raporlama ve izleme

### 🎨 UI ve UX

- **cached_network_image 3.3.0**: Verimli görsel yükleme ve önbellekleme
- **flutter_svg 2.0.10+1**: SVG desteği
- **inner_shadow_container 1.0.4**: Özel gölge efektleri

### 📸 Medya ve Dosyalar

- **image_picker 1.2.0**: Kamera ve galeri erişimi

### 🔧 Geliştirme Araçları

- **build_runner 2.4.7**: Kod üretimi
- **json_serializable 6.7.1**: JSON kod üretimi
- **injectable_generator 2.4.1**: DI kod üretimi
- **flutter_lints 3.0.0**: Kod kalitesi kuralları
- **flutter_launcher_icons 0.13.1**: Uygulama ikonu yönetimi

### 🎬 Animasyonlar

- **lottie 2.7.0**: Lottie animasyon desteği
- **Loading Animasyonları**: Spinner, dots, pulse
- **Success Animasyonları**: Check, star
- **Error Animasyonları**: Shake, sad
- **Empty State Animasyonları**: Box, list
- **Movie Animasyonları**: Reel, popcorn, heart beat
- **Navigation Animasyonları**: Page transition, tab switch

### 🎨 Tasarım Sistemi

- **Özel Fontlar**: EuclidCircularA, Montserrat
- **Koyu Tema**: Tutarlı renk paleti
- **Material Design 3**: Modern UI bileşenleri

---

## 🚀 Başlangıç

### Ön Gereksinimler

- Flutter SDK 3.19.0 veya üzeri
- Dart SDK 3.2.3 veya üzeri
- Android Studio / VS Code
- Git

### Kurulum

1. **Repository'yi klonlayın**

   ```bash
   git clone https://github.com/yourusername/shartflix.git
   cd shartflix
   ```

2. **Bağımlılıkları yükleyin**

   ```bash
   flutter pub get
   ```

3. **Firebase Kurulumu (Opsiyonel)**

   ```bash
   # Aşağıda yazıyor.
   ```

4. **Kodu üretin**

   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

5. **Uygulamayı çalıştırın**

   ```bash
   flutter run
   ```

### 🔧 Yapılandırma

1. **API Yapılandırması**

   - `lib/core/constants/app_constants.dart` dosyasını güncelleyin
   - API base URL ve endpoint'lerinizi ayarlayın

2. **Ortam Kurulumu**

   - Platform özel ayarları yapılandırın
   - Release build'leri için imzalama ayarlayın

---

## 🎨 Uygulama İkonu

### 📋 Genel Bakış

Bu proje `assets/logo/SinFlixLogo.png` dosyasını kullanarak tüm platformlar için uygulama ikonlarını otomatik olarak oluşturur.

### ✅ Tamamlanan İşlemler

#### 1. Flutter Launcher Icons Paketi Eklendi

- `pubspec.yaml` dosyasına `flutter_launcher_icons: ^0.13.1` eklendi
- Tüm platformlar için ikon yapılandırması yapıldı

#### 2. İkon Yapılandırması

```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/logo/SinFlixLogo.png"
  min_sdk_android: 21
  web:
    generate: true
    image_path: "assets/logo/SinFlixLogo.png"
    background_color: "#1A1A1A"
    theme_color: "#FF3B30"
  windows:
    generate: true
    image_path: "assets/logo/SinFlixLogo.png"
    icon_size: 48
  macos:
    generate: true
    image_path: "assets/logo/SinFlixLogo.png"
```

#### 3. Platform Yapılandırmaları Güncellendi

**Android**

- `android/app/src/main/AndroidManifest.xml` güncellendi
- Uygulama adı "Shartflix" olarak değiştirildi
- İkon referansı `@mipmap/launcher_icon` olarak güncellendi

**iOS**

- `ios/Runner/Info.plist` güncellendi
- Uygulama adı "Shartflix" olarak değiştirildi

**Web**

- `web/manifest.json` güncellendi
- Uygulama adı "Shartflix" olarak değiştirildi
- Yeni ikonlar otomatik olarak eklendi

#### 4. İkonlar Oluşturuldu

Aşağıdaki platformlar için ikonlar başarıyla oluşturuldu:

**Android**

- `mipmap-mdpi/launcher_icon.png` (48x48)
- `mipmap-hdpi/launcher_icon.png` (72x72)
- `mipmap-xhdpi/launcher_icon.png` (96x96)
- `mipmap-xxhdpi/launcher_icon.png` (144x144)
- `mipmap-xxxhdpi/launcher_icon.png` (192x192)

**iOS**

- `AppIcon.appiconset/` klasöründe tüm boyutlar
- 20x20, 29x29, 40x40, 60x60, 76x76, 83.5x83.5, 1024x1024

**Web**

- `web/icons/Icon-192.png`
- `web/icons/Icon-512.png`
- `web/icons/Icon-maskable-192.png`
- `web/icons/Icon-maskable-512.png`

**Windows & macOS**

- Windows: 48x48 ikon
- macOS: 1024x1024 ikon

### 🛠️ Kullanım

#### Otomatik Script Kullanımı

**Linux/macOS**

```bash
chmod +x scripts/update_app_icons.sh
./scripts/update_app_icons.sh
```

**Windows**

```cmd
scripts\update_app_icons.bat
```

#### Manuel Kullanım

```bash
flutter pub run flutter_launcher_icons:main
```

### 📁 Dosya Yapısı

```
shartflix/
├── assets/
│   └── logo/
│       ├── SinFlixLogo.png          # Ana logo dosyası
│       └── SinFlixSplash.png        # Splash screen logosu
├── scripts/
│   ├── update_app_icons.sh          # Linux/macOS script
│   └── update_app_icons.bat         # Windows script
├── android/app/src/main/res/
│   ├── mipmap-mdpi/launcher_icon.png
│   ├── mipmap-hdpi/launcher_icon.png
│   ├── mipmap-xhdpi/launcher_icon.png
│   ├── mipmap-xxhdpi/launcher_icon.png
│   └── mipmap-xxxhdpi/launcher_icon.png
├── ios/Runner/Assets.xcassets/AppIcon.appiconset/
│   ├── Icon-App-20x20@1x.png
│   ├── Icon-App-20x20@2x.png
│   ├── Icon-App-20x20@3x.png
│   ├── Icon-App-29x29@1x.png
│   ├── Icon-App-29x29@2x.png
│   ├── Icon-App-29x29@3x.png
│   ├── Icon-App-40x40@1x.png
│   ├── Icon-App-40x40@2x.png
│   ├── Icon-App-40x40@3x.png
│   ├── Icon-App-60x60@2x.png
│   ├── Icon-App-60x60@3x.png
│   ├── Icon-App-76x76@1x.png
│   ├── Icon-App-76x76@2x.png
│   ├── Icon-App-83.5x83.5@2x.png
│   └── Icon-App-1024x1024@1x.png
└── web/icons/
    ├── Icon-192.png
    ├── Icon-512.png
    ├── Icon-maskable-192.png
    └── Icon-maskable-512.png
```

### 🔄 İkon Güncelleme

#### Yeni İkon Ekleme

1. Yeni ikon dosyasını `assets/logo/` klasörüne koyun
2. `pubspec.yaml` dosyasındaki `image_path` değerini güncelleyin
3. İkonları yeniden oluşturun:
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

#### Desteklenen Formatlar

- PNG (önerilen)
- JPG
- SVG

#### Önerilen Boyutlar

- **Ana logo**: 1024x1024 piksel
- **Splash screen**: 1024x1024 piksel
- **Format**: PNG (şeffaflık desteği için)

### 🚀 Test Etme

#### Debug Modunda Test

```bash
flutter run
```

#### Release Build Test

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

### ⚠️ Önemli Notlar

1. **İkon Boyutu**: Ana logo dosyası en az 1024x1024 piksel olmalıdır
2. **Format**: PNG formatı önerilir (şeffaflık desteği)
3. **Temizlik**: İkon değişikliklerinden sonra `flutter clean` çalıştırın
4. **Platform Spesifik**: Her platform için farklı boyutlar otomatik oluşturulur

### 🐛 Sorun Giderme

#### İkonlar Görünmüyor

1. `flutter clean` çalıştırın
2. `flutter pub get` çalıştırın
3. İkonları yeniden oluşturun
4. Uygulamayı yeniden başlatın

#### Hatalı İkon Boyutu

1. Ana logo dosyasının 1024x1024 piksel olduğunu kontrol edin
2. PNG formatında olduğunu kontrol edin
3. İkonları yeniden oluşturun

#### Platform Spesifik Sorunlar

- **Android**: `android/app/src/main/res/` klasörünü kontrol edin
- **iOS**: `ios/Runner/Assets.xcassets/AppIcon.appiconset/` klasörünü kontrol edin
- **Web**: `web/icons/` klasörünü kontrol edin

---

## 📊 Analytics Kurulumu

### 🔥 Firebase Analytics ve Crashlytics Kurulumu

Bu proje Firebase Analytics ve Crashlytics entegrasyonu ile gelir. Analytics özelliklerini kullanmak için aşağıdaki adımları takip edin:

#### 📋 Ön Gereksinimler

- Google hesabı
- Firebase Console erişimi
- Flutter projesi kurulumu tamamlanmış olmalı

#### 1. Firebase Projesi Oluşturma

1. [Firebase Console](https://console.firebase.google.com/)'a gidin
2. "Yeni Proje Oluştur" butonuna tıklayın
3. Proje adını girin (örn: "shartflix-analytics")
4. Google Analytics'i etkinleştirin
5. Proje oluşturulduktan sonra "Android" platformunu ekleyin

#### 2. Android Yapılandırması

1. **Package Name**: `com.shartflix.app.shartflix` (proje ayarlarınıza göre)
2. **App Nickname**: "Shartflix" (opsiyonel)
3. **Debug Signing Certificate**: SHA-1 sertifikanızı ekleyin

```bash
# Debug SHA-1 sertifikasını almak için:
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# Windows için:
keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

4. `google-services.json` dosyasını indirin ve `android/app/` klasörüne yerleştirin

#### 3. iOS Yapılandırması (Opsiyonel)

1. Firebase Console'da "iOS" platformunu ekleyin
2. Bundle ID: `com.example.shartflix` (veya kendi bundle ID'niz)
3. `GoogleService-Info.plist` dosyasını indirin ve `ios/Runner/` klasörüne yerleştirin

#### 4. Android Gradle Yapılandırması

`android/build.gradle.kts` dosyasına Firebase plugin'lerini ekleyin:

```kotlin
buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
        classpath("com.google.firebase:firebase-crashlytics-gradle:2.9.9")
    }
}
```

`android/app/build.gradle.kts` dosyasına plugin'leri ekleyin:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // Firebase plugins
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}
```

#### 5. Flutter Bağımlılıkları

`pubspec.yaml` dosyasında Firebase paketleri zaten mevcut:

```yaml
dependencies:
  # Firebase
  firebase_core: ^2.24.2
  firebase_analytics: ^10.8.0
  firebase_crashlytics: ^3.4.8
```

Bağımlılıkları yükleyin:

```bash
flutter pub get
```

#### 6. Firebase Servisini Başlatma

`lib/main.dart` dosyasında Firebase'i başlatın:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'core/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlat
  await FirebaseService.initialize();

  runApp(MyApp());
}
```

#### 7. Dependency Injection Yapılandırması

`lib/core/di/injection.dart` dosyasında Firebase servisini kaydedin:

```dart
import '../services/firebase_service.dart';

// Services
getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
```

#### 8. Analytics Kodlarını Aktif Etme

Analytics kodlarını aktif etmek için yorum satırlarını kaldırın:

**Auth Bloc** (`lib/features/auth/presentation/bloc/auth_bloc.dart`):

```dart
// Login başarılı
FirebaseService.logEvent(
  name: 'login_success',
  parameters: {
    'email': event.email,
  },
);

// Set user ID for analytics
if (data['user'] != null && data['user']['id'] != null) {
  FirebaseService.setUserId(data['user']['id'].toString());
  FirebaseService.setUserIdentifier(data['user']['id'].toString());
}
```

**Movies Bloc** (`lib/features/home/presentation/bloc/movies_bloc.dart`):

```dart
// Film yükleme
FirebaseService.logEvent(
  name: 'movies_loaded',
  parameters: {
    'page': event.page,
    'movie_count': movies.length,
    'total_pages': response.totalPages,
    'refresh': event.refresh,
  },
);

// Favori işlemleri
FirebaseService.logEvent(
  name: 'favorite_toggled',
  parameters: {
    'movie_id': event.movieId,
    'movie_title': movie.title,
    'action': newFavoriteStatus ? 'added' : 'removed',
  },
);
```

#### 9. Firebase Service Kullanımı

Analytics olaylarını manuel olarak loglamak için:

```dart
import '../../../../core/services/firebase_service.dart';

// Özel olay loglama
FirebaseService.logEvent(
  name: 'custom_event',
  parameters: {
    'parameter1': 'value1',
    'parameter2': 'value2',
  },
);

// Hata loglama
FirebaseService.logError(
  error,
  stackTrace,
  reason: 'Custom error description'
);

// Kullanıcı özelliği ayarlama
FirebaseService.setUserProperty(
  name: 'user_type',
  value: 'premium'
);

// Ekran görüntüleme
FirebaseService.setCurrentScreen(
  screenName: 'movie_details',
  screenClass: 'MovieDetailsPage'
);

// Crashlytics test crash (debug modunda)
FirebaseService.testCrash();
```

#### 10. Test ve Doğrulama

1. **Debug Modunda Test**:

   ```bash
   flutter run --debug
   ```

2. **Firebase Console'da Veri Kontrolü**:

   - Analytics > Events bölümünde olayları kontrol edin
   - Crashlytics > Issues bölümünde hataları kontrol edin

3. **Test Olayları**:

   ```dart
   // Test olayı gönder
   FirebaseService.logEvent(
     name: 'test_event',
     parameters: {'test': 'value'},
   );
   ```

4. **Test Crash**:
   ```dart
   // Debug modunda test crash'i tetikle
   FirebaseService.testCrash();
   ```

#### 11. Production Yapılandırması

Release build için:

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

### 📈 Analytics Metrikleri

Uygulama şu metrikleri toplar:

#### 🔐 Kimlik Doğrulama Olayları

- **login_success**: Başarılı giriş
- **login_failed**: Başarısız giriş
- **register_success**: Başarılı kayıt
- **register_failed**: Başarısız kayıt
- **logout_success**: Başarılı çıkış

#### 🎬 Film Olayları

- **movies_loaded**: Film listesi yüklendi
- **favorite_toggled**: Favori film eklendi/çıkarıldı
- **movie_viewed**: Film detayı görüntülendi

#### 📱 Ekran Takibi

- Otomatik ekran görüntüleme takibi
- Kullanıcı kimliği takibi
- Sayfa geçiş süreleri

#### 🐛 Hata Takibi

- **Crashlytics**: Otomatik hata raporlama
- **Custom Errors**: Manuel hata loglama
- **Performance Issues**: Performans sorunları

### 🔒 Gizlilik ve Veri Koruması

Analytics kullanırken dikkat edilmesi gerekenler:

1. **GDPR Uyumluluğu**: Kullanıcı onayı alın
2. **Kişisel Veri Koruması**: Hassas bilgileri loglamayın
3. **Veri Minimizasyonu**: Sadece gerekli verileri toplayın
4. **Şeffaflık**: Kullanıcılara hangi verilerin toplandığını bildirin

### 🚀 Performans Optimizasyonu

Analytics'in performans etkisini minimize etmek için:

1. **Batch İşlemler**: Olayları toplu olarak gönderin
2. **Network Optimizasyonu**: Analytics isteklerini optimize edin
3. **Bellek Yönetimi**: Analytics servislerini uygun şekilde dispose edin
4. **Conditional Logging**: Debug modunda daha detaylı loglama yapın

### 🔍 Firebase Console'da Veri Görüntüleme

#### Analytics Dashboard

- **Dashboard**: Genel kullanım istatistikleri
- **Events**: Özel olaylar
- **Audience**: Kullanıcı segmentasyonu
- **User Properties**: Kullanıcı özellikleri

#### Crashlytics Dashboard

- **Issues**: Hata raporları
- **Users**: Etkilenen kullanıcılar
- **Trends**: Hata trendleri

### ⚠️ Önemli Notlar

1. **Debug vs Release**: Crashlytics debug modunda da çalışır (test için)
2. **Veri Gecikmesi**: Analytics verileri 24-48 saat içinde görünür
3. **Crashlytics**: Hatalar anında görünür
4. **Kullanıcı Gizliliği**: GDPR uyumluluğu için gerekli önlemler alınmıştır

### 🛠️ Sorun Giderme

#### Firebase Başlatılamıyor

- Konfigürasyon dosyalarının doğru konumda olduğunu kontrol edin
- Proje ID'sinin doğru olduğunu kontrol edin
- İnternet bağlantısını kontrol edin

#### Analytics Verileri Görünmüyor

- 24-48 saat bekleyin
- Debug modunda test edin
- Firebase Console'da doğru projeyi seçtiğinizi kontrol edin

#### Crashlytics Hataları Görünmüyor

- Uygulamayı yeniden başlatın
- Test crash'i deneyin
- Firebase Console'da Crashlytics'in etkin olduğunu kontrol edin

---

## 📁 Proje Yapısı

```
lib/
├── 📁 core/                          # Temel işlevsellik
│   ├── 📁 constants/                 # Uygulama sabitleri
│   │   └── app_constants.dart        # API yapılandırması, depolama anahtarları
│   ├── 📁 di/                        # Bağımlılık enjeksiyonu
│   │   └── injection.dart            # Service locator kurulumu
│   ├── 📁 errors/                    # Hata yönetimi
│   │   └── failures.dart             # Hata sınıfları
│   ├── 📁 navigation/                # Navigasyon servisi
│   │   └── navigation_service.dart   # Rota yönetimi
│   ├── 📁 services/                  # Temel servisler
│   │   ├── api_service.dart          # HTTP client
│   │   ├── firebase_service.dart     # Analytics ve Crashlytics
│   │   └── movie_repository.dart     # Film veri erişimi
│   ├── 📁 storage/                   # Veri kalıcılığı
│   │   └── secure_storage_service.dart # Şifrelenmiş depolama
│   └── 📁 theme/                     # UI temalama
│       └── app_theme.dart            # Koyu tema yapılandırması
│
├── 📁 features/                      # Özellik modülleri
│   ├── 📁 auth/                      # Kimlik doğrulama
│   │   ├── 📁 data/
│   │   │   ├── 📁 datasources/       # API veri kaynakları
│   │   │   └── 📁 repositories/      # Repository implementasyonları
│   │   ├── 📁 domain/
│   │   │   ├── 📁 repositories/      # Repository arayüzleri
│   │   │   └── 📁 usecases/          # İş mantığı
│   │   └── 📁 presentation/
│   │       ├── 📁 bloc/              # Durum yönetimi
│   │       ├── 📁 pages/             # UI ekranları
│   │       └── 📁 widgets/           # Yeniden kullanılabilir bileşenler
│   │
│   ├── 📁 home/                      # Film tarama
│   │   └── 📁 presentation/
│   │       ├── 📁 bloc/
│   │       ├── 📁 pages/
│   │       └── 📁 widgets/
│   │
│   ├── 📁 profile/                   # Kullanıcı profili
│   │   └── 📁 presentation/
│   │       ├── 📁 pages/
│   │       └── 📁 widgets/
│   │
│   ├── 📁 limited_offer/             # Özel teklifler
│   │   └── 📁 presentation/
│   │       ├── 📁 pages/
│   │       └── 📁 widgets/
│   │
│   └── 📁 main/                      # Ana navigasyon
│       └── 📁 presentation/
│           └── 📁 pages/
│
├── 📁 shared/                        # Paylaşılan kaynaklar
│   ├── 📁 models/                    # Veri modelleri
│   │   ├── movie_model.dart          # Film varlığı
│   │   ├── user_model.dart           # Kullanıcı varlığı
│   │   └── api_response_model.dart   # API yanıt sarmalayıcısı
│   └── 📁 widgets/                   # Paylaşılan UI bileşenleri
│       └── bottom_navigation.dart    # Navigasyon çubuğu
│
└── main.dart                         # Uygulama giriş noktası
```

---

## 🎯 Temel Özelliklerin Uygulanması

### 🔐 Kimlik Doğrulama Akışı

```dart
// Güvenli depolama ile JWT token yönetimi
class SecureStorageService {
  Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: AppConstants.tokenKey);
  }
}
```

### 🎬 Film Yönetimi

```dart
// Durum yönetimi için BLoC pattern
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  Future<void> _onLoadMovies(LoadMovies event, Emitter<MoviesState> emit) async {
    final response = await _movieRepository.getMovies(page: event.page);
    emit(MoviesLoaded(movies: response.movies));
  }

  // Lazy loading için LoadMoreMovies event
  Future<void> _onLoadMoreMovies(LoadMoreMovies event, Emitter<MoviesState> emit) async {
    final currentState = state;
    if (currentState is MoviesLoaded && currentState.hasMoreData) {
      final nextPage = currentState.currentPage + 1;
      final response = await _movieRepository.getMovies(page: nextPage);
      final allMovies = [...currentState.movies, ...response.movies];
      emit(MoviesLoaded(
        movies: allMovies,
        currentPage: response.currentPage,
        hasMoreData: response.currentPage < response.totalPages,
      ));
    }
  }
}
```

### 🖼️ Görsel Önbellekleme

```dart
// Önbellekleme ile verimli görsel yükleme
CachedNetworkImage(
  imageUrl: movie.imageUrl,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### 📊 Analytics ve Monitoring (Opsiyonel)

```dart
// Firebase Analytics olay takibi
FirebaseService.logEvent(
  name: 'favorite_toggled',
  parameters: {
    'movie_id': movieId,
    'action': 'added',
  },
);

// Crashlytics hata raporlama
FirebaseService.logError(error, stackTrace, reason: 'API Error');
```

### 🎬 Lottie Animasyonları

```dart
// Loading animasyonu
AnimationService.getLoadingAnimation(
  width: 100,
  height: 100,
);

// Heart beat animasyonu (favoriler için)
AnimationService.getHeartBeatAnimation(
  width: 50,
  height: 50,
  isFavorite: true,
);

// Empty state animasyonu
AnimationService.getEmptyAnimation(
  width: 200,
  height: 200,
);
```

---

## 🎨 Tasarım Sistemi

### Renk Paleti

```dart
// Koyu tema renkleri
static const Color primaryRed = Color(0xFFFF3B30);
static const Color darkBackground = Color(0xFF1A1A1A);
static const Color darkSurface = Color(0xFF2C2C2C);
static const Color darkCard = Color(0xFF3A3A3A);
```

### Tipografi

- **Birincil Font**: EuclidCircularA (Regular, Medium, SemiBold, Bold)
- **İkincil Font**: Montserrat (SemiBold, Black)

### Bileşenler

- **Kartlar**: Yuvarlatılmış köşeler ve yükseltme ile
- **Düğmeler**: Hover efektleri ile birincil kırmızı
- **Giriş Alanları**: Odak durumları ile koyu tema

---

## 🔄 API Entegrasyonu

### Endpoint'ler

- `GET /movies` - Sayfalama ile film listesini getir
- `GET /movies/favorites` - Kullanıcının favori filmlerini al
- `POST /movies/{id}/favorite` - Favori durumunu değiştir
- `POST /auth/login` - Kullanıcı kimlik doğrulama
- `POST /auth/register` - Kullanıcı kaydı
- `GET /auth/user` - Mevcut kullanıcı verilerini al
- `POST /auth/upload-photo` - Profil fotoğrafı yükle
---

## 🚀 Performans Optimizasyonları

### Lazy Loading (Sonsuz Kaydırma)

- **Otomatik Sayfa Yükleme**: Kullanıcı listenin sonuna yaklaştığında otomatik olarak yeni sayfa yüklenir
- **Pagination Kontrolü**: Her sayfada 5 film gösterimi
- **Loading State**: Yeni filmler yüklenirken loading göstergesi
- **Memory Management**: Sadece görünen filmler bellekte tutulur

```dart
// Lazy loading implementasyonu
NotificationListener<ScrollNotification>(
  onNotification: (ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
      context.read<MoviesBloc>().add(const LoadMoreMovies());
    }
    return false;
  },
  child: PageView.builder(...),
)
```

### Görsel Optimizasyonu

- CachedNetworkImage ile tembel yükleme
- Yükleme sırasında placeholder görseller
- Başarısız yüklemeler için hata işleme
- Bellek verimli önbellekleme

### Durum Yönetimi

- Verimli BLoC implementasyonları
- Minimal durum güncellemeleri
- Kaynakların uygun şekilde dispose edilmesi
- Bellek sızıntısı önleme

### Ağ Optimizasyonu

- Dio ile istek önbellekleme
- Bağlantı zaman aşımı yönetimi
- Yeniden deneme mekanizmaları
- Çevrimdışı destek planlaması

---

## 🔒 Güvenlik Özellikleri

### Veri Koruması

- JWT token şifreleme
- Hassas veriler için güvenli depolama
- Sadece HTTPS API iletişimi
- Giriş doğrulama ve sanitizasyon

### Kimlik Doğrulama

- Token tabanlı kimlik doğrulama
- Otomatik token yenileme
- Token geçersiz kılma ile güvenli çıkış
- Oturum yönetimi

---

## 📊 Analitik ve İzleme

### Hata Takibi

- Kapsamlı hata loglama
- Kullanıcı dostu hata mesajları
- Çökme raporlama entegrasyonu (Opsiyonel)
- Performans izleme

### Kullanıcı Analitiği

- Ekran görüntüleme takibi (Opsiyonel)
- Kullanıcı etkileşim loglama (Opsiyonel)
- Performans metrikleri
- Kullanım istatistikleri

---
### Ekran Görüntüleri
<img width="405" height="872" alt="Ekran Görüntüsü (446)" src="https://github.com/user-attachments/assets/031e6c46-d4fd-4788-a244-59053da94b64" />
<img width="403" height="874" alt="Ekran Görüntüsü (445)" src="https://github.com/user-attachments/assets/54e1d0da-0487-408d-93a1-56ab319ae45c" />
<img width="410" height="879" alt="Ekran Görüntüsü (444)" src="https://github.com/user-attachments/assets/7a789bcd-34af-4aa7-aa62-cd70539d0a20" />
<img width="412" height="872" alt="Ekran Görüntüsü (449)" src="https://github.com/user-attachments/assets/a5816f0c-e1a2-4cdb-a081-a47a7aec2c8e" />
<img width="410" height="872" alt="Ekran Görüntüsü (448)" src="https://github.com/user-attachments/assets/4e63b992-47dd-4c46-b0bd-8d94a5785c3b" />
<img width="403" height="874" alt="Ekran Görüntüsü (447)" src="https://github.com/user-attachments/assets/1cc21d83-b623-452a-abc6-3e23cd2c41cb" />


<div align="center">

**Flutter ile ❤️ ile yapıldı**

[![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.2.3-blue?style=for-the-badge&logo=dart)](https://dart.dev)

</div>

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  static const String _languageKey = 'selected_language';

  // Supported languages
  static const String tr = 'tr';
  static const String en = 'en';

  // Default language
  static const String defaultLanguage = tr;

  // Current locale
  static Locale _currentLocale = const Locale(tr);

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale(tr, 'TR'),
    Locale(en, 'US'),
  ];

  // Get current locale
  static Locale get currentLocale => _currentLocale;

  // Get current language code
  static String get currentLanguage => _currentLocale.languageCode;

  // Initialize localization
  static Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey) ?? defaultLanguage;
      await setLanguage(savedLanguage);
    } catch (e) {
      // If SharedPreferences fails, use default language
      _currentLocale = const Locale(defaultLanguage);
    }
  }

  // Set language
  static Future<void> setLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {
      // If SharedPreferences fails, just update the locale
    }
    _currentLocale = Locale(languageCode);
  }

  // Get localized string
  static String getString(String key) {
    switch (_currentLocale.languageCode) {
      case tr:
        return _getTurkishString(key);
      case en:
        return _getEnglishString(key);
      default:
        return _getTurkishString(key);
    }
  }

  // Turkish translations
  static String _getTurkishString(String key) {
    switch (key) {
      // Auth
      case 'login':
        return 'Giriş Yap';
      case 'register':
        return 'Kayıt Ol';
      case 'email':
        return 'E-posta';
      case 'password':
        return 'Şifre';
      case 'confirm_password':
        return 'Şifre Tekrarı';
      case 'name':
        return 'Ad Soyad';
      case 'forgot_password':
        return 'Şifremi Unuttum';
      case 'login_success':
        return 'Giriş başarılı!';
      case 'register_success':
        return 'Kayıt başarılı!';
      case 'login_failed':
        return 'Giriş başarısız';
      case 'register_failed':
        return 'Kayıt başarısız';

      // Navigation
      case 'home':
        return 'Anasayfa';
      case 'profile':
        return 'Profil';
      case 'discover':
        return 'Keşfet';

      // Profile
      case 'profile_details':
        return 'Profil Detayı';
      case 'upload_photo':
        return 'Fotoğraf Yükle';
      case 'favorite_movies':
        return 'Favori Filmler';
      case 'no_favorites':
        return 'Henüz favori filminiz yok';
      case 'user':
        return 'Kullanıcı';

      // Movies
      case 'no_movies':
        return 'Henüz film bulunmuyor';
      case 'retry':
        return 'Tekrar Dene';
      case 'loading':
        return 'Yükleniyor...';
      case 'error':
        return 'Hata';

      // Limited Offer
      case 'limited_offer':
        return 'Sınırlı Teklif';
      case 'unlock_bonuses':
        return 'Bonuslarınızı Kilidi Açın';
      case 'bonuses_description':
        return 'Premium hesap, daha fazla eşleşme ve öne çıkarma özelliklerini açın';
      case 'bonuses_you_will_get':
        return 'Alacağınız Bonuslar';
      case 'premium_account':
        return 'Premium\nHesap';
      case 'more_matches':
        return 'Daha Fazla\nEşleşme';
      case 'featured':
        return 'Öne\nÇıkarma';
      case 'more_likes':
        return 'Daha Fazla\nBeğeni';
      case 'select_token_package':
        return 'Kilidi açmak için bir jeton paketi seçin';
      case 'tokens':
        return 'Jeton';
      case 'view_all_tokens':
        return 'Tüm Jetonları Gör';

      // Common
      case 'ok':
        return 'Tamam';
      case 'cancel':
        return 'İptal';
      case 'save':
        return 'Kaydet';
      case 'delete':
        return 'Sil';
      case 'edit':
        return 'Düzenle';
      case 'close':
        return 'Kapat';
      case 'back':
        return 'Geri';
      case 'next':
        return 'İleri';
      case 'previous':
        return 'Önceki';
      case 'search':
        return 'Ara';
      case 'filter':
        return 'Filtrele';
      case 'sort':
        return 'Sırala';

      default:
        return key;
    }
  }

  // English translations
  static String _getEnglishString(String key) {
    switch (key) {
      // Auth
      case 'login':
        return 'Login';
      case 'register':
        return 'Register';
      case 'email':
        return 'Email';
      case 'password':
        return 'Password';
      case 'confirm_password':
        return 'Confirm Password';
      case 'name':
        return 'Full Name';
      case 'forgot_password':
        return 'Forgot Password';
      case 'login_success':
        return 'Login successful!';
      case 'register_success':
        return 'Registration successful!';
      case 'login_failed':
        return 'Login failed';
      case 'register_failed':
        return 'Registration failed';

      // Navigation
      case 'home':
        return 'Home';
      case 'profile':
        return 'Profile';
      case 'discover':
        return 'Discover';

      // Profile
      case 'profile_details':
        return 'Profile Details';
      case 'upload_photo':
        return 'Upload Photo';
      case 'favorite_movies':
        return 'Favorite Movies';
      case 'no_favorites':
        return 'No favorite movies yet';
      case 'user':
        return 'User';

      // Movies
      case 'no_movies':
        return 'No movies available';
      case 'retry':
        return 'Retry';
      case 'loading':
        return 'Loading...';
      case 'error':
        return 'Error';

      // Limited Offer
      case 'limited_offer':
        return 'Limited Offer';
      case 'unlock_bonuses':
        return 'Unlock Your Bonuses';
      case 'bonuses_description':
        return 'Unlock premium account, more matches and featured features';
      case 'bonuses_you_will_get':
        return 'Bonuses You Will Get';
      case 'premium_account':
        return 'Premium\nAccount';
      case 'more_matches':
        return 'More\nMatches';
      case 'featured':
        return 'Featured';
      case 'more_likes':
        return 'More\nLikes';
      case 'select_token_package':
        return 'Select a token package to unlock';
      case 'tokens':
        return 'Tokens';
      case 'view_all_tokens':
        return 'View All Tokens';

      // Common
      case 'ok':
        return 'OK';
      case 'cancel':
        return 'Cancel';
      case 'save':
        return 'Save';
      case 'delete':
        return 'Delete';
      case 'edit':
        return 'Edit';
      case 'close':
        return 'Close';
      case 'back':
        return 'Back';
      case 'next':
        return 'Next';
      case 'previous':
        return 'Previous';
      case 'search':
        return 'Search';
      case 'filter':
        return 'Filter';
      case 'sort':
        return 'Sort';

      default:
        return key;
    }
  }
}

class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://caseapi.servicelabs.tech';
  static const String apiVersion = '';
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  // Pagination
  static const int moviesPerPage = 5;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // App Info
  static const String appName = 'Shartflix';
  static const String appVersion = '1.0.0';

  // Social Login
  static const String googleClientId = 'your_google_client_id';
  static const String facebookAppId = 'your_facebook_app_id';
}

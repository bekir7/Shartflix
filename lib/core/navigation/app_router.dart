import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/profile/presentation/pages/upload_photo_page.dart';
import '../../features/main/presentation/pages/main_scaffold.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );
      case '/main':
        // Extract initial tab index from arguments
        final args = settings.arguments as Map<String, dynamic>?;
        final initialTabIndex = args?['initialTabIndex'] as int? ?? 0;
        return MaterialPageRoute(
          builder: (context) => MainScaffold(initialTabIndex: initialTabIndex),
        );
      case '/upload-photo':
        return MaterialPageRoute(
          builder: (context) => const UploadPhotoPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}


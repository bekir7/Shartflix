import 'package:shared_preferences/shared_preferences.dart';

class AppLaunchService {
  static const String _firstLaunchKey = 'is_first_launch';

  /// Check if this is the first time the app is being launched
  static Future<bool> isFirstLaunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_firstLaunchKey) ?? true;
    } catch (e) {
      // If there's an error, assume it's first launch
      // Error checking first launch status
      return true;
    }
  }

  /// Mark that the app has been launched (not first launch anymore)
  static Future<void> markAppAsLaunched() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_firstLaunchKey, false);
    } catch (e) {
      // Error marking app as launched
      // Don't throw, just log the error
    }
  }

  /// Reset the first launch flag (useful for testing)
  static Future<void> resetFirstLaunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_firstLaunchKey, true);
    } catch (e) {
      // Error resetting first launch
      // Don't throw, just log the error
    }
  }

  /// Check if app has been launched before
  static Future<bool> hasBeenLaunchedBefore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_firstLaunchKey) ?? false;
    } catch (e) {
      // Error checking if app has been launched before
      return false;
    }
  }
}

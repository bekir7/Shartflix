import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'logger_service.dart';

class FirebaseService {
  static FirebaseAnalytics? _analytics;
  static FirebaseCrashlytics? _crashlytics;

  // Initialize Firebase
  static Future<void> initialize() async {
    try {
      // Initialize Firebase Core
      await Firebase.initializeApp();
      LoggerService.info('Firebase Core initialized');

      // Initialize Analytics
      _analytics = FirebaseAnalytics.instance;
      LoggerService.info('Firebase Analytics initialized');

      // Initialize Crashlytics
      _crashlytics = FirebaseCrashlytics.instance;

      // Enable Crashlytics in debug mode for testing
      if (kDebugMode) {
        await _crashlytics!.setCrashlyticsCollectionEnabled(true);
      }

      LoggerService.info('Firebase Crashlytics initialized');

      // Set up error handling
      FlutterError.onError = _crashlytics!.recordFlutterFatalError;

      LoggerService.info('Firebase services initialized successfully');
    } catch (e, stackTrace) {
      LoggerService.error(
          'Failed to initialize Firebase services', e, stackTrace);
    }
  }

  // Analytics Methods
  static Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      if (_analytics != null) {
        await _analytics!.logEvent(
          name: name,
          parameters: parameters,
        );
        LoggerService.info('Analytics event logged: $name', parameters);
      }
    } catch (e) {
      LoggerService.error('Failed to log analytics event: $name', e);
    }
  }

  // User Properties
  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      if (_analytics != null) {
        await _analytics!.setUserProperty(name: name, value: value);
        LoggerService.info('User property set: $name = $value');
      }
    } catch (e) {
      LoggerService.error('Failed to set user property: $name', e);
    }
  }

  // User ID
  static Future<void> setUserId(String userId) async {
    try {
      if (_analytics != null) {
        await _analytics!.setUserId(id: userId);
        LoggerService.info('User ID set: $userId');
      }
    } catch (e) {
      LoggerService.error('Failed to set user ID: $userId', e);
    }
  }

  // Screen tracking
  static Future<void> setCurrentScreen({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      if (_analytics != null) {
        await _analytics!.logScreenView(
          screenName: screenName,
          screenClass: screenClass,
        );
        LoggerService.info('Screen tracked: $screenName');
      }
    } catch (e) {
      LoggerService.error('Failed to track screen: $screenName', e);
    }
  }

  // Crashlytics Methods
  static Future<void> logError(
    dynamic error,
    StackTrace? stackTrace, {
    String? reason,
  }) async {
    try {
      if (_crashlytics != null) {
        await _crashlytics!.recordError(
          error,
          stackTrace,
          reason: reason,
        );
        LoggerService.error(
            'Error logged to Crashlytics: $reason', error, stackTrace);
      }
    } catch (e) {
      LoggerService.error('Failed to log error to Crashlytics', e);
    }
  }

  static Future<void> logMessage(String message) async {
    try {
      if (_crashlytics != null) {
        await _crashlytics!.log(message);
        LoggerService.info('Message logged to Crashlytics: $message');
      }
    } catch (e) {
      LoggerService.error('Failed to log message to Crashlytics', e);
    }
  }

  static Future<void> setUserIdentifier(String userId) async {
    try {
      if (_crashlytics != null) {
        await _crashlytics!.setUserIdentifier(userId);
        LoggerService.info('Crashlytics user identifier set: $userId');
      }
    } catch (e) {
      LoggerService.error('Failed to set Crashlytics user identifier', e);
    }
  }

  // Custom Keys
  static Future<void> setCustomKey(String key, dynamic value) async {
    try {
      if (_crashlytics != null) {
        await _crashlytics!.setCustomKey(key, value);
        LoggerService.info('Custom key set: $key = $value');
      }
    } catch (e) {
      LoggerService.error('Failed to set custom key: $key', e);
    }
  }

  // Test Crash (for debugging)
  static void testCrash() {
    try {
      if (_crashlytics != null) {
        _crashlytics!.crash();
      }
    } catch (e) {
      LoggerService.error('Failed to test crash', e);
    }
  }

  // Getters
  static FirebaseAnalytics? get analytics => _analytics;
  static FirebaseCrashlytics? get crashlytics => _crashlytics;
}

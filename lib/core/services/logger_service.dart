import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  // Info level logging
  static void info(String message, [dynamic data]) {
    if (data != null) {
      _logger.i('$message: $data');
    } else {
      _logger.i(message);
    }
  }

  // Debug level logging
  static void debug(String message, [dynamic data]) {
    if (data != null) {
      _logger.d('$message: $data');
    } else {
      _logger.d(message);
    }
  }

  // Warning level logging
  static void warning(String message, [dynamic data]) {
    if (data != null) {
      _logger.w('$message: $data');
    } else {
      _logger.w(message);
    }
  }

  // Error level logging
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (error != null) {
      _logger.e('$message: $error', error: error, stackTrace: stackTrace);
    } else {
      _logger.e(message);
    }
  }

  // Fatal level logging
  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    if (error != null) {
      _logger.f('$message: $error', error: error, stackTrace: stackTrace);
    } else {
      _logger.f(message);
    }
  }

  // API request logging
  static void logApiRequest(String method, String url,
      [Map<String, dynamic>? headers, dynamic body]) {
    final data = {
      'headers': headers,
      'body': body,
    };
    _logger.i('API Request: $method $url - $data');
  }

  // API response logging
  static void logApiResponse(String method, String url, int statusCode,
      [dynamic response]) {
    _logger.i('API Response: $method $url - $statusCode - $response');
  }

  // User action logging
  static void logUserAction(String action, [Map<String, dynamic>? data]) {
    if (data != null) {
      _logger.i('User Action: $action - $data');
    } else {
      _logger.i('User Action: $action');
    }
  }

  // Navigation logging
  static void logNavigation(String from, String to) {
    _logger.i('Navigation: $from -> $to');
  }

  // Performance logging
  static void logPerformance(String operation, Duration duration) {
    _logger.i('Performance: $operation took ${duration.inMilliseconds}ms');
  }
}

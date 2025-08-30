import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';
import '../../shared/models/user_model.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Token operations
  Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: AppConstants.tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: AppConstants.tokenKey);
  }

  // User data operations
  Future<void> saveUser(UserModel user) async {
    // Convert user to JSON string
    final userJson = user.toJson();
    await _storage.write(key: AppConstants.userKey, value: userJson.toString());
  }

  Future<UserModel?> getUser() async {
    final userJson = await _storage.read(key: AppConstants.userKey);
    if (userJson != null) {
      // Parse JSON string back to UserModel
      // This is a simplified version, you might want to use proper JSON parsing
      return null; // TODO: Implement proper JSON parsing
    }
    return null;
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: AppConstants.userKey);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

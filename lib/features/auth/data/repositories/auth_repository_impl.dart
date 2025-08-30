import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../../../../core/errors/failures.dart';
import '../../../../shared/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
      String email, String password) async {
    try {
      final response = await _dio.post('/user/login', data: {
        'email': email,
        'password': password,
      });
      return Right(response.data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> register(String name,
      String email, String password, String passwordConfirmation) async {
    try {
      final response = await _dio.post('/user/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      return Right(response.data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final response = await _dio.get('/user/profile');

      // API response'u {response: {...}, data: {...}} formatında geliyor
      // UserModel.fromJson için data kısmını kullanıyoruz
      final userData = response.data['data'] ?? response.data;

      final user = UserModel.fromJson(userData);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(
      {String? name, String? email, String? phoneNumber}) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (phoneNumber != null) data['phone_number'] = phoneNumber;

      final response = await _dio.put('/user/profile', data: data);
      final user = UserModel.fromJson(response.data);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> uploadProfilePhoto(
      String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return Left(ServerFailure(message: 'Dosya bulunamadı: $filePath'));
      }

      // Swagger dokümantasyonuna göre field adı 'file' olmalı
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: 'profile_photo.jpg',
        ),
      });

      final response = await _dio.post(
        '/user/upload_photo',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return Right(response.data);
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            e.message ??
            'Fotoğraf yükleme başarısız';
        return Left(ServerFailure(message: errorMessage));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _dio.post('/user/logout');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await _dio.post('/user/forgot-password', data: {'email': email});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import '../../../../shared/models/user_model.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> login(
      String email, String password);
  Future<Either<Failure, Map<String, dynamic>>> register(
      String name, String email, String password, String passwordConfirmation);
  Future<Either<Failure, UserModel>> getCurrentUser();
  Future<Either<Failure, UserModel>> updateProfile(
      {String? name, String? email, String? phoneNumber});
  Future<Either<Failure, Map<String, dynamic>>> uploadProfilePhoto(
      String filePath);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> forgotPassword(String email);
}

import 'package:equatable/equatable.dart';
import '../../../../shared/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileUpdateSuccess extends AuthState {
  final UserModel user;

  const ProfileUpdateSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class PhotoUploadSuccess extends AuthState {
  final String photoUrl;

  const PhotoUploadSuccess({required this.photoUrl});

  @override
  List<Object?> get props => [photoUrl];
}

class ForgotPasswordSuccess extends AuthState {
  final String message;

  const ForgotPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

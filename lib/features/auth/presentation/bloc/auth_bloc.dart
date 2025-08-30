import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/home/presentation/bloc/movies_bloc.dart';
import 'package:shartflix/features/home/presentation/bloc/movies_event.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/storage/secure_storage_service.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = getIt<AuthRepository>();

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<GetCurrentUserRequested>(_onGetCurrentUserRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<UploadProfilePhotoRequested>(_onUploadProfilePhotoRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.login(event.email, event.password);

    result.fold(
      (failure) {
        // Log failed login attempt - Commented out for optional use
        // FirebaseService.logEvent(
        //   name: 'login_failed',
        //   parameters: {
        //     'error': failure.message,
        //     'email': event.email,
        //   },
        // );
        emit(AuthFailure(message: failure.message));
      },
      (response) {
        // Save token and user data
        final data = response['data'];
        final token = data?['token'];

        if (token != null) {
          // Log successful login - Commented out for optional use
          // FirebaseService.logEvent(
          //   name: 'login_success',
          //   parameters: {
          //     'email': event.email,
          //   },
          // );

          // Set user ID for analytics - Commented out for optional use
          // if (data['user'] != null && data['user']['id'] != null) {
          //   FirebaseService.setUserId(data['user']['id'].toString());
          //   FirebaseService.setUserIdentifier(data['user']['id'].toString());
          // }

          // Save token asynchronously but emit immediately
          getIt<SecureStorageService>().saveToken(token).then((_) {
            // Token saved successfully
          }).catchError((error) {
            // Error saving token
          });
          emit(AuthSuccess(message: 'Giriş başarılı!'));
        } else {
          emit(AuthFailure(message: 'Token bulunamadı: $response'));
        }
      },
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.register(
      event.name,
      event.email,
      event.password,
      event.passwordConfirmation,
    );

    result.fold(
      (failure) {
        // Log failed registration attempt - Commented out for optional use
        // FirebaseService.logEvent(
        //   name: 'register_failed',
        //   parameters: {
        //     'error': failure.message,
        //     'email': event.email,
        //   },
        // );
        emit(AuthFailure(message: failure.message));
      },
      (response) {
        final data = response['data'];
        final token = data?['token'];
        if (token != null) {
          // Log successful registration - Commented out for optional use
          // FirebaseService.logEvent(
          //   name: 'register_success',
          //   parameters: {
          //     'email': event.email,
          //     'name': event.name,
          //   },
          // );

          // Set user ID for analytics - Commented out for optional use
          // if (data['user'] != null && data['user']['id'] != null) {
          //   FirebaseService.setUserId(data['user']['id'].toString());
          //   FirebaseService.setUserIdentifier(data['user']['id'].toString());
          // }

          // Save token and load favorites
          getIt<SecureStorageService>().saveToken(token).then((_) {
            // Load user-specific favorites after registration
            try {
              final moviesBloc = getIt<MoviesBloc>();
              // First load movies, then load favorites to sync
              moviesBloc.add(const LoadMovies(refresh: true));
              Future.delayed(const Duration(milliseconds: 500), () {
                moviesBloc.add(const LoadFavoriteMovies());
              });
            } catch (e) {
              // Error loading favorites after registration
            }
          }).catchError((error) {
            // Error saving token
          });
          emit(AuthSuccess(message: 'Kayıt başarılı!'));
        } else {
          emit(AuthFailure(message: 'Kayıt başarısız'));
        }
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.logout();

    result.fold(
      (failure) {
        // Log failed logout attempt - Commented out for optional use
        // FirebaseService.logEvent(
        //   name: 'logout_failed',
        //   parameters: {
        //     'error': failure.message,
        //   },
        // );
        emit(AuthFailure(message: failure.message));
      },
      (_) {
        // Log successful logout - Commented out for optional use
        // FirebaseService.logEvent(
        //   name: 'logout_success',
        // );

        getIt<SecureStorageService>().clearAll();

        // Clear favorites when user logs out
        try {
          final moviesBloc = getIt<MoviesBloc>();
          moviesBloc.add(const ClearFavorites());
        } catch (e) {
          // Error clearing favorites
        }

        emit(AuthUnauthenticated());
      },
    );
  }

  Future<void> _onGetCurrentUserRequested(
    GetCurrentUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.getCurrentUser();

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.updateProfile(
      name: event.name,
      email: event.email,
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(ProfileUpdateSuccess(user: user)),
    );
  }

  Future<void> _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.forgotPassword(event.email);

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(ForgotPasswordSuccess(
          message: 'Şifre sıfırlama e-postası gönderildi')),
    );
  }

  Future<void> _onUploadProfilePhotoRequested(
    UploadProfilePhotoRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _authRepository.uploadProfilePhoto(event.filePath);

    result.fold(
      (failure) {
        if (!emit.isDone) {
          emit(AuthFailure(message: failure.message));
        }
      },
      (response) async {
        // Check different possible response formats
        final photoUrl = response['photoUrl'];
        final photo_url = response['photo_url'];
        final data = response['data'];
        final photoUrlFromData = data?['photoUrl'];
        final photoUrlFromDataAlt = data?['photo_url'];

        // Try to find photo URL in different locations
        final finalPhotoUrl =
            photoUrl ?? photo_url ?? photoUrlFromData ?? photoUrlFromDataAlt;

        if (finalPhotoUrl != null && finalPhotoUrl.toString().isNotEmpty) {
          if (!emit.isDone) {
            emit(PhotoUploadSuccess(photoUrl: finalPhotoUrl.toString()));
          }

          // Refresh user data to get updated profile photo
          final userResult = await _authRepository.getCurrentUser();
          userResult.fold(
            (failure) {
              if (!emit.isDone) {
                emit(AuthFailure(message: failure.message));
              }
            },
            (user) {
              if (!emit.isDone) {
                emit(AuthAuthenticated(user: user));
              }
            },
          );
        } else {
          if (!emit.isDone) {
            emit(AuthFailure(
                message:
                    'Fotoğraf yükleme başarısız - URL alınamadı. Response: $response'));
          }
        }
      },
    );
  }
}

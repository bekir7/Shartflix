import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../storage/secure_storage_service.dart';
import '../services/api_service.dart';
import '../services/movie_repository.dart';
import '../services/logger_service.dart';
import '../services/localization_service.dart';
import '../services/animation_service.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/home/presentation/bloc/movies_bloc.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Dio instance
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.baseUrl = 'https://caseapi.servicelabs.tech';

    // Add interceptors for authentication
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        final token = await getIt<SecureStorageService>().getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        // Handle 401 errors
        if (error.response?.statusCode == 401) {
          await getIt<SecureStorageService>().deleteToken();
          // Navigate to login
        }
        handler.next(error);
      },
    ));

    return dio;
  });

  // Services
  getIt.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MovieRepository>(() => MovieRepository());
  getIt.registerLazySingleton<LoggerService>(() => LoggerService());
  getIt.registerLazySingleton<LocalizationService>(() => LocalizationService());
  getIt.registerLazySingleton<AnimationService>(() => AnimationService());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<Dio>()));

  // Blocs
  getIt.registerLazySingleton<MoviesBloc>(() => MoviesBloc());
}

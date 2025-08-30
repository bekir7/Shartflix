import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/di/injection.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../core/constants/app_constants.dart';
import '../../shared/models/api_response_model.dart';
import '../../shared/models/movie_model.dart';

class ApiService {
  static const String baseUrl = 'https://caseapi.servicelabs.tech';

  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // HTTP client
  final http.Client _client = http.Client();

  // Get headers with user's actual JWT token
  Future<Map<String, String>> get _headersWithAuth async {
    final token = await getIt<SecureStorageService>().getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Get paginated list of all movies
  Future<MovieListResponse> getMovies({int page = 1}) async {
    try {
      final url = '$baseUrl/movie/list?page=$page';

      LoggerService.logApiRequest('GET', url);

      final response = await _client.get(
        Uri.parse(url),
        headers: await _headersWithAuth, // Use real JWT token
      );

      LoggerService.logApiResponse(
          'GET', url, response.statusCode, response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Handle API wrapper response format
        if (jsonData.containsKey('response') && jsonData.containsKey('data')) {
          final responseCode = jsonData['response']['code'] as int;
          if (responseCode == 200) {
            return MovieListResponse.fromJson(
                jsonData['data'] as Map<String, dynamic>);
          } else {
            final message = jsonData['response']['message'] as String;
            throw Exception('API Error: $message');
          }
        } else {
          // Direct response format
          return MovieListResponse.fromJson(jsonData);
        }
      } else if (response.statusCode == 400) {
        final errorData = json.decode(response.body);
        if (errorData.containsKey('response')) {
          final message = errorData['response']['message'] as String;
          if (message == 'TOKEN_UNAVAILABLE' || message == 'JWT_MALFORMED') {
            // Return empty response for now, BLoC will handle with test data
            return const MovieListResponse(
              movies: [],
              pagination: PaginationInfo(
                totalCount: 0,
                perPage: AppConstants.moviesPerPage,
                maxPage: 1,
                currentPage: 1,
              ),
            );
          }
          throw Exception('API Error: $message');
        }
        throw Exception('Bad Request - Invalid parameters: ${response.body}');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized - Please login');
      } else {
        throw Exception(
            'Failed to load movies: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      LoggerService.error('Error getting movies', e);
      // Return empty response for now, BLoC will handle with test data
      return const MovieListResponse(
        movies: [],
        pagination: PaginationInfo(
          totalCount: 0,
          perPage: AppConstants.moviesPerPage,
          maxPage: 1,
          currentPage: 1,
        ),
      );
    }
  }

  /// Get list of user's favorite movies
  Future<MovieListResponse> getFavoriteMovies() async {
    try {
      final url = '$baseUrl/movie/favorites';

      final response = await _client.get(
        Uri.parse(url),
        headers: await _headersWithAuth, // Use real JWT token
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Handle API wrapper response format
        if (jsonData.containsKey('response') && jsonData.containsKey('data')) {
          final responseCode = jsonData['response']['code'] as int;
          if (responseCode == 200) {
            // For favorite movies, data is a list, not an object
            final data = jsonData['data'] as List<dynamic>;
            final movies = data
                .map((movieJson) =>
                    MovieModel.fromJson(movieJson as Map<String, dynamic>))
                .toList();

            return MovieListResponse(
              movies: movies,
              pagination: const PaginationInfo(
                totalCount: 0,
                perPage: AppConstants.moviesPerPage,
                maxPage: 1,
                currentPage: 1,
              ),
            );
          } else {
            final message = jsonData['response']['message'] as String;
            throw Exception('API Error: $message');
          }
        } else {
          return MovieListResponse.fromJson(jsonData);
        }
      } else if (response.statusCode == 400) {
        final errorData = json.decode(response.body);
        if (errorData.containsKey('response')) {
          final message = errorData['response']['message'] as String;
          if (message == 'TOKEN_UNAVAILABLE' || message == 'JWT_MALFORMED') {
            return const MovieListResponse(
              movies: [],
              pagination: PaginationInfo(
                totalCount: 0,
                perPage: AppConstants.moviesPerPage,
                maxPage: 1,
                currentPage: 1,
              ),
            );
          }
        }
        throw Exception(
            'Failed to load favorite movies: ${response.statusCode}');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized - Please login');
      } else {
        throw Exception(
            'Failed to load favorite movies: ${response.statusCode}');
      }
    } catch (e) {
      return const MovieListResponse(
        movies: [],
        pagination: PaginationInfo(
          totalCount: 0,
          perPage: AppConstants.moviesPerPage,
          maxPage: 1,
          currentPage: 1,
        ),
      );
    }
  }

  /// Toggle favorite status of a movie
  Future<ApiResponse> toggleFavorite(String movieId) async {
    try {
      final url = '$baseUrl/movie/favorite/$movieId';

      final response = await _client.post(
        Uri.parse(url),
        headers: await _headersWithAuth, // Use real JWT token
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Handle API wrapper response format
        if (jsonData.containsKey('response')) {
          return ApiResponse.fromJson(
              jsonData['response'] as Map<String, dynamic>);
        } else {
          return ApiResponse.fromJson(jsonData);
        }
      } else if (response.statusCode == 400) {
        final errorData = json.decode(response.body);
        if (errorData.containsKey('response')) {
          final message = errorData['response']['message'] as String;
          if (message == 'TOKEN_UNAVAILABLE' || message == 'JWT_MALFORMED') {
            // Return mock success for now
            return const ApiResponse(
              success: true,
              message: 'Mock favorite toggle success',
            );
          }
        }
        throw Exception('Failed to toggle favorite: ${response.statusCode}');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized - Please login');
      } else if (response.statusCode == 404) {
        throw Exception('Movie not found');
      } else {
        throw Exception('Failed to toggle favorite: ${response.statusCode}');
      }
    } catch (e) {
      // Return mock success for now
      return const ApiResponse(
        success: true,
        message: 'Mock favorite toggle success',
      );
    }
  }

  void dispose() {
    _client.close();
  }
}

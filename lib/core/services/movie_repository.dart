import '../../shared/models/api_response_model.dart';
import 'api_service.dart';

class MovieRepository {
  final ApiService _apiService = ApiService();

  /// Get paginated list of all movies
  Future<MovieListResponse> getMovies({int page = 1}) async {
    return await _apiService.getMovies(page: page);
  }

  /// Get list of user's favorite movies
  Future<MovieListResponse> getFavoriteMovies() async {
    return await _apiService.getFavoriteMovies();
  }

  /// Toggle favorite status of a movie
  Future<ApiResponse> toggleFavorite(String movieId) async {
    return await _apiService.toggleFavorite(movieId);
  }
}

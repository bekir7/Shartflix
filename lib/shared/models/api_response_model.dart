import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';
import '../../core/constants/app_constants.dart';

part 'api_response_model.g.dart';

@JsonSerializable()
class ApiResponse extends Equatable {
  @JsonKey(name: 'success', defaultValue: false)
  final bool success;
  @JsonKey(name: 'message', defaultValue: '')
  final String message;
  @JsonKey(name: 'code', defaultValue: 0)
  final int code;

  const ApiResponse({
    required this.success,
    required this.message,
    this.code = 0,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    // Handle API response format where success might not exist
    final bool success = json['success'] ?? (json['code'] == 200);
    final String message = json['message'] ?? '';
    final int code = json['code'] ?? 0;

    return ApiResponse(
      success: success,
      message: message,
      code: code,
    );
  }

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  List<Object?> get props => [success, message, code];
}

@JsonSerializable()
class MovieListResponse extends Equatable {
  @JsonKey(name: 'movies')
  final List<MovieModel> movies;
  @JsonKey(name: 'pagination')
  final PaginationInfo pagination;

  const MovieListResponse({
    required this.movies,
    required this.pagination,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    // Handle null-safe parsing
    final movies = (json['movies'] as List<dynamic>?)
            ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final paginationJson = json['pagination'] as Map<String, dynamic>?;
    final pagination = paginationJson != null
        ? PaginationInfo.fromJson(paginationJson)
        : const PaginationInfo(
            totalCount: 0,
            perPage: AppConstants.moviesPerPage,
            maxPage: 1,
            currentPage: 1,
          );

    return MovieListResponse(
      movies: movies,
      pagination: pagination,
    );
  }

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);

  int get totalPages => pagination.maxPage;
  int get currentPage => pagination.currentPage;

  @override
  List<Object?> get props => [movies, pagination];
}

@JsonSerializable()
class PaginationInfo extends Equatable {
  @JsonKey(name: 'totalCount')
  final int totalCount;
  @JsonKey(name: 'perPage')
  final int perPage;
  @JsonKey(name: 'maxPage')
  final int maxPage;
  @JsonKey(name: 'currentPage')
  final int currentPage;

  const PaginationInfo({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    // Handle null-safe parsing for numeric values that might come as strings
    int parseToInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value) ?? 0;
      }
      if (value is num) return value.toInt();
      return 0;
    }

    return PaginationInfo(
      totalCount: parseToInt(json['totalCount']),
      perPage: parseToInt(json['perPage']),
      maxPage: parseToInt(json['maxPage']),
      currentPage: parseToInt(json['currentPage']),
    );
  }

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);

  @override
  List<Object?> get props => [totalCount, perPage, maxPage, currentPage];
}

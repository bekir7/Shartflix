import 'package:equatable/equatable.dart';
import '../../../../shared/models/movie_model.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MovieModel> movies;
  final int currentPage;
  final int totalPages;
  final bool hasMoreData;
  final bool isLoadingMore;
  final bool showPageSelector;
  final List<MovieModel> favoriteMovies;

  const MoviesLoaded({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    required this.hasMoreData,
    this.isLoadingMore = false,
    this.showPageSelector = false,
    this.favoriteMovies = const [],
  });

  @override
  List<Object?> get props => [
        movies,
        currentPage,
        totalPages,
        hasMoreData,
        isLoadingMore,
        showPageSelector,
        favoriteMovies
      ];

  MoviesLoaded copyWith({
    List<MovieModel>? movies,
    int? currentPage,
    int? totalPages,
    bool? hasMoreData,
    bool? isLoadingMore,
    bool? showPageSelector,
    List<MovieModel>? favoriteMovies,
  }) {
    return MoviesLoaded(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      showPageSelector: showPageSelector ?? this.showPageSelector,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
    );
  }
}

class FavoriteMoviesLoading extends MoviesState {}

class FavoriteMoviesLoaded extends MoviesState {
  final List<MovieModel> favoriteMovies;

  const FavoriteMoviesLoaded({required this.favoriteMovies});

  @override
  List<Object?> get props => [favoriteMovies];
}

class FavoriteMoviesError extends MoviesState {
  final String message;

  const FavoriteMoviesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FavoriteToggled extends MoviesState {
  final String movieId;
  final bool isFavorite;

  const FavoriteToggled({
    required this.movieId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [movieId, isFavorite];
}

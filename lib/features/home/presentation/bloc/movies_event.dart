import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovies extends MoviesEvent {
  final int page;
  final bool refresh;

  const LoadMovies({this.page = 1, this.refresh = false});

  @override
  List<Object?> get props => [page, refresh];
}

class LoadMoreMovies extends MoviesEvent {
  const LoadMoreMovies();

  @override
  List<Object?> get props => [];
}

class SelectPage extends MoviesEvent {
  final int page;

  const SelectPage({required this.page});

  @override
  List<Object?> get props => [page];
}

class UpdateCurrentPage extends MoviesEvent {
  final int page;

  const UpdateCurrentPage({required this.page});

  @override
  List<Object?> get props => [page];
}

class ShowPageSelector extends MoviesEvent {
  const ShowPageSelector();

  @override
  List<Object?> get props => [];
}

class HidePageSelector extends MoviesEvent {
  const HidePageSelector();

  @override
  List<Object?> get props => [];
}

class LoadFavoriteMovies extends MoviesEvent {
  const LoadFavoriteMovies();

  @override
  List<Object?> get props => [];
}

class ToggleFavorite extends MoviesEvent {
  final String movieId;

  const ToggleFavorite({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class ClearFavorites extends MoviesEvent {
  const ClearFavorites();

  @override
  List<Object?> get props => [];
}

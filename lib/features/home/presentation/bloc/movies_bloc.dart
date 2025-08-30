import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/movie_repository.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../shared/models/movie_model.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository _movieRepository = getIt<MovieRepository>();

  MoviesBloc() : super(MoviesInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<SelectPage>(_onSelectPage);
    on<UpdateCurrentPage>(_onUpdateCurrentPage);
    on<ShowPageSelector>(_onShowPageSelector);
    on<HidePageSelector>(_onHidePageSelector);
    on<LoadFavoriteMovies>(_onLoadFavoriteMovies);
    on<ToggleFavorite>(_onToggleFavorite);
    on<ClearFavorites>(_onClearFavorites);
  }

  Future<void> _onLoadMovies(
    LoadMovies event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      // Check if we already have movies loaded and this is not a refresh
      final currentState = state;
      if (currentState is MoviesLoaded && !event.refresh) {
        // If movies are already loaded and this is not a refresh, don't reload
        return;
      }

      if (event.refresh) {
        // Don't emit loading state for refresh to avoid showing loading indicator
        // emit(MoviesLoading());
      }

      final response = await _movieRepository.getMovies(page: event.page);

      final hasMoreData = response.currentPage < response.totalPages;
      final movies = response.movies;

      // Log movies loaded event - Commented out for optional use
      // FirebaseService.logEvent(
      //   name: 'movies_loaded',
      //   parameters: {
      //     'page': event.page,
      //     'movie_count': movies.length,
      //     'total_pages': response.totalPages,
      //     'refresh': event.refresh,
      //   },
      // );

      if (event.refresh) {
        // For refresh, keep the current page and update movies
        emit(MoviesLoaded(
          movies: movies,
          currentPage: event.page, // Keep the current page
          totalPages: response.totalPages,
          hasMoreData: hasMoreData,
          favoriteMovies:
              currentState is MoviesLoaded ? currentState.favoriteMovies : [],
        ));
      } else if (event.page == 1) {
        emit(MoviesLoaded(
          movies: movies,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
          hasMoreData: hasMoreData,
          favoriteMovies:
              currentState is MoviesLoaded ? currentState.favoriteMovies : [],
        ));
      } else {
        if (currentState is MoviesLoaded) {
          final updatedMovies = [...currentState.movies, ...movies];
          emit(MoviesLoaded(
            movies: updatedMovies,
            currentPage: response.currentPage,
            totalPages: response.totalPages,
            hasMoreData: hasMoreData,
            favoriteMovies: currentState.favoriteMovies,
          ));
        }
      }
    } catch (e) {
      // Log error - Commented out for optional use
      // FirebaseService.logError(e, StackTrace.current,
      //     reason: 'Failed to load movies');
      emit(MoviesError(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMovies event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is MoviesLoaded &&
          currentState.hasMoreData &&
          !currentState.isLoadingMore) {
        // Set loading more state
        emit(currentState.copyWith(isLoadingMore: true));

        final nextPage = currentState.currentPage + 1;
        final response = await _movieRepository.getMovies(page: nextPage);

        final newMovies = response.movies;

        // Update new movies with favorite status
        final favoriteMovieIds = currentState.favoriteMovies
            .map((m) => m.id)
            .where((id) => id != null)
            .toSet();

        final updatedNewMovies = newMovies.map((movie) {
          final isFavorite =
              movie.id != null && favoriteMovieIds.contains(movie.id);
          return movie.copyWith(isFavorite: isFavorite);
        }).toList();

        final allMovies = [...currentState.movies, ...updatedNewMovies];
        final hasMoreData = response.currentPage < response.totalPages;

        // Log movies loaded event - Commented out for optional use
        // FirebaseService.logEvent(
        //   name: 'movies_loaded_more',
        //   parameters: {
        //     'page': nextPage,
        //     'movie_count': newMovies.length,
        //     'total_movies': allMovies.length,
        //   },
        // );

        emit(MoviesLoaded(
          movies: allMovies,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
          hasMoreData: hasMoreData,
          isLoadingMore: false,
          favoriteMovies: currentState.favoriteMovies,
        ));
      }
    } catch (e) {
      // If error occurs, revert to previous state without loading more
      final currentState = state;
      if (currentState is MoviesLoaded) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
      emit(MoviesError(message: e.toString()));
    }
  }

  Future<void> _onSelectPage(
    SelectPage event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      final currentState = state;

      // Don't emit loading state if we're just changing pages
      if (currentState is! MoviesLoaded) {
        emit(MoviesLoading());
      }

      final response = await _movieRepository.getMovies(page: event.page);

      final movies = response.movies;
      final hasMoreData = response.currentPage < response.totalPages;

      // Log page selection event - Commented out for optional use
      // FirebaseService.logEvent(
      //   name: 'page_selected',
      //   parameters: {
      //     'page': event.page,
      //     'movie_count': movies.length,
      //   },
      // );

      // Update movies with favorite status from current favorites
      final favoriteMovieIds = currentState is MoviesLoaded
          ? currentState.favoriteMovies
              .map((m) => m.id)
              .where((id) => id != null)
              .toSet()
          : <String>{};

      final updatedMovies = movies.map((movie) {
        final isFavorite =
            movie.id != null && favoriteMovieIds.contains(movie.id);
        return movie.copyWith(isFavorite: isFavorite);
      }).toList();

      emit(MoviesLoaded(
        movies: updatedMovies,
        currentPage: event.page, // Use the selected page number
        totalPages: response.totalPages,
        hasMoreData: hasMoreData,
        showPageSelector: false,
        favoriteMovies:
            currentState is MoviesLoaded ? currentState.favoriteMovies : [],
      ));
    } catch (e) {
      emit(MoviesError(message: e.toString()));
    }
  }

  Future<void> _onUpdateCurrentPage(
    UpdateCurrentPage event,
    Emitter<MoviesState> emit,
  ) async {
    final currentState = state;
    if (currentState is MoviesLoaded) {
      emit(currentState.copyWith(currentPage: event.page));
    }
  }

  Future<void> _onShowPageSelector(
    ShowPageSelector event,
    Emitter<MoviesState> emit,
  ) async {
    final currentState = state;
    if (currentState is MoviesLoaded) {
      emit(currentState.copyWith(showPageSelector: true));
    }
  }

  Future<void> _onHidePageSelector(
    HidePageSelector event,
    Emitter<MoviesState> emit,
  ) async {
    final currentState = state;
    if (currentState is MoviesLoaded) {
      emit(currentState.copyWith(showPageSelector: false));
    }
  }

  Future<void> _onLoadFavoriteMovies(
    LoadFavoriteMovies event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      // Don't emit loading state if we already have movies loaded
      final currentState = state;
      if (currentState is! MoviesLoaded) {
        emit(FavoriteMoviesLoading());
      }

      final response = await _movieRepository.getFavoriteMovies();

      // Update the current movies list with favorite status
      if (currentState is MoviesLoaded) {
        final favoriteMovieIds =
            response.movies.map((m) => m.id).where((id) => id != null).toSet();

        final updatedMovies = currentState.movies.map((movie) {
          final isFavorite =
              movie.id != null && favoriteMovieIds.contains(movie.id);
          return movie.copyWith(isFavorite: isFavorite);
        }).toList();

        emit(MoviesLoaded(
          movies: updatedMovies,
          currentPage: currentState.currentPage,
          totalPages: currentState.totalPages,
          hasMoreData: currentState.hasMoreData,
          favoriteMovies: response.movies, // Store all favorite movies
        ));
      } else {
        emit(FavoriteMoviesLoaded(favoriteMovies: response.movies));
      }
    } catch (e) {
      emit(FavoriteMoviesError(message: e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      await _movieRepository.toggleFavorite(event.movieId);

      final currentState = state;
      if (currentState is MoviesLoaded) {
        final movieIndex =
            currentState.movies.indexWhere((m) => m.id == event.movieId);
        if (movieIndex == -1) {
          return; // Movie not found
        }

        final movie = currentState.movies[movieIndex];
        final newFavoriteStatus = !(movie.isFavorite ?? false);

        // Log favorite toggle event - Commented out for optional use
        // FirebaseService.logEvent(
        //   name: 'favorite_toggled',
        //   parameters: {
        //     'movie_id': event.movieId,
        //     'movie_title': movie.title,
        //     'action': newFavoriteStatus ? 'added' : 'removed',
        //   },
        // );

        final updatedMovies = currentState.movies.map((movie) {
          if (movie.id == event.movieId) {
            return movie.copyWith(isFavorite: newFavoriteStatus);
          }
          return movie;
        }).toList();

        // Update favorite movies list
        List<MovieModel> updatedFavoriteMovies =
            List.from(currentState.favoriteMovies);
        if (newFavoriteStatus) {
          // Add to favorites if not already there
          if (!updatedFavoriteMovies.any((m) => m.id == event.movieId)) {
            updatedFavoriteMovies.add(movie.copyWith(isFavorite: true));
          }
        } else {
          // Remove from favorites
          updatedFavoriteMovies.removeWhere((m) => m.id == event.movieId);
        }

        // Emit updated movies state
        emit(MoviesLoaded(
          movies: updatedMovies,
          currentPage: currentState.currentPage,
          totalPages: currentState.totalPages,
          hasMoreData: currentState.hasMoreData,
          favoriteMovies: updatedFavoriteMovies,
        ));
      }
    } catch (e) {
      // Log error
      FirebaseService.logError(e, StackTrace.current,
          reason: 'Failed to toggle favorite');
      emit(MoviesError(message: e.toString()));
    }
  }

  Future<void> _onClearFavorites(
    ClearFavorites event,
    Emitter<MoviesState> emit,
  ) async {
    final currentState = state;
    if (currentState is MoviesLoaded) {
      // Clear all favorite flags
      final updatedMovies = currentState.movies.map((movie) {
        return movie.copyWith(isFavorite: false);
      }).toList();

      emit(MoviesLoaded(
        movies: updatedMovies,
        currentPage: currentState.currentPage,
        totalPages: currentState.totalPages,
        hasMoreData: currentState.hasMoreData,
        favoriteMovies: const [], // Clear all favorite movies
      ));
    }
  }
}

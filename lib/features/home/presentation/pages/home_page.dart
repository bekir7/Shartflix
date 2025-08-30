import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/movies_bloc.dart';
import '../bloc/movies_event.dart';
import '../bloc/movies_state.dart';
import '../../../../shared/models/movie_model.dart';
import '../../../../core/services/animation_service.dart';
import '../../../../core/constants/app_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _pageTransitionController;
  late Animation<double> _pageTransitionAnimation;
  bool _isPageTransitioning = false;
  static int _currentMovieIndex =
      0; // Track current movie index (static to persist across navigations)

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageTransitionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pageTransitionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pageTransitionController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check if movies are already loaded, if not then load first page
    final currentState = context.read<MoviesBloc>().state;
    if (currentState is! MoviesLoaded) {
      context.read<MoviesBloc>().add(const LoadMovies());
    } else {
      // Only load favorites if they're empty, but don't reload movies
      if (currentState.favoriteMovies.isEmpty) {
        // Load favorites without affecting the current page
        context.read<MoviesBloc>().add(const LoadFavoriteMovies());
      }

      // Restore current movie index when returning to home
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          // If _currentMovieIndex is 0 (initial value), calculate based on current page
          if (_currentMovieIndex == 0) {
            final expectedMovieIndex =
                (currentState.currentPage - 1) * AppConstants.moviesPerPage;
            if (expectedMovieIndex < currentState.movies.length) {
              _currentMovieIndex = expectedMovieIndex;
            }
          }

          // Restore the current movie index
          if (_currentMovieIndex < currentState.movies.length) {
            _pageController.jumpToPage(_currentMovieIndex);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageTransitionController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // Get current page and movie index before refresh
    final currentState = context.read<MoviesBloc>().state;
    int currentPage = 1;
    int currentMovieIndex = 0;

    if (currentState is MoviesLoaded) {
      currentPage = currentState.currentPage;
      // Keep the current movie index, don't reset it
      currentMovieIndex = _currentMovieIndex;
    }

    // Refresh movies with current page
    context
        .read<MoviesBloc>()
        .add(LoadMovies(page: currentPage, refresh: true));
    // Also refresh favorite movies
    context.read<MoviesBloc>().add(const LoadFavoriteMovies());

    // Wait a bit for the refresh to complete
    await Future.delayed(const Duration(milliseconds: 500));

    // Restore the current movie index after refresh
    _currentMovieIndex = currentMovieIndex;

    // Jump to the correct movie index
    if (_pageController.hasClients) {
      _pageController.jumpToPage(_currentMovieIndex);
    }
  }

  void _toggleFavorite(String movieId) {
    if (movieId.isNotEmpty) {
      context.read<MoviesBloc>().add(ToggleFavorite(movieId: movieId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    // Main content area
                    Expanded(
                      child: _buildMainContent(state),
                    ),

                    // Page selector at bottom of screen
                    _buildPageSelectorWidget(state),
                  ],
                ),

                // Page transition overlay
                if (_isPageTransitioning)
                  AnimatedBuilder(
                    animation: _pageTransitionAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _pageTransitionAnimation.value,
                        child: AnimationService.getPageTransitionOverlay(
                          onComplete: () {
                            // Animation completed
                          },
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(MoviesState state) {
    if (state is MoviesLoading) {
      return _buildLoadingView();
    } else if (state is MoviesLoaded) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        color: const Color(0xFFFF3B30),
        backgroundColor: Colors.black,
        child: _buildReelsView(state.movies),
      );
    } else if (state is MoviesError) {
      return _buildErrorView(state.message);
    } else if (state is FavoriteMoviesLoading ||
        state is FavoriteMoviesLoaded ||
        state is FavoriteMoviesError) {
      return _buildLoadingView();
    } else {
      return _buildLoadingView();
    }
  }

  Widget _buildPageSelectorWidget(MoviesState state) {
    if (state is MoviesLoaded) {
      // Calculate current page based on current movie index
      // Film 1-5: Sayfa 1, Film 6-10: Sayfa 2, Film 11-15: Sayfa 3
      final currentPage =
          (_currentMovieIndex ~/ AppConstants.moviesPerPage) + 1;
      return _buildPageSelector(currentPage, state.totalPages);
    }
    return const SizedBox.shrink();
  }

  Widget _buildReelsView(List<MovieModel> movies) {
    if (movies.isEmpty) {
      return _buildEmptyView();
    }

    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        // Track current movie index
        _currentMovieIndex = index;

        // Force rebuild to update page selector
        setState(() {});

        // Check if we need to load more movies (when we're near the end)
        final state = context.read<MoviesBloc>().state;
        if (state is MoviesLoaded) {
          if (index >= movies.length - 2) {
            if (state.hasMoreData && !state.isLoadingMore) {
              context.read<MoviesBloc>().add(const LoadMoreMovies());
            }
          }
        }
      },
      itemCount: movies.length,
      itemBuilder: (context, index) {
        if (index >= movies.length) {
          return _buildLoadingView();
        }
        final movie = movies[index];
        return _buildFullScreenMovieCard(movie);
      },
    );
  }

  Widget _buildFullScreenMovieCard(MovieModel movie) {
    // Null safety check
    if (movie.id == null) {
      return _buildLoadingView();
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Movie image (full screen)
          CachedNetworkImage(
            imageUrl: movie.imageUrl ??
                'https://via.placeholder.com/400x600/1A1A1A/FFFFFF?text=No+Image',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: const Color(0xFF1A1A1A),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF3B30),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: const Color(0xFF1A1A1A),
              child: const Icon(
                Icons.movie,
                color: Colors.white,
                size: 64,
              ),
            ),
          ),

          // Dark overlay gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.5),
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),

          // Favorite button (bottom right, above movie title)
          Positioned(
            bottom: 120,
            right: 20,
            child: GestureDetector(
              onTap: () => _toggleFavorite(movie.id ?? ''),
              child: Container(
                width: 49.18,
                height: 71.7,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: movie.isFavorite == true
                      ? AnimationService.getHeartBeatAnimation(
                          width: 24,
                          height: 24,
                          isFavorite: true,
                        )
                      : SvgPicture.asset(
                          'assets/icons/like.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                        ),
                ),
              ),
            ),
          ),

          // Content overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie title and icon
                  Row(
                    children: [
                      // Red icon (like in the photo)
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF3B30),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Movie title
                      Expanded(
                        child: Text(
                          movie.title ?? 'Unknown Title',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'EuclidCircularA',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Movie description with "Daha Fazlası" link
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'EuclidCircularA',
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(text: movie.description),
                        const TextSpan(
                          text: ' Daha Fazlası',
                          style: TextStyle(
                            color: Color(0xFFFF3B30),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'EuclidCircularA',
                          ),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimationService.getLoadingAnimation(
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 24),
          const Text(
            'Filmler yükleniyor...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'EuclidCircularA',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Color(0xFFFF3B30),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'EuclidCircularA',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<MoviesBloc>().add(const LoadMovies(refresh: true));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF3B30),
              foregroundColor: Colors.white,
            ),
            child: const Text(
              'Tekrar Dene',
              style: TextStyle(
                fontFamily: 'EuclidCircularA',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimationService.getEmptyAnimation(
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 24),
          const Text(
            'Henüz film bulunmuyor',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 18,
              fontFamily: 'EuclidCircularA',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Yakında harika filmler burada olacak!',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 14,
              fontFamily: 'EuclidCircularA',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageSelector(int currentPage, int totalPages) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.95),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Navigation controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous page button
              GestureDetector(
                onTap: () {
                  if (currentPage > 1) {
                    final targetIndex =
                        (currentPage - 2) * AppConstants.moviesPerPage;

                    // Update the current movie index
                    _currentMovieIndex = targetIndex;

                    // Jump to the correct movie index
                    if (_pageController.hasClients) {
                      _pageController.jumpToPage(targetIndex);
                    }

                    // Update the current page in the bloc
                    context
                        .read<MoviesBloc>()
                        .add(UpdateCurrentPage(page: currentPage - 1));
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: currentPage > 1
                        ? const Color(0xFFFF3B30).withOpacity(0.2)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: currentPage > 1
                          ? const Color(0xFFFF3B30).withOpacity(0.4)
                          : Colors.white.withOpacity(0.1),
                      width: 1.5,
                    ),
                    boxShadow: currentPage > 1
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF3B30).withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: currentPage > 1
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    size: 15,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Page numbers with dots
              Flexible(
                child: Container(
                  height: 32,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalPages, (index) {
                        final pageNumber = index + 1;
                        final isSelected = pageNumber == currentPage;
                        final isNearCurrent =
                            (pageNumber - currentPage).abs() <= 1;

                        // Show only current page and nearby pages
                        if (isNearCurrent ||
                            pageNumber == 1 ||
                            pageNumber == totalPages) {
                          return GestureDetector(
                            onTap: () {
                              // Calculate the correct movie index for the selected page
                              final targetIndex =
                                  (pageNumber - 1) * AppConstants.moviesPerPage;

                              // Update the current movie index
                              _currentMovieIndex = targetIndex;

                              // Jump to the correct movie index
                              if (_pageController.hasClients) {
                                _pageController.jumpToPage(targetIndex);
                              }

                              // Update the current page in the bloc
                              context
                                  .read<MoviesBloc>()
                                  .add(UpdateCurrentPage(page: pageNumber));
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: isSelected ? 36 : 30,
                              height: 30,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFFF3B30)
                                    : Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFFFF3B30)
                                      : Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFFFF3B30)
                                              .withOpacity(0.4),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  pageNumber.toString(),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.9),
                                    fontSize: isSelected ? 12 : 10,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                    fontFamily: 'EuclidCircularA',
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (pageNumber == 2 && currentPage > 3) {
                          // Show dots for skipped pages
                          return Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: Center(
                              child: Text(
                                '...',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'EuclidCircularA',
                                ),
                              ),
                            ),
                          );
                        } else if (pageNumber == totalPages - 1 &&
                            currentPage < totalPages - 2) {
                          // Show dots for skipped pages
                          return Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: Center(
                              child: Text(
                                '...',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'EuclidCircularA',
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Next page button
              GestureDetector(
                onTap: () {
                  if (currentPage < totalPages) {
                    final targetIndex =
                        currentPage * AppConstants.moviesPerPage;

                    // Update the current movie index
                    _currentMovieIndex = targetIndex;

                    // Jump to the correct movie index
                    if (_pageController.hasClients) {
                      _pageController.jumpToPage(targetIndex);
                    }

                    // Update the current page in the bloc
                    context
                        .read<MoviesBloc>()
                        .add(UpdateCurrentPage(page: currentPage + 1));
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: currentPage < totalPages
                        ? const Color(0xFFFF3B30).withOpacity(0.2)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: currentPage < totalPages
                          ? const Color(0xFFFF3B30).withOpacity(0.4)
                          : Colors.white.withOpacity(0.1),
                      width: 1.5,
                    ),
                    boxShadow: currentPage < totalPages
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF3B30).withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: currentPage < totalPages
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

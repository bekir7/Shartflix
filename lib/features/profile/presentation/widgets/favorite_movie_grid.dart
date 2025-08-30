import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../shared/models/movie_model.dart';
import '../../../home/presentation/bloc/movies_bloc.dart';
import '../../../home/presentation/bloc/movies_state.dart';

class FavoriteMovieGrid extends StatelessWidget {
  const FavoriteMovieGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          // Use the favoriteMovies list from state instead of filtering current movies
          final favoriteMovies = state.favoriteMovies;

          if (favoriteMovies.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Color(0xFF808080),
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Henüz favori filminiz yok',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Filmleri favorilere ekleyerek burada görebilirsiniz',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return _buildMovieCard(movie);
            },
          );
        } else if (state is FavoriteMoviesLoaded) {
          final favoriteMovies = state.favoriteMovies;

          if (favoriteMovies.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Color(0xFF808080),
                    size: 48,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Henüz favori filminiz yok',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Filmleri favorilere ekleyerek burada görebilirsiniz',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return _buildMovieCard(movie);
            },
          );
        } else if (state is FavoriteMoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF3B30),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Favori filmler yüklenemedi',
              style: TextStyle(
                color: Color(0xFF808080),
                fontSize: 16,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildMovieCard(MovieModel movie) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to movie details
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF3A3A3A),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: movie.imageUrl ??
                      'https://via.placeholder.com/150x225/1A1A1A/FFFFFF?text=No+Image',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: const Color(0xFF4A4A4A),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF3B30),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: const Color(0xFF4A4A4A),
                    child: const Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Movie Info
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? 'Unknown Title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFF3B30),
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        movie.rating ?? 'N/A',
                        style: const TextStyle(
                          color: Color(0xFFB0B0B0),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

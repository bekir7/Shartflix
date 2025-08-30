import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_event.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import '../../../home/presentation/bloc/movies_bloc.dart';
import '../../../home/presentation/bloc/movies_event.dart';
import '../../../home/presentation/bloc/movies_state.dart';
import '../../../../shared/models/movie_model.dart';
// Bottom navigation import removed - handled by MainScaffold
import '../../../limited_offer/presentation/pages/limited_offer_page.dart';

import '../../../../core/services/localization_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Get current user data when page loads
    context.read<AuthBloc>().add(GetCurrentUserRequested());
    // Load favorite movies for profile page
    context.read<MoviesBloc>().add(const LoadFavoriteMovies());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return current is PhotoUploadSuccess || current is AuthAuthenticated;
      },
      listener: (context, state) {
        if (state is PhotoUploadSuccess) {
          // Refresh user data to get updated profile photo
          context.read<AuthBloc>().add(GetCurrentUserRequested());
        } else if (state is AuthAuthenticated) {
          // User data updated
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          String userName = 'Kullanıcı';
          String userId = 'ID: ---';
          String? userProfilePhoto;

          if (state is AuthAuthenticated) {
            try {
              userName =
                  state.user.name.isNotEmpty ? state.user.name : 'Kullanıcı';
              userId =
                  state.user.id.isNotEmpty ? 'ID: ${state.user.id}' : 'ID: ---';
              userProfilePhoto = state.user.profilePhoto;
            } catch (e) {
              userName = 'Kullanıcı';
              userId = 'ID: ---';
              userProfilePhoto = null;
            }
          }

          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) return;
              // Navigate to main page with home tab selected
              Navigator.pushReplacementNamed(
                context,
                '/main',
                arguments: {'initialTabIndex': 0},
              );
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: Column(
                  children: [
                    // Top Navigation Bar
                    _buildTopNavigationBar(),

                    // Profile Information Section
                    _buildProfileInfoSection(
                        userName, userId, userProfilePhoto),

                    // Liked Movies Section
                    Expanded(
                      child: _buildLikedMoviesSection(),
                    ),
                  ],
                ),
              ),
              // Bottom navigation is handled by MainScaffold
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Back button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                // Navigate to main page with home tab selected
                Navigator.pushReplacementNamed(
                  context,
                  '/main',
                  arguments: {'initialTabIndex': 0},
                );
              },
            ),
          ),

          const SizedBox(width: 16),

          // Title
          const Expanded(
            child: Text(
              'Profil Detayı',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Limited Offer button
          GestureDetector(
            onTap: () {
              LimitedOfferPage.show(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B30),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/sinirlierisim.svg',
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Sınırlı Teklif',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoSection(
      String userName, String userId, String? userProfilePhoto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Picture
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: userProfilePhoto != null &&
                            userProfilePhoto.isNotEmpty
                        ? NetworkImage(userProfilePhoto)
                        : const NetworkImage(
                            'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=120&h=120&fit=crop&crop=face'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userId,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Add Photo button
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/upload-photo');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    LocalizationService.getString('upload_photo'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Language Selector - Commented out for optional use
          // _buildLanguageSelector(),
        ],
      ),
    );
  }

  Widget _buildLikedMoviesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizationService.getString('favorite_movies'),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          // Movies Grid
          Expanded(
            child: BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                try {
                  if (state is MoviesLoading ||
                      state is FavoriteMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF3B30),
                      ),
                    );
                  } else if (state is MoviesLoaded) {
                    // Use the favoriteMovies list from state instead of filtering current movies
                    final favoriteMovies = state.favoriteMovies;

                    if (favoriteMovies.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              size: 64,
                              color: Color(0xFF666666),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              LocalizationService.getString('no_favorites'),
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: favoriteMovies.length,
                      itemBuilder: (context, index) {
                        return _buildFavoriteMovieCard(favoriteMovies[index]);
                      },
                    );
                  } else if (state is FavoriteMoviesLoaded) {
                    final favoriteMovies = state.favoriteMovies;

                    if (favoriteMovies.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              size: 64,
                              color: Color(0xFF666666),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              LocalizationService.getString('no_favorites'),
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: favoriteMovies.length,
                      itemBuilder: (context, index) {
                        return _buildFavoriteMovieCard(favoriteMovies[index]);
                      },
                    );
                  } else if (state is MoviesError) {
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
                            state.message,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  // Default empty state
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: Color(0xFF666666),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          LocalizationService.getString('no_favorites'),
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                } catch (e, stackTrace) {
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
                          'Hata: $e',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteMovieCard(MovieModel movie) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(movie.imageUrl ??
                      'https://via.placeholder.com/400x600/1A1A1A/FFFFFF?text=No+Image'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Movie Title
          Text(
            movie.title ?? 'Unknown Title',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 2),

          // Studio Name
          Text(
            movie.studio ?? 'Unknown Studio',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.language,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Language / Dil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  LocalizationService.currentLanguage == 'tr'
                      ? 'Türkçe'
                      : 'English',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            onSelected: (String languageCode) async {
              await LocalizationService.setLanguage(languageCode);
              if (mounted) {
                setState(() {});
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'tr',
                child: Row(
                  children: [
                    Text('🇹🇷 Türkçe'),
                    if (LocalizationService.currentLanguage == 'tr')
                      Icon(Icons.check, color: Colors.green, size: 16),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'en',
                child: Row(
                  children: [
                    Text('🇺🇸 English'),
                    if (LocalizationService.currentLanguage == 'en')
                      Icon(Icons.check, color: Colors.green, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class AnimationService {
  // Loading animations
  static const String loadingSpinner = 'assets/animations/loading_spinner.json';
  static const String loadingDots = 'assets/animations/loading_dots.json';
  static const String loadingPulse = 'assets/animations/loading_pulse.json';

  // Success animations
  static const String successCheck = 'assets/animations/success_check.json';
  static const String successStar = 'assets/animations/success_star.json';

  // Error animations
  static const String errorShake = 'assets/animations/error_shake.json';
  static const String errorSad = 'assets/animations/error_sad.json';

  // Empty state animations
  static const String emptyBox = 'assets/animations/empty_box.json';
  static const String emptyList = 'assets/animations/empty_list.json';

  // Movie related animations
  static const String movieReel = 'assets/animations/movie_reel.json';
  static const String popcorn = 'assets/animations/popcorn.json';
  static const String heartBeat = 'assets/animations/heart_beat.json';

  // Navigation animations
  static const String pageTransition = 'assets/animations/page_transition.json';
  static const String tabSwitch = 'assets/animations/tab_switch.json';

  // Splash animations
  static const String splashLogo = 'assets/animations/splash_logo.json';
  static const String appLaunch = 'assets/animations/app_launch.json';

  // Get loading animation widget
  static Widget getLoadingAnimation({
    String animationPath = loadingSpinner,
    double width = 100,
    double height = 100,
    Color? color,
  }) {
    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
      options: LottieOptions(enableMergePaths: true),
      repeat: true,
      animate: true,
    );
  }

  // Get success animation widget
  static Widget getSuccessAnimation({
    String animationPath = successCheck,
    double width = 80,
    double height = 80,
    VoidCallback? onComplete,
  }) {
    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
      repeat: false,
      onLoaded: (composition) {
        if (onComplete != null) {
          Future.delayed(composition.duration, onComplete);
        }
      },
    );
  }

  // Get error animation widget
  static Widget getErrorAnimation({
    String animationPath = errorShake,
    double width = 80,
    double height = 80,
  }) {
    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
      repeat: true,
    );
  }

  // Get empty state animation widget
  static Widget getEmptyAnimation({
    String animationPath = emptyBox,
    double width = 200,
    double height = 200,
  }) {
    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
      repeat: true,
    );
  }

  // Get movie related animation widget
  static Widget getMovieAnimation({
    String animationPath = movieReel,
    double width = 120,
    double height = 120,
  }) {
    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
      repeat: true,
    );
  }

  // Get heart beat animation for favorites
  static Widget getHeartBeatAnimation({
    double width = 50,
    double height = 50,
    bool isFavorite = false,
  }) {
    return Lottie.asset(
      heartBeat,
      width: width,
      height: height,
      repeat: isFavorite,
      options: LottieOptions(enableMergePaths: true),
    );
  }

  // Get splash animation
  static Widget getSplashAnimation({
    String animationPath = splashLogo,
    double width = 200,
    double height = 200,
    VoidCallback? onComplete,
  }) {
    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
      repeat: false,
      onLoaded: (composition) {
        if (onComplete != null) {
          Future.delayed(composition.duration, onComplete);
        }
      },
    );
  }

  // Get page transition animation
  static Widget getPageTransitionAnimation({
    double width = 60,
    double height = 60,
    VoidCallback? onComplete,
  }) {
    return Lottie.asset(
      pageTransition, // Using custom page transition animation
      width: width,
      height: height,
      repeat: false,
      onLoaded: (composition) {
        if (onComplete != null) {
          Future.delayed(composition.duration, onComplete);
        }
      },
    );
  }

  // Get smooth page transition overlay
  static Widget getPageTransitionOverlay({
    required VoidCallback onComplete,
    Color backgroundColor = Colors.black,
  }) {
    return Container(
      color: backgroundColor.withValues(alpha: 0.8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getPageTransitionAnimation(
              width: 80,
              height: 80,
              onComplete: onComplete,
            ),
            const SizedBox(height: 20),
            const Text(
              'Sayfa yükleniyor...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'EuclidCircularA',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Preload animations for better performance
  static Future<void> preloadAnimations() async {
    final animations = [
      loadingSpinner,
      successCheck,
      errorShake,
      emptyBox,
      movieReel,
      heartBeat,
      splashLogo,
    ];

    for (final animation in animations) {
      try {
        await AssetLottie(animation).load();
      } catch (e) {
        // Animation file not found, skip
        // Animation file not found, skip
      }
    }
  }
}

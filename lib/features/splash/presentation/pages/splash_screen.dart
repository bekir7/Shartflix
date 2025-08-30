import 'package:flutter/material.dart';
import '../../../../core/services/app_launch_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  void _checkFirstLaunch() async {
    try {
      // Check if this is the first launch
      final isFirstLaunch = await AppLaunchService.isFirstLaunch();

      if (isFirstLaunch) {
        // First launch - show splash for 3 seconds
        await Future.delayed(const Duration(seconds: 3));
        // Mark app as launched
        await AppLaunchService.markAppAsLaunched();
      } else {
        // Not first launch - skip splash
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Navigate to login with animation
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      // If there's an error, just go to login
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Full screen background image
            Positioned.fill(
              child: Image.asset(
                'assets/logo/SinFlixSplash.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if image fails to load
                  return Container(
                    color: const Color(0xFF1A1A1A),
                    child: const Center(
                      child: Icon(
                        Icons.movie,
                        color: Color(0xFFFF3B30),
                        size: 100,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Loading indicator at bottom center
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Circular progress indicator
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xFFFF3B30),
                        ),
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Loading text
                    const Text(
                      'Yükleniyor...',
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
            ),
          ],
        ),
      ),
    );
  }
}

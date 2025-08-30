import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SharedBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTabTapped;

  const SharedBottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402,
      height: 71.1,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Home tab
          _buildNavItem(
            context: context,
            icon: SvgPicture.asset(
              'assets/icons/Home.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
            label: 'Anasayfa',
            isSelected: currentIndex == 0,
            onTap: () {
              if (onTabTapped != null) {
                onTabTapped!(0);
              } else {
                // Fallback to old navigation if callback not provided
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
          ),
          // Profile tab
          _buildNavItem(
            context: context,
            icon: SvgPicture.asset(
              'assets/icons/profil.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
            label: 'Profil',
            isSelected: currentIndex == 1,
            onTap: () {
              if (onTabTapped != null) {
                onTabTapped!(1);
              } else {
                // Fallback to old navigation if callback not provided
                Navigator.pushReplacementNamed(context, '/profile');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required Widget icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 125.04,
        height: 40.92,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 204, 204, 204)
                : const Color.fromARGB(100, 204, 204, 204),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'EuclidCircularA',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

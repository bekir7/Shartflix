import 'package:flutter/material.dart';
import '../../../../features/home/presentation/pages/home_page.dart';
import '../../../../features/profile/presentation/pages/profile_page.dart';
import '../../../../shared/widgets/bottom_navigation.dart';

class MainScaffold extends StatefulWidget {
  final int initialTabIndex;

  const MainScaffold({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late int _currentIndex;
  late PageController _pageController;

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
    _pageController = PageController(initialPage: widget.initialTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // If switching to home tab (index 0), preserve the current movies state
    if (index == 0) {
      // The HomePage will check if movies are already loaded in its didChangeDependencies
      // and preserve the current page state
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: SharedBottomNavigation(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}

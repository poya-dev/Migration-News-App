import 'package:flutter/material.dart';

import '../theme/color.dart';
import './home_screen.dart';
import './bookmark_screen.dart';
import './consulting_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  int _activeTabIndex = 0;
  final List _pages = [
    {
      "page": const HomeScreen(),
    },
    {
      "page": const BookmarkScreen(),
    },
    {
      "page": const ConsultingScreen(),
    },
  ];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(microseconds: 1000),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    if (index == _activeTabIndex) return;
    _controller.reset();
    setState(() {
      _activeTabIndex = index;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      bottomNavigationBar: Material(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8),
        ),
        child: buildBottomNavBar(),
      ),
      body: buildBottomBarPage(),
    );
  }

  Widget buildBottomNavBar() {
    return BottomNavigationBar(
      elevation: 1,
      selectedFontSize: 14,
      currentIndex: _activeTabIndex,
      iconSize: 28,
      onTap: onPageChanged,
      selectedIconTheme: const IconThemeData(
        color: Colors.lightBlue,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          activeIcon: Icon(
            Icons.home,
          ),
          label: 'Home',
          tooltip: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_outline,
          ),
          activeIcon: Icon(
            Icons.favorite,
          ),
          label: 'Favorite',
          tooltip: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.support_agent_outlined,
          ),
          activeIcon: Icon(
            Icons.support_agent_rounded,
          ),
          label: 'Consulting',
          tooltip: 'Consulting',
        ),
      ],
    );
  }

  Widget buildBottomBarPage() {
    return IndexedStack(
      index: _activeTabIndex,
      children: List.generate(
        _pages.length,
        (index) => animatedPage(_pages[index]["page"]),
      ),
    );
  }
}

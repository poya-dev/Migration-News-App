import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/bookmark/bookmark_bloc.dart';
import '../blocs/bookmark/bookmark_event.dart';
import '../blocs/consulting/consulting_bloc.dart';
import '../blocs/consulting/consulting_event.dart';
import '../blocs/news/news_event.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/badge/badge_bloc.dart';
import '../theme/color.dart';
import './home_screen.dart';
import './bookmark_screen.dart';
import './consulting_screen.dart';
import './sign_up_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  int _activeTabIndex = 0;
  int _newsBadgeCount = 0;
  int _consultingBadgeCount = 0;
  bool _shouldHomeRefresh = true;
  bool _shouldBookmarkRefresh = true;
  // bool _shouldConsultingRefresh = true;
  String _accessToken = '';

  final List _pages = [
    {"page": const HomeScreen()},
    {"page": const BookmarkScreen()},
    {"page": const ConsultingScreen()}
  ];

  final BadgeBloc _badgeBloc = BadgeBloc();

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

    _badgeBloc.newsBadge.listen(
      (value) => setState(() => _newsBadgeCount = value),
    );

    _badgeBloc.consultingBadge.listen(
      (value) => setState(() => _consultingBadgeCount = value),
    );

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

  onPageChanged(BuildContext context, int index) {
    if (index == _activeTabIndex) return;

    if (index == 0 && _shouldHomeRefresh) {
      context.read<NewsBloc>().add(NewsRefreshed(_accessToken));
    }

    if (index == 0 && _newsBadgeCount > 0) {
      context.read<NewsBloc>().add(NewsRefreshed(_accessToken));
      setState(() {
        _shouldHomeRefresh = true;
      });
    }

    if (index == 2) {
      context
          .read<ConsultingBloc>()
          .add(ConsultingResponseFetched(_accessToken));
    }

    if (index == 1 && _shouldBookmarkRefresh) {
      context.read<BookmarkBloc>().add(BookmarkFetched(_accessToken));
      setState(() {
        _shouldHomeRefresh = false;
        _shouldBookmarkRefresh = false;
      });
    }

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
        child: buildBottomNavBar(context),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is UnAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Authenticated) {
            _accessToken = state.user.accessToken;
          }
          return buildBottomBarPage();
        },
      ),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      elevation: 1,
      selectedFontSize: 14,
      currentIndex: _activeTabIndex,
      iconSize: 28,
      onTap: (index) => onPageChanged(context, index),
      selectedIconTheme: const IconThemeData(color: Colors.lightBlue),
      items: [
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(
                Icons.home_outlined,
              ),
              buildBadge(_newsBadgeCount)
            ],
          ),
          activeIcon: Stack(
            children: [
              const Icon(
                Icons.home,
              ),
              buildBadge(_newsBadgeCount)
            ],
          ),
          label: 'Home',
          tooltip: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark_outline,
          ),
          activeIcon: Icon(
            Icons.bookmark,
          ),
          label: 'Bookmarks',
          tooltip: 'Bookmarks',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const Icon(Icons.support_agent_outlined),
              buildBadge(_consultingBadgeCount)
            ],
          ),
          activeIcon: Stack(
            children: [
              const Icon(Icons.support_agent_rounded),
              buildBadge(_consultingBadgeCount)
            ],
          ),
          label: 'Consulting',
          tooltip: 'Consulting',
        ),
      ],
    );
  }

  Widget buildBadge(int badgeCount) {
    return badges.Badge(
      badgeContent: Text(
        "${badgeCount <= 10 ? badgeCount : '+10'}",
        style: const TextStyle(fontSize: 7.5, color: Colors.white),
      ),
      showBadge: badgeCount > 0 ? true : false,
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

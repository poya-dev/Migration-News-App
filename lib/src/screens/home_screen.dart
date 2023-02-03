import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/blocs/auth/auth_bloc.dart';
import 'package:news_app/src/blocs/category/category_event.dart';

import '../widgets/custom_round_textbox.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/category_item.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/category/category_state.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/news/news_event.dart';
import '../blocs/news/news_state.dart';
import './news_details_screen.dart';
import '../widgets/news_item.dart';
import './sign_up_screen.dart';
import './search_screen.dart';
import '../widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  String _accessToken = '';

  final _scrollController = ScrollController();

  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is UnAuthenticated,
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
        builder: (context, authState) {
          authState is Authenticated
              ? _accessToken = authState.user.accessToken
              : '';
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CategoryBloc>().add(CategoryRefreshed(_accessToken));
              context.read<NewsBloc>().add(NewsRefreshed(_accessToken));
              return Future.delayed(const Duration(seconds: 3));
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels > 0 && _isVisible) {
                  setState(() => _isVisible = false);
                } else if (notification.metrics.pixels <= 0 && !_isVisible) {
                  setState(() => _isVisible = true);
                }
                return false;
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: _isVisible,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: CustomRoundTextBox(
                              hint: "جستجو",
                              isReadOnly: true,
                              prefix: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SearchScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, newsState) {
                      if (newsState is CategoryLoading) {
                        return const Loader();
                      }
                      if (newsState is CategoryFailure) {
                        return Container(
                          padding: const EdgeInsets.all(6),
                          child: const Center(
                            child: Text('Failed to fetch category'),
                          ),
                        );
                      }
                      if (newsState is CategorySuccess) {
                        final categoryList = newsState.categories;
                        return SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(15, 5, 7, 20),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              categoryList.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CategoryItem(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  data: categoryList[index],
                                  isSelected: index == _selectedCategoryIndex,
                                  onTap: () {
                                    setState(() {
                                      _selectedCategoryIndex = index;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        if (state.status == Status.initial) {
                          return const Loader();
                        }
                        if (state.status == Status.failure) {
                          return Container(
                            padding: const EdgeInsets.all(6),
                            child: const Center(
                              child: Text('Failed to load News'),
                            ),
                          );
                        }
                        if (state.status == Status.success) {
                          final news = state.news;
                          return ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: state.hasReachedMax
                                ? state.news.length
                                : state.news.length + 1,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return index >= state.news.length
                                  ? const Loader()
                                  : NewsItem(
                                      data: news[index],
                                      onBookmarkTap: () {
                                        context.read<NewsBloc>().add(
                                              NewsBookmarked(
                                                _accessToken,
                                                news[index].id,
                                              ),
                                            );
                                      },
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetailsScreen(
                                            data: news[index],
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<NewsBloc>().add(NewsFetched(_accessToken));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

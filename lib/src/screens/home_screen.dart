import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../blocs/category/category_event.dart';
import '../utils/ad_helper.dart';
import '../widgets/custom_round_textbox.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/category_item.dart';
import '../blocs/category/category_bloc.dart';
import '../blocs/category/category_state.dart';
import '../blocs/news_detail/news_detail_bloc.dart';
import '../blocs/news_detail/news_detail_event.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/news/news_event.dart';
import '../blocs/news/news_state.dart';
import './news_details_screen.dart';
import '../widgets/news_item.dart';
import './search_screen.dart';
import '../widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;
  final _inlineAdIndex = 3;
  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;
  final _scrollController = ScrollController();
  bool _isVisible = true;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isInlineBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _inlineBannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
    _createInlineBannerAd();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      persistentFooterButtons: [
        _isBottomBannerAdLoaded
            ? Container(
                height: _bottomBannerAd.size.height.toDouble(),
                width: _bottomBannerAd.size.width.toDouble(),
                child: AdWidget(ad: _bottomBannerAd),
              )
            : SizedBox()
      ],
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CategoryBloc>().add(CategoryRefreshed());
          context.read<NewsBloc>().add(NewsRefreshed());
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
                                builder: (context) => SearchScreen(),
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
                    return Container(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 1.5),
                    );
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
                  buildWhen: (previous, current) => previous != current,
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
                          return index >=
                                  state.news.length +
                                      (_isInlineBannerAdLoaded ? 1 : 0)
                              ? const Loader()
                              : (_isInlineBannerAdLoaded &&
                                      index == _inlineAdIndex)
                                  ? Container(
                                      padding: EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      width:
                                          _inlineBannerAd.size.width.toDouble(),
                                      height: _inlineBannerAd.size.height
                                          .toDouble(),
                                      child: AdWidget(ad: _inlineBannerAd),
                                    )
                                  : NewsItem(
                                      data: news[_getListViewItemIndex(index)],
                                      onBookmarkTap: () {
                                        context.read<NewsBloc>().add(
                                              NewsBookmarked(news[index].id),
                                            );
                                      },
                                      onTap: () {
                                        context.read<NewsDetailBloc>().add(
                                            NewsDetailFetched(news[index].id));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NewsDetailsScreen(
                                              newsId: news[index].id,
                                            ),
                                          ),
                                        );
                                      },
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
      ),
    );
  }

  int _getListViewItemIndex(int index) {
    if (index >= _inlineAdIndex && _isInlineBannerAdLoaded) {
      return index - 1;
    }
    return index;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _bottomBannerAd.dispose();
    _inlineBannerAd.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<NewsBloc>().add(NewsFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

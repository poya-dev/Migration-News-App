import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/language_selection_screen.dart';
import '../blocs/news_detail/news_detail_bloc.dart';
import '../blocs/news_detail/news_detail_event.dart';
import '../blocs/bookmark/bookmark_event.dart';
import '../blocs/bookmark/bookmark_bloc.dart';
import '../blocs/bookmark/bookmark_state.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/custom_app_bar.dart';
import './news_details_screen.dart';
import '../widgets/news_item.dart';
import '../widgets/loader.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  String _accessToken = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is UnAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LanguageSelectionScreen(),
              ),
            );
          }
        },
        builder: (context, authState) {
          if (authState is Authenticated) {
            _accessToken = authState.user.accessToken;
          }
          return BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (context, state) {
              if (state.status == BookmarkStatus.initial) {
                return const Loader();
              }
              if (state.status == BookmarkStatus.failure) {
                return Container(
                  padding: const EdgeInsets.all(6),
                  child: const Center(
                    child: Text('Failed to load bookmarks'),
                  ),
                );
              }
              if (state.status == BookmarkStatus.success) {
                final bookmarks = state.bookmarks;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: bookmarks.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsItem(
                      data: bookmarks[index],
                      onBookmarkTap: () {
                        context.read<BookmarkBloc>().add(
                              BookmarkRemoved(
                                accessToken: _accessToken,
                                newsId: bookmarks[index].id,
                              ),
                            );
                      },
                      onTap: () {
                        context.read<NewsDetailBloc>().add(
                              NewsDetailFetched(
                                _accessToken,
                                bookmarks[index].id,
                              ),
                            );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailsScreen(
                              accessToken: _accessToken,
                              newsId: bookmarks[index].id,
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
          );
        },
      ),
    );
  }
}

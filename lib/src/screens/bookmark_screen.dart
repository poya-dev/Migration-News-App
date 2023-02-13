import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/blocs/news/news_state.dart';
import 'package:news_app/src/models/category.dart';

import '../blocs/news_detail/news_detail_bloc.dart';
import '../blocs/news_detail/news_detail_event.dart';
import '../blocs/bookmark/bookmark_event.dart';
import '../blocs/bookmark/bookmark_bloc.dart';
import '../blocs/bookmark/bookmark_state.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/news/news_event.dart';
import '../widgets/custom_app_bar.dart';
import './news_details_screen.dart';
import '../widgets/news_item.dart';
import '../widgets/loader.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
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
            final newsState = context.select((NewsBloc bloc) => bloc);
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
                          BookmarkRemoved(newsId: bookmarks[index].id),
                        );
                    context
                        .read<NewsBloc>()
                        .add(NewsReFetched(newsState.category));
                  },
                  onTap: () {
                    context.read<NewsDetailBloc>().add(
                          NewsDetailFetched(bookmarks[index].id),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailsScreen(newsId: bookmarks[index].id),
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
    );
  }
}

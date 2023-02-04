import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bookmark/bookmark_bloc.dart';
import '../blocs/bookmark/bookmark_state.dart';
import '../widgets/custom_app_bar.dart';
import './news_details_screen.dart';
import '../widgets/news_item.dart';
import '../widgets/loader.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoading) {
            return const Loader();
          }
          if (state is BookmarkFailure) {
            return Container(
              padding: const EdgeInsets.all(6),
              child: const Center(
                child: Text('Failed to bookmarks'),
              ),
            );
          }
          if (state is BookmarkSuccess) {
            final bookmarks = state.bookmarks;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: bookmarks.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return NewsItem(
                  data: bookmarks[index],
                  isBookmark: true,
                  onBookmarkTap: () {},
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailsScreen(
                        data: bookmarks[index],
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
    );
  }
}

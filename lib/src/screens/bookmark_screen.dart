import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/news_item.dart';
import '../utils/data.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: news.length,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return NewsItem(
              data: news[index],
            );
          },
        ),
      ),
    );
  }
}

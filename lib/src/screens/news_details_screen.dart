import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/news_detail/news_detail_bloc.dart';
import '../blocs/news_detail/news_detail_event.dart';
import '../blocs/news_detail/news_detail_state.dart';
import '../widgets/custom_image.dart';
import '../widgets/icon_box.dart';
import '../widgets/loader.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    Key? key,
    required this.accessToken,
    required this.newsId,
  }) : super(key: key);

  final String accessToken;
  final String newsId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: BlocBuilder<NewsDetailBloc, NewsDetailState>(
            builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBox(
                bgColor: Colors.black54.withOpacity(0.055),
                isShadow: false,
                radius: 30,
                padding: const EdgeInsets.all(10),
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black38,
                    size: 18,
                  ),
                ),
              ),
              const Text(
                'جزییات',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context
                      .read<NewsDetailBloc>()
                      .add(NewsDetailBookmarked(accessToken, newsId));
                },
                child: state.status == NewsDetailStatus.success &&
                        state.news!.isBookmark == true
                    ? const Icon(
                        Icons.bookmark,
                        color: Colors.black38,
                        size: 32,
                      )
                    : const Icon(
                        Icons.bookmark_outline,
                        color: Colors.black38,
                        size: 32,
                      ),
              )
            ],
          );
        }),
      ),
      body: BlocBuilder<NewsDetailBloc, NewsDetailState>(
        builder: (context, state) {
          if (state.status == NewsDetailStatus.initial) {
            return const Loader();
          }
          if (state.status == NewsDetailStatus.failure) {
            return const Center(
              child: Text('something went wrong'),
            );
          }
          if (state.status == NewsDetailStatus.success) {
            final newsDetail = state.news!;
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SafeArea(
                      child: Text(
                        newsDetail.title,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            newsDetail.category.name,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            DateFormat.yMMMEd().format(newsDetail.createdAt),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CustomImage(
                      newsDetail.imageUrl,
                      radius: 0,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(14),
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Html(
                      data: newsDetail.content,
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

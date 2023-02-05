import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/models/news_detail.dart';

import '../../repositories/news_repository.dart';
import './news_detail_event.dart';
import './news_detail_state.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  final NewsRepository newsRepository;
  NewsDetailBloc({required this.newsRepository})
      : super(const NewsDetailState()) {
    on<NewsDetailFetched>(
      (event, emit) async {
        emit(state.copyWith(status: NewsDetailStatus.initial));
        await Future.delayed(const Duration(seconds: 3));
        try {
          final String token = event.accessToken;
          final String newsId = event.newsId;
          final response = await newsRepository.getNewsDetail(token, newsId);
          emit(state.copyWith(
            news: response.data,
            status: NewsDetailStatus.success,
          ));
        } catch (error) {
          emit(state.copyWith(error: error.toString()));
        }
      },
    );
    on<NewsDetailBookmarked>((event, emit) async {
      try {
        final news = state.news!;
        final newState = NewsDetail(
          id: news.id,
          title: news.title,
          content: news.content,
          imageUrl: news.imageUrl,
          viewCount: news.viewCount,
          isBookmark: !news.isBookmark,
          category: news.category,
          createdAt: news.createdAt,
        );
        emit(state.copyWith(
          news: newState,
          status: NewsDetailStatus.success,
        ));
        if (newState.isBookmark) {
          await newsRepository.addBookmark(event.accessToken, event.newsId);
        } else {
          await newsRepository.removeBookmark(event.accessToken, event.newsId);
        }
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    });
  }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/news_repository.dart';
import './news_event.dart';
import './news_state.dart';

var page = 1;

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(const NewsState()) {
    on<NewsFetched>(_onNewsFetched);
  }

  Future _onNewsFetched(NewsFetched event, Emitter<NewsState> emit) async {
    try {
      final String token = event.accessToken;
      await Future.delayed(const Duration(seconds: 5));
      if (state.hasReachedMax) return;
      if (state.status == Status.initial) {
        final response = await newsRepository.getNews(token);
        final hasReachedMax = response.currentPage == response.lastPage;
        return emit(
          state.copyWith(
            news: response.data,
            status: Status.success,
            hasReachedMax: hasReachedMax,
          ),
        );
      }
      final response = await newsRepository.getNews(token, page);
      final hasReachedMax = response.currentPage == response.lastPage;
      emit(
        state.copyWith(
          news: response.data,
          status: Status.success,
          hasReachedMax: hasReachedMax,
        ),
      );
      page++;
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }
}

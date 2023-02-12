import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../repositories/news_repository.dart';
import '../../api/response.dart';
import '../../models/news.dart';
import './news_event.dart';
import './news_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  int page = 1;

  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(NewsState()) {
    on<NewsFetched>(_onNewsFetched,
        transformer: throttleDroppable(throttleDuration));
    on<NewsRefreshed>(_onRefreshed);
    on<NewsBookmarked>(_onNewsBookmarked);
  }

  Future _onNewsFetched(
    NewsFetched event,
    Emitter<NewsState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      if (state.hasReachedMax) return;
      if (state.status == Status.initial) {
        final response = await newsRepository.getNews();
        final int current = response.currentPage!;
        final int last = response.lastPage!;
        bool reachedMax = current >= last ? true : false;
        page++;
        return emit(state.copyWith(
          news: response.data,
          status: Status.success,
          hasReachedMax: reachedMax,
        ));
      }
      final Response<List<News>> news = await newsRepository.getNews(page);
      final int current = news.currentPage!;
      final int last = news.lastPage!;
      bool reachedMax = current >= last ? true : false;
      emit(state.copyWith(
          news: List.of(state.news)..addAll(news.data!),
          status: Status.success,
          hasReachedMax: reachedMax));
      page++;
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future _onRefreshed(
    NewsRefreshed event,
    Emitter<NewsState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      final Response<List<News>> news = await newsRepository.getNews();
      final int current = news.currentPage!;
      final int last = news.lastPage!;
      bool reachedMax = current >= last ? true : false;
      return emit(state.copyWith(
        news: news.data,
        status: Status.success,
        hasReachedMax: reachedMax,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future _onNewsBookmarked(
    NewsBookmarked event,
    Emitter<NewsState> emit,
  ) async {
    try {
      final newState = state.news;

      final newsItem = newState.firstWhere(
        (element) => element.id == event.newsId,
      );

      newState.forEach((element) {
        if (element.id == event.newsId) {
          element.isBookmark = true;
        }
      });

      emit(state.copyWith(
        news: newState,
        status: Status.success,
      ));

      if (newsItem.isBookmark) {
        await newsRepository.addBookmark(event.newsId);
      } else {
        await newsRepository.removeBookmark(event.newsId);
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}

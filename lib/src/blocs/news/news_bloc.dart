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
  String category = 'All';

  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(NewsState()) {
    on<NewsFetched>(_onNewsFetched,
        transformer: throttleDroppable(throttleDuration));
    on<ResetNewsRequested>(_onResetNewsRequested);
    on<NewsReFetched>(_onNewsReFetched);
    on<NewsBookmarked>(_onNewsBookmarked);
  }

  Future _onNewsFetched(
    NewsFetched event,
    Emitter<NewsState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      category = event.category!;
      if (state.hasReachedMax) return;
      if (state.status == Status.initial) {
        final response = await newsRepository.getNews(event.category!);
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
      final Response<List<News>> news =
          await newsRepository.getNews(event.category!, page);
      final int current = news.currentPage!;
      final int last = news.lastPage!;
      bool reachedMax = current >= last ? true : false;
      emit(state.copyWith(
        news: List.of(state.news)..addAll(news.data!),
        status: Status.success,
        hasReachedMax: reachedMax,
      ));
      page++;
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future _onNewsReFetched(
    NewsReFetched event,
    Emitter<NewsState> emit,
  ) async {
    try {
      final Response<List<News>> news =
          await newsRepository.getNews(event.category);
      final int current = news.currentPage!;
      final int last = news.lastPage!;
      bool reachedMax = current >= last ? true : false;
      emit(state.copyWith(
        news: news.data,
        status: Status.success,
        hasReachedMax: reachedMax,
      ));
      page++;
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future _onResetNewsRequested(
    ResetNewsRequested event,
    Emitter<NewsState> emit,
  ) async {
    page = 1;
    return emit(state.copyWith(
      news: const <News>[],
      status: Status.initial,
      hasReachedMax: false,
    ));
  }

  Future _onNewsBookmarked(
    NewsBookmarked event,
    Emitter<NewsState> emit,
  ) async {
    try {
      bool _isBookmark = false;
      List<News> newState = state.news.map<News>(
        (element) {
          if (element.id == event.newsId) {
            element.isBookmark = !element.isBookmark;
            _isBookmark = element.isBookmark;
          }
          return element;
        },
      ).toList();
      emit(state.copyWith(
        news: newState,
        status: Status.success,
      ));
      if (_isBookmark) {
        await newsRepository.addBookmark(event.newsId);
      } else {
        await newsRepository.removeBookmark(event.newsId);
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}

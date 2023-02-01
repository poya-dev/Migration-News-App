import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../repositories/news_repository.dart';
import './news_event.dart';
import './news_state.dart';

int page = 1;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc({required this.newsRepository}) : super(const NewsState()) {
    on<NewsFetched>(
      _onNewsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future _onNewsFetched(NewsFetched event, Emitter<NewsState> emit) async {
    try {
      final String token = event.accessToken;
      await Future.delayed(const Duration(seconds: 5));
      if (state.hasReachedMax) return;
      if (state.status == Status.initial) {
        final response = await newsRepository.getNews(token);
        bool reachedMax =
            response.currentPage! >= response.lastPage! ? true : false;
        page++;
        return emit(
          state.copyWith(
            news: response.data,
            status: Status.success,
            hasReachedMax: reachedMax,
          ),
        );
      }
      final response = await newsRepository.getNews(token, page);
      bool reachedMax =
          response.currentPage! >= response.lastPage! ? true : false;
      emit(
        state.copyWith(
          news: List.of(state.news)..addAll(response.data!),
          status: Status.success,
          hasReachedMax: reachedMax,
        ),
      );
      page++;
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }
}

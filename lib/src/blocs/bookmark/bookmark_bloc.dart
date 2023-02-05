import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/news_repository.dart';
import '../../api/response.dart';
import '../../models/news.dart';
import './bookmark_event.dart';
import './bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final NewsRepository newsRepository;
  BookmarkBloc({required this.newsRepository}) : super(const BookmarkState()) {
    on<BookmarkFetched>(
      (BookmarkFetched event, Emitter<BookmarkState> emit) async {
        try {
          final Response<List<News>> bookmarks =
              await newsRepository.getBookmarks(event.accessToken);
          emit(state.copyWith(
            bookmarks: bookmarks.data,
            status: BookmarkStatus.success,
          ));
        } catch (e) {
          emit(state.copyWith(
            status: BookmarkStatus.failure,
            error: e.toString(),
          ));
        }
      },
    );
    on<BookmarkRemoved>((event, emit) async {
      try {
        final accessToken = event.accessToken;
        final newState = [...state.bookmarks];
        newState.removeWhere((element) => element.id == event.newsId);
        emit(state.copyWith(
          bookmarks: newState,
          status: BookmarkStatus.success,
        ));
        await newsRepository.removeBookmark(accessToken, event.newsId);
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    });
  }
}

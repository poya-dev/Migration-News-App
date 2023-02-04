import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/news_repository.dart';
import '../../api/response.dart';
import '../../models/news.dart';
import './bookmark_event.dart';
import './bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final NewsRepository newsRepository;
  BookmarkBloc({required this.newsRepository}) : super(BookmarkState()) {
    on<BookmarkFetched>(
      (BookmarkFetched event, Emitter<BookmarkState> emit) async {
        emit(BookmarkLoading());
        try {
          final Response<List<News>> bookmarks =
              await newsRepository.getBookmarks(event.accessToken);
          emit(BookmarkSuccess(bookmarks: bookmarks.data!));
        } catch (e) {
          emit(BookmarkFailure(error: e.toString()));
        }
      },
    );
  }
}

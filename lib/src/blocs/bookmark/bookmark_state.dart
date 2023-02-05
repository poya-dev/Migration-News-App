import 'package:equatable/equatable.dart';

import '../../models/news.dart';

enum BookmarkStatus { initial, success, failure }

class BookmarkState extends Equatable {
  const BookmarkState({
    this.bookmarks = const <News>[],
    this.status = BookmarkStatus.initial,
    this.error = '',
  });

  final List<News> bookmarks;
  final BookmarkStatus status;
  final String error;

  BookmarkState copyWith({
    List<News>? bookmarks,
    BookmarkStatus? status,
    String? error,
  }) {
    return BookmarkState(
      bookmarks: bookmarks ?? this.bookmarks,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [bookmarks, status, error];
}

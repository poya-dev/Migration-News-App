import 'package:equatable/equatable.dart';

import '../../models/news.dart';

class BookmarkState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookmarkLoading extends BookmarkState {}

class BookmarkSuccess extends BookmarkState {
  BookmarkSuccess({required this.bookmarks});

  final List<News> bookmarks;
  @override
  List<Object> get props => [bookmarks];
}

class BookmarkFailure extends BookmarkState {
  BookmarkFailure({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

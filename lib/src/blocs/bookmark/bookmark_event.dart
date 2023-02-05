import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookmarkFetched extends BookmarkEvent {
  BookmarkFetched(this.accessToken);

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}

class BookmarkRemoved extends BookmarkEvent {
  BookmarkRemoved({required this.accessToken, required this.newsId});

  final String accessToken;
  final String newsId;

  @override
  List<Object> get props => [accessToken, newsId];
}

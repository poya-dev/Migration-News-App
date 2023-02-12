import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookmarkFetched extends BookmarkEvent {}

class BookmarkRemoved extends BookmarkEvent {
  BookmarkRemoved({required this.newsId});

  final String newsId;

  @override
  List<Object> get props => [newsId];
}

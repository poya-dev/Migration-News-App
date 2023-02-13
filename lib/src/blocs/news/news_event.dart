import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsFetched extends NewsEvent {
  NewsFetched(this.category);

  final String? category;

  @override
  List<Object?> get props => [category];
}

class NewsReFetched extends NewsEvent {
  NewsReFetched(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}

class ResetNewsRequested extends NewsEvent {}

class NewsBookmarked extends NewsEvent {
  NewsBookmarked(this.newsId);

  final String newsId;

  @override
  List<Object> get props => [newsId];
}

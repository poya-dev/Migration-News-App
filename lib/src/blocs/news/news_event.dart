import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsFetched extends NewsEvent {}

class NewsReFetched extends NewsEvent {}

class NewsRefreshed extends NewsEvent {}

class NewsBookmarked extends NewsEvent {
  NewsBookmarked(this.newsId);

  final String newsId;

  @override
  List<Object> get props => [newsId];
}

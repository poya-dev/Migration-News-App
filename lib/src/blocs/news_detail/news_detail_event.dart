import 'package:equatable/equatable.dart';

abstract class NewsDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsDetailFetched extends NewsDetailEvent {
  NewsDetailFetched(this.newsId);

  final String newsId;

  @override
  List<Object> get props => [newsId];
}

class NewsDetailBookmarked extends NewsDetailEvent {
  NewsDetailBookmarked(this.newsId);

  final String newsId;

  @override
  List<Object> get props => [newsId];
}

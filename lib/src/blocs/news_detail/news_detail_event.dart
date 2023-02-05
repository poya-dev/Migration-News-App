import 'package:equatable/equatable.dart';

abstract class NewsDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsDetailFetched extends NewsDetailEvent {
  NewsDetailFetched(this.accessToken, this.newsId);

  final String accessToken;
  final String newsId;

  @override
  List<Object> get props => [accessToken, newsId];
}

class NewsDetailBookmarked extends NewsDetailEvent {
  NewsDetailBookmarked(this.accessToken, this.newsId);

  final String accessToken;
  final String newsId;

  @override
  List<Object> get props => [accessToken, newsId];
}

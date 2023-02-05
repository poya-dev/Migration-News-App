import 'package:equatable/equatable.dart';
import 'package:news_app/src/blocs/news/news_state.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsFetched extends NewsEvent {
  NewsFetched(this.accessToken);

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}

class NewsRefreshed extends NewsEvent {
  NewsRefreshed(this.accessToken);

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}

class NewsBookmarked extends NewsEvent {
  NewsBookmarked(this.accessToken, this.newsId);

  final String accessToken;
  final String newsId;

  @override
  List<Object> get props => [accessToken, newsId];
}

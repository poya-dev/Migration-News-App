import 'package:equatable/equatable.dart';

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

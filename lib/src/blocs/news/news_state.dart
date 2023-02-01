import 'package:equatable/equatable.dart';

import '../../models/news.dart';

enum Status { initial, success, failure }

class NewsState extends Equatable {
  const NewsState({
    this.news = const <News>[],
    this.status = Status.initial,
    this.hasReachedMax = false,
    this.error = '',
  });

  final List<News> news;
  final Status status;
  final bool hasReachedMax;
  final String error;

  NewsState copyWith({
    List<News>? news,
    Status? status,
    bool? hasReachedMax,
    String? error,
  }) {
    return NewsState(
      news: news ?? this.news,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [news, status, hasReachedMax, error];
}

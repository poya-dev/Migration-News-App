import 'package:equatable/equatable.dart';

import '../../models/news_detail.dart';

enum NewsDetailStatus { initial, success, failure }

class NewsDetailState extends Equatable {
  const NewsDetailState({
    this.news,
    this.status = NewsDetailStatus.initial,
    this.error = '',
  });

  final NewsDetail? news;
  final NewsDetailStatus status;
  final String error;

  NewsDetailState copyWith({
    NewsDetail? news,
    NewsDetailStatus? status,
    String? error,
  }) {
    return NewsDetailState(
      news: news ?? this.news,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [news, status, error];
}

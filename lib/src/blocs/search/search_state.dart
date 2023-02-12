import 'package:equatable/equatable.dart';

import '../../models/news.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoadIsEmpty extends SearchState {}

class SearchIsLoading extends SearchState {}

class SearchLoadSuccess extends SearchState {
  const SearchLoadSuccess(this.news);

  final List<News> news;

  @override
  List<Object> get props => [news];
}

class SearchLoadError extends SearchState {
  const SearchLoadError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

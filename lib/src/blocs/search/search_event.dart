import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  List<Object?> get props => [];
}

class SearchTermChanged extends SearchEvent {
  const SearchTermChanged({required this.text, required this.accessToken});
  final String text;
  final String accessToken;

  @override
  List<Object?> get props => [text, accessToken];
}

class ClearButtonPressed extends SearchEvent {}

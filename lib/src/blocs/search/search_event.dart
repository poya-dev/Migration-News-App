import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  List<Object?> get props => [];
}

class SearchTermChanged extends SearchEvent {
  const SearchTermChanged({required this.text});
  final String text;

  @override
  List<Object?> get props => [text];
}

class ClearButtonPressed extends SearchEvent {}

import 'package:equatable/equatable.dart';

abstract class BookmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookmarkFetched extends BookmarkEvent {
  BookmarkFetched(this.accessToken);

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}

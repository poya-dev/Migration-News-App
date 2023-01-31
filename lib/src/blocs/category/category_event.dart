import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryFetched extends CategoryEvent {
  CategoryFetched(this.accessToken);

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}

import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryFetched extends CategoryEvent {}

class CategoryRefreshed extends CategoryEvent {}

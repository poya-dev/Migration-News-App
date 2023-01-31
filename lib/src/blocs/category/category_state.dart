import 'package:equatable/equatable.dart';

import '../../models/category.dart';

class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  CategorySuccess({required this.categories});

  final List<Category> categories;

  @override
  List<Object?> get props => [categories];
}

class CategoryFailure extends CategoryState {
  CategoryFailure({required this.error});
  final String error;

  @override
  List<Object?> get props => [error];
}

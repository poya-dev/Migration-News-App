import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/news_repository.dart';
import './category_event.dart';
import './category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final NewsRepository newsRepository;
  CategoryBloc({required this.newsRepository}) : super(CategoryLoading()) {
    on<CategoryFetched>(
      (event, emit) async {
        emit(CategoryLoading());
        await Future.delayed(const Duration(seconds: 3));
        try {
          final String token = event.accessToken;
          final response = await newsRepository.getCategories(token);
          emit(CategorySuccess(categories: response.data!));
        } catch (error) {
          emit(CategoryFailure(error: error.toString()));
        }
      },
    );
    on<CategoryRefreshed>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      try {
        final String token = event.accessToken;
        final response = await newsRepository.getCategories(token);
        emit(CategorySuccess(categories: response.data!));
      } catch (error) {
        emit(CategoryFailure(error: error.toString()));
      }
    });
  }
}

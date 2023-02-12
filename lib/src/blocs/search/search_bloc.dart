import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../repositories/news_repository.dart';
import './search_event.dart';
import './search_state.dart';

const _duration = const Duration(milliseconds: 600);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NewsRepository newsRepository;

  SearchBloc({required this.newsRepository}) : super(SearchIsLoading()) {
    on<SearchTermChanged>(_onTermChanged, transformer: debounce(_duration));
    on<ClearButtonPressed>(_onClearButtonPressed);
  }
  Future _onTermChanged(
      SearchTermChanged event, Emitter<SearchState> emit) async {
    try {
      final searchTerm = event.text;
      if (searchTerm.isEmpty) return emit(SearchLoadIsEmpty());
      emit(SearchIsLoading());
      final results = await newsRepository.searchNews(searchTerm);
      emit(SearchLoadSuccess(results.data!));
    } catch (error) {
      emit(SearchLoadError(error.toString()));
    }
  }

  Future _onClearButtonPressed(
      ClearButtonPressed event, Emitter<SearchState> emit) async {
    try {
      emit(SearchIsLoading());
    } catch (error) {
      emit(SearchLoadError(error.toString()));
    }
  }
}

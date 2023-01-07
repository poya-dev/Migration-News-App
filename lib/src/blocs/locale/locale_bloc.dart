import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './locale_event.dart';
import './locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc()
      : super(
          const LocaleState(locale: Locale('fa'), lang: Language.english),
        ) {
    on<LocaleChanged>(
      (LocaleChanged event, Emitter<LocaleState> emit) => {
        if (event.lang == Language.english)
          emit(const LocaleState(locale: Locale('en'), lang: Language.english))
        else if (event.lang == Language.persian)
          emit(const LocaleState(locale: Locale('fa'), lang: Language.persian))
        else
          emit(const LocaleState(locale: Locale('ps'), lang: Language.pashto))
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../preferences/language_prefs.dart';
import './locale_event.dart';
import './locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, AppLocaleState> {
  LocaleBloc() : super(AppLocaleState()) {
    on<LocaleChanged>(
      (LocaleChanged event, Emitter<AppLocaleState> emit) {
        if (event.lang == Language.persian) {
          LanguagePrefs.setLocale(event.lang);
          return emit(state.copyWith(
            lang: Language.persian,
            locale: Locale('fa'),
          ));
        } else {
          LanguagePrefs.setLocale(event.lang);
          return emit(state.copyWith(
            lang: Language.pashto,
            locale: Locale('ps'),
          ));
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import './locale_event.dart' show Language;

class AppLocaleState extends Equatable {
  final Locale locale;
  final Language lang;

  AppLocaleState({
    this.locale = const Locale('fa'),
    this.lang = Language.persian,
  });

  copyWith({Locale? locale, Language? lang}) => AppLocaleState(
        locale: locale ?? this.locale,
        lang: lang ?? this.lang,
      );

  @override
  List<Object> get props => [locale, lang];
}

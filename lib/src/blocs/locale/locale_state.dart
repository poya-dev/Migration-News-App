import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import './locale_event.dart' show Language;

class LocaleState extends Equatable {
  const LocaleState({
    required this.locale,
    required this.lang,
  });

  final Locale locale;
  final Language lang;

  @override
  List<Object> get props => [locale, lang];
}

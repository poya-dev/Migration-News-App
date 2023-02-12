import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations({required this.locale});

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Map<String, dynamic>? _localizedString;

  Future<void> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedString = jsonMap.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );
  }

  String translate(String key) {
    return _localizedString![key];
  }

  bool get isEnLocale => locale.languageCode == 'fa';
}

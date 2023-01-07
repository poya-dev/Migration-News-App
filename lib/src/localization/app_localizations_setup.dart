import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './app_localizations.dart';

class AppLocalizationSetup {
  static const Iterable<Locale> supportedLocale = [
    Locale("en", "US"),
    Locale("fa", "IR"),
    Locale("ps", "AF"),
  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegate =
      [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}

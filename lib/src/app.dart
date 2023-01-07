import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './localization/app_localizations_setup.dart';
import './blocs/locale/locale_bloc.dart';
import './blocs/locale/locale_state.dart';
import './screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleBloc(),
        ),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'News App',
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('fa', 'IR'),
              Locale('ps', 'PT')
            ],
            localizationsDelegates: AppLocalizationSetup.localizationsDelegate,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

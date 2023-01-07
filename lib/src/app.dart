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
            supportedLocales: AppLocalizationSetup.supportedLocale,
            localizationsDelegates: AppLocalizationSetup.localizationsDelegate,
            localeResolutionCallback: (currentLocal, supportedLocales) {
              for (var locale in supportedLocales) {
                if (currentLocal != null &&
                    currentLocal.languageCode == locale.languageCode) {
                  return currentLocal;
                }
              }
              return supportedLocales.first;
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

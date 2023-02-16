import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './localization/app_localizations_setup.dart';
import './blocs/locale/locale_bloc.dart';
import './blocs/locale/locale_state.dart';
import './blocs/auth/auth_event.dart';
import './blocs/auth/auth_bloc.dart';
import './blocs/category/category_bloc.dart';
import './blocs/news/news_bloc.dart';
import './blocs/search/search_bloc.dart';
import './blocs/bookmark/bookmark_bloc.dart';
import './blocs/consulting/consulting_bloc.dart';
import './blocs/news_detail/news_detail_bloc.dart';
import './blocs/network/network_bloc.dart';
import './blocs/network/network_event.dart';
import './repositories/user_repository.dart';
import './repositories/news_repository.dart';
import './repositories/consulting_repository.dart';
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
        BlocProvider(
          create: (context) => AuthBloc(
            userRepository: UserRepository(),
          )..add(IsUserLoggedIn()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            newsRepository: NewsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => NewsBloc(
            newsRepository: NewsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            newsRepository: NewsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => BookmarkBloc(
            newsRepository: NewsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => ConsultingBloc(
            consultingRepository: ConsultingRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => NewsDetailBloc(
            newsRepository: NewsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => NetworkBloc()..add(NetworkObserved()),
        ),
      ],
      child: BlocBuilder<LocaleBloc, AppLocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Migration News App',
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

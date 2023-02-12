import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/blocs/news/news_bloc.dart';
import 'package:news_app/src/preferences/user_prefs.dart';
import 'package:news_app/src/screens/root_screen.dart';

import '../blocs/category/category_bloc.dart';
import '../blocs/category/category_event.dart';
import '../blocs/news/news_event.dart';
import '../preferences/language_prefs.dart';
import '../screens/sign_up_screen.dart';
import '../blocs/locale/locale_bloc.dart';
import '../blocs/locale/locale_event.dart';
import './language_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final lang = LanguagePrefs.getLocale();
    final user = UserPrefs.getUser();
    if (lang != null) {
      switch (lang) {
        case Language.persian:
          context.read<LocaleBloc>()..add(LocaleChanged(lang: lang));
          break;
        case Language.pashto:
          context.read<LocaleBloc>()..add(LocaleChanged(lang: lang));
          break;
      }
    }
    if (user != null) {
      context.read<NewsBloc>().add(NewsFetched());
      context.read<CategoryBloc>().add(CategoryFetched());
    }
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        setState(
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => (lang != null && user != null)
                    ? RootScreen()
                    : const LanguageSelectionScreen(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/icons/logo-white-1024x1024.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const CircularProgressIndicator(
            strokeWidth: 1.5,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

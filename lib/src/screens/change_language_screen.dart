import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/preferences/language_prefs.dart';

import '../blocs/locale/locale_bloc.dart';
import '../blocs/locale/locale_event.dart';
import '../widgets/icon_box.dart';
import '../widgets/language_item.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  final languages = ['دری', 'پشتو'];
  int selectedLanguageIndex = 0;

  @override
  void initState() {
    super.initState();
    Language? locale = LanguagePrefs.getLocale();
    switch (locale) {
      case Language.persian:
        setState(() {
          selectedLanguageIndex = 0;
        });
        break;
      case Language.pashto:
        setState(() {
          selectedLanguageIndex = 1;
        });
        break;
      default:
        setState(() {
          selectedLanguageIndex = 0;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconBox(
              bgColor: Colors.black54.withOpacity(0.055),
              isShadow: false,
              radius: 30,
              padding: const EdgeInsets.all(10),
              onTap: () {
                Navigator.pop(context);
              },
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black38,
                  size: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 100),
              child: const Text(
                'تغییر زبان',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   height: 150,
            // child:
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                languages.length,
                (index) => LanguageItem(
                  icon: 'assets/icons/afghanistan.svg',
                  language: languages[index],
                  isSelected: index == selectedLanguageIndex,
                  onTap: () {
                    setState(
                      () {
                        selectedLanguageIndex = index;
                      },
                    );
                  },
                ),
                // ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 42,
              child: ElevatedButton(
                child: Text('Change'),
                onPressed: () {
                  changeLanguage(context);
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void changeLanguage(BuildContext context) {
    if (selectedLanguageIndex == 0) {
      context
          .read<LocaleBloc>()
          .add(const LocaleChanged(lang: Language.persian));
    } else {
      context
          .read<LocaleBloc>()
          .add(const LocaleChanged(lang: Language.pashto));
    }
  }
}

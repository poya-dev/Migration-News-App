import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/locale/locale_bloc.dart';
import '../blocs/locale/locale_event.dart';
import '../blocs/locale/locale_state.dart';
import '../widgets/language_item.dart';
import '../utils/translation_util.dart';
import './sign_up_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final languages = ['دری', 'پشتو'];
  int selectedLanguageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 18,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: SvgPicture.asset(
                      'assets/icons/logo.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'به',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'معلومات مهاجرت',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'خوش آمدید',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    getTranslated(context, 'lang_selection_instruction'),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
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
                            changeLanguage(context, index);
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          Colors.lightBlue,
                        )),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'ادامه',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void changeLanguage(BuildContext context, int index) {
    if (index == 0) {
      context
          .read<LocaleBloc>()
          .add(const LocaleChanged(lang: Language.persian));
    } else if (index == 1) {
      context
          .read<LocaleBloc>()
          .add(const LocaleChanged(lang: Language.pashto));
    } else {
      context
          .read<LocaleBloc>()
          .add(const LocaleChanged(lang: Language.english));
    }
  }
}

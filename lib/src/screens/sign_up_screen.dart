import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/social_button.dart';
import './language_selection_screen.dart';
import './root_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    'برای استفاده از خدمات ما باید در اپلیکیشن ما ثبت نام کنید.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SocialButton(
                text: 'ورود با فیسبوک',
                color: Colors.blue,
                icon: 'assets/icons/facebook_logo.svg',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageSelectionScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 18,
              ),
              SocialButton(
                text: 'ورود با گوگل',
                color: const Color.fromARGB(255, 190, 22, 10),
                icon: 'assets/icons/google_logo.svg',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageSelectionScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Row(
                    children: [
                      const Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        'با ورود به سیستم شما با',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(left: 4, right: 4),
                          child: Text(
                            'شرایط و ضوابط',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        'ما موافقت میکنید.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

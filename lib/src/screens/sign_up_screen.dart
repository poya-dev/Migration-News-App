import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/social_button.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/auth/auth_event.dart';
import './root_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RootScreen(),
              ),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UnAuthenticated) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        'assets/icons/logo-blue-300x300.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                    color: const Color.fromARGB(255, 36, 130, 207),
                    icon: FontAwesomeIcons.facebookF,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RootScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SocialButton(
                    text: 'ورود با گوگل',
                    color:
                        const Color.fromARGB(255, 233, 10, 5).withOpacity(0.7),
                    icon: FontAwesomeIcons.google,
                    onTap: () {
                      context.read<AuthBloc>().add(GoogleSignInRequested());
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
            );
          }
          return Container();
        },
      ),
    );
  }
}

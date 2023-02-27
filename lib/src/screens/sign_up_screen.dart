import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../blocs/category/category_bloc.dart';
import '../blocs/category/category_event.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/news/news_event.dart';
import '../widgets/social_button.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/auth/auth_event.dart';
import './root_screen.dart';
import '../utils/translation_util.dart';
import 'user_agreement_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.read<CategoryBloc>().add(CategoryFetched());
            context.read<NewsBloc>().add(NewsFetched('All'));
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
                        'assets/icons/logoai-copy.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text(
                        getTranslated(context, 'app_instruction'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black87.withOpacity(.5),
                          fontFamily: 'BNazann',
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SocialButton(
                    text: getTranslated(context, 'facebook_btn_txt'),
                    color: const Color.fromARGB(255, 36, 130, 207),
                    icon: FontAwesomeIcons.facebookF,
                    onTap: () {
                      context.read<AuthBloc>().add(FacebookSignInRequested());
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SocialButton(
                    text: getTranslated(context, 'google_btn_txt'),
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
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            getTranslated(context, 'app_privacy_and_policy_1'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'BNazann',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UserAgreementScreen(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 4, right: 4),
                              child: Text(
                                getTranslated(
                                    context, 'app_privacy_and_policy_2'),
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontFamily: 'BNazann',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            getTranslated(context, 'app_privacy_anc_policy_3'),
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'BNazann',
                              fontSize: 16,
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

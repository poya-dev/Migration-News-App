import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './change_language_screen.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../widgets/icon_box.dart';
import '../utils/translation_util.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
              child: Text(
                getTranslated(context, 'setting'),
                style: TextStyle(
                  fontFamily: 'BNazann',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              style: ListTileStyle.drawer,
              iconColor: Colors.lightBlue,
              minLeadingWidth: 5,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeLanguageScreen(),
                  ),
                );
              },
              title: Text(
                getTranslated(context, 'change_language'),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'BNazann',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.language),
            ),
            ListTile(
              style: ListTileStyle.drawer,
              iconColor: Colors.lightBlue,
              minLeadingWidth: 5,
              title: Text(
                getTranslated(context, 'about_app'),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'BNazann',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.info_outline),
            ),
            ListTile(
              style: ListTileStyle.drawer,
              iconColor: Colors.lightBlue,
              minLeadingWidth: 5,
              title: Text(
                getTranslated(context, 'privacy_policy'),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'BNazann',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.policy),
            ),
            ListTile(
              style: ListTileStyle.drawer,
              iconColor: Colors.lightBlue,
              minLeadingWidth: 5,
              title: Text(
                getTranslated(context, 'usage_condition'),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'BNazann',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.details),
            ),
            ListTile(
              style: ListTileStyle.drawer,
              iconColor: Colors.lightBlue,
              minLeadingWidth: 5,
              title: Text(
                getTranslated(context, 'rate_our_app'),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'BNazann',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.feedback),
            ),
            ListTile(
              style: ListTileStyle.drawer,
              iconColor: Colors.lightBlue,
              minLeadingWidth: 5,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    title: Text(
                      getTranslated(context, 'warning'),
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'BNazann',
                      ),
                    ),
                    content: Text(
                      getTranslated(context, 'logout_warning_txt'),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontFamily: 'BNazann',
                      ),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              getTranslated(context, 'cancel_btn'),
                              style: TextStyle(
                                fontFamily: 'BNazann',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context
                                .read<AuthBloc>()
                                .add(SignOutRequested()),
                            child: Text(
                              getTranslated(context, 'yes_btn'),
                              style: TextStyle(
                                fontFamily: 'BNazann',
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              title: Text(
                getTranslated(context, 'logout'),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'BNazann',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}

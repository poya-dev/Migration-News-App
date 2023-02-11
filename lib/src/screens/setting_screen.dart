import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../widgets/icon_box.dart';

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
              child: const Text(
                'تنظیمات',
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
        child: ListView(
          children: [
            ListTile(
              style: ListTileStyle.drawer,
              iconColor: Colors.lightBlue,
              minLeadingWidth: 5,
              title: Text(
                'تغییر زبان',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -0.5,
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
                'در باره اپلیکیشن',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -0.5,
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
                'سیاست های حریم خصوصی',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -0.5,
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
                'شرایط استفاده',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -0.5,
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
                'راجع به اپلیکیشن ما نظر بدهید',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -0.5,
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
                context.read<AuthBloc>().add(SignOutRequested());
              },
              title: Text(
                'خارج شدن',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: -0.5,
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

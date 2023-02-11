import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/setting_screen.dart';
import '../widgets/icon_box.dart';
import '../theme/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconBox(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  color: darker,
                  width: 28,
                  height: 28,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'کریم محمدی',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          IconBox(
            isShadow: false,
            child: Image.asset(
              'assets/icons/logo-blue-300x300.png',
              color: Colors.blue,
              width: 32,
              height: 32,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

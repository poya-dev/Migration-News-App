import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/icon_box.dart';
import '../theme/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconBox(
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
                'Karim Mohammadi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          IconBox(
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              color: darker,
              width: 28,
              height: 28,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

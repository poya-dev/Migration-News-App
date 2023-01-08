import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/color.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    Key? key,
    required this.icon,
    required this.language,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final String icon;
  final String language;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(vertical: 4),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white12 : Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.07),
              spreadRadius: .5,
              blurRadius: .5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
            fit: BoxFit.fitWidth,
          ),
          title: Text(
            language,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          trailing: isSelected
              ? const Icon(
                  Icons.check,
                  shadows: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: .5,
                      blurRadius: .5,
                      offset: Offset(0, 1),
                    )
                  ],
                  color: Colors.lightBlue,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

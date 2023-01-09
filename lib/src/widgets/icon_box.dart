import 'package:flutter/material.dart';

import '../theme/color.dart';

class IconBox extends StatelessWidget {
  const IconBox({
    Key? key,
    required this.child,
    this.borderColor = Colors.transparent,
    this.bgColor = Colors.white,
    this.radius = 50,
    this.padding = const EdgeInsets.all(5),
    this.onTap,
    this.isShadow = true,
  }) : super(key: key);

  final Widget child;
  final Color borderColor;
  final Color bgColor;
  final double radius;
  final EdgeInsetsGeometry padding;
  final GestureTapCallback? onTap;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor),
          boxShadow: [
            if (isShadow)
              BoxShadow(
                color: shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              )
          ],
        ),
        child: child,
      ),
    );
  }
}

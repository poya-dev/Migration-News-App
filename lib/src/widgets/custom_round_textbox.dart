import 'package:flutter/material.dart';

import '../theme/color.dart';

class CustomRoundTextBox extends StatelessWidget {
  const CustomRoundTextBox({
    Key? key,
    this.hint = "",
    this.prefix,
    this.suffix,
    this.onTap,
  }) : super(key: key);
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 223, 224),
        border: Border.all(color: textBoxColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          prefixIcon: prefix,
          suffixIcon: suffix,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

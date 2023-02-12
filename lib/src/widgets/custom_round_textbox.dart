import 'package:flutter/material.dart';

import '../theme/color.dart';

class CustomRoundTextBox extends StatelessWidget {
  const CustomRoundTextBox(
      {Key? key,
      this.hint = "",
      this.isReadOnly = false,
      this.isAutoFocus = false,
      this.controller,
      this.prefix,
      this.suffix,
      this.onTap,
      this.onChanged,
      this.onSubmitted})
      : super(key: key);
  final String hint;
  final bool isReadOnly;
  final bool isAutoFocus;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onTap;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xfff3f3f4),
        border: Border.all(color: textBoxColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        autofocus: isAutoFocus,
        onTap: onTap,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
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

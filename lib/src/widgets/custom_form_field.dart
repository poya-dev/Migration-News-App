import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.keyboardType,
    required this.onSaved,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        onSaved: onSaved,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(icon),
        ),
      ),
    );
  }
}

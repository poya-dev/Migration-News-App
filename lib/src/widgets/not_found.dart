import 'package:flutter/material.dart';

import '../utils/translation_util.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 36,
          color: Colors.black87.withOpacity(.5),
        ),
        const SizedBox(height: 12),
        Text(
          getTranslated(context, 'not_found_error'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87.withOpacity(.5),
            fontFamily: 'BNazann',
          ),
        ),
      ],
    );
  }
}

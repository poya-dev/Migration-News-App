import 'package:flutter/material.dart';

import '../utils/translation_util.dart';

class SearchError extends StatelessWidget {
  const SearchError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off_outlined,
          size: 36,
          color: Colors.black45,
        ),
        const SizedBox(height: 8),
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

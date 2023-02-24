import 'package:flutter/material.dart';
import 'package:news_app/src/utils/translation_util.dart';

class MakeError extends StatelessWidget {
  const MakeError({
    super.key,
    required this.error,
    required this.onTap,
  });

  final String error;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 50,
            color: Colors.black87.withOpacity(.5),
          ),
          const SizedBox(height: 12),
          Text(
            error,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87.withOpacity(.5),
              fontFamily: 'BNazann',
            ),
          ),
          SizedBox(height: 18),
          ElevatedButton(
            onPressed: onTap,
            child: Text(getTranslated(context, 'try_again')),
          )
        ],
      ),
    );
  }
}

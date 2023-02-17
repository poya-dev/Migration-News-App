import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/data.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 36, 12, 0),
        child: RichText(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            style: TextStyle(
              color: Colors.grey.withOpacity(.7),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: privacy_policy,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

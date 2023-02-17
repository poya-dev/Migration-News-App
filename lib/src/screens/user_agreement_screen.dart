import 'package:flutter/material.dart';

import '../utils/translation_util.dart';
import '../widgets/icon_box.dart';
import '../utils/data.dart';

class UserAgreementScreen extends StatelessWidget {
  const UserAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconBox(
              bgColor: Colors.black54.withOpacity(0.055),
              isShadow: false,
              radius: 30,
              padding: const EdgeInsets.all(10),
              onTap: () {
                Navigator.pop(context);
              },
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black38,
                  size: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 90),
              child: Text(
                getTranslated(context, 'usage_condition'),
                style: TextStyle(
                  fontFamily: 'BNazann',
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: RichText(
            textDirection: TextDirection.ltr,
            text: TextSpan(
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              text: user_agreement,
            ),
          ),
        ),
      ),
    );
  }
}

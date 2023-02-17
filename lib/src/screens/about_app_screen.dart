import 'package:flutter/material.dart';

import '../utils/translation_util.dart';
import '../widgets/icon_box.dart';
import '../utils/data.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

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
              margin: EdgeInsets.only(right: 80),
              child: Text(
                getTranslated(context, 'about_app'),
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
          child: Column(
            children: [
              RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black54.withOpacity(.6),
                    fontSize: 18.0,
                    fontFamily: 'BNazann',
                    wordSpacing: 3,
                  ),
                  text: about_app,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Icon(
                      Icons.whatsapp,
                      color: Colors.green.withOpacity(.9),
                    ),
                  ),
                  Text(
                    'شماره واتساپ:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'BNazann',
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Text(
                      '93784684908+',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87.withOpacity(.7),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Icon(
                      Icons.email_outlined,
                      color: Colors.red.withOpacity(.7),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'ایمیل:',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'BNazann',
                        color: Colors.black87.withOpacity(.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Container(
                      margin: EdgeInsets.only(right: 4),
                      child: Text(
                        'contacts@migration-information.com',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

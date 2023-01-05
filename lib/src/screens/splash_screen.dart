import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 5000),
      () {
        setState(
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'MIGRATION',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              wordSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'INFORMATION',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              wordSpacing: 3,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

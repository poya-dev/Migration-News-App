import 'package:flutter/material.dart';

import './language_selection_screen.dart';

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
                builder: (context) => const LanguageSelectionScreen(),
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
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/icons/logo-white-1024x1024.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const CircularProgressIndicator(
            strokeWidth: 1.5,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

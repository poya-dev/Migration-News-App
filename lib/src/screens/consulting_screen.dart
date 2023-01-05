import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import '../widgets/custom_app_bar.dart';

class ConsultingScreen extends StatelessWidget {
  const ConsultingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('Consulting Screen'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/consulting_response_message.dart';
import '../widgets/custom_app_bar.dart';
import '../utils/data.dart';

class ConsultingScreen extends StatelessWidget {
  const ConsultingScreen({super.key});

  final data =
      'اگر میخواهید در مورد مهاجرت جایگزین های قانونی تحصیل اشتغال و سایر فرصت های مرتبط بیشتر بدانید لطفآ فورم زیر را پر کنید و از مشاورین ما مشاوره های تلفونی دریافت نمایید.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                data,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                  backgroundColor: MaterialStatePropertyAll(Colors.lightBlue),
                ),
                onPressed: () {},
                child: const Text(
                  'فورم مشاوره تلفونی',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'فورم های که قبلآ پور نموده اید:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: userFormData.length,
                itemBuilder: (context, index) {
                  return ConsultingResponseMessage(
                    timeAgo: userFormData[index]['timeAgo'],
                    message: userFormData[index]['message'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

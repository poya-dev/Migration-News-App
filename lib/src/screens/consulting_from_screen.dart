import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_form_field.dart';

class ConsultingFormScreen extends StatefulWidget {
  const ConsultingFormScreen({super.key});

  @override
  State<ConsultingFormScreen> createState() => _ConsultingFormScreenState();
}

class _ConsultingFormScreenState extends State<ConsultingFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomFormField(
                  hintText: 'اسم',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'لطفآ اسم تان را وارد نمایید';
                    }
                  },
                ),
                CustomFormField(
                  hintText: 'آدرس',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'لطفآ ادرس تان را وارد نمایید';
                    }
                  },
                ),
                CustomFormField(
                  hintText: 'نمبر تماس',
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'نمبر تماس تان را وارد نمایید';
                    }
                    if (val.length < 10 || val.length > 12) {
                      return 'نمبر تماس باید 10 الی 12 عدد  باشد';
                    }
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('ارسال'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

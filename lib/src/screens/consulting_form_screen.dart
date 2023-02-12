import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/blocs/auth/auth_bloc.dart';
import 'package:news_app/src/blocs/auth/auth_state.dart';

import '../blocs/consulting/consulting_bloc.dart';
import '../blocs/consulting/consulting_event.dart';
import '../blocs/consulting/consulting_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_form_field.dart';
import '../models/consulting_request.dart';
import '../widgets/icon_box.dart';

class ConsultingFormScreen extends StatefulWidget {
  const ConsultingFormScreen({super.key});

  @override
  State<ConsultingFormScreen> createState() => _ConsultingFormScreenState();
}

class _ConsultingFormScreenState extends State<ConsultingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _accessToken = '';
  String _name = '';
  String _address = '';
  String _phone = '';

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
              child: const Text(
                'درخواست مشوره',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        if (authState is Authenticated) {
          _accessToken = authState.user.accessToken;
        }
        return BlocConsumer<ConsultingBloc, ConsultingState>(
            listener: (context, state) {
          if (state is ConsultingRequestFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong, please try again!'),
              ),
            );
          }
          if (state is ConsultingRequestSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Your request has been sent successfully.'),
              ),
            );
          }
        }, builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomFormField(
                      hintText: 'اسم',
                      icon: Icons.person,
                      onSaved: (String? value) {
                        _name = value!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'لطفآ اسم تان را وارد نمایید';
                        }
                        return null;
                      },
                    ),
                    CustomFormField(
                      hintText: 'آدرس',
                      icon: Icons.location_city,
                      onSaved: (String? value) {
                        _address = value!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'لطفآ ادرس تان را وارد نمایید';
                        }
                        return null;
                      },
                    ),
                    CustomFormField(
                      hintText: 'نمبر تماس',
                      icon: Icons.phone,
                      keyboardType: TextInputType.number,
                      onSaved: (String? value) {
                        _phone = value!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'نمبر تماس تان را وارد نمایید';
                        }
                        if (val.length < 10 || val.length > 12) {
                          return 'نمبر تماس باید 10 الی 12 عدد  باشد';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: state is ConsultingRequestLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  final data = ConsultingRequest(
                                    name: _name,
                                    address: _address,
                                    phone: _phone,
                                  );
                                  context.read<ConsultingBloc>().add(
                                      ConsultingRequested(_accessToken, data));
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  if (state is ConsultingRequestSuccess) {
                                    _formKey.currentState!.reset();
                                  }
                                }
                              },
                        child: state is ConsultingRequestLoading
                            ? const Center(
                                child: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Text('ارسال'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}

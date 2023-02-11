import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/consulting_response_message.dart';
import '../blocs/consulting/consulting_bloc.dart';
import '../blocs/consulting/consulting_event.dart';
import '../blocs/consulting/consulting_state.dart';
import '../screens/language_selection_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../blocs/auth/auth_state.dart';
import './consulting_form_screen.dart';
import '../blocs/auth/auth_bloc.dart';
import '../utils/convert_to_ago.dart';
import '../widgets/loader.dart';

class ConsultingScreen extends StatefulWidget {
  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  String accessToken = '';

  final data =
      'اگر میخواهید در مورد مهاجرت جایگزین های قانونی تحصیل اشتغال و سایر فرصت های مرتبط بیشتر بدانید لطفآ فورم زیر را پر کنید و از مشاورین ما مشاوره های تلفونی دریافت نمایید.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, authState) {
        if (authState is UnAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LanguageSelectionScreen(),
            ),
          );
        }
      }, builder: (context, authState) {
        if (authState is Authenticated) {
          accessToken = authState.user.accessToken;
        }
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<ConsultingBloc>()
                .add(ConsultingResponseFetched(accessToken));
            return Future.delayed(const Duration(seconds: 2));
          },
          child: Container(
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
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.lightBlue),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConsultingFormScreen(),
                        ),
                      );
                    },
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
                  BlocBuilder<ConsultingBloc, ConsultingState>(
                    builder: (context, state) {
                      if (state is ConsultingResponseLoading) {
                        return Container(
                          margin: const EdgeInsets.only(top: 150),
                          child: const Loader(),
                        );
                      }
                      if (state is ConsultingResponseFailure) {
                        return const Center(
                          child: Text('Failed to get consulting response'),
                        );
                      }
                      if (state is ConsultingResponseSuccess) {
                        final response = state.consultingResponse.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: response!.length,
                          itemBuilder: (context, index) {
                            return ConsultingResponseMessage(
                              timeAgo: convertToAgo(
                                response[index].createdAt,
                                'fa',
                              ),
                              message: response[index].responseMessage,
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

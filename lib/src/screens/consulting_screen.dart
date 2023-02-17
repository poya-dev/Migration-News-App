import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/consulting_response_message.dart';
import '../blocs/consulting/consulting_bloc.dart';
import '../blocs/consulting/consulting_event.dart';
import '../blocs/consulting/consulting_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/make_error.dart';
import './consulting_form_screen.dart';
import '../utils/convert_to_ago.dart';
import '../widgets/loader.dart';
import '../utils/translation_util.dart';

class ConsultingScreen extends StatefulWidget {
  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ConsultingBloc>().add(ConsultingResponseFetched());
          return Future.delayed(const Duration(seconds: 2));
        },
        child: Container(
          padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  getTranslated(context, 'consulting_info'),
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'BNazann',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
                    backgroundColor: MaterialStatePropertyAll(Colors.lightBlue),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConsultingFormScreen(),
                      ),
                    );
                  },
                  child: Text(
                    getTranslated(context, 'consulting_request_btn'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'BNazann',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  getTranslated(context, 'already_form_filled'),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'BNazann',
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
                      return MakeError(
                        error: getTranslated(context, 'something_went_wrong'),
                        onTap: () {
                          context
                              .read<ConsultingBloc>()
                              .add(ConsultingResponseFetched());
                        },
                      );
                    }
                    if (state is ConsultingResponseSuccess) {
                      final response = state.consultingResponse.data;
                      if (response!.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.only(top: 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  getTranslated(
                                      context, 'if_already_filled_txt'),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'BNazann',
                                    color: Colors.black87.withOpacity(.7),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Icon(
                                Icons.file_copy_outlined,
                                size: 36,
                                color: Colors.black87.withOpacity(.5),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: response.length,
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
      ),
    );
  }
}

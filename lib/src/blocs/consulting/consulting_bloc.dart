import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/consulting_repository.dart';
import './consulting_event.dart';
import './consulting_state.dart';

class ConsultingBloc extends Bloc<ConsultingEvent, ConsultingState> {
  final ConsultingRepository consultingRepository;
  ConsultingBloc({required this.consultingRepository})
      : super(ConsultingState()) {
    on<ConsultingRequested>(
      (ConsultingRequested event, Emitter<ConsultingState> emit) async {
        emit(ConsultingRequestLoading());
        await Future.delayed(const Duration(seconds: 3));
        try {
          final accessToken = event.accessToken;
          final data = event.data;
          await consultingRepository.consultingRequest(accessToken, data);
          emit(ConsultingRequestSuccess());
        } catch (e) {
          emit(ConsultingRequestFailure());
        }
      },
    );
  }
}

import 'package:equatable/equatable.dart';

import '../../models/consulting.dart';

class ConsultingState extends Equatable {
  @override
  List<Object> get props => [];
}

class ConsultingResponseLoading extends ConsultingState {}

class ConsultingResponseSuccess extends ConsultingState {
  ConsultingResponseSuccess({required this.consultingResponse});

  final List<ConsultingResponse> consultingResponse;
  @override
  List<Object> get props => [consultingResponse];
}

class ConsultingResponseFailure extends ConsultingState {
  ConsultingResponseFailure({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class ConsultingRequestLoading extends ConsultingState {}

class ConsultingRequestSuccess extends ConsultingState {}

class ConsultingRequestFailure extends ConsultingState {}

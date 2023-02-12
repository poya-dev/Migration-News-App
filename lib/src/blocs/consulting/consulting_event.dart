import 'package:equatable/equatable.dart';

import '../../models/consulting_request.dart';

abstract class ConsultingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConsultingRequested extends ConsultingEvent {
  ConsultingRequested(this.data);

  final ConsultingRequest data;

  @override
  List<Object> get props => [data];
}

class ConsultingResponseFetched extends ConsultingEvent {}

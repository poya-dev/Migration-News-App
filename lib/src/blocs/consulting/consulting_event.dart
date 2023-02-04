import 'package:equatable/equatable.dart';

import '../../models/consulting_request.dart';

abstract class ConsultingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ConsultingRequested extends ConsultingEvent {
  ConsultingRequested(this.accessToken, this.data);

  final String accessToken;
  final ConsultingRequest data;

  @override
  List<Object> get props => [accessToken];
}

class ConsultingResponseFetched extends ConsultingEvent {
  ConsultingResponseFetched(this.accessToken);

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}

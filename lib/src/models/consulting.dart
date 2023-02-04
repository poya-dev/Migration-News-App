import 'package:intl/intl.dart';

class ConsultingResponse {
  ConsultingResponse({
    required this.responseMessage,
    required this.createdAt,
  });

  final String responseMessage;
  final DateTime createdAt;

  factory ConsultingResponse.fromJson(Map<String, dynamic> json) =>
      ConsultingResponse(
        responseMessage: json['message'],
        createdAt: DateFormat('yyyy-MM-ddTHH:mm:ssZ')
            .parse(json['createdAt'])
            .toLocal(),
      );
}

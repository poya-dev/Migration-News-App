import '../models/consulting_request.dart';
import '../models/consulting.dart';
import '../api/response.dart';
import '../api/api.dart';

class ConsultingRepository {
  Future<void> consultingRequest(
    String accessToken,
    ConsultingRequest data,
  ) async {
    return await ApiService.consultingRequest(accessToken, data);
  }

  Future<Response<List<ConsultingResponse>>> getConsultingResponse(
    String accessToken,
  ) async {
    return await ApiService.getConsultingResponse(accessToken);
  }
}

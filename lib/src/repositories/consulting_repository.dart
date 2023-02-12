import '../models/consulting_request.dart';
import '../models/consulting.dart';
import '../api/response.dart';
import '../api/api.dart';

class ConsultingRepository {
  Future<void> consultingRequest(ConsultingRequest data) async {
    return await ApiService.consultingRequest(data);
  }

  Future<Response<List<ConsultingResponse>>> getConsultingResponse() async {
    return await ApiService.getConsultingResponse();
  }
}

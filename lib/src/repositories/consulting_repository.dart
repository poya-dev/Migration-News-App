import '../models/consulting_request.dart';
import '../api/api.dart';

class ConsultingRepository {
  Future<void> consultingRequest(
      String accessToken, ConsultingRequest data) async {
    return await ApiService.consultingRequest(accessToken, data);
  }
}

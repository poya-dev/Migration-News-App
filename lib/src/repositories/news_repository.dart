import '../models/category.dart';
import '../api/api.dart';

class NewsRepository {
  Future<List<Category>> getCategories(String idToken) async {
    return await ApiService.getCategories(idToken);
  }
}

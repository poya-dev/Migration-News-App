import '../models/category.dart';
import '../models/news.dart';
import '../api/response.dart';
import '../api/api.dart';

class NewsRepository {
  Future<Response<List<Category>>> getCategories(String idToken) async {
    return await ApiService.getCategories(idToken);
  }

  Future<Response<List<News>>> getNews(String idToken, [int page = 1]) async {
    return await ApiService.getNews(idToken, page);
  }
}

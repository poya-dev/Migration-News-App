import '../models/category.dart';
import '../models/news.dart';
import '../api/response.dart';
import '../api/api.dart';

class NewsRepository {
  Future<Response<List<Category>>> getCategories(
    String accessToken,
  ) async {
    return await ApiService.getCategories(accessToken);
  }

  Future<Response<List<News>>> getNews(String accessToken,
      [int page = 1]) async {
    return await ApiService.getNews(accessToken, page);
  }

  Future<void> toggleBookmark(
      String accessToken, String newsId, bool add) async {
    return await ApiService.toggleBookmark(accessToken, newsId, add);
  }

  Future<Response<List<News>>> getBookmarks(String accessToken) async {
    return await ApiService.getBookmarks(accessToken);
  }
}

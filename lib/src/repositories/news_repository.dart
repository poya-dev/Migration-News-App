import '../models/category.dart';
import '../models/news.dart';
import '../models/news_detail.dart';
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

  Future<Response<NewsDetail>> getNewsDetail(
    String accessToken,
    String newsId,
  ) async {
    return await ApiService.getNewsDetail(accessToken, newsId);
  }

  Future<Response<List<News>>> searchNews(
      String accessToken, String term) async {
    return await ApiService.searchNews(accessToken, term);
  }

  Future<void> addBookmark(String accessToken, String newsId) async {
    return await ApiService.addBookmark(accessToken, newsId);
  }

  Future<void> removeBookmark(String accessToken, String newsId) async {
    return await ApiService.removeBookmark(accessToken, newsId);
  }

  Future<Response<List<News>>> getBookmarks(String accessToken) async {
    return await ApiService.getBookmarks(accessToken);
  }
}

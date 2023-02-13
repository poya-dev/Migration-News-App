import '../models/category.dart';
import '../models/news.dart';
import '../models/news_detail.dart';
import '../api/response.dart';
import '../api/api.dart';

class NewsRepository {
  Future<Response<List<Category>>> getCategories() async {
    return await ApiService.getCategories();
  }

  Future<Response<List<News>>> getNews(String category, [int page = 1]) async {
    return await ApiService.getNews(category, page);
  }

  Future<Response<NewsDetail>> getNewsDetail(
    String newsId,
  ) async {
    return await ApiService.getNewsDetail(newsId);
  }

  Future<Response<List<News>>> searchNews(String term) async {
    return await ApiService.searchNews(term);
  }

  Future<void> addBookmark(String newsId) async {
    return await ApiService.addBookmark(newsId);
  }

  Future<void> removeBookmark(String newsId) async {
    return await ApiService.removeBookmark(newsId);
  }

  Future<Response<List<News>>> getBookmarks() async {
    return await ApiService.getBookmarks();
  }
}

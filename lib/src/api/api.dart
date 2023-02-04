import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constant.dart';
import '../models/user.dart';
import '../models/category.dart';
import '../models/news.dart';
import './response.dart';

class ApiService {
  static final http.Client client = http.Client();
  static Future<User> signInWithGoogle(String idToken) async {
    try {
      final response = await client.get(
        Uri.parse(ApiEndpoints.googleSinIn),
        headers: {'Authorization': 'Bearer $idToken'},
      );
      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return User.fromJson(body);
      }
      throw Exception('Google authentication failed');
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<User> signInWithFacebook(String token) async {
    try {
      final response = await client.post(
        Uri.parse(ApiEndpoints.facebookSinIn),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return User.fromJson(body);
      }
      throw Exception('Facebook authentication failed');
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<Response<List<Category>>> getCategories(String token) async {
    try {
      final response = await client.get(
        Uri.parse(ApiEndpoints.category),
        headers: {'Authorization': 'Bearer $token'},
      );
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        List<Category> categories = body['data'].map<Category>((categoryItem) {
          return Category.fromJson(categoryItem);
        }).toList();
        return Response(data: categories);
      }
      throw Exception('Failed to get news category');
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<Response<List<News>>> getNews(String token, int page) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiEndpoints.news}?page=$page'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final currentPage = body['currentPage'];
        final lastPage = body['lastPage'];
        final List<News> newsList = body['data']
            .map<News>((newsItem) => News.fromJson(newsItem))
            .toList();
        return Response(
          data: newsList,
          currentPage: currentPage,
          lastPage: lastPage,
        );
      }
      throw Exception('Failed to get news data');
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<void> toggleBookmark(
    String token,
    String newsId,
    bool add,
  ) async {
    try {
      final String bookmarkEndpoint = add
          ? '${ApiEndpoints.bookmark}/add/$newsId'
          : '${ApiEndpoints.bookmark}/remove/$newsId';
      final response = await client.put(
        Uri.parse(bookmarkEndpoint),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode != 200) {
        throw Exception('Something went wrong');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<Response<List<News>>> getBookmarks(String token) async {
    try {
      final response = await client.get(
        Uri.parse(ApiEndpoints.bookmark),
        headers: {'Authorization': 'Bearer $token'},
      );
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        List<News> bookmarks =
            body['data']['bookmarkNews'].map<News>((bookmarkItem) {
          return News.fromJson(bookmarkItem);
        }).toList();
        return Response(data: bookmarks);
      }
      throw Exception('Failed to get user bookmarks');
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}

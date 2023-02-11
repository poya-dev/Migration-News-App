import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/consulting_request.dart';
import '../models/consulting.dart';
import '../utils/constant.dart';
import '../models/user.dart';
import '../models/category.dart';
import '../models/news.dart';
import '../models/news_detail.dart';
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
        return User.fromJson(body['user'], body['accessToken']);
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
        return User.fromJson(body['user'], body['accessToken']);
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

  static Future<Response<NewsDetail>> getNewsDetail(
    String token,
    String newsId,
  ) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiEndpoints.news}/id/$newsId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final NewsDetail news = NewsDetail.fromJson(body['data'][0]);
        return Response(data: news);
      }
      throw Exception('Failed to get news record');
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<void> addBookmark(String token, String newsId) async {
    try {
      final response = await client.post(Uri.parse(ApiEndpoints.bookmark),
          headers: {'Authorization': 'Bearer $token'}, body: {'news': newsId});
      if (response.statusCode != 200) {
        throw Exception('Something went wrong');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<void> removeBookmark(String token, String newsId) async {
    try {
      final response = await client.delete(
          Uri.parse('${ApiEndpoints.bookmark}/id/$newsId'),
          headers: {'Authorization': 'Bearer $token'});
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
        List<News> bookmarks = body['data'].map<News>((bookmarkItem) {
          return News.fromJson(bookmarkItem['news']);
        }).toList();
        return Response(data: bookmarks);
      }
      throw Exception('Failed to get user bookmarks');
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<void> consultingRequest(
    String token,
    ConsultingRequest data,
  ) async {
    try {
      final response = await client.post(
        Uri.parse(ApiEndpoints.consulting),
        headers: {'Authorization': 'Bearer $token'},
        body: data.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to send the request');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<Response<List<ConsultingResponse>>> getConsultingResponse(
    String token,
  ) async {
    try {
      final response = await client.get(
        Uri.parse(ApiEndpoints.consulting),
        headers: {'Authorization': 'Bearer $token'},
      );
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        List<ConsultingResponse> consultingResponse =
            body['data'].map<ConsultingResponse>((responseItem) {
          return ConsultingResponse.fromJson(responseItem['response']);
        }).toList();
        return Response(data: consultingResponse);
      }
      throw Exception('Failed to get consulting response');
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}

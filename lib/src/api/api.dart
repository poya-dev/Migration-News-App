// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/category.dart';
import '../models/news.dart';
import './response.dart';

const baseUrl = 'http://192.168.13.96:3000/api/v1/';

class ApiService {
  static final http.Client client = http.Client();
  static Future<User> signInWithGoogle(String idToken) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/auth/google'),
        headers: {
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/json'
        },
      );
      final resJson = json.decode(response.body);
      return User.fromJson(resJson);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<User> signInWithFacebook(String token) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/auth/facebook'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      final resJson = json.decode(response.body);
      return User.fromJson(resJson);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<Response<List<Category>>> getCategories(String token) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/client/news-category'),
        headers: {'Authorization': 'Bearer $token'},
      );
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        final List<Category> categoryList =
            body['data'].map<Category>((categoryItem) {
          return Category.fromJson(categoryItem);
        }).toList();
        return Response(data: categoryList);
      }
      throw Exception('Something went wrong ---> ${response.body}');
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<Response<List<News>>> getNews(String token, int page) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/client/news?page=$page'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final currentPage = body['currentPage'];
        final lastPage = body['lastPage'];
        final List<News> newsList = body['data'].map<News>((newsItem) {
          return News.fromJson(newsItem);
        }).toList();
        return Response(
          data: newsList,
          currentPage: currentPage,
          lastPage: lastPage,
        );
      }
      throw Exception('Something went wrong ---> ${response.body}');
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}

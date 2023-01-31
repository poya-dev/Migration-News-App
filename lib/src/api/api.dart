// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/category.dart';

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
      final resJson = jsonDecode(response.body);
      return User.fromJson(resJson);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<User> signInWithFacebook(String accessToken) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/auth/facebook'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
      );
      final resJson = jsonDecode(response.body);
      return User.fromJson(resJson);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<List<Category>> getCategories(String accessToken) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/client/news-category?langCode=us'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
      );
      final resJson = jsonDecode(response.body);
      final List<Category> categoryList = resJson['data']
          .map<Category>((category) => Category.fromJson(category))
          .toList();
      return categoryList;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}

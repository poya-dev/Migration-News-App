import 'package:intl/intl.dart';

import './category.dart';

class NewsDetail {
  String id;
  String title;
  String content;
  String imageUrl;
  int viewCount;
  bool isBookmark;
  Category category;
  DateTime createdAt;

  NewsDetail({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.viewCount,
    required this.isBookmark,
    required this.category,
    required this.createdAt,
  });

  factory NewsDetail.fromJson(Map<String, dynamic> json) {
    return NewsDetail(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      viewCount: json['view_count'],
      isBookmark: json['isBookmark'],
      category: Category.fromJson(json['category']),
      createdAt:
          DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(json['createdAt']).toLocal(),
    );
  }
}

import './category.dart';

class News {
  final String id;
  final String title;
  final String imageUrl;
  final int viewCount;
  final Category category;
  // final DateTime createdAt;

  News({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.viewCount,
    required this.category,
    // required this.createdAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      viewCount: json['view_count'],
      category: Category.fromJson(json['category']),
      // createdAt: json['created_at'],
    );
  }
}

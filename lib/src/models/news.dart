import './category.dart';

class News {
  String id;
  String title;
  String imageUrl;
  int viewCount;
  bool isBookmark;
  Category category;
  // DateTime createdAt;

  News({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.viewCount,
    required this.isBookmark,
    required this.category,
    // required this.createdAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      viewCount: json['view_count'],
      isBookmark: json['isBookmark'],
      category: Category.fromJson(json['category']),
      // createdAt: json['created_at'],
    );
  }
}

class ApiEndpoints {
  static String root = 'http://192.168.13.96:3000';
  static String baseUrl = '$root/api/v1/';
  static String googleSinIn = '$baseUrl/auth/google';
  static String facebookSinIn = '$baseUrl/auth/facebook';
  static String category = '$baseUrl/client/news-category';
  static String news = '$baseUrl/client/news';
  static String bookmark = '$baseUrl/client/bookmark';
  static String consulting = '$baseUrl/client/consulting';
}

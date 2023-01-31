class User {
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final String accessToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['user']['_id'],
        name: json['user']['name'],
        email: json['user']['email'],
        profilePicture: json['user']['userPictureUrl'],
        accessToken: json['accessToken'],
      );
}

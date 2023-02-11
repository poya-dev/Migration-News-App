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

  factory User.fromJson(Map<String, dynamic> json, String accessToken) => User(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        profilePicture: json['userPictureUrl'],
        accessToken: accessToken,
      );

  factory User.fromPrefJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        profilePicture: json['profilePicture'],
        accessToken: json['accessToken'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profilePicture": profilePicture,
        'accessToken': accessToken
      };
}

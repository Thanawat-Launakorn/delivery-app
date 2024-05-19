class User {
  final int id;
  final String username;
  final String email;

  User({
    required this.username,
    required this.id,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        email: json['email'] as String,
        username: json['username'] as String);
  }
}

class UserResponse {
  final String message;
  List<User> info;

  UserResponse({this.message = 'no-content', this.info = const []});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        message: json['message'] as String,
        info: List<User>.from(
            (json['info'] as List).map((e) => User.fromJson(e)).toList()));
  }
}

class UserDetailResponse {
  final String message;
  final User info;

  UserDetailResponse({this.message = 'no-content', required this.info});

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailResponse(
        info: User.fromJson(json['info']), message: json['message'] as String);
  }
}

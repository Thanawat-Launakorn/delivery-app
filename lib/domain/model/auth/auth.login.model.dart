class LoginModel {
  final int response_status;
  final String token;

  LoginModel({required this.response_status, required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        response_status: json['response_status'] as int,
        token: json['token'] as String);
  }
}

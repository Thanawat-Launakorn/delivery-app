class LoginModel {
  final String role;
  final int response_status;
  final String access_token;

  LoginModel({
    required this.role,
    required this.access_token,
    required this.response_status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      role: json['role'] as String,
      access_token: json['access_token'] as String,
      response_status: json['response_status'] as int,
    );
  }
}

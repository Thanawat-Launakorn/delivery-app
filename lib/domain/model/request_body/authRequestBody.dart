class AuthRequest {
  final String email;
  final String password;

  AuthRequest({required this.email, required this.password});

  // แปลงเป็น json
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Factory method to create an instance from JSON
  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest(
      email: json['email'],
      password: json['password'],
    );
  }
}

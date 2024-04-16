import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_application_1/domain/model/auth/auth.login.model.dart';
import 'package:http/http.dart' as http;

class AuthService {

  late LoginModel loginModel;
  Future<LoginModel> loginService(String email, String password) async {
    try {
      final Map<String, dynamic> signInDto = {
        'email': email,
        'password': password,
      };

      http.Response response = await http.post(Uri.parse('${config['uri']}/auth/login'), body: signInDto);
      if (response.statusCode == 200) {
        loginModel = await compute(_pareJsonLogin, response.body);
      }
        return loginModel;
    } catch (err) {
      throw Exception(err);
    }

  }
}

LoginModel _pareJsonLogin(String json) => LoginModel.fromJson(jsonDecode(json));
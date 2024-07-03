import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_application_1/domain/model/request_body/authRequestBody.dart';
import 'package:flutter_application_1/domain/model/response_body/authResponseBody.dart';

class AuthService {
  final LoginModel _initialLoginModel =
      LoginModel(response_status: 0, access_token: '', role: '');
  Future<LoginModel> loginService(AuthRequest body) async {
    late LoginModel loginModel;

    try {
      http.Response response = await http.post(
          Uri.parse('${config['baseurl']}auth/login'),
          body: body.toJson());
      if (response.statusCode == 200) {
        debugPrint('async res url: ${response.request!.url}');
      } else if (response.statusCode != 200) {
        return _initialLoginModel;
      }

      loginModel = await compute(_pareJsonLogin, response.body);
      return loginModel;
    } catch (err) {
      throw Exception(err);
    }
  }
}

LoginModel _pareJsonLogin(String json) => LoginModel.fromJson(jsonDecode(json));

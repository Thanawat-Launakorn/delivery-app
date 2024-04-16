import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_application_1/domain/model/user/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  UserService();

  Future<bool> addUserService(String email, String username) async {
    try {
      final Map<String, dynamic> requestBody = {
        'username': username,
        'email': email,
      };

      http.Response response = await http
          .post(Uri.parse('${config['uri']}/user'), body: requestBody);
      debugPrint("Response body: ${response.body}");
      if (response.statusCode != 200) {
        return false;
      } else {
        return true;
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> updateUserService(int id, String email, String username) async {
    try {
      final Map<String, dynamic> requestBody = {
        'id': id.toString(),
        'username': username,
        'email': email,
      };

      http.Response response = await http
          .patch(Uri.parse('${config['uri']}/user/'), body: requestBody);
      debugPrint(response.body);
      if (response.statusCode != 200) {
        return false;
      } else {
        return true;
      }
    } catch (err) {
      debugPrint('Error updateUserService $err');
      throw Exception(err);
    }
  }

  Future<UserDetailResponse> fetchDetailUesr(int id) async {
    late UserDetailResponse _user;
    try {
      http.Response response =
          await http.get(Uri.parse('${config['uri']}/user/$id'));
      if (response.statusCode != 200) {
      } else {
        _user = await compute(_parseUserDetailJson, response.body);
      }
    } catch (err) {
      debugPrint('Error UserDetailService $err');
      throw Exception(err);
    }

    return _user;
  }

  Future<UserResponse> fetchUser() async {
    UserResponse _user = UserResponse();
    try {
      http.Response response =
          await http.get(Uri.parse('${config['uri']}/user'));
      if (response.statusCode != 200) {
      } else {
        _user = await compute(_parseUserJson, response.body);
      }
    } catch (err) {
      throw Exception(err);
    }
    return _user;
  }

  Future<bool> deleteUserService(int id) async {
    try {
      final Map<String, dynamic> requestBody = {
        'id': id.toString(),
      };

      http.Response response = await http
          .delete(Uri.parse('${config['uri']}/user'), body: requestBody);

      if (response.statusCode != 200) {
        return false;
      } else {
        return true;
      }
    } catch (err) {
      debugPrint('Error deleteUserService $err');
      throw Exception(err);
    }
  }
}

UserResponse _parseUserJson(String json) =>
    UserResponse.fromJson(jsonDecode(json));
UserDetailResponse _parseUserDetailJson(String json) =>
    UserDetailResponse.fromJson(jsonDecode(json));

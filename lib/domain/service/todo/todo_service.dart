import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/domain/model/todo/todo_model.dart';

class TodoService {
  Future<TodoAllResponse> fetchTodo() async {
    TodoAllResponse todos = TodoAllResponse();
    try {
      http.Response response =
          await http.get(Uri.parse('${config['uri']}/todo'));
      if (response.statusCode == 200) {
        debugPrint(response.body);
        todos = TodoAllResponse();
      } else {}
    } catch (err) {
      throw Exception(err);
    }

    return todos;
  }
}

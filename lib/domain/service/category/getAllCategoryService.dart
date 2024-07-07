import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllCategoryResponseBody.dart';

class GetAllCategoryServiceReturnValue {
  final List<GetAllCategoryResponse> response;
  final int response_status;

  GetAllCategoryServiceReturnValue(
      {required this.response, required this.response_status});
}

class GetAllCategoryService {
  final List<GetAllCategoryResponse> _initGetAllCategory = [
    GetAllCategoryResponse(id: 0, image: '', category: '', description: '')
  ];

  Future<GetAllCategoryServiceReturnValue> fetchData() async {
    GetAllCategoryServiceReturnValue returnValue =
        GetAllCategoryServiceReturnValue(
            response: _initGetAllCategory, response_status: 0);

    final id_token = await CacheToken().readToken();

    try {
      final res = await http.get(
        Uri.parse('${config['baseurl']}category/all'),
        headers: {
          'Content-Type': 'application/json',
          'id_token': id_token,
        },
      );

      debugPrint('async res url: ${res.request!.url}');
      debugPrint('res status => ${res.statusCode}');

      if (res.statusCode == 200) {
        final json = await compute(_parseJsonAllCategory, res.body);
        returnValue = GetAllCategoryServiceReturnValue(
            response: json, response_status: res.statusCode);
      } else {
        returnValue = GetAllCategoryServiceReturnValue(
            response: _initGetAllCategory, response_status: res.statusCode);
      }
    } catch (err) {
      debugPrint('Fetch GetAllCategoryService $err');
      returnValue = GetAllCategoryServiceReturnValue(
          response: _initGetAllCategory, response_status: 0);
    }

    return returnValue;
  }
}

List<GetAllCategoryResponse> _parseJsonAllCategory(String jsonString) {
  final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
  return parsed
      .map<GetAllCategoryResponse>(
          (json) => GetAllCategoryResponse.fromJson(json))
      .toList();
}

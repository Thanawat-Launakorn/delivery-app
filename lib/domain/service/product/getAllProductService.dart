import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllCategoryResponseBody.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/model/response_body/getAllProductResponseBody.dart';

class GetAllProductServiceReturnValue {
  final List<GetAllProductResponse> response;
  final int response_status;

  GetAllProductServiceReturnValue(
      {required this.response, required this.response_status});
}

class GetAllProductService {
  final List<GetAllProductResponse> _initGetAllProduct = [
    GetAllProductResponse(
        id: 0,
        name: '',
        description: '',
        price: 0,
        image: '',
        category_id: 0,
        category: GetAllCategoryResponse(
            id: 0, category: '', description: '', image: ''))
  ];

  Future<GetAllProductServiceReturnValue> fetchData() async {
    GetAllProductServiceReturnValue returnValue =
        GetAllProductServiceReturnValue(
            response: _initGetAllProduct, response_status: 0);

    final token = await CacheToken().readToken();

    try {
      final res = await http.get(Uri.parse('${config['baseurl']}product/all'),
          headers: {'Content-Type': 'application/json', 'id_token': token});

      debugPrint('async res url: ${res.request!.url}');
      debugPrint('res status: ${res.statusCode}');
      if (res.statusCode == 200) {
        final json = await compute(_parseJsonAllProduct, res.body);
        returnValue = GetAllProductServiceReturnValue(
            response: json, response_status: res.statusCode);
      } else if (res.statusCode != 200) {
        returnValue = GetAllProductServiceReturnValue(
            response: _initGetAllProduct, response_status: res.statusCode);
      }
    } catch (err) {
      debugPrint('Error Fetch GetAllProductService ${err}');
      returnValue = GetAllProductServiceReturnValue(
          response: _initGetAllProduct, response_status: 0);
    }

    return returnValue;
  }
}

List<GetAllProductResponse> _parseJsonAllProduct(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed
      .map<GetAllProductResponse>(
          (json) => GetAllProductResponse.fromJson(json))
      .toList();
}

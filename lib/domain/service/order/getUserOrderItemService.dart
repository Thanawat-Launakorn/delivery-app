import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/model/response_body/getUserOrderItemResponseBody.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetUserOrderItemServiceReturnValue {
  final List<OrderItemResponse> response;
  final int response_status;

  GetUserOrderItemServiceReturnValue(
      {required this.response, required this.response_status});
}

class GetUserOrderItemService {
  final List<OrderItemResponse> _initGetUserOrderItem = [
    OrderItemResponse(
        id: 0,
        orderId: 0,
        productId: 0,
        quantity: 0,
        order: OrderResponse(
            id: 0, userId: 0, addressId: 0, createdAt: '', updatedAt: ''),
        product: ProductResponse(
            id: 0,
            name: '',
            description: '',
            price: 0,
            image: '',
            categoryId: 0))
  ];

  Future<GetUserOrderItemServiceReturnValue> fetchData() async {
    GetUserOrderItemServiceReturnValue returnValue =
        GetUserOrderItemServiceReturnValue(
            response: _initGetUserOrderItem, response_status: 0);

    final id_token = await CacheToken().readToken();
    final userId = await const FlutterSecureStorage().read(key: 'userId');

    try {
      if (userId == null) debugPrint('not found userId');

      final res = await http
          .get(Uri.parse('${config['baseurl']}order/all/orderItem'), headers: {
        'Content-Type': 'application/json',
        'id_token': id_token,
      });

      debugPrint('async res url: ${res.request!.url}');
      debugPrint('res status => ${res.statusCode}');
      debugPrint('res body => ${res.body}');
      if (res.statusCode == 200) {
        final json = await compute(_parseJsonOrder, res.body);
        returnValue = GetUserOrderItemServiceReturnValue(
            response: json, response_status: res.statusCode);
      }
    } catch (err) {
      debugPrint('Fetch GetUserOrderItem $err');
      returnValue = GetUserOrderItemServiceReturnValue(
          response: _initGetUserOrderItem, response_status: 0);
    }

    return returnValue;
  }
}

List<OrderItemResponse> _parseJsonOrder(String jsonString) {
  final parsed = jsonDecode(jsonString) as Map<String, dynamic>;
  final data =
      parsed['response'] as List<dynamic>?; // Handle possible null values
  if (data == null) return [];

  return data
      .map<OrderItemResponse>(
          (json) => OrderItemResponse.fromJson(json))
      .toList();
}

import 'dart:convert';

import 'package:flutter_application_1/domain/model/response_body/getUserOrderResponseBody.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/model/response_body/addressResponseBody.dart';

class GetUserOrderServiceReturnValue {
  final List<GetUserOrderResponse> response;
  final int response_status;

  GetUserOrderServiceReturnValue(
      {required this.response, required this.response_status});
}

class GetUserOrderService {
  final List<GetUserOrderResponse> _initGetUserOrder = [
    GetUserOrderResponse(
        id: 0,
        userId: 0,
        addressId: 0,
        createdAt: '',
        updatedAt: null,
        user: UserResponse(
            userId: 0,
            email: '',
            password: '',
            role: '',
            createdAt: '',
            updatedAt: ''),
        address: AddressResponse(
            address: '',
            addressTitle: '',
            fullName: '',
            id: 0,
            method: '',
            phone: '',
            userId: 0,
            zipCode: ''),
        orderItems: [
          OrderItemsResponse(id: 0, orderId: 0, productId: 0, quantity: 0)
        ])
  ];

  Future<GetUserOrderServiceReturnValue> fetchData() async {
    GetUserOrderServiceReturnValue returnValue = GetUserOrderServiceReturnValue(
        response: _initGetUserOrder, response_status: 0);

    final id_token = await CacheToken().readToken();
    final userId = await const FlutterSecureStorage().read(key: 'userId');

    try {
      if (userId == null) debugPrint('not found userId');

      final res =
          await http.get(Uri.parse('${config['baseurl']}order/all'), headers: {
        'Content-Type': 'application/json',
        'id_token': id_token,
      });

      debugPrint('async res url: ${res.request!.url}');
      debugPrint('res status => ${res.statusCode}');
      debugPrint('res body => ${res.body}');
      if (res.statusCode == 200) {
        final json = await compute(_parseJsonOrder, res.body);
        returnValue = GetUserOrderServiceReturnValue(
            response: json, response_status: res.statusCode);
      }
    } catch (err) {
      debugPrint('Fetch GetUserOrder $err');
      returnValue = GetUserOrderServiceReturnValue(
          response: _initGetUserOrder, response_status: 0);
    }

    return returnValue;
  }
}

List<GetUserOrderResponse> _parseJsonOrder(String jsonString) {
  final parsed = jsonDecode(jsonString) as Map<String, dynamic>;
  final data = parsed['response'] as List<dynamic>?; // Handle possible null values
  if (data == null) return [];

  return data
      .map<GetUserOrderResponse>((json) => GetUserOrderResponse.fromJson(json))
      .toList();
}

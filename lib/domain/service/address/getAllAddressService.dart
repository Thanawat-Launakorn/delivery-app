import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:flutter_application_1/domain/model/response_body/addressResponseBody.dart';

class GetAllAddressServiceReturnValue {
  final List<AddressResponse> response;
  final int response_status;

  GetAllAddressServiceReturnValue(
      {required this.response, required this.response_status});
}

class GetAllAddressService {
  final List<AddressResponse> _initGetUserAddress = [
    AddressResponse(
        id: 0,
        method: '',
        address: '',
        fullName: '',
        phone: '',
        userId: 0,
        addressTitle: '',
        zipCode: '')
  ];

  Future<GetAllAddressServiceReturnValue> fetchData() async {
    GetAllAddressServiceReturnValue returnValue =
        GetAllAddressServiceReturnValue(
            response: _initGetUserAddress, response_status: 0);

    final id_token = await CacheToken().readToken();
    final userId = await const FlutterSecureStorage().read(key: 'userId');

    try {
      if (userId == null) debugPrint('not found userId');

      final res = await http
          .get(Uri.parse('${config['baseurl']}address/user/$userId'), headers: {
        'Content-Type': 'application/json',
        'id_token': id_token,
      });

      debugPrint('async res url: ${res.request!.url}');
      debugPrint('res status => ${res.statusCode}');

      if (res.statusCode == 200) {
        final json = await compute(_parseJsonAddress, res.body);
        returnValue = GetAllAddressServiceReturnValue(
            response: json, response_status: res.statusCode);
      }
    } catch (err) {
      debugPrint('Fetch GetAllAddress $err');
      returnValue = GetAllAddressServiceReturnValue(
          response: _initGetUserAddress, response_status: 0);
    }

    return returnValue;
  }
}

List<AddressResponse> _parseJsonAddress(String jsonString) {
  final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
  return parsed
      .map<AddressResponse>((json) => AddressResponse.fromJson(json))
      .toList();
}

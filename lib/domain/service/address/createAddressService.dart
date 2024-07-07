import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/config/config.dart';
import 'package:flutter_application_1/domain/model/request_body/addressRequestBody.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/domain/db_helper/cache_token.dart';

class CreateAddressServiceReturnValue {
  final int response_status;

  CreateAddressServiceReturnValue({required this.response_status});
}

class CreateAddressService {
  Future<CreateAddressServiceReturnValue> fetchData(AddressRequest body) async {
    CreateAddressServiceReturnValue returnValue =
        CreateAddressServiceReturnValue(response_status: 0);

    final id_token = await CacheToken().readToken();
    debugPrint('body => ${body.toJson()}');
    final bodyJson = jsonEncode(body.toJson());
    try {
      final res =
          await http.post(Uri.parse('${config['baseurl']}address/create'),
              headers: {
                'Content-Type': 'application/json',
                'id_token': id_token,
              },
              body: bodyJson);

      debugPrint('async res url: ${res.request!.url}');
      debugPrint('res status => ${res.statusCode}');

      if (res.statusCode == 200) {
        returnValue =
            CreateAddressServiceReturnValue(response_status: res.statusCode);
      } else {
        returnValue =
            CreateAddressServiceReturnValue(response_status: res.statusCode);
      }
    } catch (err) {
      debugPrint('Fetch CreateAddressService $err');
      returnValue = CreateAddressServiceReturnValue(response_status: 0);
    }

    return returnValue;
  }
}

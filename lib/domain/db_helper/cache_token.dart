import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheToken {
  final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  String token = 'token';
  String noToken = 'noToken';

  // save localStorage
  void writeToken(String value) {
    _flutterSecureStorage.write(key: token, value: value);
  }

  // read localStorage
  Future<String> readToken() async {
    String? tokenUser = await _flutterSecureStorage.read(key: token);
    return tokenUser ?? noToken;
  }

  // clear localStorage
  void deleteAll() {
    _flutterSecureStorage.deleteAll();
  }


}
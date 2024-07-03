import 'package:flutter_application_1/domain/db_helper/cache_token.dart';
import 'package:http/http.dart' as http;

// class HttpService {
//   final http.Client client;

//   HttpService(this.client);

//   Future<Map<String, String>> headers() async {
//     final getToken = await CacheToken().readToken();
//     print('getToken : ${getToken}');
//     late String token;
//     var _initHeader = {
//       'Content-Type': 'application/json',
//       'id_token': '0000-0000-0000-0000'
//     };
//     if (getToken.toString().isNotEmpty) {
//       token = getToken.toString();
//       print('isTrue ?');
//       _initHeader = {'Content-Type': 'application/json', 'id_token': token};
//       return _initHeader;
//     }
//     return _initHeader;
//   }

//   Future<http.Response> get(String url) async {
//     final response = await client.get(Uri.parse(url), headers: headers());
//     return response;
//   }

//   Future<http.Response> post(String url, Map<String, dynamic> body) async {
//     final response = await client.post(
//       Uri.parse(url),
//       headers: headers(),
//       body: body,
//     );
//     return response;
//   }

//   void dispose() {
//     client.close();
//   }
// }

Map<String, dynamic> config = {
  'baseurl': 'http://localhost:3000/',
};

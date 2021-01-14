import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> getRequest(String url) {
  return http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}
Future<http.Response> postRequest(String url, data) {
  return http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
}
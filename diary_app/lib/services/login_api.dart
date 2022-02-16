import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class LoginApi{
  final String email;
  final String password;

  const LoginApi(this.email, this.password);

  final urlLink = 'http://192.168.100.141:3000';

  Future<http.Response> loginWithEmailPassword() async {
    final queryParameters = {
      "email" : email,
      "password" : password
    };
    // final uri = Uri.http('192.168.100.141:3000', '/users/login/', queryParameters);
    final uri = Uri.http('localhost:3000', '/users/login/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.post(uri, headers: headers, body: jsonEncode(queryParameters));
    return response;
  }
}
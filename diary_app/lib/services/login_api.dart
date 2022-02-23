import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class LoginApi{
  final String email;
  final String password;

  LoginApi(this.email, this.password);

  final urlLink = Platform.isWindows || Platform.isMacOS || Platform.isLinux ? 'localhost:3000' : '10.0.2.2:3000';
  // In case of physical device, replace with Wifi ipv4 address

  Future<http.Response> loginWithEmailPassword() async {
    final queryParameters = {
      "email" : email,
      "password" : password
    };
    // final uri = Uri.http('192.168.100.141:3000', '/users/login/', queryParameters);
    final uri = Uri.http(urlLink, '/users/login/');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.post(uri, headers: headers, body: jsonEncode(queryParameters));
    print(response);
    return response;
  }
}
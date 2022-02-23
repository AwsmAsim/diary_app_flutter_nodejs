import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
class RegisterAPI{
  final String email;
  final String password;
  final String name;

  RegisterAPI(this.email, this.password, this.name);

  // final urlLink = 'http://192.168.100.141:3000/users';
  final urlLink = Platform.isWindows || Platform.isMacOS || Platform.isLinux ? 'http://localhost:3000/users' : 'http://10.0.2.2:3000/users';
// In case of physical device, replace with Wifi ipv4 address
  Future<http.Response> registerWithEmailPassword() async {
    var url = Uri.parse(urlLink);
    var body = {
      "name" : name,
      "email" : email,
      "password" : password
    };
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    var response = await http.post(url,
      headers: headers,
      body: jsonEncode(body)
    );
    return response;
  }
}
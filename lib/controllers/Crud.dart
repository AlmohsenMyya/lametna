import 'dart:convert';

import 'package:http/http.dart' as http;

class Crud {
  String loginUrl = 'https://lametna.000webhostapp.com/auth/login.php';
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  loginRequest(Map data) async {
    try {
      var response = await http.post(Uri.parse(loginUrl), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }
}

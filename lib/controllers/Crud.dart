// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseURL = "https://lametna2023-store.preview-domain.com/";
String loginUrl = baseURL + "auth/login.php";

class Crud {
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

  Future<void> saveUserCredentials(
      List<Map<String, String>> credentials) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedCredentials =
        credentials.map((cred) => jsonEncode(cred)).toList();
    await prefs.setStringList('userCredentials', encodedCredentials);
  }

  Future<List<Map<String, String>>> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedCredentials = prefs.getStringList('userCredentials');
    if (encodedCredentials != null) {
      final credentials = encodedCredentials
          .map((encodedCred) => jsonDecode(encodedCred))
          .cast<Map<String, String>>()
          .toList();
      return credentials;
    }
    return [];
  }

  Future<void> updateUserCredentials(
      List<Map<String, String>> updatedCredentials) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedCredentials =
        updatedCredentials.map((cred) => jsonEncode(cred)).toList();
    await prefs.setStringList('userCredentials', encodedCredentials);
  }
}

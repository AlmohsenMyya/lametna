// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  postRequest(Map data) async {
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

  get(String targetedUrl) async {
    var url = Uri.parse(targetedUrl);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request successful, parse the response data
      var jsonResponse = json.decode(response.body);
      // print(response.body["status"]);
      return jsonResponse;
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  post(String targetedUrl, Map data) async {
    var url = Uri.parse(targetedUrl);
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      // Request successful, parse the response data
      var jsonResponse = json.decode(response.body);
      // print(response.body["status"]);
      return jsonResponse;
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}

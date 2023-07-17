import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';

class ProfileController extends GetxController {
  // List roles = [];
  bool isLoading = true;
  var data;
  bool pageIndex = true;

  @override
  void onInit() {
    super.onInit();
    getData();
    isLoading = true;
  }

  Future getData() async {
    var url = Uri.parse(userInfo);
    var response = await http.post(url, body: {
      "username": userName,
    });
    if (response.statusCode == 200) {
      final dataBody = json.decode(response.body);
      data = dataBody["data"];
      print(dataBody);
      isLoading = false;
      update();
      // roles.add(data["data"])
      // print(json.decode(response.body));
    }
  }

  changePage(bool value) {
    pageIndex = value;
    update();
  }
}

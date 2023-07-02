import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/variables.dart';

class AccountMangementController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getRoles();
  }

  Future getRoles() async {
    var url = Uri.parse(listRoles);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}

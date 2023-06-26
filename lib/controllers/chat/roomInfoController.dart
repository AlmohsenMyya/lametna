import 'package:get/get.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomInfoController extends GetxController {
  Future<dynamic> getData() async {
    try {
      var url = Uri.parse(roomInfoUrl);
      var response = await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
      });
      final dataBody = json.decode(response.body);
      // streamController.sink.add(dataBody);
      return dataBody;
    } catch (e) {}
  }
}

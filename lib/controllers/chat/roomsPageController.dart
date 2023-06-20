import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../userData/userCredentials.dart';

class RoomsPageController extends GetxController {
  bool roomStatus = true;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    var url = Uri.parse('${baseURL}/messages/showmessagegroup.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request successful, parse the response data
      var jsonResponse = json.decode(response.body);
      // print(response.body["status"]);
      return jsonResponse;
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void changeRoomStatus() {
    roomStatus = !roomStatus;
    update();
    // print(roomStatus);
  }
}

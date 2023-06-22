import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/model/rooms.dart';

class ChatHomeController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  List vipRooms = [];
  List regularRooms = [];
  Crud crud = Crud();
  int selectedIndex = 0;
  int alertIndex = 0;

  @override
  void onInit() {
    super.onInit();
    fetchAllRooms();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  Future<void> fetchAllRooms() async {
    // rooms = await _roomService.getAllRooms();
    var response = await crud.get("${baseURL}/messages/room.php");
    if (response["status"] == "success") {
      // rooms = respose["data"];
      // response = json.decode(response);
      for (var item in response["data"]) {
        if (item["room_type"] == "vip") {
          vipRooms.add(item);
        } else {
          regularRooms.add(item);
        }
      }
      print(vipRooms);
      print('-----------');
      print(regularRooms);
    }

    update();
  }

  void changeAlertIndex(int index) {
    alertIndex = index;
    alertPageController.jumpToPage(index);
    update();
  }

  void resetAlertIndex() {
    alertIndex = 0;
    alertPageController.jumpToPage(0);
    update();
  }

  List countries = [
    "algeria",
    "egypt",
    "sudan",
    "iraq",
    "morocco",
    "yemen",
    "syria",
    "tunisia",
    "spain",
    "palestine",
  ];
}



// vipRooms.add(Rooms(
//               roomId: data["room_id"],
//               ownerUsername: data["owner_username"],
//               roomName: data["room_name"],
//               channelName: data["Channel_Name"],
//               token: data["Token"],
//               roomImg: data["room_img"],
//               backgroundImg: data["background_img"],
//               backgroundColor: data["background_color"],
//               status: data["status"],
//               helloMsg: data["hello_msg"],
//               password: data["password"],
//               capacity: data["capacity"],
//               numberOfConnections: data["number_of_connections"],
//               startDate: data["start_date"],
//               expiryDate: data["expiry_date"],
//               roomType: data["room_type"],
//               roomPlan: data["room_plan"],
//               description: data["description"],
//               countryName: data["country_name"],
//               flag: data["flag"]));
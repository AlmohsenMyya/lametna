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
  TextEditingController guestController = TextEditingController();
  TextEditingController Controller = TextEditingController();
  List vipRooms = [];
  List regularRooms = [];
  Crud crud = Crud();
  int selectedIndex = 0;
  int alertIndex = 0;

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
    var response = await crud.get(getRooms);
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

  checkUsername() {
    // if(username == null){
    //   Get.defaultDialog(
    //     title: "تنبيه",
    //     content: Text("يجب عليك تسجيل الدخول اولا"),
    //     confirm: TextButton(
    //       onPressed: () {
    //         Get.back();
    //       },
    //       child: Text("حسنا"),
    //     ),
    //   );
    // }
  }
}

// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/model/rooms.dart';

class ChatHomeController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  TextEditingController guestController = TextEditingController();
  // TextEditingController Controller = TextEditingController();
  List vipRooms = [];
  List regularRooms = [];
  Crud crud = Crud();
  int selectedIndex = 0;
  int alertIndex = 0;
  int roomNumber = 0;

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
      roomNumber = response["data"].length;
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

  checkUsername() async {
    // print("guest-${guestController.text.trim()}${Random().nextInt(9999)}");
    guestUserName =
        "guest-${guestController.text.trim()}${Random().nextInt(9999)}";
    isGuest = true;
    Get.back();
    // if (guestController.text.trim().isNotEmpty) {
    //   var url = Uri.parse(checkUser);
    //   var response = await http.post(
    //     url,
    //     body: {
    //       "username": guestController.text.trim(),
    //     },
    //   );
    //   var res = json.decode(response.body);
    //   if (res["status"] == true) {
    //     Get.snackbar(
    //       "",
    //       "",
    //       titleText: Text(
    //         "تنبيه",
    //         textDirection: TextDirection.rtl,
    //       ),
    //       messageText: Text(
    //         "اسم المستخدم غير متاح",
    //         textDirection: TextDirection.rtl,
    //       ),
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.red,
    //       colorText: Colors.white,
    //     );
    //   } else {
    //     print("ok");
    //   }
    //   // print(res);
    // } else {
    //   Get.snackbar(
    //     "",
    //     "",
    //     titleText: Text(
    //       "تنبيه",
    //       textDirection: TextDirection.rtl,
    //     ),
    //     messageText: Text(
    //       "يجب ادخال اسم المستخدم",
    //       textDirection: TextDirection.rtl,
    //     ),
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //   );
    // }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/Crud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class RolesController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  ScrollController _scrollController = ScrollController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int selectedIndex = 0;

  void changeSeletedIndex(int newIndex) {
    selectedIndex = newIndex;
    update();
  }
 Future <dynamic>addRoles() async {
    var url = Uri.parse(rolesRoom);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "username":userNameController.text.trim(),
      "password":passwordController.text.trim(),
      //بيبعت كل حاجة لربيع ماعدا الحتة البضاان دى بيبعتلة كل حاجة ماعدا role
      //"roleType":selectedIndex,
    });
    final dataBody = json.decode(response.body);
    if (dataBody['status'] == "success") {
      Get.defaultDialog();
      update();
     // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainView()));
    } else {
      print("signup fail");
    }
  }

// void changePageColor(){
//   switch ( pageIndex <= pageIndex1) {
//     case Color(0xFFFABD63);
//   else {
//     pageIndex1 = 0;
//   }
//
// }}
}
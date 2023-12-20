import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class MainControllerPanelController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  final ScrollController _scrollController = ScrollController();
  bool passwordVisibility = false;
  int selectedIndex = 0;
  int alertIndex = 0;
  bool isLoading = true;
  var data;
  bool pageIndex = true;
  String ?roomId;
  List listOfRoles = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    await getData();
    getRoles();

    isLoading = true;
  }

  Future getData() async {
    var url = Uri.parse(roomInfoUser);
    var response = await http.post(url, body: {
      "username": mobileUserName,
    });
    if (response.statusCode == 200) {
      final dataBody = json.decode(response.body);
      data = dataBody["data"];
      print(dataBody["data"]);
      isLoading = false;
      roomId = dataBody["data"][0]["room_id"].toString();

      update();
      // roles.add(data["data"])
      // print(json.decode(response.body));
    }
  }

  getRoles() async {
    // print();
    listOfRoles.clear();
    var url = Uri.parse(listRoles);
    var response = await http.post(url, body: {
      "roomId": roomId.toString(),
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // for (var element in data["data"]) {
      //   roles.add(element);
      //   print(element["username"]);
      // }
      for (var i = 0; i < data["data"].length; i++) {
        listOfRoles.add(data["data"][i]);
      }
      print(data["data"]);
      listOfRoles.add(data["data"]);
      update();
      for (var e in listOfRoles) {
        print(e);
      }
    } else {
      // return null;
    }
  }

  void changeIndex(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update();
  }
}

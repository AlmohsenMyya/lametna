import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../userData/variables.dart';

class AlmohsenSearchController extends GetxController {
  var list = ["المستخدمين", "الغرف الكتابية", "الكل"];
  TextEditingController searchController = TextEditingController();
  var data;

  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    // print(index);
    searchController.text = "";
    data = null;
    update();
  }

  search() async {
    if (selectedIndex == 0) {
      searchUser();
      print("user");
    } else if (selectedIndex == 1) {
      searchRoom();
      print("room");
    } else {
      print("all");
    }
  }

  Future searchUser() async {
    var url = Uri.parse(userSearch);
    var response = await http.post(url, body: {
      "search": searchController.text.trim(),
    });
    final dataBody = json.decode(response.body);
    if (dataBody['status'] == "success") {
      // print(dataBody);

      for (var i = 0; i < dataBody["data"].length; i++) {
        print(dataBody["data"][i]["username"]);
      }
      // return dataBody;
      data = dataBody;
      update();

      print("success222");
    } else {
      print("error");
    }
  }

  Future searchRoom() async {
    var url = Uri.parse(roomSearch);
    var response = await http.post(url, body: {
      "search": searchController.text.trim(),
    });
    final dataBody = json.decode(response.body);
    if (dataBody['status'] == "success") {
      print(dataBody);

      // for (var i = 0; i < dataBody["data"].length; i++) {
      //   print(dataBody["data"][i]["username"]);
      // }
      // return dataBody;
      data = dataBody;
      update();

      print("success3333");
    } else {
      print("error");
    }
  }
}

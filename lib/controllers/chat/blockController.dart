// ignore_for_file: use_function_type_syntax_for_parameters

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/variables.dart';

class BlockController extends GetxController {
  // get blocked user with streamBuilder

  var data;
  int currentIndex = 1;
  String roomId;

  PageController pageController = PageController();
  var searchController = TextEditingController();
  String searchValue = "";

  @override
  Future<void> onInit() async {
    super.onInit();
    // update();
    roomId = Get.arguments["room_id"];
  }

  getBlockedUsers() async {
    var res = await http.post(Uri.parse(viewBannedUsers), body: {
      "roomId": roomId,
    });
    var dataBody = json.decode(res.body);

    print(dataBody);

    return dataBody["data"];
    // update();

    // get blocked users from firebase
    // streamController.add();
  }

  changeIndex(int index) {
    currentIndex = index;
    pageController.animateToPage(index - 1, duration: Duration(milliseconds: 500), curve: Curves.ease);
    update();
  }

  Future<void> removeBan(
    String name,
  ) async {
    var req = await http.post(Uri.parse(removeBanUser), body: {
      "roomId": roomId,
      "username": name,
    });
    var dataBody = json.decode(req.body);
    // print(dataBody);
    if (req.statusCode == 200) {
      // getBlockedUsers(
      update();
      print("sucess");
    }
  }

  updateSearchValue() {
    searchValue = searchController.text;

    update();
    print(searchValue);
  }

  getBannedCountry() async {
    var req = await http.post(Uri.parse(viewBannedCountry), body: {
      "roomId": roomId,
    });
    var dataBody = json.decode(req.body);
    // print(dataBody);
    if (req.statusCode == 200) {
      // getBlockedUsers(
      // update();
      print("sucess");
    }
    return dataBody["data"];
  }

  countryBan({String countryEn, String countryAr, String countryCode}) async {
    var req = await http.post(Uri.parse(banCountry), body: {
      "roomId": roomId,
      "countryEn": countryEn,
      "countryAr": countryAr,
      "countryCode": countryCode,
    });
    var dataBody = json.decode(req.body);
    // print(dataBody);

    if (req.statusCode == 200) {
      // getBlockedUsers(
      // update();
      print("sucess");
      print(dataBody);
      Get.back();
      getBannedCountry();
      update();
    }
  }

  deleteBannedCountry(String id) async {
    var req = await http.post(
      Uri.parse(removeBanCountry),
      body: {
        "banCountryId": id,
      },
    );
    var dataBody = json.decode(req.body);
    if (req.statusCode == 200) {
      print("sucess");
      getBannedCountry();
      update();
    }
  }
}

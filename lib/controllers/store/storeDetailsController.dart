// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/variables.dart';

class StoreDetailsController extends GetxController {
  int selectedPage = 1;
  int roomIndex = 0;
  int namesIndex = 0;
  int vipIndex = 0;

  PageController pageController = PageController();
  PageController upperSectionController = PageController();

  PageController roomController = PageController();
  PageController roomUpperSectionController = PageController();

  PageController namesController = PageController();
  PageController namesUpperSectionController = PageController();

  PageController vipController = PageController();
  PageController vipUpperSectionController = PageController();

  // StreamController framesController = StreamController();

  String roomType = "مميزة";
  String roomTime = "شهر";
  String country = "مصر";

  String selectedFrameImage = "";
  String selectedFramePrice = "";

  String selectedEntryImage = "";
  String selectedEntryPrice = "";

  var framesList;
  var entriesList;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await frames();
    await enties();
    // Timer.periodic(Duration(milliseconds: 50), (timer) {
    //   update();
    // });
    // print(Get.arguments["selectedPage"]);
    // if (Get.arguments["selectedPage"] != null) {
    //   changeSelectedPage(Get.arguments["selectedPage"]);
    //   print("not null");
    //   // pageController.jumpToPage(selectedPage - 1);
    //   // upperSectionController.jumpToPage(selectedPage - 1);
    // }
  }

  @override
  void onClose() {
    // framesController.close();
  }

  void changeSelectedPage(int index) {
    selectedPage = index;
    pageController.jumpToPage(index - 1);
    upperSectionController.jumpToPage(index - 1);
    roomIndex = 0;
    namesIndex = 0;
    vipIndex = 0;
    update();
  }

  void changeRoomIndex(int index) {
    roomIndex = index;
    roomController.jumpToPage(index);
    roomUpperSectionController.jumpToPage(index);
    update();
  }

  void changeNamesIndex(int index) {
    namesIndex = index;
    namesController.jumpToPage(index);
    namesUpperSectionController.jumpToPage(index);
    // namesUpperSectionController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    update();
  }

  void changeVipIndex(int index) {
    vipIndex = index;
    vipController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    vipUpperSectionController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    update();
  }

  void updateRoomType(String newValue) {
    roomType = newValue;
    update();
  }

  void updateRoomTime(String newValue) {
    roomTime = newValue;
    update();
  }

  void updateCountry(String newValue) {
    country = newValue;
    update();
  }

  updateSelectedFrameImage(String newValue, String price) {
    selectedFrameImage = newValue;
    selectedFramePrice = price;
    update();
    print(selectedFrameImage);
  }

  updateSelectedEntryImage(String newValue, String price) {
    selectedEntryImage = newValue;
    selectedEntryPrice = price;
    update();
    print(selectedEntryImage);
  }

  frames() async {
    try {
      var url = Uri.parse(getFrames);
      var response = await http.post(url);
      final dataBody = json.decode(response.body);
      // print(dataBody);
      // framesController.sink.add(dataBody['data']);
      framesList = dataBody['data'];
      // return dataBody['data'];
    } catch (e) {
      print(e);
    }
  }

  enties() async {
    try {
      var url = Uri.parse(getEntries);
      var response = await http.post(url);
      final dataBody = json.decode(response.body);
      // print(dataBody);
      // framesController.sink.add(dataBody['data']);
      entriesList = dataBody['data'];
      // return dataBody['data'];
    } catch (e) {
      print(e);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ChatHomeController extends GetxController {
  PageController pageController = PageController();
  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
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

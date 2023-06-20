import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  int selectedIndex = 0;
  PageController scrollController = PageController();

  void changeIndex(int index) {
    selectedIndex = index;
    scrollController.jumpToPage(index);

    print("object");
    update();
  }

  void changeAlertIndex(int index) {
    // alertIndex = index;
    scrollController.jumpToPage(index);
    update();
  }
}

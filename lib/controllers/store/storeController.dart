import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class StoreController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;
  int alertIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    // pageController.jumpToPage(index);
    update();
  }
}

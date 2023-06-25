import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class RolesController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;

  void changeSeletedIndex(int newIndex) {
    selectedIndex = newIndex;
    update();
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
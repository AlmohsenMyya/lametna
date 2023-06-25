import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class RolesController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;
  int alertIndex = 0;
  int pageIndex;
  int pageIndex1=1;
  int pageIndex2=2;
  int pageIndex3=3;
  var isIcon1Highlighted = false.obs;
  var isIcon2Highlighted = false.obs;

  void changeIconColors() {

  }
  // void changePageColor(){
  //   switch ( pageIndex <= pageIndex1) {
  //     case Color(0xFFFABD63);
  //   else {
  //     pageIndex1 = 0;
  //   }
  //
  // }}

  void changeIndex(int index) {
    selectedIndex = index;
    isIcon1Highlighted.value = !isIcon1Highlighted.value;
    isIcon2Highlighted.value = !isIcon2Highlighted.value;

    update();
  }
}
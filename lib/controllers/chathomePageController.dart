import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ChatHomeController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  ScrollController _scrollController = ScrollController();

  // KeyboardVisibilityNotification().addNewListener(
  //   onChange: (bool visible) {
  //     if(visible){
  //       final offset = _scrollController.offset;
  //       print("current offset = ${offset}");
  //       _scrollController.animateTo(
  //           offset+50.0,
  //           duration: Duration(milliseconds: 100),
  //           curve: Curves.easeIn);
  //     }else{
  //       final offset = _scrollController.offset;
  //       print("current offset = ${offset}");
  //       _scrollController.animateTo(
  //           offset-50.0,
  //           duration: Duration(milliseconds: 100),
  //           curve: Curves.easeIn);

  //     }
  //   },
  // );

  int selectedIndex = 0;
  int alertIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  void changeAlertIndex(int index) {
    alertIndex = index;
    alertPageController.jumpToPage(index);
    update();
  }

  void resetAlertIndex() {
    alertIndex = 0;
    alertPageController.jumpToPage(0);
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

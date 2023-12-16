import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lametna/view/chatHomePage.dart';
import 'package:lametna/view/messages/messages.dart';
import '../view/chat/moments/moments.dart';
import 'userData/userCredentials.dart';
import 'package:lametna/view/store/test.dart';
import 'package:get/get.dart';

class BottomNavitionBarController extends GetxController {
  bool isShow = true;
  int currentIndex = 0;
  int selectedIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  void changeShow() {
    isShow = !isShow;
    update();
  }

  List<Widget> pages = <Widget>[
    const ChatHomePage(),
    Moments(appBar: 1),
    // Get.toNamed()
    // Container(),
    if(isGuest == false && isRole == false)  Messages() ,
    test(),
    // Container()
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}

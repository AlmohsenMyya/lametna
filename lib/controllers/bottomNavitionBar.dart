import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lametna/view/chat/moments.dart';
import 'package:lametna/view/chatHomePage.dart';
import 'package:lametna/view/messages/messages.dart';
import 'userData/userCredentials.dart';
import 'package:lametna/view/store/test.dart';

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
    ChatHomePage(),
    // Moments(),
    Container(),
    !isGuest ? Messages() : null,
    test(),
    // Container()
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomsSettingPageController extends GetxController {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  int sliderValue = 0;
  Color pickerColor = Colors.black;
  bool roomStatus = false;
  TextEditingController hexaInputController = TextEditingController();

  void updatePickerColor(Color color) {
    pickerColor = color;
    update();
    // print(fontColor);
  }

  void changeRoomStatus() {
    roomStatus = !roomStatus;
    update();
    // print(roomStatus);
  }

  void updateSliderValue(double value) {
    sliderValue = value.toInt();
    update();
    // print(sliderValue);
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      isSwitched = true;
      textValue = 'Switch Button is ON';
      update();
      print('Switch Button is ON');
    } else {
      isSwitched = false;
      textValue = 'Switch Button is OFF';
      update();
      print('Switch Button is OFF');
    }
  }

  String _site = "male";
  bool value = false;
  void RadioStatus() {
    _site = value as String;
    update();
  }
}

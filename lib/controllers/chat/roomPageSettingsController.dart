// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class RoomsSettingPageController extends GetxController {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  int sliderValue = 21;
  Color pickerColor = Colors.black;
  bool roomStatus = false;
  TextEditingController hexaInputController = TextEditingController();
  bool isBold = false;
  bool isItalic = false;

  @override
  onInit() {
    super.onInit();
    getSettings();
  }

  // @override
  // Future<void> onDelete() async {
  //   // TODO: implement onClose

  //   super.onDelete();
  // }
  @override
  Future<void> onClose() async {
    // TODO: implement onClose
    sendFontSize();
    // await changeFontColor("#" + pickerColor.toString().substring(10, 16));
    super.onClose();
  }

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

  sendFontSize() async {
    var url = Uri.parse(fontSize);
    await http.post(url, body: {
      'username': mobileUserName,
      'fontSize': sliderValue.toString(),
    });

    print(sliderValue);
  }

  getSettings() async {
    var url = Uri.parse(getFontSettings);
    var res = await http.post(url, body: {
      'username': mobileUserName,
    });
    var data = json.decode(res.body);
    sliderValue = int.parse(data["data"][0]["fontSize"]);
    isBold = data["data"][0]["isBold"] == "1" ? true : false;
    isItalic = data["data"][0]["isItalic"] == "1" ? true : false;
    pickerColor = Color(
        int.parse(data["data"][0]["color"].substring(1, 7), radix: 16) +
            0xFF000000);
    update();
    // print();
  }

  changeBold() async {
    var url = Uri.parse(toggleBold);
    await http.post(url, body: {
      'username': mobileUserName,
    });
    isBold = !isBold;
    update();
  }

  changeItalic() async {
    var url = Uri.parse(toggleItalic);
    await http.post(url, body: {
      'username': mobileUserName,
    });
    isItalic = !isItalic;
    update();
  }

  changeFontColor() async {
    var url = Uri.parse(changeFontColorUrl);
    await http.post(url, body: {
      'username': mobileUserName,
      'color': ("#" + pickerColor.toString().substring(10, 16)),
    });
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';

class ControlPanelController extends GetxController {
  int selectedPage = 0;
  PageController pageController = PageController();

  //room tab
  PageController roomController = PageController();
  TextEditingController roomPasswordController = TextEditingController();
  TextEditingController roomCodeController = TextEditingController();
  var categories = ["الرئيسية", "الغرف", "الأسماء", "الروتات", "المشتريات", "المستخدمين", "المحظورين", "المحظورين", "سجل الغرف", "سجل الغرف"];

  updateSelectedPage(int index) {
    selectedPage = index;
    pageController.jumpToPage(index);
    // if (index != 1) {
    //   roomController.jumpToPage(0);
    // }
    FocusScope.of(Get.context!).unfocus();
    update();
  }

  getRooms() async {
    var request = await http.post(Uri.parse(controlPanelRoomInfo), body: {
      'ownerUser': mobileUserName,
    });
    var res = json.decode(request.body);
    print(res);
    return res["data"];
  }

  jumpage() {
    roomController.jumpToPage(1);
  }

  updateRoomPassword() async {
    print("object");
    if (roomCodeController.text.isNotEmpty && roomPasswordController.text.length > 8) {
      var request = await http.post(Uri.parse(controlPanelUpdatePassword), body: {
        "roomId": roomCodeController.text.trim(),
        'password': roomPasswordController.text,
        "roomOwner": mobileUserName,
      });
      var res = json.decode(request.body);
      print(res);
      if (res["status"] == "success") {
        roomPasswordController.clear();
        roomCodeController.clear();
        // Get.snackbar("تم", "تم تغيير كلمة المرور بنجاح", backgroundColor: Colors.green, colorText: Colors.white);
        showDialog(
            context: Get.context!,
            builder: (context) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop(true);
              });
              return const AlertDialog(
                title: Text('Title'),
              );
            });
      } else {
        Get.snackbar("خطأ", "حدث خطأ ما", backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
    //   var request = await http.post(Uri.parse(controlPanelRoomInfo), body: {
    //     "roomId":"",
    //   'password': userName,
    // });
    // var res = json.decode(request.body);
    // roomController.jumpToPage(1);
  }
}

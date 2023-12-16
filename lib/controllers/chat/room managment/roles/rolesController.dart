// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors, use_build_context_synchronously, avoid_print, depend_on_referenced_packages, unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/room%20managment/accountMangementController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/Crud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class RolesController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedMasterType = "ماستر";
  var selectedIndex = 0;
  bool isLock = false;
  var icons = [
    {"text": "مسح النص للجميع", "icon": Icons.cleaning_services, "val": 1, "isActive": false},
    {"text": "دور المايك", "icon": Icons.mic, "val": 1, "isActive": false},
    {"text": "طرد", "icon": Icons.star, "val": 1, "isActive": false},
    {"text": "ايقاف", "icon": Icons.highlight_remove, "val": 1, "isActive": false},
    {"text": "حظر الجهاز", "icon": Icons.not_interested, "val": 1, "isActive": false},
    {"text": "ادارة ممبر", "icon": Icons.person, "val": 3, "isActive": false},
    {"text": "ادارة الحسابات", "icon": Icons.group, "val": 3, "isActive": false},
    {"text": "سجل الخروج", "icon": Icons.sensor_door_outlined, "val": 2, "isActive": false},
    {"text": "الغاء الحظر", "icon": Icons.reply, "val": 2, "isActive": false},
    {"text": "رسالة عامة", "icon": Icons.email, "val": 1, "isActive": false},
    {"text": "تقارير المشرفين", "icon": Icons.sticky_note_2_outlined, "val": 3, "isActive": false},
    {"text": "اعدادات الغرفة", "icon": Icons.settings, "val": 3, "isActive": false},
    {"text": "ادارة ماستر", "icon": Icons.person, "val": 3, "isActive": false},
    {"text": "ادارة سوبر ادمن", "icon": Icons.person, "val": 3, "isActive": false},
    {"text": "ادارة ادمن", "icon": Icons.person, "val": 3, "isActive": false},
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // passwordController.text = Get.arguments["password"];
  }

  void changeSeletedIndex(int newIndex) {
    selectedIndex = newIndex;
    for (var i = 0; i < icons.length; i++) {
      if (newIndex >= (icons[i]["val"]as num)) {
        icons[i]["isActive"] = true;
      } else {
        icons[i]["isActive"] = false;
      }
    }
    update();
  }

  void changeIconColor(int index) {
    icons[index]["isActive"] = !(icons[index]["isActive"] as bool);
    update();
  }

  void toggleLock() {
    isLock = !isLock;
    update();
  }

  Future<dynamic> addRoles(BuildContext context) async {
    var url = Uri.parse(rolesRoom);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "username": userNameController.text.trim(),
      "password": passwordController.text.trim(),
      "roleType": selectedIndex.toString(),
      "deleteChat": icons[0]["isActive"] == true ? "1" : "0",
      "mic": icons[1]["isActive"] == true ? "1" : "0",
      "kick": icons[2]["isActive"] == true ? "1" : "0",
      "stop": icons[3]["isActive"] == true ? "1" : "0",
      "banDevice": icons[4]["isActive"] == true ? "1" : "0",
      "memberMangment": icons[5]["isActive"] == true ? "1" : "0",
      "accountMangment": icons[6]["isActive"] == true ? "1" : "0",
      "logRecord": icons[7]["isActive"] == true ? "1" : "0",
      "removeBan": icons[8]["isActive"] == true ? "1" : "0",
      "publicmessage": icons[9]["isActive"] == true ? "1" : "0",
      "adminReport": icons[10]["isActive"] == true ? "1" : "0",
      "roomSettings": icons[11]["isActive"] == true ? "1" : "0",
      "masterMangment": icons[12]["isActive"] == true ? "1" : "0",
      "superAdminMangment": icons[13]["isActive"] == true ? "1" : "0",
      "adminMangment": icons[14]["isActive"] == true ? "1" : "0",
      "isLocked": isLock == true ? "1" : "0",
    });
    update();
    FocusScope.of(context).unfocus();
    final dataBody = json.decode(response.body);
    if (dataBody['status'] == "success") {
      await Get.put(AccountMangementController()).getRoles();
      showAlert(context);
      print("object");
      update();
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainView()));
    } else {
      print("error");
      Get.snackbar("", "",
          titleText: Text(
            "خطأ",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, fontFamily: "Portada"),
          ),
          messageText: Text(
            "الرجاء ادخال اسم مستخدم اخر",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, fontFamily: "Portada"),
          ),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  changeSelectedMasterType(String newType) {
    selectedMasterType = newType;
    if (newType == "ماستر") {
      changeSeletedIndex(3);
    } else {
      changeSeletedIndex(4);
    }
    update();
  }

  void showAlert(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              title: SizedBox(
                height: 183.h,
                width: 387.w,
                child: Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      Icons.check_box_outlined,
                      size: 50.sp,
                      color: Colors.green,
                    ),
                    Text(
                      "تم إضافة الحساب بنجاح",
                      style: TextStyle(
                        color: Color(0xff2ABC42),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Segoe UI",
                      ),
                    ),
                  ]),
                ),
              ));
        });
  }
}

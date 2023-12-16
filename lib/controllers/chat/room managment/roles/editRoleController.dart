import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lametna/controllers/Crud.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/view/store/storeDetails.dart';

class EditRolesController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedMasterType = "ماستر";
  var selectedIndex = 0;
  bool isLock = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userNameController.text = Get.arguments["data"]["username"];
    passwordController.text = Get.arguments["data"]["password"];
    selectedIndex = int.parse(Get.arguments["data"]["roleType"]);
    if (Get.arguments["data"]["roleType"].toString() == "3") {
      selectedMasterType = "ماستر";
    } else if (Get.arguments["data"]["roleType"].toString() == "4") {
      selectedMasterType = "زهري";
    }
    [
      "deleteChat",
      "mic",
      "kick",
      "stop",
      "banDevice",
      "memberMangment",
      "accountMangment",
      "logRecord",
      "removeBan",
      "publicmessage",
      "adminReport",
      "roomSettings",
      "masterMangment",
      "superAdminMangment",
      "adminMangment",
    ].mapIndexed((e, i) => icons[i]["isActive"] = Get.arguments["data"][e] == "1" ? true : false).toList();
    update();
    print(Get.arguments["data"]["username"]);
    print("object");
  }

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

  void changeSeletedIndex(int newIndex) {
    selectedIndex = newIndex;
    for (var i = 0; i < icons.length; i++) {
      if (newIndex >= (icons[i]["val"] as num)) {
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

  Future<dynamic> updateRoles() async {
    print(passwordController.text.trim());
    var url = Uri.parse('https://lametnachat.com/users/updateRoomRole.php');

    var response = await http.post(url, body: {
      "id": Get.arguments["data"]["id"].toString(),
      "roomId": Get.arguments["data"]["roomId"].toString(),
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
    });
    // update();
    FocusScope.of(Get.context!).unfocus();
    final dataBody = json.decode(response.body);
    print(dataBody);
    if (dataBody['status'] == "success") {
      // await Get.put(AccountMangementController()).update();
      // showAlert(Get.context);
      print("object");
      // update();
      Get.back();
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainView()));
    } else {
      print("error");
      Get.snackbar("", "",
          titleText: Text(
            "خطأ",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          messageText: Text(
            "الرجاء ادخال اسم مستخدم اخر",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
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
          Future.delayed(const Duration(seconds: 2), () {
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
                        color: const Color(0xff2ABC42),
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

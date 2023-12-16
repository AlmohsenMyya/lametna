// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountMangementController extends GetxController {
  List roles = [];
  int index = 0;
  String roomId = Get.arguments["room_id"];
  String selectedMasterType = "ماستر";

  @override
  void onInit() {
    super.onInit();
    getRoles();
    roomId = Get.arguments["room_id"];
  }

  getRoles() async {
    // print();
    roles.clear();
    var url = Uri.parse(listRoles);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // for (var element in data["data"]) {
      //   roles.add(element);
      //   print(element["username"]);
      // }
      for (var i = 0; i < data["data"].length; i++) {
        roles.add(data["data"][i]);
      }
      print(data["data"]);
      // roles.add(data["data"]);
      update();
      // print(json.decode(response.body));

      // return json.decode(response.body);
    } else {
      // return null;
    }
  }

  void changeSeletedIndex(int index) {
    this.index = index;
    update();
  }

  void deleteAlert(String name, int index) {
    Get.defaultDialog(
      title: 'هل تريد حذف حساب ${name}',
      titleStyle: TextStyle(
        fontSize: 15.sp,
        fontFamily: 'Portada',
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                )),
            onPressed: () {
              Get.back();
            },
            child: Text(
              'إلغاء',
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Portada',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                )),
            onPressed: () {
              delete(name, index);
              // print(roomId);
            },
            child: Text(
              'تأكيد الحذف',
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Portada',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  delete(String name, int index) async {
    var url = Uri.parse(deleteRole);
    print(roomId);
    var res = await http.post(url, body: {
      "roomId": roomId,
      "username": name,
    });
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      print(data);
      Get.back();

      print("object");
      roles.removeAt(index);
      update();
      // getRoles();
    }
  }

  checkIfCanAddRole() async {
    if (true) {
      // print("owner");
      print(Get.arguments["owner"]);
      Get.toNamed('/roles', arguments: {
        "room_id": Get.arguments["room_id"],
        "color": Get.arguments["color"],
      });
    } else {
      var url = Uri.parse(addMaster);
      var res = await http.post(url, body: {
        "roomId": roomId,
      });
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        // print();
        if (data["allowAddMaster"] == "true") {
          print("cant add");
          Get.snackbar("تنبية", "لا يمكنك اضافة مشرفين لهذه الغرفة");
        } else {
          Get.toNamed('/roles', arguments: {
            "room_id": Get.arguments["room_id"],
            "color": Get.arguments["color"],
          });
        }
      }
      print("not owner");
      print(Get.arguments["roomOwner"]);
    }
  }

  toggleLock(String roleId) async {
    var url = Uri.parse(toggleIsLocked);
    var res = await http.post(url, body: {
      "id": roleId,
    });
    print("object");
    if (res.statusCode == 200) {
      // final data = json.decode(res.body);
      // print(data);
      getRoles();
    }
  }

  changeSelectedMasterType(String s) {
    selectedMasterType = s;
    if (s == "ماستر") {
      // print("master");
      changeSeletedIndex(4);
    } else if (s == "زهري") {
      // print("super");
      changeSeletedIndex(5);
    }
    update();
  }
}

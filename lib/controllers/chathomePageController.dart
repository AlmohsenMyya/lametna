// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/view/chatHomePage.dart';

class ChatHomeController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  TextEditingController guestController = TextEditingController();
  TextEditingController roleUsernameController = TextEditingController();
  TextEditingController rolePasswordController = TextEditingController();
  // TextEditingController Controller = TextEditingController();
  List vipRooms = [];
  List regularRooms = [];
  List favoriteRooms = [];
  Crud crud = Crud();
  int selectedIndex = 0;
  int alertIndex = 0;
  int roomNumber = 0;
  int numberOfConnections = 0;
  List banedUsers = [];

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

  @override
  void onInit() {
    super.onInit();
    fetchAllRooms();
    getFavourites();
    isRole = false;
  }

  void changeIndex(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  getFavourites() async {
    var url = Uri.parse(viewFavoriteRooms);
    var response = await http.post(url, body: {
      "username": userName,
    });
    final databody = json.decode(response.body);
    // update();
    // if (databody["data"].length == 0) {
    //   noFavourites = true;
    // }
    for (var i = 0; i < databody["data"].length; i++) {
      // favouriteRooms.add(databody["data"][i]);
      // print();

      favoriteRooms.add(databody["data"][i]["roomId"]);
    }
    update();

    // return databody;
  }

  Future<void> fetchAllRooms() async {
    // rooms = await _roomService.getAllRooms();
    regularRooms.clear();
    vipRooms.clear();
    var response = await crud.get(getRooms);
    print("data fetched room");
    print(response["data"][3]);
    if (response["status"] == "success") {
      // rooms = respose["data"];
      // response = json.decode(response);
      roomNumber = response["data"].length;

      for (var item in response["data"]) {
        // print(item["number_of_connections"]);
        numberOfConnections += int.parse(item["number_of_connections"]);
        if (item["room_type"] == "vip") {
          vipRooms.add(item);
        } else {
          regularRooms.add(item);
        }
      }

      update();

      print(vipRooms[3]);
    }
  }

  addOrRemoveToFavourite(String roomId) async {
    var url = Uri.parse(favoriteRoom);
    var response = await http.post(
      url,
      body: {
        "username": userName,
        "roomId": roomId,
      },
    );
    // print(dataBody);
    if (favoriteRooms.contains(roomId)) {
      favoriteRooms.remove(roomId);
    } else {
      favoriteRooms.add(roomId);
    }
    update();
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      print(res);
      print("---------");
      //get snackbar with right arabic right to left

      Get.snackbar(
        "",
        "",
        titleText: Text(
          "تنبيه",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),
        ),
        messageText: Text(
          "تمت العملية بنجاح",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),
        ),
        backgroundColor: Colors.green,
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  loginRoleAccount(String roomId, String owner, String roomName) async {
    print("role");
    FocusScope.of(Get.context).unfocus();

    if (roleUsernameController.text.trim().isEmpty ||
        rolePasswordController.text.trim().isEmpty) {
      // print("empty");
      Get.snackbar(
        "",
        "",
        titleText: Text(
          "تنبيه",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),
        ),
        messageText: Text(
          "من فضلك ادخل اسم المستخدم أو كلمة المرور",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),
        ),
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } else {
      print(roomId);
      var url = Uri.parse(loginRole);
      var response = await http.post(
        url,
        body: {
          "roomId": roomId,
          "username": roleUsernameController.text.trim(),
          "password": rolePasswordController.text,
        },
      );
      final databody = json.decode(response.body);
      print(databody);

      if (databody["status"] == "success") {
        //role
        print("login");
        userName = roleUsernameController.text.trim();
        isRole = true;
        isGuest = false;
        roleType = databody["data"]["roleType"].toString();
        // print(roleType);
        if (userName.isNotEmpty) {
          Get.toNamed('/room', arguments: {
            "room_name": roomName,
            "room_id": roomId,
            "owner": owner,
          });
        } else if (isGuest) {
          showAlert(Get.context, roomId, roomName, owner);
        }
      } else {
        Get.snackbar(
          "",
          "",
          titleText: Text(
            "تنبيه",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo",
            ),
          ),
          messageText: Text(
            "اسم المستخدم أو كلمة المرور غير صحيحة",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo",
            ),
          ),
          backgroundColor: Colors.red,
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
      roleUsernameController.text = "";
      rolePasswordController.text = "";
    }
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

  removeBannedUser(String id, String username) async {
    var url = Uri.parse(removeBanUser);
    await http.post(url, body: {
      "roomId": id,
      "username": username,
    });
  }

  checkIfBanned(String roomId, String owner, String roomName) async {
    // viewBannedUsers
    var url = Uri.parse(viewBannedUsers);
    var response = await http.post(
      url,
      body: {
        // "username": userName,
        "roomId": roomId,
      },
    );
    var res = json.decode(response.body);
    print(res);
    if (response.statusCode == 200) {
      for (var e in res["data"]) {
        if (e["username"] == userName &&
            !DateTime.parse(e["endTime"])
                .difference(DateTime.now())
                .isNegative) {
          // banedUsers.add(e["username"]);
          print("banned");
          Get.defaultDialog(
              // title: "تنبيه",
              title: "لقد تم حظرك من هذه الغرفة",
              titleStyle: TextStyle(
                  color: Colors.black, fontFamily: "Portada", fontSize: 12.sp),
              middleText: DateTime.parse(e["endTime"])
                          .difference(DateTime.now())
                          .inDays >
                      0
                  ? "متبقي " +
                      DateTime.parse(e["endTime"])
                          .difference(DateTime.now())
                          .inDays
                          .toString() +
                      " ايام"
                  : "متبقي " +
                      DateTime.parse(e["endTime"])
                          .difference(DateTime.now())
                          .inMinutes
                          .toString() +
                      " دقائق",
              middleTextStyle: TextStyle(
                  color: Colors.black, fontFamily: "Portada", fontSize: 12.sp),
              confirm: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "حسنا",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Portada",
                      fontSize: 12.sp),
                ),
              ));
          return;
        }
      }
      removeBannedUser(roomId, userName);

      print("not banned");
      if (userName.isNotEmpty) {
        Get.toNamed('/room', arguments: {
          "room_name": roomName,
          "room_id": roomId,
          "owner": owner,
        });
      } else if (isGuest) {
        showAlert(Get.context, roomId, roomName, owner);
      }
    }
  }

  loginAsGuest(String roomName, String roomId) async {
    print("guest-${guestController.text.trim()}${Random().nextInt(9999)}");

    if (guestController.text.isEmpty) {
      // print("empty");
      Get.snackbar(
        "",
        "",
        titleText: Text(
          "تنبيه",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),
        ),
        messageText: Text(
          "من فضلك ادخل اسم المستخدم",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "Cairo",
          ),
        ),
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } else {
      userName =
          "${guestController.text.trim()}${Random().nextInt(999999).toString().substring(0, 3)}";
      isRole = false;
      isGuest = true;
      // isRole = false;
      update();
      Get.toNamed('/room', arguments: {
        "room_name": roomName,
        "room_id": roomId,
      });
    }
  }
}

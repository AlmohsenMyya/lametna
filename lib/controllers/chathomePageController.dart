// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, depend_on_referenced_packages, unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/view/chat/roomPage.dart';
import 'package:lametna/view/chatHomePage.dart';

import 'package:get_ip_address/get_ip_address.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:get_mac_address/get_mac_address.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoder/geocoder.dart';

// import 'package:mac_address/mac_address.dart';

import 'package:lametna/view/VIPRoombuildder.dart';

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
  final String _platformVersion = 'Unknown';
  Timer ?timer;

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
    determinePosition();

    isRole = false;
  }

  void changeIndex(int index) {
    selectedIndex = index;
    // pageController.jumpToPage(index);
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

  loginRoleAccount({required String roomId, required String roomName, required String welcomeText}) async {
    print("role");
    FocusScope.of(Get.context!).unfocus();
    Get.back();
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "... برجاء الانتظار ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    var device = DeviceInfoPlugin();
    // determinePosition();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
Placemark addresses = placemarks[0];

    
    String country = addresses.country!;

    String? id = await getId();
    var ip = IpAddress(type: RequestType.json);
    dynamic ipAddress = await ip.getIpAddress();

    if (roleUsernameController.text.trim().isEmpty || rolePasswordController.text.trim().isEmpty) {
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
      Get.back();
      var url = Uri.parse(loginRole);
      var response = await http.post(
        url,
        body: {
          "roomId": roomId,
          "userName": roleUsernameController.text.trim(),
          "password": rolePasswordController.text,
          "macAddress": await getId(),
          "country": country.toString(),
          // "ipAddress": ipAddress["ip"],
        },
      );
      final databody = json.decode(response.body);
      print(databody);
      if (databody["status"] == "success") {
        print("login");
        print(databody);
        userName = roleUsernameController.text.trim();
        isRole = true;
        isGuest = false;
        roleType = databody["data"]["roleType"].toString();
        deleteChat = databody["data"]["deleteChat"] == "1" ? true : false;
        mic = databody["data"]["mic"] == "1" ? true : false;
        kick = databody["data"]["kick"] == "1" ? true : false;
        stop = databody["data"]["stop"] == "1" ? true : false;
        banDevice = databody["data"]["banDevice"] == "1" ? true : false;
        accountMangment = databody["data"]["accountMangment"] == "1" ? true : false;
        logRecord = databody["data"]["logRecord"] == "1" ? true : false;
        removeBan = databody["data"]["removeBan"] == "1" ? true : false;
        publicmessage = databody["data"]["publicmessage"] == "1" ? true : false;
        adminReport = databody["data"]["adminReport"] == "1" ? true : false;
        roomSettings = databody["data"]["roomSettings"] == "1" ? true : false;
        memberMangment = databody["data"]["memberMangment"] == "1" ? true : false;
        masterMangment = databody["data"]["masterMangment"] == "1" ? true : false;
        superAdminMangment = databody["data"]["superAdminMangment"] == "1" ? true : false;
        adminMangment = databody["data"]["adminMangment"] == "1" ? true : false;
        // roleType = databody["data"]["roleType"].toString();
        // print(roleType);
        // if (userName.isNotEmpty) {
        Get.toNamed(
          '/room',
          arguments: {
            "room_id": roomId,
            "username": userName,
          },
        );
        // } else if (isGuest) {
        //   showAlert(Get.context!, roomId: roomId, roomName: roomName, welcomeText: welcomeText);
        // }
      } else if (databody["status"] == "success") {
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
            ),
          ),
          messageText: Text(
            databody["message"],
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
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

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> checkIfBanned({required String roomId, required String username}) async {
    // viewBannedUsers
    // alertMessage("message");
    // return
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "... برجاء الانتظار ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    var device = DeviceInfoPlugin();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  Placemark addresses = placemarks[0];

    
    String? id = await getId();
    var ip = IpAddress(type: RequestType.json);
    dynamic ipAddress = await ip.getIpAddress();
    String country = addresses.country!;

    // getCurrentPosition();

    // getLocation();

    var url = Uri.parse(checkUserBan);

    var res = await http.post(
      url,
      body: {
        "username": username,
        "roomId": roomId,
        "macAddress": await getId(),
        "country": country.toString(),
        "ipAddress": ipAddress["ip"],
      },
    );
    var data = json.decode(res.body);
    print(data);
    // print(res);
    if (res.statusCode == 200) {
      if (data["status"] == "success") {
        Get.back();
        roleType = "";
        print(data);
        if (data["isAdmin"] == "true") {
          deleteChat = true;
          mic = true;
          kick = true;
          stop = true;
          banDevice = true;
          accountMangment = true;
          logRecord = true;
          removeBan = true;
          publicmessage = true;
          adminReport = true;
          roomSettings = true;
          memberMangment = true;
          masterMangment = true;
          superAdminMangment = true;
          adminMangment = true;
        } else {
          deleteChat = false;
          mic = false;
          kick = false;
          stop = false;
          banDevice = false;
          accountMangment = false;
          logRecord = false;
          removeBan = false;
          publicmessage = false;
          adminReport = false;
          roomSettings = false;
          memberMangment = false;
          masterMangment = false;
          superAdminMangment = false;
          adminMangment = false;
        }
        Get.toNamed(
          '/room',
          arguments: {
            "room_id": roomId,
            "username": username,
          },
        );
      } else if (data["status"] == "closed") {
        Get.back();
        showDialog(
          context: Get.context!,
          builder: (context) {
            timer = Timer.periodic(Duration(seconds: 2), (timer) {
              checkIfAccept(username: username);
            });
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      data["message"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).then((value) {
          deleteFromRoomLock();
          timer!.cancel();

          // return ;
        });
      } else {
        Get.back();
        // timer.cancel();

        alertMessage(data["message"]);
        timer!.cancel();
      }
    } else {
      Get.back();
    }
  }

  checkIfAccept({required String username}) async {
    // https://lametnachat.com/rooms/checkEnteringRoom.php
    var url = Uri.parse(checkEnteringRoom);
    var response = await http.post(
      url,
      body: {
        "username": username,
      },
    );
    final databody = json.decode(response.body);
    print(databody);
    if (databody["status"] == "success") {
      Get.back();
      timer!.cancel();
      Get.toNamed(
        '/room',
        arguments: {
          "room_id": databody["roomId"].toString(),
          "username": username,
        },
      );
      timer!.cancel();
    } else if (databody["status"] == "fail") {
      Get.back();
      timer!.cancel();
      alertMessage(databody["message"]);
    }
    print("----------");
  }

  deleteFromRoomLock() async {
    //https://lametnachat.com/rooms/deleteEnteringRoom.php
    var url = Uri.parse(deleteEnteringRoom);
    var response = await http.post(
      url,
      body: {
        "username": userName,
      },
    );
    final databody = json.decode(response.body);
    print(databody);
    print("----------");
  }

  loginAsGuest(
      {required String welcomeText,
      required String roomName,
      // String owner,
      required String roomId}) async {
    print("guest-${guestController.text.trim()}");

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
      var guestLoginUrl = Uri.parse(guestLogin);
      var res = await http.post(
        guestLoginUrl,
        body: {
          "name": guestController.text.trim(),
          "roomId": roomId,
        },
      );
      var data = json.decode(res.body);

      if (data["status"] == "success") {
        Get.back();

        userName = guestController.text.trim();
        isRole = false;
        isGuest = true;
        guestController.text = "";
        // isRole = false;
        // update();

        Get.toNamed(
          '/room',
          arguments: {
            // "room_name": roomName,
            "room_id": roomId,
            // "owner": owner,
            // "welcome_text": welcomeText,
          },
        );
        // Get.toNamed(
        //   '/room',
        //   // arguments: {
        //   //   "room_name": roomName,
        //   //   "room_id": roomId,
        //   //   // "owner": owner,
        //   //   "welcome_text": welcomeText,
        //   // },
        // );
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
            " من فضلك ادخل اسم المستخدم اخر", //
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
    }
  }
}

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // unique ID on Android
  }
  return null;
}

alertMessage(String message) {
  return showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFABD63),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(3.sp),
        child: Text(
          "تنبيه",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      actionsPadding: EdgeInsets.zero,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFABD63),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 3.h,
                ),
                child: Text(
                  "حسنا",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

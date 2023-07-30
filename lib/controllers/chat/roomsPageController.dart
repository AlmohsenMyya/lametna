// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/videoController.dart';
import 'package:lametna/controllers/chathomePageController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/model/message.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:lametna/view/chat/addAccount.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get_ip_address/get_ip_address.dart';
import 'package:lametna/view/chatHomePage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../userData/variables.dart';

const String APP_ID = "e151cc863dd34adc9f76f085e4fb7b78";

class RoomsPageController extends GetxController {
  bool roomStatus = true;
  Crud crud = Crud();
  StreamController streamController = StreamController();
  StreamController membersController = StreamController();
  OverlayEntry entry;
  // Timer _timer;
  TextEditingController messageController = TextEditingController();
  bool scrollDownButton = true;
  ScrollController scrollController = ScrollController();
  bool messageStatus = false;
  bool emojiStatus = true;
  bool cameraWidget = false;
  bool micWidget = false;
  bool mute = false;
  bool inCall = false;

  var userInRoom;
  String roomId;
  // bool owner = Get.arguments["owner"] == userName;

  //blocktime
  String quarterHour = DateTime.now()
      .add(Duration(minutes: 15))
      .toString()
      .substring(0, 19)
      .toString();
  String hour = DateTime.now()
      .add(Duration(minutes: 60))
      .toString()
      .substring(0, 19)
      .toString();
  String sixHours = DateTime.now()
      .add(Duration(hours: 6))
      .toString()
      .substring(0, 19)
      .toString();
  String day = DateTime.now()
      .add(Duration(days: 1))
      .toString()
      .substring(0, 19)
      .toString();

  String week = DateTime.now()
      .add(Duration(days: 7))
      .toString()
      .substring(0, 19)
      .toString();
  String month = DateTime.now()
      .add(Duration(days: 30))
      .toString()
      .substring(0, 19)
      .toString();
  String forever = DateTime.now()
      .add(Duration(days: 365))
      .toString()
      .substring(0, 19)
      .toString();
  bool isKicked = false;
  VideoController videoController = Get.put(VideoController());

  //voice room
  // String channelName = "";
  // String token = "";
  // String channelName = "2";
  // String token =
  //     "007eJxTYKh99aOr7HP0FNmPLzgVK1YnqwZP1vVbq75dyuf/pVtvzu5WYEg1NDVMTrYwM05JMTZJTEm2TDM3SzOwME01SUsyTzK30P28MKUhkJHhg74DEyMDBIL4jAxGDAwAlBAgUQ==";

  @override
  Future<void> onInit() async {
    super.onInit();
    roomId = await Get.arguments["room_id"];
    onJoin();
    isKicked = false;

    await getRoomInformation();
  }

  //video
  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    // getActiveOrDefualtBask
    //  emitTypingChange(0);
    await streamController.close();
    // _timer.cancel();

    onLeave();
    // await agoraEngine.leaveChannel();
    super.dispose();
  }

  @override
  Future<void> onClose() async {
    print("close");

    streamController.close();
    // onLeave();
    // _timer.cancel();
    super.onClose();
  }

  getRoomInformation() async {
    var url = Uri.parse(roomInfoUrl);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);
    // channelName = dataBody["data"][0]["Channel_Name"];
    // token = dataBody["data"][0]["Token"];
    update();
    // print();
  }

  onJoin() async {
    var url = Uri.parse(joinRoom);
    var url2 = Uri.parse(sendRoomMessage);
    await http.post(url2, body: {
      "roomId": Get.arguments["room_id"],
      "senderName": "roomAlert",
      "message": "$userName انضم للغرفة",
      "joinOrLeave": "0", //left 1 joined 0
    });

    await http.post(url, body: {
      "roomId": roomId,
      "userName": userName,
    });
  }

  onLeave() async {
    var url = Uri.parse(leaveRoom);
    var url2 = Uri.parse(sendRoomMessage);
    await http.post(url2, body: {
      "roomId": roomId,
      "senderName": "roomAlert",
      "message": "$userName غادر للغرفة",
      "joinOrLeave": "1", //left 1 joined 0
    });
    await http.post(url, body: {
      "roomId": roomId,
      "userName": userName,
    });
    print("leave");
    // isGuest = false;
    Get.back();
  }

  Future<dynamic> getData() async {
    try {
      var url = Uri.parse(getRoomMessagesUrl);
      var response = await http.post(url, body: {
        "roomId": roomId,
      });
      final dataBody = json.decode(response.body);

      if (dataBody["roomPlan"][0]["room_plan"] == "0") {
        roomStatus = false;
      } else {
        roomStatus = true;
      }
      update();
      // print(dataBody["banuser"]);
      // print(dataBody["roomPlan"][0]["room_plan"]);
      for (var element in dataBody["banuser"]) {
        if (element == (isGuest ? guestUserName : userName) &&
            isKicked == false) {
          onLeave();
          isKicked = true;
          update();
        }
      }
      // if (owner) {
      //   if (dataBody["videoRequest"].length != 0) {
      //     for (var e in dataBody["videoRequest"]) {
      //       print(e);
      //       await Get.defaultDialog(
      //           middleText: "هل تريد قبول طلب الفيديو من ${e["name"]}",
      //           middleTextStyle: TextStyle(color: Colors.black),
      //           confirm: TextButton(
      //               child: Text(
      //                 "test",
      //                 style: TextStyle(color: Colors.black),
      //               ),
      //               onPressed: () {
      //                 remove(e["name"], roomId);
      //                 Get.back();
      //               }));
      //     }
      //   }
      //   print(dataBody["videoRequest"]);
      //   print("-------------------");
      // }

      membersController.sink.add(dataBody["membersInCall"]);
      // print(dataBody["membersInCall"]);
      streamController.sink.add(dataBody);
      update();
    } catch (e) {}
  }

  sendMessage(String message) async {
    print(isRole);
    print(isGuest);

    var response = await http.post(Uri.parse(messageInRoomStatus), body: {
      "roomId": roomId,
      //left 1 joined 0
    });
    final dataBody = json.decode(response.body);
    // if
    print(dataBody);
    // Get.snackbar("title", );
    if (message != "") {
      messageStatus = true;
      update();
      var url = Uri.parse(sendRoomMessage);
      var response = await http.post(url, body: {
        "roomId": roomId,
        "senderName": userName,
        "message": message,
        "isGuest": isGuest && !isRole ? "1" : "0",
        "joinOrLeave": "9", //left 1 joined 0
      });

      final dataBody = json.decode(response.body);
      // print(dataBody);
      if (dataBody["status"] == "fail") {
        Get.snackbar("تنبية", dataBody["message"]);
      }
      messageController.clear();
      messageStatus = false;
      update();
    } else {
      Get.snackbar("تنبية", "لا يمكن ارسال رسال فارغة");
    }
  }

  remove(name, id) {
    var url = Uri.parse(
        'https://lametnachat.com/rooms/deleteVideoRequest.php'); //https://lametnachat.com/rooms/deleteVideoRequest.php //videoRequest
    http.post(url, body: {
      "roomId": id,
      "name": name,
      // "status": "",
    });
  }

  getRoomMembers() async {
    try {
      // usersInRoom.sink.close();
      var url = Uri.parse(roomMember);
      var response = await http.post(url, body: {
        "roomid": roomId,
      });
      final dataBody = json.decode(response.body);
      // print(dataBody);
      // usersInRoom.sink.add(dataBody);
      userInRoom = dataBody;
      update();
      // usersInRoom = ;
      // for (var e in dataBody["data"]) {
      //   print(e);
      // }
      // print("object");
      // update();
      // return dataBody;
    } catch (e) {
      print("object");
    }
  }

  blockUser(String name, int selection) async {
    // Get.back();
    // Get.back();
    // Get.back();
    // Get.back();
    var url = Uri.parse(banUser);
    var response = await http.post(url, body: {
      "roomId": roomId,
      "username": name,
      "endTime": selection == 0
          ? quarterHour
          : selection == 1
              ? hour
              : selection == 2
                  ? sixHours
                  : selection == 3
                      ? day
                      : selection == 4
                          ? week
                          : selection == 5
                              ? month
                              : forever,
    });

    if (response.statusCode == 200) {
      print("blocked");
    }

    Get.defaultDialog(
        middleText: "تم حظر هذا المستخدم",
        middleTextStyle: TextStyle(color: Colors.green),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));
  }

  kickUser(String name) async {
    Get.defaultDialog(
        middleText: "هل تريد طرد هذا المستخدم؟",
        middleTextStyle: TextStyle(color: Colors.green),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));

    var url = Uri.parse(banUser);
    var response = await http.post(url, body: {
      "roomId": roomId,
      "username": name,
      "endTime": DateTime.now()
          .add(Duration(seconds: 1))
          .toString()
          .substring(0, 19)
          .toString()
    });
    if (response.statusCode == 200) {
      print("kicked");
    }
  }

  scrollDownButtonStatus(bool status) {
    scrollDownButton = status;
    update();
  }

  Future<void> changeRoomStatus() async {
    // print(roomId);
    // print("changed");

    var url = Uri.parse(changeRoomPlan);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);
    print(dataBody);
    if (dataBody["status"] == "success") {
      // print("changed");
      roomStatus = !roomStatus;
    }
    update();
    // print(roomStatus);
  }

  void changeEmojiStatus(bool status) {
    emojiStatus = status;
    update();
  }

  toggleMic() {
    if (cameraWidget) {
      toggleCamera();
    }
    micWidget = !micWidget;
    update();
    // agoraEngine.muteLocalAudioStream(mic);
  }

  // micStatus() {
  //   if (mute) {
  //     agoraEngine.muteLocalAudioStream(false);
  //   } else {
  //     agoraEngine.muteLocalAudioStream(true);
  //   }
  //   mute = !mute;
  //   update();
  // }

  toggleCamera() {
    if (micWidget) {
      toggleMic();
    }
    cameraWidget = !cameraWidget;
    update();
  }

  // joinLeaveCalls() {
  //   if (!inCall) {
  //     join();
  //   } else {
  //     leave();
  //   }
  //   inCall = !inCall;
  //   update();
  //   print(inCall);
  // }

  getUserIP() async {
    var ipAddress = IpAddress(type: RequestType.json);
    dynamic data = await ipAddress.getIpAddress();

    Get.defaultDialog(
        title: "IP",
        middleText: data["ip"].toString(),
        middleTextStyle: TextStyle(color: Colors.black),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));
  }

  getUserDeviceType() async {
    String os = await Platform.operatingSystem;
    // Or, use a predicate getter.
    Get.defaultDialog(
        title: "IP",
        middleText: os,
        middleTextStyle: TextStyle(color: Colors.black),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));
  }

  getUserCountry() async {
    String localeName = await Platform.localeName;

    print(localeName);
    Get.defaultDialog(
        title: "IP",
        middleText: localeName,
        middleTextStyle: TextStyle(color: Colors.black),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));
  }
}

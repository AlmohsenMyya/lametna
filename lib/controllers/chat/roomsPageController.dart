// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/videoController.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/voiceController.dart';
import 'package:lametna/controllers/chathomePageController.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/model/message.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:lametna/view/chat/addAccount.dart';
import 'package:image_picker/image_picker.dart';

import 'package:get_ip_address/get_ip_address.dart';
import 'package:lametna/view/chatHomePage.dart';
import 'package:lametna/view/home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import '../userData/variables.dart';

const String APP_ID = "e151cc863dd34adc9f76f085e4fb7b78";

class RoomsPageController extends GetxController {
  bool roomStatus = true;
  Crud crud = Crud();
  StreamController streamController = StreamController();
  StreamController membersController = StreamController();
  StreamController roomLockController = StreamController.broadcast();
  // VideoController videoController = Get.put(VideoController());
  // VoiceController voiceController = Get.put(VoiceController());
  OverlayEntry entry;
  var memberInCall;

  bool isRoomLock = false;
  // Timer _timer;
  TextEditingController messageController = TextEditingController();
  bool scrollDownButton = true;
  // ScrollController scrollController = ScrollController();
  bool messageStatus = false;
  bool emojiStatus = true;
  bool cameraWidget = false;
  bool micWidget = false;
  bool mute = false;
  bool inCall = false;
  bool isVisible = false;
  bool waitingListStatus = false;

  String timeEntered;

  String privateMessages;

  var userInRoom;
  String roomId;

  String roomOwner;
  String welcomeText;
  String welcomeMsg;

  String roomName;
  String themeColor;

  bool isEndrawerOpen = false;

  // bool owner = Get.arguments["owner"] == userName;

  //blocktime
  String quarterHour = DateTime.now().add(Duration(minutes: 15)).toString().substring(0, 19).toString();
  String hour = DateTime.now().add(Duration(minutes: 60)).toString().substring(0, 19).toString();
  String sixHours = DateTime.now().add(Duration(hours: 6)).toString().substring(0, 19).toString();
  String day = DateTime.now().add(Duration(days: 1)).toString().substring(0, 19).toString();

  String week = DateTime.now().add(Duration(days: 7)).toString().substring(0, 19).toString();
  String month = DateTime.now().add(Duration(days: 30)).toString().substring(0, 19).toString();
  String forever = DateTime.now().add(Duration(days: 365)).toString().substring(0, 19).toString();
  bool isKicked = false;

  bool isChatActive = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    roomId = await Get.arguments["room_id"];
    // roomId = await Get.arguments["room_id"];
    timeEntered = DateTime.now().toUtc().subtract(Duration(seconds: 5)).toString();
    onJoin();
    isKicked = false;

    await getRoomInformation();
    Timer.periodic(Duration(seconds: 2), (timer) {
      update();
      getRoomInformation();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose

    streamController.close();
    membersController.close();
    super.onClose();
  }

  //video
  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    // getActiveOrDefualtBask
    //  emitTypingChange(0);

    // scrollController.removeListener(() {});
    streamController.close();
    membersController.close();
    roomLockController.close();
    timeEntered = "";
    // _timer.cancel();

    await onLeave();
    // await agoraEngine.leaveChannel();
    super.dispose();
  }

  changeChatStatus(bool status) {
    isChatActive = status;
    update();
  }

  Future<dynamic> getData() async {
    userName == roomOwner ? getRoomLock() : null;
    try {
      var url = Uri.parse(getRoomMessagesUrl);
      var response = await http.post(url, body: {
        "roomId": roomId,
        "time": timeEntered,
      });
      final dataBody = json.decode(response.body);
      // print(dataBody["themeColor"][0]["themeColor"]);
      themeColor = dataBody["themeColor"][0]["themeColor"];
      memberInCall = await dataBody["membersInCall"];
      update();
      if (dataBody["roomPlan"][0]["room_plan"] == "0") {
        roomStatus = false;
      } else {
        roomStatus = true;
      }
      for (var element in dataBody["banuser"]) {
        if (element == (isGuest ? guestUserName : userName) && isKicked == false) {
          onLeave();
          isKicked = true;
          update();
        }
      }
      for (var e in dataBody["membersInCall"]) {
        if (e["name"] == userName) {}
      }
      // print("---");
      // memberInCall = dataBody["membersInCall"];
      membersController.sink.add(dataBody["membersInCall"]);
      streamController.sink.add(dataBody["data"]);
      update();
    } catch (e) {
      print(e);
    }
  }

  getRoomInformation() async {
    var url = Uri.parse(roomInfoUrl);
    var response = await http.post(url, body: {
      "roomId": roomId,
    });

    final dataBody = json.decode(response.body);
    privateMessages = dataBody["data"][0]["privateMessages"];
    roomOwner = dataBody["data"][0]["owner_username"];
    welcomeText = dataBody["data"][0]["hello_msg"];
    welcomeMsg = dataBody["data"][0]["welcomeMsg"];
    roomName = dataBody["data"][0]["room_name"];
    roomId = dataBody["data"][0]["room_id"];
    isRoomLock = dataBody["data"][0]["roomLock"] == "بوابة دخول" ? true : false;
    // print(dataBody);

    update();
  }

  onJoin() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    String country = first.countryName;

    var url = Uri.parse(joinRoom);
    http.post(url, body: {
      "roomId": roomId,
      "userName": Get.arguments["username"],
      "macAddress": await getId(),
      "country": country,
      // "isRole": isRole == true ? "1" : "0",
    });
    var url2 = Uri.parse(sendRoomMessage);
    await http.post(url2, body: {
      "roomId": roomId,
      "senderName": "roomAlert",
      "message": "${Get.arguments["username"]} انضم للغرفة",
      "joinOrLeave": "0", //left 1 joined 0S
    });
  }

  onLeave() async {
    // await Get.put(VoiceController()).agoraEngine.leaveChannel(); ////disable voice

    // Get.offAll(Home());
    Get.back();
    // await videoController.leave();
    // await voiceController.leave();

    var url = Uri.parse(leaveRoom);
    await http.post(url, body: {
      "roomId": roomId,
      "userName": Get.arguments["username"],
    });
    var url2 = Uri.parse(sendRoomMessage);
    await http.post(url2, body: {
      "roomId": roomId,
      "senderName": "roomAlert",
      "message": "${Get.arguments["username"]} غادر للغرفة",
      "joinOrLeave": "1", //left 1 joined 0
    });

    print("leave");
    // if (isRole) {
    //   isRole = true;
    // } else if (isGuest) {
    //   isGuest = true;
    // }
    // isGuest = false;
  }

  sendMessage(String message) async {
    print(isRole);
    print(isGuest);
    if (message != "") {
      messageStatus = true;
      update();
      var url = Uri.parse(sendRoomMessage);
      var response = await http.post(url, body: {
        "roomId": roomId,
        "senderName": userName,
        "message": message,
        "isGuest": isGuest && !isRole ? "1" : "0",
        "userType": isRole == true
            ? roleType.toString()
            : isGuest == true
                ? ""
                : userType.toString(),
        // "joinOrLeave": "9", //left 1 joined 0
      });

      final dataBody = json.decode(response.body);
      // print(dataBody);
      if (dataBody["status"] == "fail") {
        Get.snackbar("تنبية", dataBody["message"]);
      }
      messageController.clear();
      messageStatus = false;
      update();
    }
  }

  remove(name, id) {
    var url = Uri.parse('https://lametnachat.com/rooms/deleteVideoRequest.php'); //https://lametnachat.com/rooms/deleteVideoRequest.php //videoRequest
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
      print("memebers");
      // return dataBody;
    } catch (e) {
      print("object");
    }
  }

  blockUser(String name, String selection, String macAddress) async {
    // Get.back();
    // Get.back();
    // Get.back();
    // Get.back();
    var url = Uri.parse(banUser);
    var response = await http.post(url, body: {
      "roomId": roomId,
      "username": name,
      "macAddress": macAddress,
      "userBan": "watan",
      "country": "",
      "ipAddress": "",
      "banType": selection == "0"
          ? "ربع ساعة"
          : selection == "1"
              ? "ساعة"
              : selection == "2"
                  ? "ستة ساعات"
                  : selection == "3"
                      ? "يوم"
                      : selection == "4"
                          ? "اسبوع"
                          : selection == "5"
                              ? "شهر"
                              : "دائما",
      "endTime": selection
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

  kickUser(String name, {String roomId}) async {
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
      "roomId": Get.arguments["room_id"],
      "username": name,
      "endTime": DateTime.now().add(Duration(days: -10)).toString().substring(0, 19).toString()
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
      "roomId": roomId,
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
      ),
    );
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
  //peopleMessaged

  getPeopleMessaged() async {
    var url = Uri.parse(peopleMessaged);
    var response = await http.post(url, body: {
      "senderId": userId,
    });
    final dataBody = json.decode(response.body);
    // print(dataBody);
    return dataBody["participants"];
  }

  getRoomLock() async {
    var url = Uri.parse(waitingList);
    var response = await http.post(url, body: {
      "roomId": roomId,
    });
    final dataBody = json.decode(response.body);
    // print(dataBody);
    // print("-------");
    roomLockController.sink.add(dataBody["data"]);
    // roomLockController.sink.();
    return dataBody["participants"];
  }

  acceptOrRejectWaitingList({String status, String name}) async {
    var url = Uri.parse(statusEntringRoom);
    var response = await http.post(url, body: {
      "userName": name,
      "status": status,
    });
    final dataBody = json.decode(response.body);
  }

  void toggleWaitingList() {
    waitingListStatus = !waitingListStatus;
    print(waitingListStatus);
    update();
  }
}

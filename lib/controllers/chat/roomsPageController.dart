import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/model/message.dart';

import '../userData/variables.dart';

class RoomsPageController extends GetxController {
  bool roomStatus = true;
  Crud crud = Crud();
  StreamController streamController = StreamController();
  Timer _timer;
  TextEditingController messageController = TextEditingController();
  bool scrollDownButton = false;
  ScrollController scrollController = ScrollController();
  bool messageStatus = false;
  @override
  void onInit() {
    super.onInit();
    onJoin();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => getData());

    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamController.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    print("close");
    // onJoinOrLeave(false);
    _timer.cancel();
    super.onClose();
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
      "roomId": Get.arguments["room_id"],
      "userName": userName,
    });
  }

  onLeave() async {
    var url = Uri.parse(leaveRoom);
    var url2 = Uri.parse(sendRoomMessage);
    await http.post(url2, body: {
      "roomId": Get.arguments["room_id"],
      "senderName": "roomAlert",
      "message": "$userName غادر للغرفة",
      "joinOrLeave": "1", //left 1 joined 0
    });
    await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "userName": userName,
    });
    print("leave");
    Get.back();
  }

  Future<dynamic> getData() async {
    try {
      var url = Uri.parse(getRoomMessagesUrl);
      var response = await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
      });
      final dataBody = json.decode(response.body);
      streamController.sink.add(dataBody);
    } catch (e) {}
  }

  sendMessage(String message) async {
    if (message != "") {
      messageStatus = true;
      update();
      var url = Uri.parse(sendRoomMessage);
      var response = await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
        "senderName": userName,
        "message": message,
      });

      final dataBody = json.decode(response.body);
      print(dataBody);
      if (dataBody["status"] == "success") {
        messageController.clear();
        messageStatus = false;
        update();
        // getData();
      }
    }
  }

  getRoomMembers() async {
    try {
      var url = Uri.parse(roomMember);
      var response = await http.post(url, body: {
        "roomid": Get.arguments["room_id"],
      });
      final dataBody = json.decode(response.body);
      print(dataBody);
      return dataBody;
    } catch (e) {
      print("object");
    }
  }

  scrollDownButtonStatus(bool status) {
    scrollDownButton = status;
    update();
  }

  void changeRoomStatus() {
    roomStatus = !roomStatus;
    update();
    // print(roomStatus);
  }
}

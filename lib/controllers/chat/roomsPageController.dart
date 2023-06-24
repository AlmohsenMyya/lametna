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
    onJoinOrLeave(false);
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

  Future<dynamic> getData() async {
    try {
      var url = Uri.parse('${baseURL}/messages/showmessagegroup.php');
      var response = await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
      });
      final dataBody = json.decode(response.body);
      streamController.sink.add(dataBody);
    } catch (e) {}
  }

  onJoinOrLeave(bool joinOrLeave) async {
    var url = Uri.parse('${baseURL}/messages/groupchat.php');
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "senderName": "roomAlert",
      "message":
          joinOrLeave ? "$userName انضم للغرفة" : "$userName غادر للغرفة",
      "joinOrLeave": joinOrLeave ? "1" : "0",
    });
    if (joinOrLeave) {
      Get.back();
    }
  }

  sendMessage(String message) async {
    if (message != "") {
      messageStatus = true;
      update();
      var url = Uri.parse('${baseURL}/messages/groupchat.php');
      var response = await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
        "senderName": userName,
        "message": message,
      });

      final dataBody = json.decode(response.body);
      if (dataBody["status"] == "success") {
        messageController.clear();
        messageStatus = false;
        update();
        // getData();
      }
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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class CustomerServicesController extends GetxController {
  TextEditingController messageController = TextEditingController();
  StreamController messages = StreamController();
  Future getMessage() async {
    var url = Uri.parse(customerServiceMessages);

    var res = await http.post(
      url,
      body: {
        // "user_id": user_id,
        "sender": mobileUserName,
        "reciever": "CustomerService",
      },
    );

    var data = json.decode(res.body);
    update();

    messages.sink.add(data);
  }

  sendMessage(String sender) async {
    print("object");
    print(messageController.text);
    if (messageController.text.trim() != "") {
      var url = Uri.parse(customerServiceChat);
      var res = await http.post(url, body: {
        // "user_id": user_id,
        "sender": sender,
        "reciever": "CustomerService",
        "message": messageController.text,
      });
      if (res.statusCode == 200) {
        messageController.clear();
        print("sent");
      }
    }
  }
}

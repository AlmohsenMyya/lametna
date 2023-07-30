import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrivateMessagesRoomController extends GetxController {
  TextEditingController messageRoomController = TextEditingController();
  StreamController streamController = StreamController();
  Timer _timer;

  @override
  Future<void> onInit() async {
    super.onInit();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      return getData();
    });
  }

  Future<dynamic> getData() async {
    try {
      var url = Uri.parse(getPrivateMessageRoom);
      var response = await http.post(url, body: {
        "roomId": Get.arguments['room_id'],
        "senderUserRoom": isGuest ? guestUserName : userName,
        "recieverUserRoom": Get.arguments["username"],
      });
      final dataBody = json.decode(response.body);
      update();
      streamController.sink.add(dataBody);
      return dataBody; // add this line to return the data
    } catch (e) {
      // handle any errors here
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> sendMsg() async {
    try {
      var url = Uri.parse(sendPrivateMessageRoom);
      if (messageRoomController.text.trim() != "") {
        var response = await http.post(url, body: {
          "roomId": Get.arguments['room_id'],
          "senderUserRoom": isGuest ? guestUserName : userName,
          "recieverUserRoom": Get.arguments["username"],
          "message": messageRoomController.text.trim(),
        });
        final dataBody = json.decode(response.body);
        if (dataBody['status'] == "success") {
          messageRoomController.text = "";
          print("success");
        } else {
          print("error");
        }
        return dataBody;
      }
    } catch (e) {
      // handle any errors here
      print(e.toString());
    }
    return null;
  }
}
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lametna/controllers/userData/userCredentials.dart';
// import 'package:lametna/controllers/userData/variables.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class PrivateMessagesRoomController extends GetxController {
//   TextEditingController messageRoomController = TextEditingController();
//   StreamController streamController = StreamController();
//   Timer _timer;
//
//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     // _timer = Timer.periodic(Duration(seconds: 2), (timer) {
//        return getData();
//     // });
//   }
//
//   Future<dynamic> getData() async {
//     try {
//       var url = Uri.parse(getPrivateMessageRoom);
//       var response = await http.post(url, body: {
//         "roomId":"2",
//         "senderUserRoom": "khaled",
//         "recieverUserRoom": "ali",
//       });
//       final dataBody = json.decode(response.body);
//
//       update();
//       streamController.sink.add(dataBody);
//     } catch (e) {}
//   }
//
//   Future sendMsg() async {
//     var url = Uri.parse(sendPrivateMessageRoom);
//
//     if (messageRoomController.text.trim() != "") {
//       var response = await http.post(url, body: {
//         "roomId":"2",
//         "senderUserRoom": "khaled",
//         "recieverUserRoom": "ali",
//         "message": messageRoomController.text.trim(),
//       });
//       final dataBody = json.decode(response.body);
//       if (dataBody['status'] == "success") {
//         messageRoomController.text = "";
//         update();
//         print("success");
//       } else {
//         print("error");
//       }
//     }
//   }
// }
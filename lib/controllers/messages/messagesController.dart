import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class MessagesController extends GetxController {
  var data = [];
  TextEditingController searchController = TextEditingController();
  StreamController peopleMessagedController = StreamController();


  getData() async {
    var url = Uri.parse(peopleMessaged);
    var response = await http.post(url, body: {
      "senderId": userId,
    });
    final dataBody = json.decode(response.body);
    // print(dataBody);

    peopleMessagedController.sink.add(dataBody);
  }

  Future search() async {
    var url = Uri.parse(userSearch);
    var response = await http.post(url, body: {
      "search": searchController.text.trim().toString(),
    });
    final dataBody = json.decode(response.body);
    if (dataBody['status'] == "success") {
      // print(dataBody);

      for (var i = 0; i < dataBody["data"].length; i++) {
        print(dataBody["data"][i]["username"]);
      }
      // return dataBody;
      data = dataBody["data"];
      print(dataBody);
      update();

      print("success0000");
    } else {
      print("error");
    }
  }
}

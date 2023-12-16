import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/variables.dart';

class RoomReportController extends GetxController {
  int firstPage = 1;
  // String lastPage;
  String totalReports = "0";
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      update();
    });
  }

  isEmptySearch() {
    if (searchController.text.isEmpty) {
      isSearching = false;
      update();
    } else {
      isSearching = true;
      update();
    }
    print(isSearching);
  }

  getReport() async {
    var res = await http.post(Uri.parse(roomReport), body: {
      "roomId": Get.arguments["room_id"],
      "page": firstPage.toString(),
    });
    var dataBody = json.decode(res.body);
    totalReports = dataBody["totalReports"].toString();
    // update();
    print(dataBody["totalReports"].toString());
    return dataBody["data"];
  }

  Future<String> getTotalReport() async {
    var res = await http.post(Uri.parse(roomReport), body: {
      "roomId": Get.arguments["room_id"],
      "page": firstPage.toString(),
    });
    var dataBody = json.decode(res.body);
    // totalReports = ;
    print(dataBody["totalReports"].toString());
    return dataBody["totalReports"].toString();
  }

  togglePageForward() {
    if ((int.parse(totalReports) / 20).round() > firstPage) {
      firstPage++;
      update();
      getReport();
    }
  }

  togglePageBackward() {
    if (firstPage > 1) {
      firstPage--;
      update();
      getReport();
    }
  }
}

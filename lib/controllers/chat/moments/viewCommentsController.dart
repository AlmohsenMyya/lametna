// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:async';

import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewCommentsController extends GetxController {
  TextEditingController commentController = TextEditingController();
  StreamController streamController = StreamController();

  @override
  onClose() {
    streamController.close();
    super.onClose();
  }

  getComments(storyId) async {
    var res = await http.post(Uri.parse(getStoryComments), body: {
      "storyId": storyId,
    });
    var dataBody = json.decode(res.body);
    // print(dataBody);
    streamController.sink.add(dataBody);
    update();
    // return dataBody;
  }

  postComment() async {
    if (isGuest == false && isRole == false) {
      var res = await http.post(Uri.parse(addStoryComment), body: {
        "username": userName,
        "storyId": Get.arguments["id"].toString(),
        "comment": commentController.text.toString(),
      });
      var dataBody = json.decode(res.body);
      if (res.statusCode == 200) {
        Get.snackbar("تم", dataBody["message"],
            snackPosition: SnackPosition.BOTTOM);
        // print(dataBody);
      }
    } else {
      Get.defaultDialog(
        barrierDismissible: false,
        title: "تنبيه",
        titleStyle: TextStyle(
          fontSize: 22.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        content: Text(
          "التعليق متاح للمستخدمين فقط",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        confirm: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              // LinearGradient
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF792F0),
                  Color(0xFFFABD63),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              "حسنا",
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.white,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
  }

  likeStory(String storyId) async {
    if (isGuest == false && isRole == false) {
      var res = await http.post(Uri.parse(likeStoryUrl), body: {
        "username": userName,
        "storyId": storyId,
      });
      var dataBody = json.decode(res.body);
      if (res.statusCode == 200) {
        Get.snackbar("تم", dataBody["message"],
            snackPosition: SnackPosition.BOTTOM);
        // print(dataBody);
      }
    } else {
      Get.defaultDialog(
        barrierDismissible: false,
        title: "تنبيه",
        titleStyle: TextStyle(
          fontSize: 22.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        content: Text(
          "الاعجاب متاح للمستخدمين فقط",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        confirm: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              // LinearGradient
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF792F0),
                  Color(0xFFFABD63),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              "حسنا",
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.white,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    // getAllStories();
    // print("liked");

    // return dataBody["data"];
  }
}

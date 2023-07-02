// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'crud.dart';
import 'package:lametna/controllers/Crud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisibility = false;
  // List savedPassword = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Crud crud = Crud();
  //   SharedPreferences prefs = await prefs;
  //final storage = FlutterSecureStorage();

  Future<void> getSavedPassword() async {
    // String username = await storage.read(key: 'username');
    //String password = await storage.read(key: 'password');
    // userNameController.text = username;
    // passwordController.text = password;
  }

  loginAsGuest() async {
    isGuest = true;
    update();
    Get.offAllNamed("/home");
  }

  Future login(BuildContext context) async {
    try {
      Map data = {
        "username": userNameController.text,
        "password": passwordController.text
      };
      FocusScope.of(context).unfocus();

      var response = await crud.postRequest(data);
      print(response.toString());
      print(response.toString());
      if (response['status'] == "success") {
        userName = response["data"]['username'];
        userId = response["data"]['userid'];
        isGuest = false;
        // await storage.write(key: 'username', value: userNameController.text);
        //await storage.write(key: 'password', value: passwordController.text);

        Get.offAllNamed("/home");

        // Get.offAllNamed("/countries");

        print("done");
      } else {
        print("error");
        Get.snackbar("", "",
            titleText: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Portada"),
            ),
            messageText: Text(
              "اسم المستخدم او كلمة المرور غير صحيحة",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Portada"),
            ),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        // }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update();
  }
}

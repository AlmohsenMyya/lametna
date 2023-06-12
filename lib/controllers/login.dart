// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'crud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Crud crud = Crud();

  Future login(BuildContext context) async {
    Map data = {
      "name": userNameController.text,
      "pass": passwordController.text
    };
    print(data);
    var response = await crud.loginRequest(data);
    FocusScope.of(context).unfocus();
    // print(response.toString());
    if (response['Status'] == "Success") {
      userName = userNameController.text;
      userPassword = passwordController.text;

      Get.offAllNamed("/chatHomePage");
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
  }
}

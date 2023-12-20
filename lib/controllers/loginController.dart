// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment


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
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Crud crud = Crud();
  //   SharedPreferences prefs = await prefs;
  //final storage = FlutterSecureStorage();
  @override
  void onInit() {
    super.onInit();
    // getSavedPassword();
    autoLogIn();
  }

  Future<void> getSavedPassword() async {
    // String username = await storage.read(key: 'username');
    //String password = await storage.read(key: 'password');
    // userNameController.text = username;
    // passwordController.text = password;
  }

  loginAsGuest() async {
    isGuest = true;
    // userName = null;
    update();
    Get.offAllNamed("/home");
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    final String? password = prefs.getString('password');
    userNameController.text = username!;
    passwordController.text = password!;
    // login(Get.context!);
    print("saved data");
    login(Get.context!, username, password);
    }

  Future login(BuildContext context, String email, String password) async {
    try {
      Map data = {"username": email, "password": password};
      FocusScope.of(context).unfocus();

      var response = await crud.postRequest(data);
      print(response.toString());
      print(response.toString());
      if (response['status'] == "success") {
        mobileUserName = response["data"]['username'];
        userId = response["data"]['userid'];
        userImage = response["data"]["image"];
        userType = response["data"]["userType"];
        isGuest = false;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', email);

        prefs.setString('password', password);
        // await storage.write(key: 'username', value: userNameController.text);
        //await storage.write(key: 'password', value: passwordController.text);
        // print();
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

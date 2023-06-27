import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/Crud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class RolesController extends GetxController {
  PageController pageController = PageController();
  PageController alertPageController = PageController();
  ScrollController _scrollController = ScrollController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int selectedIndex = 0;

  void changeSeletedIndex(int newIndex) {
    selectedIndex = newIndex;
    update();
  }
 Future <dynamic>addRoles(BuildContext context) async {
    var url = Uri.parse(rolesRoom);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "username":userNameController.text.trim(),
      "password":passwordController.text.trim(),


      //بيبعت كل حاجة لربيع ماعدا الحتة البضاان دى بيبعتلة كل حاجة ماعدا role
      //"roleType":selectedIndex,
    });
    update();
    FocusScope.of(context).unfocus();
    final dataBody = json.decode(response.body);
    if (dataBody['status'] == "success") {
      showAlert(context);
      update();
     // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MainView()));
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
    }
  }
  void showAlert(BuildContext context,) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              title: Container(
                height: 183.h,
                width: 387.w,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_box_outlined,
                          size: 50.sp,
                          color: Colors.green,
                        ),
                        Text(
                          "تم إضافة الحساب بنجاح",
                          style: TextStyle(
                            color: Color(0xff2ABC42),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Segoe UI",
                          ),
                        ),

                      ] ),
                ),
              )
          );
        });
  }

// void changePageColor(){
//   switch ( pageIndex <= pageIndex1) {
//     case Color(0xFFFABD63);
//   else {
//     pageIndex1 = 0;
//   }
//
// }}
}
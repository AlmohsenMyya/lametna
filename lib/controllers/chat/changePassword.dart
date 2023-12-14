// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/view/chat/room%20mangement/accountMangement.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  var code = TextEditingController();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBuilder("تغير كلمه السر", true, color: Get.arguments["color"]),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  //textformfield for code in arabic
                  TextFormField(
                    controller: oldPassword,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      isDense: true,
                      hintText: "كلمه السر القديمة",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      fillColor: Colors.grey.withOpacity(0.15),
                      filled: true,
                    ),
                    obscureText: showPassword,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: newPassword,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      isDense: true,
                      hintText: " كلمه السر الجديده",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      fillColor: Colors.grey.withOpacity(0.15),
                      filled: true,
                    ),
                    obscureText: showPassword,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: confirmPassword,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      isDense: true,
                      hintText: "تأكيد كلمه السر الجديده",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      fillColor: Colors.grey.withOpacity(0.15),
                      filled: true,
                    ),
                    obscureText: showPassword,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: code,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      isDense: true,
                      hintText: "كود",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      fillColor: Colors.grey.withOpacity(0.15),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 170.w,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // verifyData();
                          togglePassword();
                        },
                        child: Text(
                          "اظهار الاحرف",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          // primary: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000),
                          primary: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Material(
          elevation: 0,
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Get.theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 140.w,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "الغاء",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 140.w,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () {
                      verifyData();
                    },
                    child: Text(
                      "تغيير",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  verifyData() async {
    if (oldPassword.text.isNotEmpty && newPassword.text.isNotEmpty && confirmPassword.text.isNotEmpty && code.text.isNotEmpty) {
      if (newPassword.text == confirmPassword.text) {
        //api request https://lametnachat.com/rooms/updateMasterPassword.php
        // body: {"oldPassword":oldPassword.text,"newPassword":newPassword.text,"code":code.text}
        var url = Uri.parse('https://lametnachat.com/rooms/updateMasterPassword.php');
        var request = await http.post(
          url,
          body: {
            "oldPassword": oldPassword.text,
            "password": newPassword.text,
            "roomId": code.text,
          },
        );
        var response = json.decode(request.body);
        // showSnackBar(context, response["status"].toString(), true);
        if (response["status"] == "تم تعديل معلومات المستخدم بنجاح") {
          print(true);
          showSnackBar(context, 'تم تغير كلمة السر', false);
        }
      } else {
        showSnackBar(context, 'كلمه السر غير متطابقه', true);
      }
    } else if (oldPassword.text.isEmpty && newPassword.text.isEmpty && confirmPassword.text.isEmpty && code.text.isEmpty) {
      showSnackBar(context, 'يرجى التحقق من جميع البيانات', true);
    }
  }
}

void showSnackBar(BuildContext context, String text, bool isError) {
  final snackBar = SnackBar(
    width: 250.w,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    content: Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    backgroundColor: !isError ? Colors.green[300] : Colors.grey[100],
    behavior: SnackBarBehavior.floating,
    // margin: EdgeInsets.all(50),
    padding: EdgeInsets.all(10.sp),
    duration: Duration(milliseconds: 1300),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

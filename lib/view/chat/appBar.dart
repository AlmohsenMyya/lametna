// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

PreferredSize appbarBuilder(String title, bool isCentered, {String color = ""}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: Container(
      decoration: BoxDecoration(
        // LinearGradient
        gradient: color == ""
            ? LinearGradient(
                colors: [
                  Color(0xFFF792F0),
                  Color(0xFFFABD63),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: color == "" ? null : Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
      ),
      child: AppBar(
        centerTitle: isCentered,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white, //Color(0xff9A8B8B),
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
            size: 25.sp,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
  );
}

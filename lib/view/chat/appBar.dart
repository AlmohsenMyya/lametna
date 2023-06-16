import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

PreferredSize appbarBuilder(String title, bool isCentered) {
  return PreferredSize(
    preferredSize: Size.fromHeight(72.h),
    child: Container(
      decoration: const BoxDecoration(
        // LinearGradient
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF792F0),
            const Color(0xFFFABD63),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: AppBar(
        title: Align(
          alignment: isCentered ? Alignment.center : Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: isCentered ? 0 : 20.w),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white, //Color(0xff9A8B8B),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Portada",
              ),
            ),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
  );
}

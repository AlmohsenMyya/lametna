// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class choosingPage extends StatelessWidget {
  // const choosingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF792F0),
            const Color(0xFFFABD63),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 107.h),
                  child: Text(
                    "أختر نوع الدردشة",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Portada"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 13.h),
                  child: Text(
                    "ودردش مع لمتنا",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Portada"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/loginPage");
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          tileMode: TileMode.clamp,
                          colors: [
                            Color(0xFFFABD63),
                            Color(0xFFFABD63),
                            Color(0xFFF6F6F6),
                          ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          transform: GradientRotation(0.4),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 15.h, left: 58.w, right: 59.w),
                            child: Text(
                              "الغرف الكتابية",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Portada"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 14.h),
                            child: Image.asset(
                              "assets/images/message.png",
                              width: 220.w,
                              height: 120.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 37.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: LinearGradient(
                        tileMode: TileMode.clamp,
                        colors: [
                          Color(0xFFF792F0),
                          Color(0xFFF792F0),
                          Color(0xFFF6F6F6),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        transform: GradientRotation(0.4),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 15.h, left: 58.w, right: 59.w),
                          child: Text(
                            "الغرف الصوتية",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Portada"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: Image.asset(
                            "assets/images/phone.png",
                            width: 220.w,
                            height: 120.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}

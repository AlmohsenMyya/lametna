// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class About extends StatelessWidget {
  const About({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("عن البرنامج", false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/logo.png",
              width: 180,
              height: 255,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Text(
                'Lametna - Audio/Video chat rooms http://chat-lametna.com/ chat.lametna@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF707070),
                  fontFamily: 'Segoe UI',
                  fontSize: 20.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
              child: Text(
                '+32466110337',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF707070),
                  fontFamily: 'Segoe UI',
                  fontSize: 20.sp,
                ),
              ),
            ),
            Container(
              width: 160.w,
              height: 46.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.r),
                color: Color(0xFF47A6E5),
              ),
              child: Center(
                child: Text(
                  'تقيم التطبيق',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Segoe UI',
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              width: 160.w,
              height: 46.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.r),
                color: Color(0xFF47A6E5),
              ),
              child: Center(
                child: Text(
                  'شروط الأستخدام',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Segoe UI',
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

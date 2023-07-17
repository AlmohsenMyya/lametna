// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Trophy extends StatelessWidget {
  const Trophy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "لوحة صدارة الشرف",
          style: TextStyle(
              color: Colors.black,
              fontSize: 17.sp,
              fontFamily: 'Portada',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          {
            "title": "لوحة صدارة الغرف المميزة",
            "gColor": Color(0xFFF792F0),
            "textColor": Color(0xFFCC77D9)
          },
          {
            "title": "لوحة صدارة الغرف الذهبية",
            "gColor": Color(0xFF6EE1DC),
            "textColor": Color(0xFF43D0CA)
          },
          {
            "title": "لوحة صدارة الحسابات المميزة",
            "gColor": Color(0xFFFABD63),
            "textColor": Color(0xFFEFA11B),
          }
        ]
            .map((e) => _bannerBuilder(e["title"], e["gColor"], e["textColor"]))
            .toList(),
        // _bannerBuilder(
        //     'لوحة صدارة الغرف المميزة', Color(0xFFF792F0), Color(0xFFCC77D9))
      ),
    );
  }

  Padding _bannerBuilder(String title, Color gradientColor, Color textColor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      child: Container(
        height: 180.h,
        // width: 100.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            gradientColor,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),

          // color: Colors.red,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(25.sp),
              child: Image.asset(
                'assets/images/banner.png',
              ),
            )),
            Container(
              decoration: BoxDecoration(
                // color: Color(0xFFCC77D9),
                color: textColor,

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                ),
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontFamily: 'Portada',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

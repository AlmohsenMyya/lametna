// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            _buildBackgroundImage("phone.png", -37.sp, -51.sp, 210),
            _buildBackgroundImage("heart.png", 214.sp, 0.sp, 202, opacity: 1),
            _buildBackgroundImage("message.png", 260.sp, 135.sp, 179),
            _buildBackgroundImage("phone.png", 274.sp, 353.sp, 210),
            _buildBackgroundImage("recipt.png", 41.sp, 651.sp, 201, opacity: 1),
            _buildBackgroundImage("heart.png", 274.sp, 700.sp, 202, opacity: 1),
            _buildBackgroundImage("heart.png", -101.sp, 231.sp, 202,
                opacity: 1),
            _buildBackgroundImage("message.png", 0.sp, 300.sp, 179),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,

                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 290.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFffcc00),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 5.h),
                          child: Text(
                            "دخول الاسماء المسجلة",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontFamily: "Portada"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 7.h),
                              filled: true,
                              hintText: "اسم المستتخدم",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.sp,
                                fontFamily: "Portada",
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xFFf1f1f1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 7.h),
                              filled: true,
                              hintText: "كلمة المرور",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.sp,
                                fontFamily: "Portada",
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xFFf1f1f1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Icon(
                              Icons.file_download_outlined,
                              color: Color(0xFFffcc00),
                              size: 40.sp,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFffcc00),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 5.h),
                              child: Text(
                                "دخول",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.white,
                                    fontFamily: "Portada"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100.h,
              left: Get.width / 2 - 50.w,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/chatHomePage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFffcc00),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 7.h, 20.w, 7.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                        Text(
                          "دخول زائر",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontFamily: "Portada"),
                        ),
                      ],
                    ),
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

Widget _buildBackgroundImage(String image, double x, double y, int size,
    {double? opacity = 0.07}) {
  return Container(
    child: Opacity(
      opacity: opacity!,
      child: Image.asset(
        'assets/images/$image',
        width: size.w,
        fit: BoxFit.scaleDown,
      ),
    ),
    transform: Matrix4.translationValues(x, y, 0),
  );
}

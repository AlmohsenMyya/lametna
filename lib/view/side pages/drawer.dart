// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget homeDrawer() => Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFABD63),
              Color(0xFFF792F0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 45.h),
              child: Image.asset(
                'assets/icons/logo.png',
                // width: 150.w,
                height: 160.h,
              ),
            ),
            isGuest == false && isRole == false
                ? drawerItem(
                    'الملف الشخصي',
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                    () {
                      Get.toNamed('/profile');
                    },
                  )
                : SizedBox(),
            isGuest == false && isRole == false
                ? drawerItem(
                    'لوحة التحكم',
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                    () {
                      Get.toNamed('/mainControllerPanel');
                    },
                  )
                : SizedBox(),
            drawerItem(
              'المتجر',
              Image.asset(
                'assets/icons/bag.png',
                color: Colors.white,
                // color: Colors.white,
                width: 25.w,
                height: 25.h,
              ),
              () {},
            ),
            drawerItem(
              'الدعم الفني',
              Icon(
                Icons.send,
                color: Colors.white,
                size: 27.sp,
              ),
              () {
                Get.toNamed('/customerService');
              },
            ),
            drawerItem(
              'خروج',
              RotatedBox(
                quarterTurns: 2,
                child: Image.asset(
                  "assets/icons/login.png",
                  color: Colors.white,
                  width: 28.w,
                  height: 28.h,
                ),
              ),
              () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                // prefs.('username', null);
                prefs.remove('username');
                prefs.remove('password');
                Get.offAllNamed('/choosingPage');
                isGuest = true;

                /// to make the user guest again
              },
            ),
          ],
        ),
      ),
    );

Widget drawerItem(String title, Widget icon, Function onTap) => Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        dense: true,
        horizontalTitleGap: 0,
        // minLeadingWidth: 9.w,
        onTap: (){
            onTap();
                  },
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Portada',
            fontSize: 16.sp,
          ),
        ),
      ),
    );

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            drawerItem(
              'الملف الشخصي',
              Icon(
                Icons.person,
                color: Colors.white,
                size: 30.sp,
              ),
              () {},
            ),
            drawerItem(
              'لوحة التحكم',
              Icon(
                Icons.person,
                color: Colors.white,
                size: 30.sp,
              ),
              () {},
            ),
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
              () {},
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
        onTap: onTap,
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

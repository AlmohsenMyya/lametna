// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/bottomNavitionBar.dart';
import 'package:lametna/controllers/chathomePageController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/VIPRoombuildder.dart';
import 'package:lametna/view/side%20pages/drawer.dart';
import 'package:lametna/view/side%20pages/scrollText.dart';
import 'package:lametna/view/store/test.dart';
import 'package:carousel_slider/carousel_slider.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ChatHomePage extends StatelessWidget {
  // const ChatHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: Drawer(),
      endDrawer: homeDrawer(),
      onEndDrawerChanged: (isOpened) {
        // print("isOpened");
        if (isOpened) {
          print("open");
          Get.put(BottomNavitionBarController()).changeShow();
        } else {
          print("close");
          Get.put(BottomNavitionBarController()).changeShow();
        }
      },
      endDrawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(27.r),
              bottomRight: Radius.circular(27.r),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFABD63),
                Color(0xFFF792F0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 110.w,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.toNamed('/favourite');
                    },
                    icon: Icon(Icons.favorite),
                  ),
                ],
              ),
              title: Text(
                "Lametna",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/search');
                  },
                  child: Icon(Icons.search, size: 30.sp),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/trophy');
                  },
                  child: Image.asset(
                    "assets/images/trophy.png",
                    width: 55.w,
                    height: 30.h,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState.openEndDrawer();
                  },
                  child: Icon(Icons.menu, size: 30.sp),
                ),
                SizedBox(width: 10.w)
              ],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0.h),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: (130 / 2).h,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.asset(
                                  "assets/images/banner.png",
                                  // width: 100.w,
                                  width: Get.width,
                                  // height: 30.h,
                                  fit: BoxFit.cover,
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ))),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 8.h,
              ),
              GetBuilder<ChatHomeController>(
                  init: ChatHomeController(),
                  builder: (controller) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.h,
                          decoration: controller.selectedIndex == 1
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFABD63),
                                      Color(0xFFF792F0),
                                    ],
                                  ),
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: Color(0xFFDADADC),
                                  ),
                                ),
                          child: TextButton(
                            onPressed: () {
                              controller.changeIndex(1);
                            },
                            child: Text(
                              'الغرف العادية',
                              style: controller.selectedIndex == 1
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    )
                                  : TextStyle(
                                      color: Color(0xFFDADADC),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Container(
                          height: 50.h,
                          decoration: controller.selectedIndex != 1
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFABD63),
                                      Color(0xFFF792F0),
                                    ],
                                  ),
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: Color(0xFFDADADC),
                                  ),
                                ),
                          child: TextButton(
                            onPressed: () {
                              controller.changeIndex(0);
                              // Scaffold.of(context).openDrawer();
                            },
                            child: Text(
                              'الغرف المميزة',
                              style: controller.selectedIndex != 1
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    )
                                  : TextStyle(
                                      color: Color(0xFFDADADC),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

              // _countriesBuilder(),
              GetBuilder<ChatHomeController>(builder: (controller) {
                return controller.vipRooms.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 150.h),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : controller.selectedIndex != 1
                        ? ListView.builder(
                            cacheExtent: 20,
                            itemCount: controller.vipRooms.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return roomBuilder(data: controller.vipRooms[index], controller: controller);
                            },
                          )
                        : ListView.builder(
                            cacheExtent: 20,
                            itemCount: controller.regularRooms.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return roomBuilder(
                                data: controller.regularRooms[index],
                                controller: controller,
                                isVIP: false,
                              );
                            },
                          );
              }),
            ],
          ),
          Container(
            color: Color(0xFFF1F1F1),
            height: 35.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GetBuilder<ChatHomeController>(
                  builder: (controller) => Text(
                    "${controller.numberOfConnections} مستخدم ",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xFFA2ACAC), fontFamily: 'Portada', fontSize: 10.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Icon(Icons.person, color: Color(0xFFA2ACAC), size: 22.sp),
                SizedBox(
                  width: 30.w,
                ),
                GetBuilder<ChatHomeController>(
                  builder: (controller) => Text(
                    "${controller.roomNumber} غرفة ",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xFFA2ACAC), fontFamily: 'Portada', fontSize: 10.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Image.asset(
                  'assets/icons/home.png',
                  width: 19.w,
                  color: Color(0xFFA2ACAC),
                  // height: 30.h,
                ),
                SizedBox(
                  width: 35.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

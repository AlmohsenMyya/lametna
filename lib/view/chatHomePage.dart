// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chathomePageController.dart';
import 'package:lametna/view/side%20pages/drawer.dart';
import 'package:lametna/view/store/test.dart';

class ChatHomePage extends StatelessWidget {
  // const ChatHomePage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      // drawer: Drawer(),
      endDrawer: homeDrawer(),
      endDrawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(300.h),
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
              leadingWidth: 130.w,
              leading: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
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
              // actions: [
              //   Image.asset(
              //     "assets/images/trophy.png",
              //     width: 55.w,
              //     height: 30.h,
              //   ),
              //   IconButton(
              //       onPressed: () {
              //         print("object");
              //         Scaffold.of(context).openDrawer();
              //         _scaffoldKey.currentState.openEndDrawer();
              //       },
              //       icon: Icon(Icons.menu)),
              // ],

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(100.h),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 45.h, horizontal: 35.w),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      width: 350.w,
                      child: Image.asset(
                        "assets/images/banner.png",
                        // width: 100.w,
                        // height: 100.h,
                      )),
                ),
              )),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 15.h,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    hintText: "بحث عن غرفة",
                    hintStyle: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 34.h,
          ),
          GetBuilder<ChatHomeController>(
              init: ChatHomeController(),
              builder: (controller) {
                return Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Scaffold.of(context).openDrawer();
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
          GetBuilder<ChatHomeController>(builder: (controller) {
            return SizedBox(
              height: (4 * 185).h,
              child: PageView(
                // physics: NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                // allowImplicitScrolling: true,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          _countriesBuilder(),
                          _builderRooms(context, color: Colors.green),
                          _builderRooms(context, color: Colors.red),
                          _builderRooms(context, color: Colors.blue),
                          _builderRooms(context, color: Colors.blue),

                          //el mic
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        _countriesBuilder(),
                        _builderRooms(context),
                        _builderRooms(context),
                        _builderRooms(context),
                        _builderRooms(context),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _countriesBuilder() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "البلد:",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Portada", fontSize: 12.sp),
            ),
            SizedBox(
              width: 5.w,
            ),
            GetBuilder<ChatHomeController>(
                init: ChatHomeController(),
                builder: (controller) {
                  return SizedBox(
                    height: 25.h,
                    width: Get.width * 0.8,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.countries.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(14.r), // Image radius
                            child: Image.asset(
                                'assets/images/flags/${controller.countries[index]}.png',
                                fit: BoxFit.fill,
                                width: 12.w,
                                height: 12.h),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _builderRooms(BuildContext context, {Color color = Colors.white}) {
    //bet5od color law mafesh color betb2a white
    //shayf el widget dy??
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          showAlert(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        height: 80.h,
                        width: 100.w,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10), // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(30.r), // Image radius
                            child: Image.network(
                              'https://media.istockphoto.com/id/1295072146/vector/mini-heart-korean-love-hand-finger-symbol-on-pink-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=eihpG3p1GoSvMjlSAQjCft50iff2I1AweF2a1MLI1SQ=',
                              fit: BoxFit.fill,
                              // height: 30,
                              // width: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        // height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/flags/egypt.png",
                                  width: 14.w,
                                  height: 15.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "القاهرة",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "Portada"),
                                ),
                              ],
                            ),
                            Text(
                              "الهروب من الواقع",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "Portada"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الناس يعرفون معني الوفاء",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontFamily: "Portada"),
                        ),
                        Text("300 ",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontFamily: "Portada")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<ChatHomeController>(builder: (controller) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.changeAlertIndex(0);
                    },
                    child: Container(
                      width: 90.w,
                      height: 40.h,
                      decoration: controller.alertIndex != 1
                          ? BoxDecoration(
                              color: Color(0xFFEFA11B),
                              borderRadius: BorderRadius.circular(10.r),
                            )
                          : BoxDecoration(
                              // color: Color(0xFFEFA11B),
                              border: Border.all(
                                  color: Color(0xFFFABB64), width: 1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                      child: Center(
                        child: Text(
                          "زائر",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: controller.alertIndex == 1
                                  ? Color(0xFFEFA11B)
                                  : Colors.white,
                              fontFamily: "Portada"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.changeAlertIndex(1);
                    },
                    child: Container(
                      width: 90.w,
                      height: 40.h,
                      decoration: controller.alertIndex == 1
                          ? BoxDecoration(
                              color: Color(0xFFEFA11B),
                              borderRadius: BorderRadius.circular(10.r),
                            )
                          : BoxDecoration(
                              // color: Color(0xFFEFA11B),
                              border: Border.all(
                                  color: Color(0xFFFABB64), width: 1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                      child: Center(
                        child: Text("عضو",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: controller.alertIndex != 1
                                    ? Color(0xFFEFA11B)
                                    : Colors.white,
                                fontFamily: "Portada")),
                      ),
                    ),
                  )
                ],
              ),
              content: Container(
                // width: MediaQuery.of(context).size.width * 0.8,
                // height: MediaQuery.of(context).size.height * 0.5,
                height: controller.alertIndex != 1 ? 135.h : 215.h,
                width: 366.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: controller.alertIndex != 1 ? 50.h : 131.h,
                      child: PageView(
                        controller: controller.alertPageController,
                        children: <Widget>[
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.person,
                                    size: 20.sp,
                                    color: Colors.grey,
                                  ),
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
                          Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person,
                                        size: 20.sp,
                                        color: Colors.grey,
                                      ),
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
                                        borderRadius:
                                            BorderRadius.circular(10.r),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
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
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Color(0xFFf1f1f1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/room');
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFEFA11B),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              "دخول",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Portada"),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    ).then((value) {
      Get.put(ChatHomeController()).changeAlertIndex(0);
    });
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chathomePage.dart';

class ChatHomePage extends StatelessWidget {
  // const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              actions: [
                Image.asset(
                  "assets/images/trophy.png",
                  width: 55.w,
                  height: 30.h,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
              ],
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
      body: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
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
                height: 500.h,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  // allowImplicitScrolling: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: ListView(
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          _countriesBuilder(),
                          _builderRooms(
                              color: Color.fromARGB(255, 226, 92, 137)),
                          _builderRooms(color: Colors.lightBlueAccent),
                          _builderRooms(color: Colors.orangeAccent),
                          _builderRooms(
                              color: Color.fromARGB(255, 226, 92, 137)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: ListView(
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          _countriesBuilder(),
                          _builderRooms(),
                          _builderRooms(),
                          _builderRooms(),
                          _builderRooms(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _countriesBuilder() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Row(
          children: [
            Text(
              "البلد:",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Portada", fontSize: 12.sp),
            ),
            SizedBox(
              width: 15.w,
            ),
            GetBuilder<ChatHomeController>(
                init: ChatHomeController(),
                builder: (controller) {
                  return SizedBox(
                    height: 25.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.countries.length,
                        itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(15.r), // Image radius
                                  child: Image.asset(
                                      'assets/images/flags/${controller.countries[index]}.png',
                                      fit: BoxFit.fill),
                                ),
                              ),
                            )),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _builderRooms({Color color = Colors.white}) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
                        borderRadius: BorderRadius.circular(10), // Image border
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
    );
  }
}

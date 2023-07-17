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
import 'package:lametna/view/side%20pages/drawer.dart';
import 'package:lametna/view/side%20pages/scrollText.dart';
import 'package:lametna/view/store/test.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ChatHomePage extends StatelessWidget {
  // const ChatHomePage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        preferredSize: Size.fromHeight(250.h),
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
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                  child: Icon(Icons.menu, size: 30.sp),
                ),
                SizedBox(width: 10.w)
              ],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 150.h,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
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
                                  // height: 100.h,
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
          SizedBox(
            height: 540.h,
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 14.h,
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

                // _countriesBuilder(),
                GetBuilder<ChatHomeController>(builder: (controller) {
                  return controller.vipRooms.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 150.h),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SizedBox(
                          height: (controller.vipRooms.length * 185).h,
                          child: PageView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: controller.pageController,
                            // allowImplicitScrolling: true,
                            children: [
                              ListView.builder(
                                itemCount: controller.vipRooms.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isGuest || isRole) {
                                          showAlert(
                                              context,
                                              controller.vipRooms[index]
                                                  ["room_id"],
                                              controller.vipRooms[index]
                                                  ["room_name"],
                                              controller.vipRooms[index]
                                                  ["owner_username"]);
                                        } else {
                                          controller.checkIfBanned(
                                              controller.vipRooms[index]
                                                  ["room_id"],
                                              controller.vipRooms[index]
                                                  ["owner_username"],
                                              controller.vipRooms[index]
                                                  ["room_name"]);
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w, vertical: 5.h),
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                      controller.vipRooms[index]
                                                              [
                                                              "background_color"]
                                                          .substring(1, 7),
                                                      radix: 16) +
                                                  0xFF000000),
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFF43D0CA),
                                                            ),
                                                          ),
                                                          height: 56.h,
                                                          width: 60.w,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10
                                                                        .r), // Image border
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: Size
                                                                  .fromRadius(30
                                                                      .r), // Image radius
                                                              child:
                                                                  Image.network(
                                                                roomImagesURL +
                                                                    controller.vipRooms[
                                                                            index]
                                                                        [
                                                                        "room_img"],
                                                                errorBuilder: (context,
                                                                        error,
                                                                        stackTrace) =>
                                                                    Image.network(
                                                                        "https://media.istockphoto.com/id/1295072146/vector/mini-heart-korean-love-hand-finger-symbol-on-pink-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=eihpG3p1GoSvMjlSAQjCft50iff2I1AweF2a1MLI1SQ=",
                                                                        fit: BoxFit
                                                                            .fill),
                                                                //  '',
                                                                fit:
                                                                    BoxFit.fill,
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
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                controller.vipRooms[
                                                                        index][
                                                                    "room_name"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "Portada"),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/images/flags/${controller.vipRooms[index]["flag"]}.png",
                                                                    width: 14.w,
                                                                    height:
                                                                        15.h,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Text(
                                                                    controller.vipRooms[
                                                                            index]
                                                                        [
                                                                        "country_name"],
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            "Portada"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    GetBuilder<
                                                            ChatHomeController>(
                                                        builder: (controller) {
                                                      return IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        constraints:
                                                            BoxConstraints(),
                                                        onPressed: () {
                                                          controller.addOrRemoveToFavourite(
                                                              controller.vipRooms[
                                                                      index]
                                                                  ["room_id"]);
                                                        },
                                                        icon: Icon(
                                                            controller.favoriteRooms
                                                                    .contains(controller
                                                                            .vipRooms[index]
                                                                        [
                                                                        "room_id"])
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border,
                                                            size: 20.sp,
                                                            color: controller
                                                                    .favoriteRooms
                                                                    .contains(controller
                                                                            .vipRooms[index]
                                                                        [
                                                                        "room_id"])
                                                                ? Colors.red
                                                                : null),
                                                      );
                                                    })
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 18.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        controller
                                                                .vipRooms[index]
                                                            ["description"],
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "Portada"),
                                                      ),
                                                      Text("300 ",
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "Portada")),
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
                                },
                              ),
                              //-------------
                              ListView.builder(
                                itemCount: controller.regularRooms.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isGuest || isRole) {
                                          print("true");
                                          showAlert(
                                              context,
                                              controller.regularRooms[index]
                                                  ["room_id"],
                                              controller.regularRooms[index]
                                                  ["room_name"],
                                              controller.vipRooms[index]
                                                  ["owner_username"]);
                                        } else {
                                          controller.checkIfBanned(
                                              controller.regularRooms[index]
                                                  ["room_id"],
                                              controller.regularRooms[index]
                                                  ["owner_username"],
                                              controller.regularRooms[index]
                                                  ["room_name"]);
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w, vertical: 5.h),
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFF43D0CA),
                                                            ),
                                                          ),
                                                          height: 56.h,
                                                          width: 60.w,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10
                                                                        .r), // Image border
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: Size
                                                                  .fromRadius(30
                                                                      .r), // Image radius
                                                              child:
                                                                  Image.network(
                                                                'https://media.istockphoto.com/id/1295072146/vector/mini-heart-korean-love-hand-finger-symbol-on-pink-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=eihpG3p1GoSvMjlSAQjCft50iff2I1AweF2a1MLI1SQ=',
                                                                fit:
                                                                    BoxFit.fill,
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
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                controller.regularRooms[
                                                                        index][
                                                                    "room_name"],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "Portada"),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/images/flags/${controller.regularRooms[index]["flag"]}.png",
                                                                    width: 14.w,
                                                                    height:
                                                                        15.h,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.w,
                                                                  ),
                                                                  Text(
                                                                    controller.regularRooms[
                                                                            index]
                                                                        [
                                                                        "country_name"],
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            "Portada"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    GetBuilder<
                                                            ChatHomeController>(
                                                        builder: (controller) {
                                                      return IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        constraints:
                                                            BoxConstraints(),
                                                        onPressed: () {
                                                          controller.addOrRemoveToFavourite(
                                                              controller.regularRooms[
                                                                      index]
                                                                  ["room_id"]);
                                                        },
                                                        icon: Icon(
                                                            controller.favoriteRooms
                                                                    .contains(controller
                                                                            .regularRooms[index]
                                                                        [
                                                                        "room_id"])
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border,
                                                            size: 20.sp,
                                                            color: controller
                                                                    .favoriteRooms
                                                                    .contains(controller
                                                                            .regularRooms[index]
                                                                        [
                                                                        "room_id"])
                                                                ? Colors.red
                                                                : null),
                                                      );
                                                    })
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 18.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        controller.regularRooms[
                                                                index]
                                                            ["description"],
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "Portada"),
                                                      ),
                                                      Text("300 ",
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "Portada")),
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
                                },
                              ),
                            ],
                          ),
                        );
                }),
              ],
            ),
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
                    style: TextStyle(
                        color: Color(0xFFA2ACAC),
                        fontFamily: 'Portada',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
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
                    style: TextStyle(
                        color: Color(0xFFA2ACAC),
                        fontFamily: 'Portada',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
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
// Widget _countriesBuilder() {
//   return Directionality(
//     textDirection: TextDirection.rtl,
//     child: Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "البلد:",
//             style: TextStyle(
//                 color: Colors.black, fontFamily: "Portada", fontSize: 12.sp),
//           ),
//           SizedBox(
//             width: 5.w,
//           ),
//           GetBuilder<ChatHomeController>(
//               init: ChatHomeController(),
//               builder: (controller) {
//                 return SizedBox(
//                   height: 25.h,
//                   width: Get.width * 0.8,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     physics: BouncingScrollPhysics(),
//                     itemCount: controller.countries.length,
//                     itemBuilder: (context, index) => Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 3.w),
//                       child: ClipOval(
//                         child: SizedBox.fromSize(
//                           size: Size.fromRadius(14.r), // Image radius
//                           child: Image.asset(
//                               'assets/images/flags/${controller.countries[index]}.png',
//                               fit: BoxFit.fill,
//                               width: 12.w,
//                               height: 12.h),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//         ],
//       ),
//     ),
//   );
// }

void showAlert(
    BuildContext context, String roomId, String roomName, String roomOwner) {
  Get.dialog(
    // context: context,

    GetBuilder<ChatHomeController>(builder: (controller) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
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
                          border:
                              Border.all(color: Color(0xFFFABB64), width: 1),
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
                          border:
                              Border.all(color: Color(0xFFFABB64), width: 1),
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
          content: SizedBox(
            // width: MediaQuery.of(context).size.width * 0.8,
            // height: MediaQuery.of(context).size.height * 0.5,
            // height: controller.alertIndex != 1 ? 135.h : 215.h,
            width: 366.w,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: controller.alertIndex != 1 ? 50.h : 155.h,
                    child: PageView(
                      controller: controller.alertPageController,
                      children: <Widget>[
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextFormField(
                              controller: controller.guestController,
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
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: TextFormField(
                                  controller: controller.roleUsernameController,
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
                                    color: Colors.black,
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
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: TextFormField(
                                  controller: controller.rolePasswordController,
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
                                    color: Colors.black,
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
                      if (controller.alertIndex == 0) {
                        controller.loginAsGuest(roomName, roomId);
                        FocusScope.of(context).unfocus();

                        // if (controller.guestController.text == "") {
                        //   // userName = controller.guestController.text;
                        //   print("empty");
                        // }
                      } else {
                        // print("object");contro
                        FocusScope.of(context).unfocus();
                        controller.loginRoleAccount(roomId, roomId, roomOwner);
                        // print(isGuest);
                        // if (isGuest == false) {
                        //   Get.toNamed('/room', arguments: {
                        //     "room_name": roomName,
                        //     "room_id": roomId,
                        //   });
                        // } else {
                        //   Get.snackbar("error", "login first");
                        // }
                      }
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
        ),
      );
    }),
  ).then((value) {
    Get.put(ChatHomeController()).changeAlertIndex(0);
  });
}

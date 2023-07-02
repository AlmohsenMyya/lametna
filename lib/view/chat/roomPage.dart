// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, missing_return, use_full_hex_values_for_flutter_colors

import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:lametna/model/message.dart';
import 'package:lametna/view/chat/roomMangement.dart';
import 'package:lametna/view/messages/messages.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../../controllers/userData/userCredentials.dart';

class RoomPage extends StatelessWidget {
  bool isOwner = Get.arguments["owner"] != userName;
  // const RoomPage({super.key});

  RoomPage({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Get.put(RoomsPageController()).onLeave();
          // return true;
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawerScrimColor: Colors.transparent,
          endDrawer: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 70.h),
              child: Container(
                  height: double.infinity,
                  width: 300.w,
                  color: Colors.white,
                  child: GetBuilder<RoomsPageController>(
                      init: RoomsPageController(),
                      builder: (controller) {
                        return FutureBuilder(
                          builder: (context, snapshot) => snapshot.data == null
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      PopupMenuButton(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color(0xFF43D0CA),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            snapshot.data["data"][index]
                                                ["username"],
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: "Segoe UI",
                                              color: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Image.asset(
                                              'assets/icons/profile.png',
                                              width: 25.w,
                                              height: 30.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 0,
                                        height: 25.h,
                                        textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Portada",
                                          color: Color(0xFF43D0CA),
                                        ),
                                        child: PopupMenuButton(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "معلومات المستخدم",
                                            ),
                                          ),
                                          itemBuilder: (context) => [
                                            usersPopUpMenu('اسم المستخدم'),
                                            usersPopUpMenu('رقم الاي بي'),
                                            usersPopUpMenu('نوع الجهاز'),
                                            usersPopUpMenu('الدول'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 0,
                                        height: 25.h,
                                        textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Portada",
                                          color: Color(0xFF43D0CA),
                                        ),
                                        child: PopupMenuButton(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "طرد",
                                            ),
                                          ),
                                          itemBuilder: (context) => [
                                            usersPopUpMenu('محادثة خاصة'),
                                            usersPopUpMenu('watan'),
                                            usersPopUpMenu('تجاهل'),
                                            usersPopUpMenu(
                                                'الابلاغ عن المسخدم'),
                                            usersPopUpMenu('خيارات الأشراف'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 0,
                                        height: 25.h,
                                        textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Portada",
                                          color: Color(0xFF43D0CA),
                                        ),
                                        child: PopupMenuButton(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "حظر",
                                            ),
                                          ),
                                          itemBuilder: (context) => [
                                            usersPopUpMenu('١٥  دقيقة'),
                                            usersPopUpMenu('ساعة'),
                                            usersPopUpMenu('٦ ساعة'),
                                            usersPopUpMenu('يوم'),
                                            usersPopUpMenu('اسبوع'),
                                            usersPopUpMenu('شهر'),
                                            usersPopUpMenu('دائم'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 0,
                                        height: 25.h,
                                        textStyle: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Portada",
                                          color: Color(0xFF43D0CA),
                                        ),
                                        child: PopupMenuButton(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "ايقاف",
                                            ),
                                          ),
                                          itemBuilder: (context) => [],
                                        ),
                                      ),
                                      usersPopUpMenu("إرسال تحذير"),
                                    ],
                                  ),
                                  itemCount: snapshot.data["data"].length,
                                ),
                          future: controller.getRoomMembers(),
                        );
                      })
                  //     ListView(
                  //   children: List.generate(
                  //     40,
                  //     (index) => PopupMenuButton(
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 10.w, vertical: 10.h),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           border: Border.all(
                  //             color: Color(0xFF43D0CA),
                  //             width: 2.0,
                  //           ),
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             Text(
                  //               'محمود',
                  //               style: TextStyle(
                  //                 fontSize: 14.sp,
                  //                 fontFamily: "Segoe UI",
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //               child: Image.asset(
                  //                 'assets/icons/profile.png',
                  //                 width: 25.w,
                  //                 height: 30.h,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       itemBuilder: (context) => [
                  //         PopupMenuItem(
                  //           value: 0,
                  //           height: 25.h,
                  //           textStyle: TextStyle(
                  //             fontSize: 10.sp,
                  //             fontWeight: FontWeight.bold,
                  //             fontFamily: "Portada",
                  //             color: Color(0xFF43D0CA),
                  //           ),
                  //           child: PopupMenuButton(
                  //             child: Align(
                  //               alignment: Alignment.center,
                  //               child: Text(
                  //                 "معلومات المستخدم",
                  //               ),
                  //             ),
                  //             itemBuilder: (context) => [
                  //               usersPopUpMenu('اسم المستخدم'),
                  //               usersPopUpMenu('رقم الاي بي'),
                  //               usersPopUpMenu('نوع الجهاز'),
                  //               usersPopUpMenu('الدول'),
                  //             ],
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: 0,
                  //           height: 25.h,
                  //           textStyle: TextStyle(
                  //             fontSize: 10.sp,
                  //             fontWeight: FontWeight.bold,
                  //             fontFamily: "Portada",
                  //             color: Color(0xFF43D0CA),
                  //           ),
                  //           child: PopupMenuButton(
                  //             child: Align(
                  //               alignment: Alignment.center,
                  //               child: Text(
                  //                 "طرد",
                  //               ),
                  //             ),
                  //             itemBuilder: (context) => [
                  //               usersPopUpMenu('محادثة خاصة'),
                  //               usersPopUpMenu('watan'),
                  //               usersPopUpMenu('تجاهل'),
                  //               usersPopUpMenu('الابلاغ عن المسخدم'),
                  //               usersPopUpMenu('خيارات الأشراف'),
                  //             ],
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: 0,
                  //           height: 25.h,
                  //           textStyle: TextStyle(
                  //             fontSize: 10.sp,
                  //             fontWeight: FontWeight.bold,
                  //             fontFamily: "Portada",
                  //             color: Color(0xFF43D0CA),
                  //           ),
                  //           child: PopupMenuButton(
                  //             child: Align(
                  //               alignment: Alignment.center,
                  //               child: Text(
                  //                 "حظر",
                  //               ),
                  //             ),
                  //             itemBuilder: (context) => [
                  //               usersPopUpMenu('١٥  دقيقة'),
                  //               usersPopUpMenu('ساعة'),
                  //               usersPopUpMenu('٦ ساعة'),
                  //               usersPopUpMenu('يوم'),
                  //               usersPopUpMenu('اسبوع'),
                  //               usersPopUpMenu('شهر'),
                  //               usersPopUpMenu('دائم'),
                  //             ],
                  //           ),
                  //         ),
                  //         PopupMenuItem(
                  //           value: 0,
                  //           height: 25.h,
                  //           textStyle: TextStyle(
                  //             fontSize: 10.sp,
                  //             fontWeight: FontWeight.bold,
                  //             fontFamily: "Portada",
                  //             color: Color(0xFF43D0CA),
                  //           ),
                  //           child: PopupMenuButton(
                  //             child: Align(
                  //               alignment: Alignment.center,
                  //               child: Text(
                  //                 "ايقاف",
                  //               ),
                  //             ),
                  //             itemBuilder: (context) => [],
                  //           ),
                  //         ),
                  //         usersPopUpMenu("إرسال تحذير"),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  ),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(72.h),
            child: Container(
              decoration: const BoxDecoration(
                // LinearGradient
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFF792F0),
                    const Color(0xFFFABD63),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: AppBar(
                leadingWidth: 105.w,
                toolbarHeight: 72.35.h,
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  Get.arguments['room_name'],
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "Portada",
                    color: Colors.white,
                  ),
                ),
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 5.w),
                    GetBuilder<RoomsPageController>(
                        init: RoomsPageController(),
                        builder: (controller) {
                          return GestureDetector(
                            onTap: () {
                              controller.onLeave();
                              // Get.back();
                            },
                            child: ImageIcon(
                              AssetImage('assets/icons/login.png'),
                            ),
                          );
                        }),
                    PopupMenuButton(
                      onCanceled: () {
                        print("You have canceled the menu.");
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          {
                            "value": "0",
                            "name": "الحالة",
                            "mustBeAdmin": false,
                            "icon": Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 17,
                            ),
                          },
                          {
                            "value": "1",
                            "name": "الاعدادات",
                            "mustBeAdmin": false,
                            "icon": Icon(
                              Icons.settings,
                              color: Colors.black,
                              size: 17,
                            ),
                          },
                          {
                            "value": "2",
                            "name": "اللحظات",
                            "mustBeAdmin": false,
                            "icon": Image.asset(
                              "assets/icons/planet.png",
                              color: Colors.black,
                              width: 22,
                            ),
                          },
                          {
                            "value": "3",
                            "name": "إدارة الغرفة",
                            "mustBeAdmin": true,
                            "icon": Icon(
                              Icons.home,
                              color: Colors.black,
                              size: 17,
                            ),
                          },
                          {
                            "value": "4",
                            "name": "مشاركة",
                            "mustBeAdmin": false,
                            "icon": Icon(
                              Icons.share,
                              color: Colors.black,
                              size: 17,
                            ),
                          },
                          {
                            "value": "5",
                            "name": "المفضلة",
                            "mustBeAdmin": false,
                            "icon": Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 17,
                            ),
                            "onTap": "/contact"
                          },
                          {
                            "value": "6",
                            "name": "عن البرنامج",
                            "mustBeAdmin": false,
                            "icon": Icon(
                              Icons.help,
                              color: Colors.black,
                              size: 17,
                            ),
                          },
                        ]
                            .toList()
                            .map((e) => PopupMenuItem(
                                  height: e["mustBeAdmin"] ? 0 : 40.h,
                                  child: e["mustBeAdmin"] && isOwner
                                      ? SizedBox()
                                      : Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(e["name"],
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: "Segoe",
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child: e["icon"],
                                            ),
                                          ],
                                        ),
                                  value: int.parse(e["value"]),
                                ))
                            .toList();
                      },
                      onSelected: (value) {
                        if (value == 1) {
                          Get.toNamed("/roomSettingsPage");
                        } else if (value == 2) {
                          Get.toNamed('/moments');
                        } else if (value == 3) {
                          Get.toNamed('/roomMangement', arguments: {
                            "room_id": Get.arguments['room_id'],
                            "room_name": Get.arguments['room_name'],
                          });
                        } else if (value == 6) {
                          Get.toNamed('/about');
                        }
                      },
                    )
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.volume_up),
                  ),
                  ImageIcon(
                    AssetImage('assets/icons/chat.png'),
                    size: 23.sp,
                  ),
                  Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Image.asset(
                          'assets/icons/group.png',
                          width: 30.sp,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),

          body: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    GetBuilder<RoomsPageController>(
                        init: RoomsPageController(),
                        builder: (controller) {
                          return Container(
                            height: 70.h,
                            decoration: BoxDecoration(
                              // LinearGradient
                              gradient: controller.roomStatus
                                  ? LinearGradient(
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFFA2ACAC),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    )
                                  : LinearGradient(
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFFFABD63),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 21.w,
                                ),
                                isOwner
                                    ? SizedBox(
                                        width: 65.w,
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          // Get.toNamed('/VIPRoom');
                                          controller.changeRoomStatus();
                                        },
                                        child: SizedBox(
                                          width: 65.w,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: controller.roomStatus
                                                  ? Color(0xffF792F0)
                                                  : Color(0xFFFABD63),
                                            ),
                                            child: Text(
                                              controller.roomStatus
                                                  ? 'الروم الحديث'
                                                  : "مظهر قديم",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 9.sp,
                                                  fontFamily: "Portada",
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 60.w,
                                ),
                                Text("22:10",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        fontFamily: "Portada",
                                        color: Colors.black)),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width: 240.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      userInCall(),
                                      userInCall(),
                                      userInCall(),
                                      userInCall(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                    GetBuilder<RoomsPageController>(builder: (controller) {
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // LinearGradient
                            gradient: controller.roomStatus
                                ? null
                                : LinearGradient(
                                    colors: [
                                      Color(0xFFFABD63),
                                      Color(0xFFFABB64),
                                      Color(0xFFF792F0),
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                  ),
                          ),
                          // child: Container(),
                          child: StreamBuilder(
                            builder: (context, snapshot) {
                              // print(snapshot.data.length);
                              return snapshot.hasData
                                  ? NotificationListener(
                                      onNotification:
                                          (ScrollNotification scrollInfo) {
                                        scrollInfo.metrics.pixels > 80
                                            ? controller
                                                .scrollDownButtonStatus(false)
                                            : controller
                                                .scrollDownButtonStatus(true);
                                      },
                                      // child: Text(snapshot.data.toString()),
                                      // child: ListView.builder(
                                      //   controller: controller.scrollController,
                                      //   reverse: true,
                                      //   shrinkWrap: true,
                                      //   itemCount: snapshot.data["data"].length,
                                      //   itemBuilder: (context, index) => snapshot
                                      //                   .data["data"][index]
                                      //               ["senderName"] ==
                                      //           "roomAlert"
                                      //       ? joinAndLeaveAlert(
                                      //           controller.roomStatus,
                                      //           snapshot.data["data"][index]["joinOrLeave"] == "0"
                                      //               ? true
                                      //               : false,
                                      //           "alert",
                                      //           snapshot.data["data"][index]
                                      //               ["message"])
                                      //       : controller.roomStatus
                                      //           ? messageBuilder(
                                      //               context,
                                      //               snapshot.data["data"]
                                      //                   [index],
                                      //               snapshot.data["data"][index]["isGuest"] == "0"
                                      //                   ? true
                                      //                   : false)
                                      //           : messageVIPBuilder(
                                      //               context,
                                      //               snapshot.data["data"][index],
                                      //               snapshot.data["data"][index]["isGuest"] == "0" ? true : false),

                                      //   //  Text(snapshot.data["data"][index]
                                      //   //         ["senderName"]
                                      //   //     .toString()),
                                      // ),
                                      child: ListView.builder(
                                        controller: controller.scrollController,
                                        reverse: true,
                                        itemBuilder: (context, index) {
                                          if (snapshot.data["data"][index]
                                                  ["senderName"] ==
                                              "roomAlert") {
                                            return joinAndLeaveAlert(
                                                controller.roomStatus,
                                                snapshot.data["data"][index]
                                                            ["joinOrLeave"] ==
                                                        "0"
                                                    ? true
                                                    : false,
                                                snapshot.data["data"][index]
                                                        ["senderName"]
                                                    .toString(),
                                                snapshot.data["data"][index]
                                                        ["message"]
                                                    .toString());
                                          } else {
                                            if (controller.roomStatus) {
                                              return messageBuilder(
                                                  context,
                                                  snapshot.data["data"][index],
                                                  snapshot.data["data"][index]
                                                              ["isGuest"] ==
                                                          "0"
                                                      ? true
                                                      : false);
                                            } else {
                                              return messageVIPBuilder(
                                                  context,
                                                  snapshot.data["data"][index],
                                                  snapshot.data["data"][index]
                                                              ["isGuest"] ==
                                                          "0"
                                                      ? true
                                                      : false);
                                              // return messageVIPBuilder(
                                              //     context,
                                              //     snapshot.data["data"][index],
                                              //     snapshot.data["data"][index]
                                              //                 ["isGuest"] ==
                                              //             "0"
                                              //         ? true
                                              //         : false);
                                            }
                                          }
                                        },
                                        itemCount: snapshot.data["data"].length,
                                        // itemCount: 1,
                                      ),
                                    )
                                  : Center(child: CircularProgressIndicator());
                            },
                            stream: controller.streamController.stream,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              buildMyNavBar(context),
              emojiPickerBuilder()
            ],
          ),
          floatingActionButton: GetBuilder<RoomsPageController>(
            builder: (controller) {
              return !controller.scrollDownButton
                  ? Padding(
                      padding:
                          EdgeInsets.only(bottom: 60.h, right: 5.w, left: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          controller.scrollController.animateTo(0,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          // width: 148.w,
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 0.35,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            gradient: !controller.roomStatus
                                ? LinearGradient(
                                    colors: [
                                      Color(0xFF00E54C),
                                      Color(0xFFDADADC),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : LinearGradient(
                                    colors: [
                                      Color(0xFFF792F0),
                                      Color(0xFFFABD63),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 7.h),
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "الرسائل الجديدة",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Segoe UI',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
            },
          ),
          // bottomNavigationBar: ,
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }

  Widget emojiPickerBuilder() {
    return GetBuilder<RoomsPageController>(builder: (controller) {
      return Offstage(
        offstage: controller.emojiStatus,
        child: SizedBox(
          height: 300.h,
          child: EmojiPicker(
            onEmojiSelected: (Category category, Emoji emoji) {
              // Do something when emoji is tapped (optional)
            },
            onBackspacePressed: () {
              // Do something when the user taps the backspace button (optional)
              // Set it to null to hide the Backspace-Button
            },
            textEditingController: controller
                .messageController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
            config: Config(
              columns: 7,
              emojiSizeMax: 32 *
                  (foundation.defaultTargetPlatform == TargetPlatform.iOS
                      ? 1.30
                      : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
              verticalSpacing: 0,
              horizontalSpacing: 0,
              gridPadding: EdgeInsets.zero,
              initCategory: Category.RECENT,
              bgColor: Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              recentTabBehavior: RecentTabBehavior.RECENT,
              recentsLimit: 28,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ), // Needs to be const Widget
              loadingIndicator:
                  const SizedBox.shrink(), // Needs to be const Widget
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL,
            ),
          ),
        ),
      );
    });
  }

  Widget messageBuilder(BuildContext context, dynamic data, bool guest) {
    // return Text(
    //   data["message"],
    //   style: TextStyle(
    //     color: Colors.black,
    //   ),
    // );
    return guest
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      // height: 20.h,
                      width: double.infinity,
                      color: Color(0xFFCAF8ED),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            data["senderName"] == guestUserName ||
                                    data["senderName"] == userName
                                ? 0.w
                                : 55.w,
                            5.h,
                            data["senderName"] == userName ||
                                    data["senderName"] == guestUserName
                                ? 55.w
                                : 0,
                            5.h),
                        child: Text(
                          data["senderName"],
                          textAlign: data["senderName"] == userName
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Portada",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: data["senderName"] == userName
                            ? LinearGradient(
                                colors: [
                                  Color(0xFFF792F0),
                                  Color(0xFFF1F1F1),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Color(0xFFF1F1F1),
                                  Color(0xFFF792F0),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                        borderRadius: data["senderName"] == userName
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                              )
                            : BorderRadius.only(
                                bottomRight: Radius.circular(20.r),
                              ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            data["senderName"] == userName ? 0.w : 60.w,
                            12.h,
                            data["senderName"] == userName ? 60.w : 0.w,
                            12.h),
                        child: Text(
                          data["message"],
                          textAlign: data["senderName"] == userName
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Portada",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 3.h,
                  left: data["senderName"] == userName ? null : 10.w,
                  right: data["senderName"] == userName ? 10.w : null,
                  child: Container(
                    width: 35.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      // color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: Color(0xff43D0CA),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -7.h,
                  // right: isMe ? 10.w : null,
                  left: data["senderName"] == userName ? 10.w : null,
                  right: data["senderName"] == userName ? null : 10.w,
                  // right: isMe ? null : 10.w,
                  child: Image.asset(
                    "assets/images/vipBadge.png",
                    width: 30.w,
                    height: 70.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  width: double.infinity,
                  color: Color(0xFFCAF8ED),
                  child: Directionality(
                    textDirection: data["senderName"] == userName ||
                            data["senderName"] == guestUserName
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Row(
                      children: [
                        Container(
                          width: 25.w,
                          height: 27.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          data["senderName"],
                          textAlign: data["senderName"] == userName ||
                                  data["senderName"] == guestUserName
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Portada",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Color(0xff00000029).withOpacity(0.2),
                      offset: Offset(0, 3),
                      spreadRadius: 1,
                      blurRadius: 6,
                    )
                  ]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        data["senderName"] == userName ||
                                data["senderName"] == guestUserName
                            ? 0.w
                            : 60.w,
                        12.h,
                        data["senderName"] == userName ||
                                data["senderName"] == guestUserName
                            ? 60.w
                            : 0.w,
                        12.h),
                    child: Text(
                      data["message"],
                      textAlign: data["senderName"] == userName ||
                              data["senderName"] == guestUserName
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Portada",
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  PopupMenuItem<int> usersPopUpMenu(String name) {
    return PopupMenuItem(
      height: 30.h,
      textStyle: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Portada",
        color: Color(0xFF43D0CA),
      ),
      value: 0,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          name,
        ),
      ),
    );
  }

  Widget userInCall() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        color: Colors.white,
        child: Icon(
          Icons.lock,
          color: Colors.black,
          size: 24.sp,
        ),
      ),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 71.h,
        decoration: const BoxDecoration(
          // LinearGradient
          gradient: LinearGradient(
            colors: [
              const Color(0xFFF792F0),
              const Color(0xFFFABD63),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: GetBuilder<RoomsPageController>(
            init: RoomsPageController(),
            builder: (controller) {
              return Row(
                children: [
                  controller.messageStatus
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: SizedBox(
                            width: 20.w,
                            height: 23.h,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                              backgroundColor: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : RotatedBox(
                          quarterTurns: 2,
                          child: IconButton(
                            onPressed: () {
                              controller.sendMessage(
                                  controller.messageController.text.trim());
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: () {
                      controller.changeEmojiStatus(!controller.emojiStatus);
                    },
                    child: Text(
                      "🙂",
                      style: TextStyle(fontSize: 25.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: SizedBox(
                      width: 230.w,
                      height: 40.h,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: GetBuilder<RoomsPageController>(
                          builder: (controller) {
                            return TextFormField(
                              cursorColor: Colors.black,
                              controller: controller.messageController,
                              style: TextStyle(
                                color: Colors.black, //Color(0xff9A8B8B),
                                fontSize: 14.sp,
                                fontFamily: "Portada",
                              ),
                              // expands: true,
                              maxLines: 1,
                              onFieldSubmitted: (value) =>
                                  controller.sendMessage(
                                      controller.messageController.text),
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              onTap: () {
                                if (!controller.emojiStatus) {
                                  controller.changeEmojiStatus(true);
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                hintText: 'اكتب رسالة',

                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "Portada",
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.r)),
                                filled: true,
                                fillColor: Colors.white, // Color(0xff00000029),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // controller.leave();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Icon(
                        Icons.add_circle_outline,
                        size: 25.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // controller.join();
                    },
                    child: Icon(
                      Icons.mic,
                      size: 25.sp,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget messageVIPBuilder(BuildContext context, dynamic data, bool guest) {
    return data["isGuest"] == "0"
        ? Padding(
            padding: EdgeInsets.only(bottom: 7.h),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/logo.png",
                            width: 70.w,
                            height: 70.h,
                            // fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "assets/images/badge4.png",
                            width: 70.w,
                            height: 70.h,
                            // fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      // Text(data["senderName"])
                      Stack(
                        children: [
                          // Implement the stroke
                          Text(
                            data["senderName"].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              // letterSpacing: 5,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.red,
                            ),
                          ),
                          // The text inside
                          Text(
                            data["senderName"].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              // letterSpacing: 5,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: Get.width * .70,
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFFBF205),
                        width: 4,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      data["message"],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Portada",
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(bottom: 7.h, right: 5.w),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Row(
                    children: [
                      //  Icon(Icons),
                      CircleAvatar(
                        backgroundColor: Color(0xFF2CCFB6),
                        child: Text(
                          data["senderName"]
                              .toString()
                              .substring(6, 7)
                              .toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ), //////error
                      SizedBox(width: 10.w),
                      Text(
                        data["senderName"],
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Portada",
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: Get.width * .70,
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(
                      //   color: Color(0xFFFBF205),
                      //   width: 4,
                      // ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                        // topRight: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      data["message"],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Portada",
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );

    //  Padding(
    //   padding: EdgeInsets.symmetric(vertical: 5.h),
    //   child: Column(
    //     children: [
    //       SizedBox(
    //         height: 70.h,
    //         width: double.infinity,
    //         // color: Color(0xFFCAF8ED),
    //         child: Padding(
    //           padding: EdgeInsets.fromLTRB(
    //               data["senderName"] == userName ? 0.w : 10.w,
    //               5.h,
    //               data["senderName"] == userName ? 10.w : 0,
    //               5.h),
    //           child: Directionality(
    //             textDirection: data["senderName"] == userName
    //                 ? TextDirection.rtl
    //                 : TextDirection.ltr,
    //             child: Row(
    //               children: [
    //                 !isGuest
    //                     ? Stack(
    //                         alignment: Alignment.center,
    //                         children: [
    //                           Image.asset(
    //                             "assets/icons/logo.png",
    //                             width: 70.w,
    //                             height: 70.h,
    //                             // fit: BoxFit.cover,
    //                           ),
    //                           Image.asset(
    //                             "assets/images/badge4.png",
    //                             width: 70.w,
    //                             height: 70.h,
    //                             // fit: BoxFit.cover,
    //                           ),
    //                         ],
    //                       )
    //                     : Container(
    //                         padding: EdgeInsets.symmetric(
    //                             horizontal: 20.w, vertical: 14.h),
    //                         decoration: BoxDecoration(
    //                           color: Color(0xFF2CCFB6),
    //                           borderRadius: BorderRadius.circular(360.r),
    //                         ),
    //                         child: Text(
    //                           data["senderName"].toString().substring(6, 7) ??
    //                               "",
    //                           style: TextStyle(
    //                             fontSize: 20.sp,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                 Stack(
    //                   children: [
    //                     Text(
    //                       data["senderName"],
    //                       textAlign: data["senderName"] == userName
    //                           ? TextAlign.right
    //                           : TextAlign.left,
    //                       style: TextStyle(
    //                         fontSize: 12.sp,
    //                         fontWeight: FontWeight.w900,
    //                         fontFamily: "Portada",
    //                         foreground: Paint()
    //                           ..style = PaintingStyle.stroke
    //                           ..strokeWidth = 1.5
    //                           ..color = Colors.yellow,
    //                       ),
    //                     ),
    //                     Text(
    //                       data["senderName"],
    //                       textAlign: data["senderName"] == userName
    //                           ? TextAlign.right
    //                           : TextAlign.left,
    //                       style: TextStyle(
    //                         fontSize: 12.sp,
    //                         fontWeight: FontWeight.w900,
    //                         fontFamily: "Portada",
    //                         color: Colors.red,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(
    //           right: data["senderName"] == userName ? 70.w : 100.w,
    //           left: data["senderName"] == userName ? 100.w : 70.w,
    //         ),
    //         child: Container(
    //           // height: 50.h,
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             border: Border.all(
    //               color: Color(0xFFFBF205),
    //               width: 4.w,
    //             ),
    //             borderRadius: data["senderName"] == userName
    //                 ? BorderRadius.only(
    //                     bottomLeft: Radius.circular(20.r),
    //                     bottomRight: Radius.circular(20.r),
    //                     topLeft: Radius.circular(20.r),
    //                   )
    //                 : BorderRadius.only(
    //                     bottomRight: Radius.circular(20.r),
    //                     bottomLeft: Radius.circular(20.r),
    //                     topRight: Radius.circular(20.r),
    //                   ),
    //           ),
    //           child: Padding(
    //             padding: EdgeInsets.fromLTRB(
    //                 data["senderName"] == userName ? 0.w : 30.w,
    //                 15.h,
    //                 data["senderName"] == userName ? 30.w : 0.w,
    //                 15.h),
    //             child: Text(
    //               data["message"],
    //               textAlign: data["senderName"] == userName
    //                   ? TextAlign.right
    //                   : TextAlign.left,
    //               style: TextStyle(
    //                 fontSize: 12.sp,
    //                 fontWeight: FontWeight.bold,
    //                 fontFamily: "Portada",
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget joinAndLeaveAlert(
      bool oldOrNew, bool joinOrLeave, String alert, String message) {
    return oldOrNew
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: joinOrLeave ? Color(0xFFE1FFE1) : Color(0xffFAE8E8),
                border: Border.all(
                  //#BABABA
                  color: Color(0xFFBABABA),
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  joinOrLeave
                      ? Padding(
                          padding: EdgeInsets.only(left: 14.w),
                          child: Image.asset(
                            "assets/icons/in.png",
                            width: 22.w,
                          ),
                        )
                      : Image.asset(
                          "assets/icons/out.png",
                          width: 45.w,
                        ),
                  Padding(
                    padding: EdgeInsets.only(right: joinOrLeave ? 0.w : 10.w),
                    child: Text(
                      message,
                      // joinOrLeave ? "$alert انضم للغرفة" : "$alert غادر للغرفة",
                      // alert,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontFamily: "Segoe UI",
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 90.w),
            child: Container(
              padding: EdgeInsets.all(7.sp),
              decoration: BoxDecoration(
                color: joinOrLeave ? Color(0xff88d95d) : Color(0xffFf6472a),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: "Segoe UI",
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Icon(joinOrLeave ? Icons.person : Icons.logout,
                      color: Colors.white, size: 20.sp),
                ],
              ),
            ),
          );
  }
}

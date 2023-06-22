// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, missing_return

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:lametna/model/message.dart';
import 'package:lametna/view/chat/roomMangement.dart';
import 'package:lametna/view/messages/messages.dart';

import '../../controllers/userData/userCredentials.dart';

class RoomPage extends StatelessWidget {
  bool isOwner = Get.arguments["owner"] != userName;
  // const RoomPage({super.key});

  RoomPage({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerScrimColor: Colors.transparent,
      endDrawer: SafeArea(
        child: Container(
          height: Get.height - (72.h + 99.h),
          width: 300.w,
          color: Colors.white,
          child: ListView(
            children: List.generate(
              40,
              (index) => PopupMenuButton(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFF43D0CA),
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'محمود',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "Segoe UI",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                        usersPopUpMenu('الابلاغ عن المسخدم'),
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
            ),
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
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: ImageIcon(
                    AssetImage('assets/icons/login.png'),
                  ),
                ),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(e["name"],
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontFamily: "Segoe",
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
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
                      Get.toNamed('/roomMangement');
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
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.h),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    scrollInfo.metrics.pixels < 80
                                        ? controller
                                            .scrollDownButtonStatus(true)
                                        : controller
                                            .scrollDownButtonStatus(false);
                                  },
                                  child: ListView.builder(
                                    controller: controller.scrollController,
                                    reverse: true,
                                    itemBuilder: (context, index) {
                                      return messageVIPBuilder(context,
                                          snapshot.data["data"][index]);
                                    },
                                    itemCount: snapshot.data["data"].length,
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
          buildMyNavBar(context)
        ],
      ),
      floatingActionButton: GetBuilder<RoomsPageController>(
        builder: (controller) {
          return controller.scrollDownButton
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  child: GestureDetector(
                    onTap: () {
                      controller.scrollController.animateTo(0,
                          duration: Duration(seconds: 1), curve: Curves.easeIn);
                    },
                    child: Container(
                      width: 145.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
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
                );
        },
      ),
      // bottomNavigationBar: ,
      resizeToAvoidBottomInset: false,
    );
  }

  // messageBuilder(
  //                           snapshot.data[index]["sender_name"],
  //                           snapshot.data[index]["text"],
  //                           snapshot.data[index]["sender"].toString() ==
  //                               userId)

  Widget messageBuilder(BuildContext context, dynamic data) {
    // return Text(
    //   data["message"],
    //   style: TextStyle(
    //     color: Colors.black,
    //   ),
    // );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            width: double.infinity,
            color: Color(0xFFCAF8ED),
            child: Directionality(
              textDirection: data["senderName"] == userName
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Row(
                children: [
                  Container(
                    width: 25.w,
                    height: 27.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
    );
  }

  Widget messageVIPBuilder(BuildContext context, dynamic data) {
    return Padding(
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
                      data["senderName"] == userName ? 0.w : 55.w,
                      5.h,
                      data["senderName"] == userName ? 55.w : 0,
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
        child: Row(
          children: [
            GetBuilder<RoomsPageController>(builder: (controller) {
              return RotatedBox(
                quarterTurns: 2,
                child: IconButton(
                  onPressed: () {
                    controller
                        .sendMessage(controller.messageController.text.trim());
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 25.sp,
                  ),
                ),
              );
            }),
            Text(
              "🙂",
              style: TextStyle(fontSize: 25.sp),
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
                        expands: true,
                        maxLines: null,
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
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Icon(
                Icons.add_circle_outline,
                size: 25.sp,
              ),
            ),
            Icon(
              Icons.mic,
              size: 25.sp,
            ),
          ],
        ),
      ),
    );
  }
}

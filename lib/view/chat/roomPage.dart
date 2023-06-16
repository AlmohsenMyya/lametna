// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:lametna/view/chat/roomMangement.dart';

class RoomPage extends StatelessWidget {
  // const RoomPage({super.key});

  RoomPage({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawerScrimColor: Colors.transparent,
        endDrawer: Container(
          height: 755.h,
          width: 300.w,
          color: Colors.white,
          child: ListView(
            children: List.generate(
              40,
              (index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                ' اسم الغرفة',
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
                          "icon": Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 17,
                          ),
                        },
                        {
                          "value": "1",
                          "name": "الاعدادات",
                          "icon": Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 17,
                          ),
                        },
                        {
                          "value": "2",
                          "name": "اللحظات",
                          "icon": Image.asset(
                            "assets/icons/planet.png",
                            color: Colors.black,
                            width: 22,
                          ),
                        },
                        {
                          "value": "3",
                          "name": "إدارة الغرفة",
                          "icon": Icon(
                            Icons.home,
                            color: Colors.black,
                            size: 17,
                          ),
                        },
                        {
                          "value": "4",
                          "name": "مشاركة",
                          "icon": Icon(
                            Icons.share,
                            color: Colors.black,
                            size: 17,
                          ),
                        },
                        {
                          "value": "5",
                          "name": "المفضلة",
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
                          "icon": Icon(
                            Icons.help,
                            color: Colors.black,
                            size: 17,
                          ),
                        },
                      ]
                          .toList()
                          .map((e) => PopupMenuItem(
                                height: 40.h,
                                child: Row(
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
                              GestureDetector(
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
                                      borderRadius: BorderRadius.circular(20.r),
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
                      ),
                    );
                  }),
                ],
              ),
            ),
            buildMyNavBar(context)
          ],
        ),
        // bottomNavigationBar: ,
        resizeToAvoidBottomInset: false,
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
            RotatedBox(
              quarterTurns: 2,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
            ),
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
                  child: TextFormField(
                    cursorColor: Colors.black,
                    // textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.black, //Color(0xff9A8B8B),
                      fontSize: 14.sp,
                      fontFamily: "Portada",
                    ),
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
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

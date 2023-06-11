// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';

class RoomPage extends StatelessWidget {
  // const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            leadingWidth: 100,
            toolbarHeight: 72.35.h,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/icons/login.png'),
                  ),

                  DropdownButton(
                    value: "الحالة",
                    items: <String>[
                      'الحالة',
                      'الإعدادات',
                      'اللحظات',
                      'إدارة الغرفة',
                      "مشاركة",
                      "المفضلة",
                      "عن البرنامج",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    underline: SizedBox(
                      height: 0,
                    ),
                    //underline: SizedBox(),
                    onChanged: (value) {},
                  ),
                  // SizedBox(
                  //   width: 65.w,
                  //   child: DropdownButton(
                  //     elevation: 0,
                  //     onChanged: (value) {},
                  //     icon: Icon(
                  //       Icons.settings,
                  //       color: Colors.white,
                  //     ),
                  // items: <String>[
                  //   'الحالة',
                  //   'الإعدادات',
                  //   'اللحظات',
                  //   'إدارة الغرفة',
                  //   "مشاركة",
                  //   "المفضلة",
                  //   "عن البرنامج",
                  // ].map<DropdownMenuItem<String>>((String value) {
                  //   return DropdownMenuItem<String>(
                  //     value: value,
                  //     child: Text(
                  //       value,
                  //       style: TextStyle(color: Colors.black),
                  //     ),
                  //   );
                  // }).toList(),
                  //   ),
                  // )
                ],
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // actions widget
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.volume_up),
              ),
              ImageIcon(
                AssetImage('assets/icons/chat.png'),
                size: 23.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Image.asset(
                  'assets/icons/group.png',
                  width: 30.sp,
                ),
              )
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
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
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
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.white,
                size: 25.sp,
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
                height: 30.h,
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/view/chat/roomInfo.dart';

var table1 = [
  {
    "name": "معلومات الغرفة",
    "icon": Icons.info_outline,
    // "page":
  },
  {
    "name": "إدارة الحسابات",
    "icon": Icons.people,
    "page": "",
  },
  {
    "name": "الحظر",
    "icon": Icons.block,
    "page": "",
  }
];
var table2 = [
  {
    "name": "إعدادت الغرفة",
    "icon": Icons.info_outline,
  },
  {
    "name": "إعدادت متقدمة",
    "icon": Icons.people,
  },
  {
    "name": "سجل الغرفة",
    "icon": Icons.block,
  },
  {
    "name": "تقارير الغرفة",
    "icon": Icons.block,
  }
];

class RoomMangement extends StatelessWidget {
  const RoomMangement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: appbarBuilder("إدارة الغرفة", true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  SizedBox(
                    width: 40.w,
                  ),
                  Text(
                    Get.arguments["room_name"],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Segoe UI",
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/icons/logo.png",
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: GestureDetector(
                        onTap: () {
                          // print(table1[index]["page"]);
                          if (index == 0) {
                            Get.toNamed('/roomInfo', arguments: {
                              "room_name": Get.arguments["room_name"],
                              "room_id": Get.arguments["room_id"],
                            });
                          } else if (index == 1) {
                            Get.toNamed('/addAccount',
                                arguments:{"room_id": Get.arguments["room_id"],}
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Icon(
                                  table1[index]["icon"],
                                  color: Colors.black,
                                  size: 25.sp,
                                ),
                              ),
                              Text(
                                table1[index]["name"],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Segoe UI",
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: table1.length),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Icon(
                                table2[index]["icon"],
                                color: Colors.black,
                                size: 25.sp,
                              ),
                            ),
                            Text(
                              table2[index]["name"],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Segoe UI",
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: table2.length),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Icon(
                          Icons.block,
                          color: Colors.black,
                          size: 25.sp,
                        ),
                      ),
                      Text(
                        "لوحة المستخدم",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Segoe UI",
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

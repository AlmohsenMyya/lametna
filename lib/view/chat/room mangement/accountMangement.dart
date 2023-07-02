// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lametna/controllers/chat/room%20managment/accountMangementController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

var user = ["الكل", "ماستر", "سوبر ادمن", "ادمن", "مستخدم"];

class AddAccount extends StatelessWidget {
  const AddAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("إدارة الحسابات", true),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0.w, top: 8.0.w),
                  child: Container(
                    //width: 122.w,
                    //height: 27.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Color(0xff6BE05B),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/roles', arguments: {
                          "room_id": Get.arguments["room_id"],
                        });
                      },
                      child: Text(
                        "إضافة حساب",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Segoe UI",
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "المجموع: 31",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Portada",
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 25.h,
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: user.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                        child: GestureDetector(
                          onTap: () {
                            // controller.changeSeletedIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 1.h),
                            decoration: //controller.selectedIndex == index
                                BoxDecoration(
                              border: Border.all(
                                color: Color(0xffFABD63),
                                style: BorderStyle.solid,
                                width: 1.0.w,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9.0.sp),
                            ),
                            child: Text(user[index],
                                style: TextStyle(
                                  color: Color(0xffFABD63),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Segoe UI",
                                  fontSize: 10.sp,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25.0.w, left: 25.0.w),
              child: Divider(
                color: Color(0xFFE7E7E7),
                thickness: 4,
              ),
            ),
            GetBuilder<AccountMangementController>(
              init: AccountMangementController(),
              builder: (controller) {
                return FutureBuilder(
                  future: controller.getRoles(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) => ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: Colors.red,
                                    ),
                                    horizontalTitleGap: -10.w,
                                    title: Text(
                                      snapshot.data["data"][index]["username"]
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15.sp,
                                        fontFamily: 'Segoe UI',
                                      ),
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                  )),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

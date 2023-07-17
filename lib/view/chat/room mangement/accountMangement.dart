// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lametna/controllers/chat/room%20managment/accountMangementController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

var user = [
  "الكل",
  "مستخدم",
  "ادمن",
  "سوبر ادمن",
  "ماستر",
];

class AddAccount extends StatelessWidget {
  const AddAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("إدارة الحسابات", true),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                  GetBuilder<AccountMangementController>(
                      init: AccountMangementController(),
                      builder: (c) {
                        return Text(
                          "المجموع: ${c.roles.length - 1}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Portada",
                          ),
                        );
                      }),
                ],
              ),
            ),
            GetBuilder<AccountMangementController>(builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: SizedBox(
                  height: 25.h,
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: user.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: GestureDetector(
                        onTap: () {
                          controller.changeSeletedIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 1.h),
                          decoration: //controller.selectedIndex == index
                              BoxDecoration(
                            border: Border.all(
                              color: controller.index != index
                                  ? Color(0xff43D0CA)
                                  : Colors.white,
                              style: BorderStyle.solid,
                              width: 1.0.w,
                            ),
                            color: controller.index == index
                                ? Color(0xff43D0CA).withOpacity(0.33)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(9.0.sp),
                          ),
                          child: Text(user[index],
                              style: TextStyle(
                                color: controller.index != index
                                    ? Color(0xff43D0CA)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Segoe UI",
                                fontSize: 10.sp,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
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
                return controller.roles.isEmpty
                    ? Center(
                        child: Text(
                          "لا يوجد مستخدمين",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.roles.length - 1,
                          itemBuilder: (context, index) => controller.index == 0
                              ? ListTile(
                                  onTap: () {
                                    print(controller.roles[index]["roleType"]);
                                  },
                                  leading: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  ),
                                  horizontalTitleGap: -10.w,
                                  title: Text(
                                    controller.roles[index]["username"]
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15.sp,
                                      fontFamily: 'Segoe UI',
                                    ),
                                  ),
                                  trailing: PopupMenuButton(
                                    child: Icon(Icons.more_vert),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          // onTap: controller.deleteAlert(
                                          //     controller.roles[index]
                                          //         ["username"]),
                                          height: 30.h,
                                          value: "delete",
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                              controller.deleteAlert(
                                                  controller.roles[index]
                                                      ["username"],
                                                  index);
                                            },
                                            child: Text(
                                              "حدف حساب",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontFamily: "Segoe UI",
                                              ),
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: 30.h,
                                          value: "edit",
                                          child: Text(
                                            "تعديل حساب",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontFamily: "Segoe UI",
                                            ),
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                )
                              : (controller.index - 1).toString() !=
                                      controller.roles[index]["roleType"]
                                          .toString()
                                  ? SizedBox()
                                  : ListTile(
                                      onTap: () {
                                        print(controller.roles[index]
                                            ["roleType"]);
                                      },
                                      leading: Icon(
                                        Icons.person,
                                        color: Colors.red,
                                      ),
                                      horizontalTitleGap: -10.w,
                                      title: Text(
                                        controller.roles[index]["username"]
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15.sp,
                                          fontFamily: 'Segoe UI',
                                        ),
                                      ),
                                      trailing: Icon(Icons.more_vert),
                                    ),
                        ),
                      );

                //     FutureBuilder(
                //   future: controller.getRoles(),
                //   builder: (context, snapshot) => snapshot.hasData
                //       ? Directionality(
                //           textDirection: TextDirection.rtl,
                //           child: ListView.builder(
                //               shrinkWrap: true,
                //               itemCount: snapshot.data["data"].length,
                //               itemBuilder: (context, index) => ListTile(
                //                     leading: Icon(
                //                       Icons.person,
                //                       color: Colors.red,
                //                     ),
                //                     horizontalTitleGap: -10.w,
                //                     title: Text(
                //                       snapshot.data["data"][index]["username"]
                //                           .toString(),
                //                       style: TextStyle(
                //                         color: Colors.red,
                //                         fontSize: 15.sp,
                //                         fontFamily: 'Segoe UI',
                //                       ),
                //                     ),
                //                     trailing: Icon(Icons.more_vert),
                //                   )),
                //         )
                //       : snapshot.hasError
                //           ? Center(
                //               child: Text(
                //                 "لا يوجد مستخدمين",
                //                 style: TextStyle(
                //                     color: Colors.black,
                //                     fontSize: 20.sp,
                //                     fontFamily: "Segoe UI",
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             )
                //           : Center(child: CircularProgressIndicator()),
                // );
              },
            )
          ],
        ),
      ),
    );
  }
}

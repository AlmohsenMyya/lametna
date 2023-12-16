// ignore_for_file: prefer_const_constructors, avoid_print

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
var color;

// var listIcon = [
//   "setting (2)",
//   "block",
//   "mic",
//   "green",
//   "red",
//   "swap",
//   "group",
//   "setting",
//   "block",
//   "mic",
//   "green",
//   "red",
//   "swap",
//   "group",
//   "setting",
// ];

class AddAccount extends StatelessWidget {
  const AddAccount({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    color = Get.arguments["color"];
    return Scaffold(
      appBar: appbarBuilder("إدارة الحسابات", true, color: color),
      // backgroundColor: ,
      // backgroundColor: Colors.green,
      body: SafeArea(
        child: Container(
          color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000).withOpacity(0.2),
          child: ListView(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: EdgeInsets.all(10.sp),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //width: 122.w,
                        //height: 27.h,
                        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(25.r),
                          // border: Border.all(
                          //   color: Colors.white,
                          //   style: BorderStyle.solid,
                          //   width: (0.7).w,
                          // ),
                        ),
                        child: GetBuilder<AccountMangementController>(
                            init: AccountMangementController(),
                            builder: (controller) {
                              return GestureDetector(
                                onTap: () {
                                  controller.checkIfCanAddRole();
                                },
                                child: Text(
                                  "إضافة حساب",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }),
                      ),
                      GetBuilder<AccountMangementController>(builder: (c) {
                        return Text(
                          "Total : ${c.roles.length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              GetBuilder<AccountMangementController>(builder: (controller) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                  child: SizedBox(
                    height: 25.h,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.changeSeletedIndex(0);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                              decoration: //controller.selectedIndex == index
                                  BoxDecoration(
                                border: Border.all(
                                  color: controller.index != 0 ? Colors.transparent : Colors.black,
                                  style: BorderStyle.solid,
                                  width: (0.7).w,
                                ),
                                color: controller.index == 0 ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Colors.white,
                                borderRadius: BorderRadius.circular(9.0.sp),
                              ),
                              child: Text("الكل",
                                  style: TextStyle(
                                    color: controller.index != 0 ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.changeSeletedIndex(1);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                              decoration: //controller.selectedIndex == index
                                  BoxDecoration(
                                border: Border.all(
                                  color: controller.index != 1 ? Colors.transparent : Colors.black,
                                  style: BorderStyle.solid,
                                  width: (0.7).w,
                                ),
                                color: controller.index == 1 ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Colors.white,
                                borderRadius: BorderRadius.circular(9.0.sp),
                              ),
                              child: Text("مستخدم",
                                  style: TextStyle(
                                    color: controller.index != 1 ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.changeSeletedIndex(2);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                              decoration: //controller.selectedIndex == index
                                  BoxDecoration(
                                border: Border.all(
                                  color: controller.index != 2 ? Colors.transparent : Colors.black,
                                  style: BorderStyle.solid,
                                  width: (0.7).w,
                                ),
                                color: controller.index == 2 ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Colors.white,
                                borderRadius: BorderRadius.circular(9.0.sp),
                              ),
                              child: Text("ادمن",
                                  style: TextStyle(
                                    color: controller.index != 2 ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.changeSeletedIndex(3);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                              decoration: //controller.selectedIndex == index
                                  BoxDecoration(
                                border: Border.all(
                                  color: controller.index != 3 ? Colors.transparent : Colors.black,
                                  style: BorderStyle.solid,
                                  width: (0.7).w,
                                ),
                                color: controller.index == 3 ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Colors.white,
                                borderRadius: BorderRadius.circular(9.0.sp),
                              ),
                              child: Text("سوبر ادمن",
                                  style: TextStyle(
                                    color: controller.index != 3 ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // controller.changeSeletedIndex(4);
                              showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(0.w, 210.h, 100.w, 100.h),
                                  constraints: BoxConstraints(
                                    minWidth: 120.w,
                                    maxWidth: 120.w,
                                  ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                  items: [
                                    PopupMenuItem<int>(
                                      padding: EdgeInsets.all(10.sp),
                                      onTap: () => controller.changeSelectedMasterType("ماستر"),
                                      child: Center(
                                        child: Text(
                                          "Master (Man)",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem<int>(
                                      padding: EdgeInsets.all(10.sp),
                                      onTap: () => controller.changeSelectedMasterType("زهري"),
                                      child: Center(
                                        child: Text(
                                          "Master (Girl)",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                              decoration: //controller.selectedIndex == index
                                  BoxDecoration(
                                border: Border.all(
                                  color: controller.index == 4 || controller.index == 5 ? Colors.black : Colors.transparent,
                                  style: BorderStyle.solid,
                                  width: (0.7).w,
                                ),
                                color: controller.index == 4 || controller.index == 5
                                    ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(9.0.sp),
                              ),
                              child: Text(controller.selectedMasterType,
                                  style: TextStyle(
                                    color: controller.index == 4
                                        ? Colors.black
                                        : controller.index == 5
                                            ? Colors.black
                                            : Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              GetBuilder<AccountMangementController>(
                init: AccountMangementController(),
                builder: (controller) {
                  if (controller.roles.isEmpty) {
                    return Center(
                      child: Text(
                        "لا يوجد مستخدمين",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    return Directionality(
                      textDirection: TextDirection.ltr,
                      child: ListView.builder(
                        // separatorBuilder: (context, index) => controller.index == 0
                        //     ? Divider(
                        //         height: 1,
                        //         thickness: 1,
                        //         color: Colors.grey.withOpacity(0.6),
                        //       )
                        //     : (controller.index).toString() != controller.roles[index]["roleType"].toString()
                        //         ? SizedBox()
                        //         : Divider(
                        //             height: 1,
                        //             thickness: 1,
                        //             color: Colors.grey.withOpacity(0.6),
                        //           ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.roles.length,
                        itemBuilder: (context, index) {
                          var data = controller.roles[index];
                          if (controller.index == 0) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              child: PopupMenuButton<String>(
                                // onSelected: (value) => print("sklkl"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                itemBuilder: (BuildContext context) {
                                  if (data["username"] == "Master") {
                                    print("object");
                                    Get.snackbar(
                                      "تنبية",
                                      "لا يمكنك تعديل هذا الحساب ",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      titleText: Text(
                                        "تنبية",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.black,
                                        ),
                                      ),
                                      messageText: Text(
                                        "لا يمكنك تعديل هذا الحساب ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.black,
                                        ),
                                      ),
                                    );
                                    return [];
                                  } else {
                                    return [
                                      PopupMenuItem(
                                        height: 30.h,
                                        value: "delete",
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                            controller.deleteAlert(data["username"], index);
                                          },
                                          child: Center(
                                            child: Text(
                                              "حدف حساب",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem(
                                        height: 30.h,
                                        onTap: () {
                                          // Get.back();
                                          // Get.toNamed("/editRole", arguments: {"data": data, "color": color});
                                        },
                                        value: "edit",
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                            Get.toNamed("/editRole", arguments: {"data": data, "color": color});
                                          },
                                          child: Center(
                                            child: Text(
                                              "تعديل حساب",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ];
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: data["roleType"] == "0" //member
                                            ? Color(0xffC77398)
                                            : data["roleType"] == "1" //admin
                                                ? Colors.blue
                                                : data["roleType"] == "2" //super admin
                                                    ? Colors.green[300]
                                                    : data["roleType"] == "4" //master girl
                                                        ? Colors.pink
                                                        : Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data["username"].toString(), //username
                                            // data["roleType"].toString(), //username
                                            style: TextStyle(
                                              color: data["roleType"] == "0"
                                                  ? Color(0xffC77398)
                                                  : data["roleType"] == "1"
                                                      ? Colors.blue
                                                      : data["roleType"] == "2"
                                                          ? Colors.green[300]
                                                          : data["roleType"] == "4"
                                                              ? Colors.pink
                                                              : Colors.red,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                              height: 30.h,
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  // scrollDirection: Axis.horizontal,
                                                  children: [
                                                    iconBuilder(data["adminReport"] == "0" ? "roomSettingsf" : "roomSettings"),
                                                    iconBuilder(data["roomSettings"] == "0" ? "roomSettingsf" : "roomSettings"),
                                                    iconBuilder(data["masterMangment"] == "0" ? "personf" : "masterMangment"),
                                                    iconBuilder(data["superAdminMangment"] == "0" ? "personf" : "superMangment"),
                                                    iconBuilder(data["adminMangment"] == "0" ? "personf" : "adminMessages"),
                                                    iconBuilder(data["memberMangment"] == "0" ? "personf" : "memberMessage"),
                                                    iconBuilder(data["accountMangment"] == "0" ? "accountMangmentf" : "accountMangment"),
                                                    iconBuilder(data["removeBan"] == "0" ? "removebanf" : "removeBan"),
                                                    iconBuilder(data["publicmessage"] == "0" ? "publicMessagef" : "publicMessage"),
                                                    iconBuilder(data["deleteChat"] == "0" ? "clearf" : "clear"),
                                                    iconBuilder(data["mic"] == "0" ? "micf" : "mic"),
                                                    iconBuilder(data["kick"] == "0" ? "kickf" : "kick"),
                                                    iconBuilder(data["banDevice"] == "0" ? "xf" : "x"),
                                                    iconBuilder(data["stop"] == "0" ? "blockf" : "block"),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          controller.toggleLock(data["id"]);
                                        },
                                        child: Icon(
                                          data["isLocked"] == "0" ? Icons.lock_open : Icons.lock,
                                          size: 22.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return (controller.index - 1).toString() != controller.roles[index]["roleType"].toString()
                                ? SizedBox(
                                    height: 3,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ),
                                    ),
                                    child: PopupMenuButton(
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                            height: 30.h,
                                            value: "delete",
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.back();
                                                controller.deleteAlert(data["username"], index);
                                              },
                                              child: Text(
                                                "حدف حساب",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
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
                                              ),
                                            ),
                                          ),
                                        ];
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8.sp),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: data["roleType"] == "0" //member
                                                  ? Color(0xffC77398)
                                                  : data["roleType"] == "1" //admin
                                                      ? Colors.blue
                                                      : data["roleType"] == "2" //super admin
                                                          ? Colors.green[300]
                                                          : data["roleType"] == "4" //master girl
                                                              ? Colors.pink
                                                              : Colors.red,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data["username"].toString(), //username
                                                  // data["roleType"].toString(), //username
                                                  style: TextStyle(
                                                    color: data["roleType"] == "0"
                                                        ? Color(0xffC77398)
                                                        : data["roleType"] == "1"
                                                            ? Colors.blue
                                                            : data["roleType"] == "2"
                                                                ? Colors.green[300]
                                                                : data["roleType"] == "4"
                                                                    ? Colors.pink
                                                                    : Colors.red,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 30.h,
                                                    child: Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        // scrollDirection: Axis.horizontal,
                                                        children: [
                                                          iconBuilder(data["adminReport"] == "0" ? "roomSettingsf" : "roomSettings"),
                                                          iconBuilder(data["roomSettings"] == "0" ? "roomSettingsf" : "roomSettings"),
                                                          iconBuilder(data["masterMangment"] == "0" ? "personf" : "masterMangment"),
                                                          iconBuilder(data["superAdminMangment"] == "0" ? "personf" : "superMangment"),
                                                          iconBuilder(data["adminMangment"] == "0" ? "personf" : "adminMessages"),
                                                          iconBuilder(data["memberMangment"] == "0" ? "personf" : "memberMessage"),
                                                          iconBuilder(data["accountMangment"] == "0" ? "accountMangmentf" : "accountMangment"),
                                                          iconBuilder(data["removeBan"] == "0" ? "removebanf" : "removeBan"),
                                                          iconBuilder(data["publicmessage"] == "0" ? "publicMessagef" : "publicMessage"),
                                                          iconBuilder(data["deleteChat"] == "0" ? "clearf" : "clear"),
                                                          iconBuilder(data["mic"] == "0" ? "micf" : "mic"),
                                                          iconBuilder(data["kick"] == "0" ? "kickf" : "kick"),
                                                          iconBuilder(data["banDevice"] == "0" ? "xf" : "x"),
                                                          iconBuilder(data["stop"] == "0" ? "blockf" : "block"),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                controller.toggleLock(data["id"]);
                                              },
                                              child: Icon(
                                                data["isLocked"] == "0" ? Icons.lock_open : Icons.lock,
                                                size: 22.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          }
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget iconBuilder(String icon) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 1.5.w),
    child: Image.asset(
      "assets/icons/mangement/$icon.png",
      width: icon == "x" || icon == "xf" ? 25.w : 20.w,
      height: icon == "x" || icon == "xf" ? 25.h : 20.h,
    ),
  );
}

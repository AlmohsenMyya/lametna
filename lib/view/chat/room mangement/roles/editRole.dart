// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/room%20managment/roles/editRoleController.dart';
// import 'package:lametna/controllers/chat/room%20managment/roles/EditRolesController.dart';
import '../../appBar.dart';

var user = [
  "ممبر",
  "ادمن",
  "سوبر ادمن",
  "ماستر",
];
var color;

class EditRole extends StatelessWidget {
  const EditRole({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    color = Get.arguments["color"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarBuilder("تعديل الحساب", true, color: color),
      body: ListView(
        children: [
          SizedBox(
            height: 14.h,
          ),
          GetBuilder<EditRolesController>(
              init: EditRolesController(),
              builder: (controller) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: TextFormField(
                      // enabled: false,
                      readOnly: true,
                      controller: controller.userNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                        hintText: "أسم المستخدم",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                        // enabled: false,

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      style: TextStyle(
                        color: controller.selectedIndex == 0
                            ? Color(0xFFF411EB)
                            : controller.selectedIndex == 1
                                ? Color(0xFF3B01E1)
                                : controller.selectedIndex == 2
                                    ? Color(0xFF11F436)
                                    : controller.selectedIndex == 4
                                        ? Colors.pink[600]
                                        : Color(0xFFFC0303),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 14.h,
          ),
          GetBuilder<EditRolesController>(builder: (controller) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                    filled: true,
                    hintText: "كلمة المرور",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
          GetBuilder<EditRolesController>(
              init: EditRolesController(),
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 25.h,
                        child: ListView(
                          reverse: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // itemCount: user.length,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                              child: GestureDetector(
                                onTap: () {
                                  controller.changeSeletedIndex(0);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                                  decoration: controller.selectedIndex == 0
                                      ? BoxDecoration(
                                          border: Border.all(
                                            color: Colors.transparent,
                                            style: BorderStyle.solid,
                                            width: 1.0.w,
                                          ),
                                          color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                                          borderRadius: BorderRadius.circular(9.0.sp),
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFFFABD63),
                                            style: BorderStyle.solid,
                                            width: 1.0.w,
                                          ),
                                          borderRadius: BorderRadius.circular(9.0.sp),
                                        ),
                                  child: Text(
                                    user[0],
                                    style: controller.selectedIndex == 0
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          )
                                        : TextStyle(
                                            color: Color(0xFFFABD63),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            //--------//
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                              child: GestureDetector(
                                onTap: () {
                                  controller.changeSeletedIndex(1);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                                  decoration: controller.selectedIndex == 1
                                      ? BoxDecoration(
                                          border: Border.all(
                                            color: Colors.transparent,
                                            style: BorderStyle.solid,
                                            width: 1.0.w,
                                          ),
                                          color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                                          borderRadius: BorderRadius.circular(9.0.sp),
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFFFABD63),
                                            style: BorderStyle.solid,
                                            width: 1.0.w,
                                          ),
                                          borderRadius: BorderRadius.circular(9.0.sp),
                                        ),
                                  child: Text(
                                    user[1],
                                    style: controller.selectedIndex == 1
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          )
                                        : TextStyle(
                                            color: Color(0xFFFABD63),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            //--------//
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                              child: GestureDetector(
                                onTap: () {
                                  controller.changeSeletedIndex(2);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                                  decoration: controller.selectedIndex == 2
                                      ? BoxDecoration(
                                          border: Border.all(
                                            color: Colors.transparent,
                                            style: BorderStyle.solid,
                                            width: 1.0.w,
                                          ),
                                          color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                                          borderRadius: BorderRadius.circular(9.0.sp),
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFFFABD63),
                                            style: BorderStyle.solid,
                                            width: 1.0.w,
                                          ),
                                          borderRadius: BorderRadius.circular(9.0.sp),
                                        ),
                                  child: Text(
                                    user[2],
                                    style: controller.selectedIndex == 2
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          )
                                        : TextStyle(
                                            color: Color(0xFFFABD63),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            //--------//
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                              child: GestureDetector(
                                onTap: () {
                                  showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(20.w, 300.h, 100.w, 100.h),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                                      items: [
                                        PopupMenuItem<int>(
                                          onTap: () => controller.changeSelectedMasterType("ماستر"),
                                          child: Center(
                                            child: Text(
                                              "ماستر",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem<int>(
                                          onTap: () => controller.changeSelectedMasterType("زهري"),
                                          child: Center(
                                            child: Text(
                                              "زهري",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                                  decoration: controller.selectedIndex >= 3
                                      ? BoxDecoration(
                                          border: Border.all(
                                            color: Colors.transparent,
                                            style: BorderStyle.solid,
                                            width: 1.0.w,
                                          ),
                                          color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                                          borderRadius: BorderRadius.circular(9.0.sp),
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFFFABD63),
                                            style: BorderStyle.solid,
                                            width: 1.0.w,
                                          ),
                                          borderRadius: BorderRadius.circular(9.0.sp),
                                        ),
                                  child: Text(
                                    controller.selectedMasterType,
                                    style: controller.selectedIndex >= 3
                                        ? TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          )
                                        : TextStyle(
                                            color: Color(0xFFFABD63),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // controller.toggleLock();
                          print(Get.arguments["data"]);
                        },
                        child: Row(
                          children: [
                            Text(
                              controller.isLock ? "فتح الجهاز" : "قفل الجهاز",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
                              controller.isLock ? Icons.lock_open : Icons.lock_outline,
                              size: 18.sp,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Divider(
              color: Color(0xffE7E7E7),
              thickness: 4.h,
            ),
          ),
          GetBuilder<EditRolesController>(builder: (controller) {
            return Directionality(
              textDirection: TextDirection.rtl,
              // height: 120.h,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                shrinkWrap: true,
                itemCount: controller.icons.length,
                itemBuilder: (context, index) => accessBuilder(index, controller),
              ),
            );
          }),
          SizedBox(
            height: 50.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 6.h),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Color(0xffDA8080),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  "إلغاء",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 30.w),
              GetBuilder<EditRolesController>(builder: (controller) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Color(0xff6BE05B),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // print(Get.arguments["data"]["roomId"]);
                      // print(Get.arguments["data"]["id"]);
                      controller.updateRoles();
                      // controller.userNameController.clear();
                      // controller.passwordController.clear();
                    },
                    child: Text(
                      "إضافة",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget accessBuilder(int index, EditRolesController controller) {
    return GestureDetector(
      onTap: () {
        controller.changeIconColor(index);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF43D0CA),
                  width: 1,
                ),
                color: controller.icons[index]["isActive"] ? Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000) : Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(360.r),
              ),
              child: Icon(
                controller.icons[index]["icon"],
                color: Colors.black,
                size: 22.sp,
              ),
            ),
            Text(controller.icons[index]["text"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 10.sp,
                ))
          ],
        ),
      ),
    );
  }
}

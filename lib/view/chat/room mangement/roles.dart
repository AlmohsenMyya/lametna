// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/room%20managment/rolesController.dart';
import '../appBar.dart';


var user = ["ممبر", "ادمن", "سوبر ادمن", "ماستر"];
var icons = [
  {"text": "مسح النص للجميع", "icon": Icons.cleaning_services},
  {"text": "دور المايك", "icon": Icons.mic},
  {"text": "طرد", "icon": Icons.star},
  {"text": "ايقاف", "icon": Icons.highlight_remove},
  {"text": "حظر الجهاز", "icon": Icons.not_interested},
  {"text": "ادارة ممبر", "icon": Icons.person},
  {"text": "ادارة الحسابات", "icon": Icons.group},
  {"text": "سجل الخروج", "icon": Icons.sensor_door_outlined},
  {"text": "الغاء الحظر", "icon": Icons.reply},
  {"text": "رسالة عامة", "icon": Icons.email},
  {"text": "تقارير المشرفين", "icon": Icons.sticky_note_2_outlined},
  {"text": "اعدادات الغرفة", "icon": Icons.settings},
  {"text": "ادارة ماستر", "icon": Icons.person},
  {"text": "ادارة سوبر ادمن", "icon": Icons.person},
  {"text": "ادارة ادمن", "icon": Icons.person},
];

class RolesPage extends StatelessWidget {
  const RolesPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("تعديل الحساب", true),
      body: Column(
        children: [
          SizedBox(
            height: 14.h,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
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
                    fontFamily: "Segoe UI",
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  filled: true,
                  hintText: "كلمة المرور",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: "Segoe UI",
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          GetBuilder<RolesController>(
              init: RolesController(),
              builder: (controller) {
                return Padding(
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
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 1.h),
                              decoration:controller.selectedIndex == index
                                  ? BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFFABD63),
                                  style: BorderStyle.solid,
                                  width: 1.0.w,
                                ),
                                color: Color(0xFFFABD63),
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
                              child: GestureDetector(
                                onTap: (){controller.changeIndex(index);},
                                child: Text(user[index],
                                    style:controller.selectedIndex == index
                                        ?TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Segoe UI",
                                      fontSize: 10.sp,
                                    )
                                        : TextStyle(
                                      color: Color(0xFFFABD63),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Segoe UI",
                                      fontSize: 10.sp,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "قفل الجهاز",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.lock_outline,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Divider(
              color: Color(0xffE7E7E7),
              thickness: 4.h,
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            // height: 120.h,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) => accessBuilder(index, context),
              itemCount: icons.length,
            ),
          ),
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
                    fontFamily: "Segoe UI",
                  ),
                ),
              ),
              SizedBox(width: 30.w),
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
                  color: Color(0xff6BE05B),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  "إضافة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Segoe UI",
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget accessBuilder(int index, BuildContext context) {
    return GetBuilder<RolesController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  // CircleAvatar(
                  //   backgroundColor: Color(0xffE7E7E7),
                  //   child:
                  // ),
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF43D0CA),
                        width: 1,
                      ),
                      color: controller.isIcon2Highlighted.value
                          ? Color(0xffFABD63)
                          : Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(360.r),
                    ),
                    child: Icon(
                      icons[index]["icon"],
                      color:Colors.black,
                      size: 22.sp,
                    ),
                  ),
                  Text(icons[index]["text"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 8.sp,
                        fontFamily: "Portada",
                      ))
                ],
              ),
            ),
          );
        }
    );
  }
}

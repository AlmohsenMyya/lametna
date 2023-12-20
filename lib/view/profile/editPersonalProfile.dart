// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings


import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/appBar.dart';

var l = [
  "تعديل خلفيات الاسم",
  "اللغة",
  "قائمة الحظر",
];

class EditPersonalProfile extends StatelessWidget {
  const EditPersonalProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("تعديل الملف الشخصي", true),
      body: ListView(
        children: [
          Container(
            color: Color(0xFFF6F6F6),
            padding: EdgeInsets.all(10.sp),
            child: Text(
              "الإعدادات الشخصية",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Color(0xFFA2ACAC),
                fontFamily: 'Portada',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/editProfile');
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 30.sp,
                  ),
                  Spacer(),
                  Text(
                    mobileUserName,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Portada',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(360.r),
                    child: Image.network(
                      imageURL + mobileUserName + ".jpeg",
                      width: 62.w,
                      height: 70.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network(
                        'https://lametnachat.com/upload/imageUser/anonymous.jpg',
                        width: 60.w,
                        height: 76.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Divider(
            color: Color(0xFFf6f6f6),
            // color: Colors.red,
            thickness: 20,
          ),
          ListView.separated(
              shrinkWrap: true,
              itemCount: l.length,
              separatorBuilder: (context, index) => Divider(
                    color: Color(0xFFf6f6f6),
                    // color: Colors.red,
                    thickness: 1,
                  ),
              itemBuilder: (context, index) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      title: Text(
                        l[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontFamily: 'Portada',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // subtitle: Text(userName),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                      onTap: () {
                        if (index == 0) {
                          print("object");
                          Get.toNamed('/editBackground');
                        }
                      },
                    ),
                  )),
        ],
      ),
    );
  }
}

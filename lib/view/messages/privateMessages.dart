// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrivateMessage extends StatelessWidget {
  const PrivateMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F1F1),
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
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  children: [
                    Text(
                      Get.arguments[1],
                      style: TextStyle(
                        color: Colors.white, //Color(0xff9A8B8B),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Portada",
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 45.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        // color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          image: NetworkImage(Get.arguments[0]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Color(0xff43D0CA),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Placeholder()),
          textFormBuilder(),
        ],
      ),
    );
  }

  Row textFormBuilder() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Container(
            // width: 46.w,
            // height: 46.h,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: Color(0xffEFA11B),
              borderRadius: BorderRadius.circular(360.r),
            ),
            child: Image.asset(
              'assets/icons/send.png',
              width: 24.sp,
              height: 24.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: SizedBox(
            height: 50.h,
            width: 340.w,
            child: TextFormField(
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffF5F5F5),
                // fillColor: Colors.green,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),

                hintText: "اكتب رسالتك",
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  // color: Colors.grey,s
                ),

                prefixIcon: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // added line
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 3.w,
                    ),
                    Icon(
                      Icons.mic,
                      size: 25.sp,
                      // color: Color(0xff43D0CA),
                      color: Colors.red[700],
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Icon(
                      Icons.image,
                      size: 25.sp,
                      // color: Color(0xff43D0CA),
                      color: Colors.orange[700],
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Icon(
                      Icons.emoji_emotions,
                      size: 25.sp,
                      // color: Color(0xff43D0CA),
                      color: Colors.yellow[700],
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23.r),
                  borderSide: BorderSide.none,
                ),
                // filled: true,
                // fillColor: Colors.grey[200],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

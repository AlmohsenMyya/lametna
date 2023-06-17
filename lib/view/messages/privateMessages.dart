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
    );
  }
}

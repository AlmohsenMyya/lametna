import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeBackground extends StatelessWidget {
  const ChangeBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("تغيير خلفية الاسم", true),
      body: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Center(
            child: Text(
              "اختر خلفية",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Portada",
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          StyleContainer(),
          StyleContainer()
        ],
      ),
    );
  }
}

Widget StyleContainer() {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      height: 83.h,
      padding: EdgeInsets.all(7.sp),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
        // color: Color(0xFFE1E1E1),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFFA2ACAC),
          ],
        ),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 53.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(360.r),
            ),
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 30.sp,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "احمد حسن",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontFamily: "Portada",
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0.h, left: 20.w),
            child: Image.asset(
              "assets/images/vipBadge.png",
              width: 60.w,
              height: 60.h,
            ),
          ),
        ],
      ),
    ),
  );
}

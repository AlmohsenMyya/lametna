import 'package:flutter/material.dart';
import 'package:lametna/controllers/control%20panel/controllerPanelController.dart';

import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordRoom extends StatelessWidget {
  const ChangePasswordRoom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBuilder("تعديل الغرفة", false),
        body: Column(children: [
          SizedBox(
            height: 40.h,
          ),
          GetBuilder<MainControllerPanelController>(
              init: MainControllerPanelController(),
              builder: (controller) {
                return Center(
                  child: Text(
                    controller.data[0]["room_name"].toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.sp,
                        fontFamily: 'portada',
                        fontWeight: FontWeight.bold),
                  ),
                );
              }),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 95.h,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.all(16.0.w),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20.0.h),
                          Text(
                            'كلمة المرور',
                            style: TextStyle(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          GetBuilder<MainControllerPanelController>(
                              init: MainControllerPanelController(),
                              builder: (controller) {
                                return TextFormField(
                                  style: new TextStyle(
                                      fontSize: 16.0.sp, color: Colors.black),
                                  obscureText: !controller.passwordVisibility,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintStyle: TextStyle(
                                      color: Color(0xffE9E9E9),
                                      fontSize: 16.sp,
                                      fontFamily: "Portada",
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.passwordVisibility
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          controller.changePasswordVisibility();
                                        }),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.0.h, horizontal: 15.0.w),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(height: 20.0.h),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0.h),
                Container(
                  height: 53.h,
                  width: 360.w,
                  decoration: BoxDecoration(
                    color: Color(0xffFABD63),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "حفظ التعديلات",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontFamily: "Portada",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}

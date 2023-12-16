import 'package:flutter/material.dart';
import 'package:lametna/controllers/control%20panel/controllerPanelController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRoot extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  AddRoot({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("إضافة روت", false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 140.h,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'اسم الروت',
                        style: TextStyle(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 16.0.sp, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          hintStyle: TextStyle(
                            color: const Color(0xffE9E9E9),
                            fontSize: 16.sp,
                            fontFamily: "Portada",
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0.h, horizontal: 10.0.w),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xFF7BB39D), width: 1.0.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xFF7BB39D), width: 1.0.w),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Text(
                        'كلمة سر الروت',
                        style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      GetBuilder<MainControllerPanelController>(
                          init: MainControllerPanelController(),
                          builder: (controller) {
                            return TextFormField(
                              style: TextStyle(
                                  fontSize: 16.0.sp, color: Colors.black),
                              obscureText: !controller.passwordVisibility,
                              decoration: InputDecoration(
                                filled: true,
                                hintStyle: TextStyle(
                                  color: const Color(0xffE9E9E9),
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
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFF7BB39D), width: 1.0.w),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff7bb39d), width: 1.0.w),
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
            SizedBox(height: 290.0.h),
            Container(
              height: 53.h,
              width: 360.w,
              decoration: BoxDecoration(
                color: const Color(0xffFABD63),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.sp),
                ),
              ),
              child: Center(
                child: Text(
                  "إضافة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: "Segoe UI",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

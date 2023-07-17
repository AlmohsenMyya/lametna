// ignore_for_file: prefer_const_constructors, missing_required_param, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/profile/editProfileController.dart';

String dropdownvalue = 'Item 1';

// List of items in our dropdown menu
var items = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
];

class EditProfileAccount extends StatelessWidget {
  const EditProfileAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Center(
            child: Text(
              "تعديل الملف الشخصي",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Portada",
              ),
            ),
          ),
          SizedBox(width: 25.w),
        ],
      ),
      body: GetBuilder<EditProfileController>(
          init: EditProfileController(),
          builder: (controller) {
            return controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // final image = controller.();
                          // print(image);
                          controller.sendImageToAPI();

                          // controller.image = await controller.pickImage();
                          // controller.update();
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            SizedBox(
                              width: 70.w,
                              height: 83.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: Image.network(
                                  "https://lametnachat.com/upload/imageUser/" +
                                      controller.data["image"],
                                  fit: BoxFit.fill,
                                  width: 65.w,
                                  height: 70.h,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    "assets/icons/profile.png",
                                    height: 83.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 50.w,
                              // height: 69.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(100.r),
                                  bottomRight: Radius.circular(100.r),
                                ),
                              ),
                              child: Text(
                                "تغيير",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Portada",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      formBuilder(
                        "اللقب",
                        controller.nameController,
                        icon: Icon(
                          Icons.person,
                          color: Color(0xFF43D0CA),
                        ),
                      ),
                      formBuilder(
                        "الجنس",
                        controller.sexController,
                        icon: Image.asset(
                          'assets/icons/profile/gender.png',
                          width: 18.w,
                        ),
                      ),
                      formBuilder(
                        "تاريخ الميلاد",
                        controller.birthdayController,
                        icon: Image.asset(
                          'assets/icons/profile/cake.png',
                          width: 18.w,
                        ),
                      ),
                      formBuilder(
                        "الجنسية",
                        controller.nationalityController,
                        icon: Image.asset(
                          'assets/icons/profile/planet.png',
                          width: 18.w,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/profile/heart.png',
                                    width: 18.w,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    'الحالة الإجتماعية',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Portada",
                                    ),
                                  ),
                                ],
                              ),
                              GetBuilder<EditProfileController>(
                                  init: EditProfileController(),
                                  builder: (controller) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.w, vertical: 8.h),
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFF6F6F6),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFF6F6F6),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFF6F6F6),
                                            ),
                                          ),
                                        ),
                                        isExpanded: true,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        iconEnabledColor: Color(0xFF43D0CA),
                                        iconSize: 12.sp,

                                        icon: RotatedBox(
                                          child: Icon(Icons.arrow_back_ios),
                                          quarterTurns: 1,
                                        ),
                                        // Step 3.
                                        value: controller.dropdownValue,
                                        // Step 4.
                                        items: <String>["اعزب", "متزوج", "مطلق"]
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        // Step 5.
                                        onChanged: (String newValue) {
                                          controller
                                              .changeDropdownValue(newValue);
                                          // setState(() {
                                          //   dropdownValue = newValue!;
                                          // });
                                        },
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      formBuilder(
                        "البرج",
                        controller.asrologyController,
                        icon: Image.asset(
                          'assets/icons/profile/astrology.png',
                          width: 18.w,
                        ),
                      ),
                      formBuilder(
                          "حالة الدردشة", controller.chatStatusController,
                          // icon: Image.asset(
                          //   'assets/icons/profile/gender.png',
                          //   width: 18.w,
                          // ),
                          isIcon: true),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "تغير كلمة المرور",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Portada',
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Icon(Icons.check_box),
                            ],
                          ),
                          passwordBuilder("كلمة المرور الحالية",
                              controller.passwordController),
                          passwordBuilder("كلمة المرور الجديدة",
                              controller.newPasswordController),
                          passwordBuilder("تأكيد كلمة المرور الجديدة",
                              controller.confirmPasswordController),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Color(0xFFDA8080),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Text(
                              "إلغاء",
                              style: TextStyle(
                                fontFamily: 'Portada',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // The correct way of closing the keyboard is

                              FocusScope.of(context).unfocus();
                              controller.sendData();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Color(0xFF6BE05B),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Text(
                                "حفظ",
                                style: TextStyle(
                                  fontFamily: 'Portada',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      // TextButton(
                      //     onPressed: () {
                      //       controller.sendData();
                      //     },
                      //     child: Text("save"))
                    ],
                  );
          }),
    );
  }

  Widget passwordBuilder(String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: controller,

          style: TextStyle(color: Colors.black),
          // initialValue: controller.data["username"],
          onChanged: (value) {
            // controller.name = value;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            hintText: hint,
            // hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Portada",
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF6F6F6), width: 1.w),
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget formBuilder(String title, TextEditingController controller,
      {Widget icon, bool isIcon = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Row(
              children: [
                isIcon
                    ? SizedBox(
                        width: 17.w,
                      )
                    : icon,
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Portada",
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
              child: TextFormField(
                controller: controller,
                style: TextStyle(color: Colors.black),
                // initialValue: controller.data["username"],
                onChanged: (value) {
                  // controller.name = value;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  hintText: "أكتب هنا",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Portada",
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF6F6F6), width: 1.w),
                    borderRadius: BorderRadius.circular(15.r),
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

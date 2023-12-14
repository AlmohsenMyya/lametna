// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lametna/controllers/controller%20Panel/controllerPanelController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/In%20Room%20Widgets/appBar.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF3F4F8),
      appBar: appbarBuilder("لوحة التحكم", true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          // shrinkWrap: true,
          children: [
            ListTile(
              dense: true,
              leading: Image.asset(
                logo,
                width: 70.sp,
                height: 70.sp,
                fit: BoxFit.cover,
              ),
              title: Align(
                alignment: Alignment((1.3).sp, 0),
                child: Text(
                  "مرحبا بك " + userName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              subtitle: Align(
                alignment: Alignment((1.3).sp, 0),
                child: Text(
                  "رقم لوحتك " + userId,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // onTap: () {
              //   Navigator.pushNamed(context, "/profile");
              // },
            ),
            // Divider(
            //   color: Colors.black,
            //   thickness: 1,
            // ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFCBCBCB),
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Text(
                "مرحبا وطن لديك في رصيدك 2000 نقطة",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.sp,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              // height: 100.h,
              width: double.infinity,
              child: GetBuilder<ControlPanelController>(
                init: ControlPanelController(),
                builder: (controller) {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.85,
                    ),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => controller.updateSelectedPage(index),
                      child: Container(
                        // color: Colors.green,
                        margin: EdgeInsets.all(7.sp),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          gradient: LinearGradient(
                            colors: controller.selectedPage == index ? [Color(0xFFF792F0), Color(0xFFFABD63)] : [Colors.white, Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                          border: controller.selectedPage == index ? null : Border.all(color: Color(0xFFFABD63)),
                        ),
                        child: Center(
                          child: Text(
                            controller.categories[index],
                            style: TextStyle(
                                color: controller.selectedPage == index ? Colors.white : Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            GetBuilder<ControlPanelController>(builder: (controller) {
              return Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    mainPage(),
                    rooms(controller),
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget rooms(ControlPanelController controller) {
    return PageView(
      controller: controller.roomController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17 / 2.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Color(0xFFFABD63),
                    )),
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["الاسم", "كلمة السر", "الكود", "التاريخ"]
                      .map((e) => Expanded(
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 5.h),
              FutureBuilder(
                future: controller.getRooms(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: PopupMenuButton(
                        itemBuilder: (context) => [
                          statusBuilder("تعديل", icon: Icon(Icons.edit), onTap: () {
                            // controller.updateRoomPassword(snapshot.data[index]["room_id"]);
                            controller.jumpage();
                          }),
                        ],
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Color(0xFFFABD63),
                                width: 2.w,
                              )),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              snapshot.data[index]["room_name"],
                              snapshot.data[index]["password"],
                              snapshot.data[index]["room_id"],
                              snapshot.data[index]["expiry_date"].toString().substring(0, 10)
                            ]
                                .map(
                                  (e) => Expanded(
                                    child: Text(
                                      e,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تعديل كلمة المرور",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 40.h,
                  child: TextFormField(
                    controller: controller.roomPasswordController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      fillColor: Color(0xFFE7E7E7),
                      filled: true,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "تعديل الكود",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 40.h,
                  child: TextFormField(
                    controller: controller.roomCodeController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      fillColor: Color(0xFFE7E7E7),
                      filled: true,
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 33.h),
                GestureDetector(
                  onTap: () {
                    controller.updateRoomPassword();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFF792F0), Color(0xFFFABD63)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    child: Text(
                      "حفظ التعديلات",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget mainPage() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF792F0), Color(0xFFFABD63)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          width: Get.width * .90,
          child: Text(
            "خصومات جديدة في المتجر",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 45.h),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(controlPanelBanner), fit: BoxFit.cover),
          ),
          width: 381.w,
          height: 216.h,
        ),
        SizedBox(height: 45.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 90.w),
          child: Text(
            "تواصل معنا  لتجديد الاشتراكات علي الأرقام التالية 0592441967",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

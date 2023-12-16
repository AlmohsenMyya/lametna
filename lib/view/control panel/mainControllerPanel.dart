// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lametna/controllers/control%20panel/controllerPanelController.dart';

import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/view/side%20pages/scrollText.dart';

var list1 = [
  "الرئيسية",
  "المشتريات",
  "الغرف",
  "المستخدمين",
  "الأسماء",
  "المحظورين",
  "الروتات",
  "التقارير"
];
var room1 = ["أسم الغرفة", "الدولة", "كلمة السر", "الخيارات"];
var room2 = ["هروب من الواقع", "مصر", "290", "تعديل"];
var name1 = ["الأسم", "من   ", "الي   ", "    كلمة السر", "الخيارات"];
var name2 = ["محمود", "12-05-2023", "12-05-2023", "290", "تعديل"];
var data5 = [
  "اسم المنتج",
  "تاريخ البداية",
  "تاريخ الانتهاء",
];
var data6 = ["محمود", "1/1/2022", "1/1/2023"];
var user1 = ["الأسم", "النوع", "ID"];
var user2 = ["محمود", "icon", "335323"];
var panuser1 = ["الأسم", "الدولة", "المشرف", "ID"];
var panuser2 = ["محمود", "مصر", "ايمن", "335323"];
var report1 = [
  "الأسم",
  "التقارير",
];
var report2 = ["محمود", "تم طرد عضو"];

class MainControllerPanel extends StatelessWidget {
  const MainControllerPanel({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainControllerPanelController>(
        init: MainControllerPanelController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: controller.selectedIndex == 3
                ? FloatingActionButton(
                    backgroundColor: Color(0xff00E54C),
                    onPressed: () {
                      Get.toNamed('/addRoot');
                    },
                    child: Icon(Icons.add))
                : null,
            appBar: appbarBuilder("لوحة التحكم", true),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  GetBuilder<MainControllerPanelController>(
                      init: MainControllerPanelController(),
                      builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0.h, horizontal: 13.0.w),
                              child: Container(
                                width: 45.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0.r)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360.r),
                                  child: Image.network(
                                    "$imageURL$userName.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    " مرحبا بك  $userName",
                                    style: TextStyle(
                                      color: Colors.black, //Color(0xff9A8B8B),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Portada",
                                    ),
                                  ),
                                  Text(
                                    "رقم لوحتك  $userId",
                                    style: TextStyle(
                                      color: Colors.black, //Color(0xff9A8B8B),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Portada",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                  GetBuilder<MainControllerPanelController>(
                      init: MainControllerPanelController(),
                      builder: (controller) {
                        return Column(children: [
                          SizedBox(
                            height: 31.h,
                          ),
                          SizedBox(
                            height: 95.h,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: list1.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  // mainAxisExtent: 70,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6.h,
                                  mainAxisSpacing: 7.w,
                                  childAspectRatio: 0.4,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: EdgeInsets.zero,
                                      decoration: controller.selectedIndex ==
                                              index
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              color: Color(0xFFFFCC00),
                                            )
                                          : BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              border: Border.all(
                                                color: Color(0xFFFABD63),
                                              ),
                                            ),
                                      child: GestureDetector(
                                        onTap: () =>
                                            controller.changeIndex(index),
                                        child: Center(
                                          child: Text(
                                            list1[index],
                                            textAlign: TextAlign.center,
                                            style: controller.selectedIndex ==
                                                    index
                                                ? TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Portada",
                                                    fontSize: 10.sp,
                                                  )
                                                : TextStyle(
                                                    color: Color(0xFFFABD63),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Portada",
                                                    fontSize: 10.sp,
                                                  ),
                                          ),
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ),
                        ]);
                      }),
                  GetBuilder<MainControllerPanelController>(
                      builder: (controller) {
                    return SizedBox(
                      height: Get.height - 370.h,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: controller.pageController,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    color: Color(0xffF50D0D),
                                  ),
                                  child: ScrollingText(
                                    text: "شريط اخبار متحرك",
                                    ratioOfBlankToScreen: 1,
                                    textStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Portada"),
                                  ),
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                Container(
                                  width: 402.w,
                                  height: 228.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.r),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: Image.network(
                                      // Use a constant for the image URL
                                      'https://scalefusion.com/assets/new_layout_assets/sf_mobile_app_mgmnt/application-management-c4ac58452d6ee566eb271bbb51d2b3cf6b8f07e4907b00b15b4fe721bafc8d22.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "تواصل معنا لتجديد الاشتراكات",
                                        style: TextStyle(
                                          color:
                                              Colors.black, //Color(0xff9A8B8B),
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Portada",
                                        ),
                                      ),
                                      Text("علي الأرقام التالية",
                                          style: TextStyle(
                                            color: Colors
                                                .black, //Color(0xff9A8B8B),
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Portada",
                                          )),
                                      Text("+02011111111111",
                                          style: TextStyle(
                                            color: Colors
                                                .black, //Color(0xff9A8B8B),
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Portada",
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   color: Colors.green,
                            // ),
                            // Container(
                            //   color: Colors.red,
                            // ),
                            // Container(
                            //   color: Colors.yellow,
                            // ),
                            // Container(
                            //   color: Colors.brown,
                            // ),
                            // Container(
                            //   color: Colors.black,
                            // ),
                            // Container(
                            //   color: Colors.pink,
                            // ),
                            // Container(
                            //   color: Colors.amber,
                            // ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                      ),
                                      child: Container(
                                        height: 40.h,
                                        width: 400.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          border: Border.all(
                                            color: Color(0xFFFABD63),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(
                                            data5.length,
                                            (index) => Text(
                                              data5[index],
                                              style: TextStyle(
                                                color: Color(0xffFABD63),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Segoe UI",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Container(
                                        height: 40.h,
                                        color: Color(0xffE9E9E9),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: List.generate(
                                              data6.length,
                                              (index) => Text(
                                                data6[index],
                                                style: TextStyle(
                                                  color: Color(0xffFF0000),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Segoe UI",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: GetBuilder<MainControllerPanelController>(
                                  init: MainControllerPanelController(),
                                  builder: (controller) {
                                    return Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: 1,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            child: Container(
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                border: Border.all(
                                                  color: Color(0xFFFABD63),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: List.generate(
                                                  room1.length,
                                                  (index) => Text(
                                                    room1[index],
                                                    style: TextStyle(
                                                      color: Color(0xffFABD63),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Segoe UI",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller.data.length,
                                          itemBuilder: (context, index) =>
                                              Column(
                                            children: [
                                              buildPadding(
                                                  controller.data[index]
                                                          ["room_name"]
                                                      .toString(),
                                                  controller.data[index]
                                                          ["country_name"]
                                                      .toString(),
                                                  controller.data[index]
                                                          ["password"]
                                                      .toString(),
                                                  "تعديل", () {
                                                Get.toNamed(
                                                    '/changePasswordRoom');
                                              }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                      ),
                                      child: Container(
                                        height: 40.h,
                                        width: 400.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          border: Border.all(
                                            color: Color(0xFFFABD63),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(
                                            user1.length,
                                            (index) => Text(
                                              user1[index],
                                              style: TextStyle(
                                                color: Color(0xffFABD63),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Segoe UI",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Container(
                                        height: 40.h,
                                        color: Color(0xffE9E9E9),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: List.generate(
                                              user2.length,
                                              (index) => Text(
                                                user2[index],
                                                style: TextStyle(
                                                  color: Color(0xffFF0000),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Segoe UI",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: GetBuilder<MainControllerPanelController>(
                                  builder: (controller) {
                                return Container(
                                  // color: Colors.green,
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: 1,
                                        itemBuilder: (context, index) => Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w),
                                            child: Container(
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                border: Border.all(
                                                  color: Color(0xFFFABD63),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: List.generate(
                                                  name1.length,
                                                  (index) => Text(
                                                    name1[index],
                                                    style: TextStyle(
                                                      color: Color(0xffFABD63),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "Segoe UI",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // FutureBuilder(
                                      //   future: controller.getRoles(),
                                      //   builder: (context, snapshot) => Text(
                                      //     snapshot.data.toString(),
                                      //     style: TextStyle(color: Colors.black),
                                      //   ),
                                      // )
                                      SizedBox(
                                        height: 300,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          // scrollDirection: Axis.vertical,
                                          itemCount:
                                              controller.listOfRoles.length - 1,
                                          itemBuilder: (context, index) =>
                                              buildPadding(
                                                  controller.listOfRoles[index]
                                                          ["username"]
                                                      .toString(),
                                                  "20-22222",
                                                  "20-22222",
                                                  "تعديل",
                                                  () {}),
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.all(8.0),
                                          //   child: Text(
                                          // controller
                                          //     .listOfRoles[index]
                                          //         ["username"]
                                          //     .toString(),
                                          //     style: TextStyle(
                                          //         color: Colors.yellow),
                                          //   ),
                                          // )
                                          // Column(
                                          //   children: [
                                          //     buildPadding(
                                          //         userName,
                                          //         controller.data[index]
                                          //                 ["start_date"]
                                          //             .toString()
                                          //             .substring(0, 10),
                                          //         controller.data[index]
                                          //                 ["expiry_date"]
                                          //             .toString()
                                          //             .substring(0, 10),
                                          //         "تعديل",
                                          //         () {}),
                                          //   ],
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                      ),
                                      child: Container(
                                        height: 40.h,
                                        width: 400.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          border: Border.all(
                                            color: Color(0xFFFABD63),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(
                                            panuser1.length,
                                            (index) => Text(
                                              panuser1[index],
                                              style: TextStyle(
                                                color: Color(0xffFABD63),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Segoe UI",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Container(
                                        height: 40.h,
                                        color: Color(0xffE9E9E9),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: List.generate(
                                              panuser2.length,
                                              (index) => Text(
                                                panuser2[index],
                                                style: TextStyle(
                                                  color: Color(0xffFF0000),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Segoe UI",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: GetBuilder<MainControllerPanelController>(
                                  builder: (controller) {
                                return Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: 1,
                                      itemBuilder: (context, index) => Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w),
                                          child: Container(
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              border: Border.all(
                                                color: Color(0xFFFABD63),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: List.generate(
                                                name1.length,
                                                (index) => Text(
                                                  name1[index],
                                                  style: TextStyle(
                                                    color: Color(0xffFABD63),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Segoe UI",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: 1,
                                      itemBuilder: (context, index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w),
                                        child: Container(
                                          height: 40.h,
                                          color: Color(0xffE9E9E9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: List.generate(
                                                name2.length,
                                                (index) => Text(
                                                  name2[index],
                                                  style: TextStyle(
                                                    color: Color(0xffFF0000),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Segoe UI",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                      ),
                                      child: Container(
                                        height: 40.h,
                                        width: 400.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          border: Border.all(
                                            color: Color(0xFFFABD63),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(
                                            report1.length,
                                            (index) => Text(
                                              report1[index],
                                              style: TextStyle(
                                                color: Color(0xffFABD63),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Segoe UI",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Container(
                                        height: 40.h,
                                        color: Color(0xffE9E9E9),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: List.generate(
                                              report2.length,
                                              (index) => Text(
                                                report2[index],
                                                style: TextStyle(
                                                  color: Color(0xffFF0000),
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Segoe UI",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        });
  }

  Padding buildPadding(String title, String title1, String title2,
      String title3, Function function) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Container(
        height: 40.h,
        color: Color(0xffE9E9E9),
        child: Padding(
          padding: EdgeInsets.only(left: 2.0.w),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xffFF0000),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Segoe UI",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.0.w),
                    child: Text(
                      title1,
                      style: TextStyle(
                        color: Color(0xffFF0000),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Segoe UI",
                      ),
                    ),
                  ),
                  Text(
                    title2,
                    style: TextStyle(
                      color: Color(0xffFF0000),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Segoe UI",
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: Color(0xffFF0000),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Segoe UI",
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_road, size: 18.sp), onPressed: () {  },
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.toNamed('/changePasswordRoom');
                          function();
                        },
                        child: Text(
                          title3,
                          style: TextStyle(
                            color: Color(0xffFF0000),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Segoe UI",
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

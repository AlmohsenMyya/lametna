// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/store/storeController.dart';

import '../../controllers/chathomePageController.dart';

var l = ["الملفات", "الغرف", "روتات", "إطارات", "العروض"];
var month = ["شهر", "3 شهر", "6 شهر", "سنة"];

class test extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //const test({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: Drawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72.h),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFABD63),
                  Color(0xFFF792F0),
                ],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 130.w,
              leading: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                  ),
                ],
              ),
              title: Text(
                "Lametna",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Portada",
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Image.asset(
                    "assets/images/trophy.png",
                    width: 55.w,
                    height: 30.h,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // print("object");
                      // Scaffold.of(context).openDrawer();
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                    icon: Icon(Icons.menu)),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(child: buildColumn(context)));
  }

  Widget buildColumn(BuildContext context) {
    return Column(
      children: [
        GetBuilder<StoreController>(
            init: StoreController(),
            builder: (controller) {
              return Column(
                  // shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 31.h,
                    ),
                    SizedBox(
                      height: 42.h,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: l.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Container(
                              height: 42.h,
                              width: 80.w,
                              decoration: controller.selectedIndex == index
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: Color(0xFFFFCC00))
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      border: Border.all(
                                        color: Color(0xFFFABD63),
                                      ),
                                    ),
                              child: TextButton(
                                onPressed: () {
                                  controller.changeIndex(index);
                                },
                                child: Text(
                                  l[index],
                                  style: controller.selectedIndex == index
                                      ? TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Portada",
                                          fontSize: 12.sp,
                                        )
                                      : TextStyle(
                                          color: Color(0xFFFABD63),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Portada",
                                          fontSize: 12.sp,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]);
            }),
        SizedBox(
          height: 25.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 42.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: month.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Container(
                    // height: 35.h,
                    // width: 52.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Color(0xFFFABD63),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          month[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 29.h,
        ),
        GetBuilder<StoreController>(builder: (controller) {
          return SizedBox(
            height: Get.height - 200.h,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.scrollController,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: GridView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 13.h,
                        ),
                        itemBuilder: (context, index) => Container(
                              color: Colors.green,
                            )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: GridView(
                        // itemCount: 3,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 13.h,
                          childAspectRatio: 0.5,
                        ),
                        children: [
                          roomBuilder(
                              "ملف محمي ",
                              "35",
                              [
                                "ملف شخصي",
                                "مجموعة من الخلفيات المميزة",
                                "ارسال الصور في العام والخاص"
                              ],
                              "assets/images/1.png"),
                          // roomBuilder("ملف محمي ", "35", [
                          //   "ملف شخصي",
                          //   "حالة تحت الأسم",
                          //   "صورة شخصية بجانب الاسم",
                          //   "ارسال الصور في العام والخاص",
                          //   "إشارة VIP",
                          //   "اسم مميز علي العام",
                          //   "اكثر من 90 خلفية للإسم"
                          // ])
                        ]),
                  ),
                  Container(
                    color: Colors.yellow,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }

  Widget roomBuilder(String title, String price, List items, String banner) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              height: 235.h,
              // width: 156.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: Color(0xFFFABD63)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                      // changes position of shadow
                    ),
                  ]),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Container(
                      width: 131,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                        color: Color(0xFFFABD63),
                        border: Border.all(
                          color: Color(0xFFFABD63),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) => Container(
                      width: 114.w,
                      height: 15.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Color(0xffE1E1E1),
                      ),
                      child: Text(
                        items[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Segoe UI",
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget offerBuilder(String title, String price, String text1, String text2,
      String text3, String text4) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              height: 220.h,
              width: 156.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: Color(0xFF43D0CA)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                      // changes position of shadow
                    ),
                  ]),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Container(
                      width: 131.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                        color: Color(0xFFFABD63),
                        border: Border.all(
                          color: Color(0xFFFABD63),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text1,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text3,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text4,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(price,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Portada",
                            fontWeight: FontWeight.w900,
                            fontSize: 12.sp,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 14.h),
                        child: Container(
                          width: 130.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFFABD63),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              "أطلب الأن",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Portada"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget frameBuilder(String text, String price, var image) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              height: 182.h,
              width: 156.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Container(
                      width: 120.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                        color: Color(0xFFFABD63),
                        border: Border.all(
                          color: Color(0xFFFABD63),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Wahran",
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        width: 63.w,
                        height: 57.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              image,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(price,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Portada",
                            fontWeight: FontWeight.w900,
                            fontSize: 13.sp,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 14.h),
                        child: Container(
                          width: 102.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFFABD63),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              "شراء",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Portada"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget rootBuilder(String text, String price, Color color) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              height: 160.h,
              width: 117.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Container(
                      width: 78,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                        color: Color(0xFFFABD63),
                        border: Border.all(
                          color: Color(0xFFFABD63),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Wahran",
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 78.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5.w, color: color),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lametna',
                              style: TextStyle(
                                color: Color(0xffFFAE0C),
                                fontFamily: "Segoe UI",
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Text(price,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Portada",
                            fontWeight: FontWeight.w900,
                            fontSize: 13.sp,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 14.h),
                        child: Container(
                          width: 61.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFFABD63),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              "شراء",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Arial"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget roomBuilder3(String title, String price, String text1, String text2,
      String text3, String text4, String text5, String text6) {
    return Padding(
      padding: EdgeInsets.only(top: 25.0.h),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                height: 300.h,
                width: 156.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: Color(0xFFFABD63)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00000029).withOpacity(0.2),
                        spreadRadius: 0.5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                        // changes position of shadow
                      ),
                    ]),
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                        width: 131.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                          ),
                          color: Color(0xFFFABD63),
                          border: Border.all(
                            color: Color(0xFFFABD63),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 114.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffE1E1E1),
                          ),
                          child: Text(
                            'ملف شخصي',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Segoe UI",
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 114.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffE1E1E1),
                          ),
                          child: Text(
                            text1,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Segoe UI",
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 114.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffE1E1E1),
                          ),
                          child: Text(
                            text2,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Segoe UI",
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 114.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffE1E1E1),
                          ),
                          child: Text(
                            text3,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Segoe UI",
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 114.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffE1E1E1),
                          ),
                          child: Text(
                            text4,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Segoe UI",
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 114.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffE1E1E1),
                          ),
                          child: Text(
                            text5,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Segoe UI",
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 114.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: Color(0xffE1E1E1),
                          ),
                          child: Text(
                            text6,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Segoe UI",
                              fontWeight: FontWeight.bold,
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        Container(
                          width: 134.w,
                          height: 27.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF6EE1DC),
                                Color(0xFFB1C061),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.r)),
                                    color: Color(0xFFFABD63),
                                    // border: Border.all(
                                    //   color: Color(0xFFFABD63),
                                    // ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/profile.png",
                                    width: 22.w,
                                    height: 22.h,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.0.h),
                                child: Text('Lametna',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Segoe UI",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7.sp,
                                    )),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 35.0.w, bottom: 10),
                                child: Container(
                                  child: Image.asset(
                                    "assets/images/tag.png",
                                    width: 21.w,
                                    height: 24.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(price,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Portada",
                              fontWeight: FontWeight.w900,
                              fontSize: 12.sp,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 14.h),
                          child: Container(
                            width: 149.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFFABD63),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                "أطلب الأن",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Portada"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget roomBuilder4(
      String title,
      String price,
      String text1,
      String text2,
      String text3,
      String text4,
      String text5,
      String text6,
      String text7,
      String text8) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              height: 340.h,
              width: 156.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: Color(0xFFFABD63)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                      // changes position of shadow
                    ),
                  ]),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Container(
                      width: 131.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                        color: Color(0xFFFABD63),
                        border: Border.all(
                          color: Color(0xFFFABD63),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          'ملف شخصي',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text1,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text3,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text4,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text5,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text6,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text7,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text8,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      Container(
                        width: 134.w,
                        height: 27.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFFCC00),
                              Color(0xFFFFFFFF),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                  color: Color(0xFFFABD63),
                                  // border: Border.all(
                                  //   color: Color(0xFFFABD63),
                                  // ),
                                ),
                                child: Image.asset(
                                  "assets/images/profile1.png",
                                  width: 22.w,
                                  height: 22.h,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0.h),
                              child: Text('Lametna',
                                  style: TextStyle(
                                    color: Color(0xffFF0000),
                                    fontFamily: "Segoe UI",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 7.sp,
                                  )),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: 35.0.w, bottom: 10),
                              child: Container(
                                child: Image.asset(
                                  "assets/images/padg3.png",
                                  width: 35.w,
                                  height: 35.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(price,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Portada",
                            fontWeight: FontWeight.w900,
                            fontSize: 12.sp,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 14.h),
                        child: Container(
                          width: 149.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFFABD63),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              "أطلب الأن",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Portada"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget roomBuilder2(String title, String price, String text1, String text2,
      String text3, Color color1) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              height: 250.h,
              width: 156.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: Color(0xFFFABD63)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                      // changes position of shadow
                    ),
                  ]),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Container(
                      width: 131.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                        color: Color(0xFFFABD63),
                        border: Border.all(
                          color: Color(0xFFFABD63),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          'ملف شخصي',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text1,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text2,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        width: 114.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Text(
                          text3,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.bold,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      Container(
                        width: 134.w,
                        height: 27.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFE1E1E1),
                              Color(0xFFffffff),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                  color: Color(0xFFFABD63),
                                  // border: Border.all(
                                  //   color: Color(0xFFFABD63),
                                  // ),
                                ),
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  width: 22.w,
                                  height: 22.h,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0.h),
                              child: Text('Lametna',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Segoe UI",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 7.sp,
                                  )),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: 35.0.w, bottom: 10),
                              child: Container(
                                child: Image.asset(
                                  "assets/images/tag.png",
                                  width: 21.w,
                                  height: 24.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(price,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Portada",
                            fontWeight: FontWeight.w900,
                            fontSize: 12.sp,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 14.h),
                        child: Container(
                          width: 149.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFFABD63),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              "أطلب الأن",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Portada"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget marketBuilder(String text, String price, String num1, String num2,
      String num3, String num4, String num5) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              height: 260.h,
              width: 156.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.2),
                      spreadRadius: 0.5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Container(
                      width: 120,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                        color: Color(0xFFFABD63),
                        border: Border.all(
                          color: Color(0xFFFABD63),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'غرفة',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontFamily: "Segoe UI",
                          fontWeight: FontWeight.normal,
                          color: Color(0xff707070),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            num1,
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "مستخدم",
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            num2,
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Color(0xFFFF0000),
                            ),
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            "سوبر ماستر",
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Color(0xFFFF0000),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            num3,
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Color(0xff5D00FF),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "سوبر أدمن",
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Color(0xff5D00FF),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            num4,
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Color(0xff00B041),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            "أدمن",
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Color(0xff00B041),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            num4,
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Color(0xffFF00EE),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            "ممبر",
                            style: TextStyle(
                              fontSize: 7.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Portada",
                              color: Color(0xffFF00EE),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Container(
                        width: 134.w,
                        height: 27.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          color: Color(0xffE1E1E1),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: Image.asset(
                                "assets/images/profile.png",
                                width: 22.w,
                                height: 22.h,
                              ),
                            ),
                            Text('Master',
                                style: TextStyle(
                                  color: Color(0xffFF1B00),
                                  fontFamily: "Portada",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Text(price,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Portada",
                            fontWeight: FontWeight.w900,
                            fontSize: 13.sp,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 14.h),
                        child: Container(
                          width: 102.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFFABD63),
                            borderRadius: BorderRadius.circular(9.r),
                          ),
                          child: Center(
                            child: Text(
                              "شراء",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Portada"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

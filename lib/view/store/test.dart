// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
                          style: TextStyle(color: Colors.red),
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
            height: Get.height - 370.h,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: GridView(
                        //itemCount: 3,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 30.w,
                          mainAxisSpacing: 13.h,
                          childAspectRatio: 0.7,
                        ),
                        children: [
                          marketBuilder(["100", "30", "30", "45", "45"], "150"),
                          marketBuilder(["50", "20", "20", "30", "30"], "100"),
                          marketBuilder(["150", "50", "50", "75", "75"], "200"),
                          // marketBuilder("كل 3 أشهر", "100 \u0024", "50", "20",
                          //     "20", "30", "30"),
                          // marketBuilder("كل 3 أشهر", "200 \u0024", "150", "50",
                          //     "50", "75", "75"),
                        ]),
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              roomBuilder(
                                  "ملف محمي",
                                  [
                                    "ملف شخصي",
                                    "ارسال الصور في العام والخاص",
                                    "بدون خلفية",
                                  ],
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Container(
                                      padding: EdgeInsets.all(7.sp),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            blurRadius: 6,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        color: Color(0xFFE1E1E1),
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360.r),
                                                ),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                  size: 20.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "lametna",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8.sp,
                                                  fontFamily: "Portada",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.verified,
                                            color: Colors.lightBlue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  "35"),
                              roomBuilder(
                                  "VIP ملف محمي",
                                  [
                                    "ملف شخصي",
                                    "مجموعة من الخلفيات المميزة",
                                    "ارسال الصور في العام والخاص",
                                  ],
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Container(
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
                                            Color(0xFF5CE1E6),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          360.r),
                                                ),
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                  size: 20.sp,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "lametna",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8.sp,
                                                  fontFamily: "Portada",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.yellow,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  "35"),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              roomBuilder(
                                  "ملف ملكي",
                                  [
                                    "ملف شخصي",
                                    "حالة تحت الأسم",
                                    "صورة شخصية بجانب الاسم"
                                        "ارسال الصور في العام والخاص",
                                  ],
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Container(
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
                                            Color(0xFF5CE1E6),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(360.r),
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.black,
                                              size: 20.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "lametna",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.sp,
                                              fontFamily: "Portada",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  "60"),
                              roomBuilder(
                                  "ملف ملكي",
                                  [
                                    "ملف شخصي",
                                    "حالة تحت الأسم",
                                    "صورة شخصية بجانب الاسم"
                                        "ارسال الصور في العام والخاص",
                                  ],
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Container(
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
                                            Color(0xFF5CE1E6),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(360.r),
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.black,
                                              size: 20.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "lametna",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.sp,
                                              fontFamily: "Portada",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  "60")
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: GridView(
                        physics: ScrollPhysics(),
                        //itemCount: 3,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 13.h,
                          childAspectRatio: 0.8,
                        ),
                        children: [
                          rootBuilder("1 روت", "50 \u0024", Colors.white),
                          rootBuilder("3 روت", "120 \u0024", Colors.black),
                          rootBuilder("5 روت", "250 \u0024", Colors.black)
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: GridView(
                        //itemCount: 3,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 13.h,
                          childAspectRatio: 1.1,
                        ),
                        children: [
                          frameBuilder(
                            "إطار مميز",
                            "5 \u0024",
                            "assets/images/badge1.png",
                          ),
                          frameBuilder(
                            "إطار مميز",
                            "5 \u0024",
                            "assets/images/badge1.png",
                          ),
                          frameBuilder(
                            "إطار مميز",
                            "5 \u0024",
                            "assets/images/badge3.png",
                          ),
                          frameBuilder(
                            "إطار مميز",
                            "5 \u0024",
                            "assets/images/badge4.png",
                          ),
                          frameBuilder(
                            "إطار مميز",
                            "5 \u0024",
                            "assets/images/badge3.png",
                          )
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: GridView(
                          //itemCount: 3,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 13.h,
                            childAspectRatio: 0.9,
                          ),
                          children: [
                            offerBuilder(
                                "العرض الثالث",
                                "350 دولار",
                                "غرف فضية 100",
                                "ملف محمي عدد 2",
                                "أسم الروت عدد 2",
                                "ملف ملكي مميز خلفية ثابتة"),
                            offerBuilder(
                                "العرض الثاني",
                                "300 دولار",
                                "غرف فضية 100",
                                "ملف ملكي مميز خلفية ثابتة",
                                "ملف محمي عدد 2",
                                "أسم الروت عدد 2"),
                            offerBuilder(
                                "العرض الأول",
                                "200 دولار",
                                "مستخدم 50",
                                "ملف ملكي",
                                "ملف محمي عدد 2",
                                "أسم الروت "),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }

  Container roomBuilder(String title, List items, Widget banner, String price) {
    return Container(
      width: 155.w,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffFABD63), width: 1.w),
        borderRadius: BorderRadius.circular(10.r),
        // color: Colors.green,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffFABD63),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontFamily: "Portada",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Color(0xffE1E1E1),
                ),
                child: Text(
                  items[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.sp,
                    fontFamily: 'Segoe UI',
                  ),
                ),
              ),
            ),
            itemCount: items.length,
            shrinkWrap: true,
          ),
          SizedBox(height: 10.h),
          banner,
          SizedBox(
            height: 10.h,
          ),
          Text(
            "$price دولار",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontFamily: 'portada',
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Color(0xffFABD63),
              ),
              child: Center(
                child: Text(
                  "أطلب الأن",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontFamily: 'portada',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
        ],
      ),
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
                      color: Color(0xFF00000029).withOpacity(0.1),
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
                            fontWeight: FontWeight.w900,
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
                            fontWeight: FontWeight.w900,
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
                            fontWeight: FontWeight.w900,
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
                            fontWeight: FontWeight.w900,
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
                            fontWeight: FontWeight.w700,
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
                      color: Color(0xFF00000029).withOpacity(0.1),
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
                      color: Color(0xFF00000029).withOpacity(0.1),
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
                            color: Color(0xffFABB64),
                            fontFamily: "Portada",
                            fontWeight: FontWeight.w900,
                            fontSize: 10.sp,
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

  Widget marketBuilder(List prices, String price) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              height: 260.h,
              // width: 156.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00000029).withOpacity(0.1),
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return [
                            {
                              "val": "مستخدم",
                              "color": Colors.black,
                            },
                            {
                              "val": "سوبر ماستر",
                              "color": Colors.red,
                            },
                            {
                              "val": "سوبر أدمن",
                              "color": Colors.purple,
                            },
                            {
                              "val": "أدمن",
                              "color": Colors.green,
                            },
                            {
                              "val": "ممبر",
                              "color": Colors.pink,
                            }
                          ]
                              .map((e) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 78.w,
                                        height: 20.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(prices[index],
                                                style: TextStyle(
                                                  color: e['color'],
                                                  fontFamily: "Portada",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10.sp,
                                                )),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              e['val'],
                                              style: TextStyle(
                                                color: e['color'],
                                                fontFamily: "Segoe UI",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList()[index];
                        },
                        itemCount: prices.length,
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
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 18.sp,
                                ),
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
                      Text(price + " \$",
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
}

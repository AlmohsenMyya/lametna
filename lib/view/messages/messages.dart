// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Messages extends StatelessWidget {
  Messages({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var images = [
    "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80",
    "https://engineering.unl.edu/images/staff/Kayla-Person.jpg",
    "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg",
  ];
  var names = ["محمد", "احمد", "محمود"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72.h),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF792F0),
                  Color(0xFFFABD63),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
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
                ),
              ),
              actions: [
                Image.asset(
                  "assets/images/trophy.png",
                  width: 55.w,
                  height: 30.h,
                ),
                IconButton(
                    onPressed: () {
                      print("object");
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                    icon: Icon(Icons.menu)),
              ],
              // actions: [
              //   Image.asset(
              //     "assets/images/trophy.png",
              //     width: 55.w,
              //     height: 30.h,
              //   ),
              //   IconButton(
              //       onPressed: () {
              //         print("object");
              //         Scaffold.of(context).openDrawer();
              //         _scaffoldKey.currentState.openEndDrawer();
              //       },
              //       icon: Icon(Icons.menu)),
              // ],
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: SizedBox(
                height: 50.h,
                child: TextFormField(
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),

                    hintText: "بحث",
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      // color: Colors.grey,s
                    ),

                    prefixIcon: Icon(
                      Icons.search,
                      size: 20.sp,
                      color: Color(0xff43D0CA),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Color(0xff43D0CA),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Color(0xff43D0CA),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Color(0xff43D0CA),
                        width: 1,
                      ),
                    ),
                    // filled: true,
                    // fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => userMessageBuilder(
                images[Random().nextInt(3)],
                names[Random().nextInt(3)],
              ),
              itemCount: 10,
            ),
          ],
        ));
  }

  Widget userMessageBuilder(String image, String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () {
            Get.toNamed("/privateMessage", arguments: [image, name]);
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 75.w,
                      height: 85.h,
                      decoration: BoxDecoration(
                        // color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Color(0xff43D0CA),
                          width: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 29.h,
                          child: Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontFamily: "Portada",
                            ),
                          ),
                        ),
                        Text(
                          "السلام عليكم",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff707070),
                            fontSize: 8.sp,
                            fontFamily: "Portada",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "12:00",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff707070),
                        fontSize: 8.sp,
                        fontFamily: "Portada",
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

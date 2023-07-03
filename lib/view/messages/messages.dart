// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/messages/messagesController.dart';

class Messages extends StatelessWidget {
  Messages({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var images = [
    "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80",
    "https://engineering.unl.edu/images/staff/Kayla-Person.jpg",
    "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg",
  ];
  var users = [
    {
      "name": "محمد",
      "image":
          "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg"
    },
    {
      "name": "احمد",
      "image": "https://engineering.unl.edu/images/staff/Kayla-Person.jpg"
    },
    {
      "name": "محمود",
      "image":
          "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg"
    },
    {
      "name": "محمد",
      "image": "https://engineering.unl.edu/images/staff/Kayla-Person.jpg"
    },
    {
      "name": "احمد",
      "image":
          "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg"
    },
    {
      "name": "محمود",
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80"
    },
    {
      "name": "محمد",
      "image":
          "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg"
    },
    {
      "name": "احمد",
      "image":
          "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg"
    },
    {
      "name": "محمود",
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80"
    },
  ];

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
              child: GetBuilder<MessagesController>(
                  init: MessagesController(),
                  builder: (controller) {
                    return TextFormField(
                      controller: controller.searchController,
                      textAlign: TextAlign.right,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) => controller.search(),
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
                    );
                  }),
            ),
          ),
          GetBuilder<MessagesController>(
              builder: (controller) => controller.searchController.text.isEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          userMessageBuilder(index, context),
                      itemCount: users.length,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: Text(
                            controller.data[index]["username"].toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      itemCount: controller.data.length,
                    ))
        ],
      ),
    );
  }

  Widget userMessageBuilder(int position, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () {
            Get.toNamed("/privateMessage",
                arguments: [users[position]["image"], users[position]["name"]]);
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
                          image: NetworkImage(users[position]["image"]),
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
                            users[position]["name"],
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
                    GestureDetector(
                      onTap: () {
                        _showMyDialog(context, position);
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
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

  Future<void> _showSuccess(BuildContext context) async {
    return showDialog<void>(
      context: context,

      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Icon(
                    Icons.check_box_outlined,
                    color: Colors.greenAccent,
                    size: 50.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "تم حذف الدردشة بناج",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Portada'),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future<void> _showMyDialog(BuildContext context, int position) async {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: 2,
                      child: Icon(Icons.info_outlined,
                          color: Colors.red, size: 50.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'هل تريد حدف الدردشة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: "Portada",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Color(0xffE34848),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
                    child: Text(
                      'إلغاء',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: "Portada",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _showSuccess(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Color(0xff47A6E5),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 5.h),
                    child: Text(
                      'موافق',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: "Portada",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

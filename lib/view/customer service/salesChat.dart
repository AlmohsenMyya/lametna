// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/customer%20service/salesChatController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';

class SalesChat extends StatelessWidget {
  const SalesChat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("فريق المبيعات", false),
      body: Column(
        children: [
          // Expanded(child: Placeholder()),
          Expanded(
            child: GetBuilder<SalesChatController>(
              init: SalesChatController(),
              builder: (controller) {
                return FutureBuilder(
                  future: controller.getMessage(),
                  builder: (context, snapshot) => StreamBuilder(
                    stream: controller.messages.stream,
                    builder: (context, snapshot) => ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 8.w),
                        child: Column(
                          crossAxisAlignment: snapshot.data["data"][index]
                                      ["reciever"] ==
                                  userName
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  // color: Colors.green,
                                  border: Border.all(color: Color(0xFF43D0CA)),
                                  borderRadius: BorderRadius.circular(360.r)),
                              child: snapshot.data["data"][index]["reciever"] ==
                                      userName
                                  ? Image.asset('assets/icons/logo.png',
                                      width: 46.w, height: 46.h)
                                  : Image.network(
                                      imageURL +
                                          snapshot.data["data"][index]
                                              ["sender"] +
                                          ".jpeg",
                                      width: 44.w,
                                      height: 44.h,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: snapshot.data["data"][index]
                                              ["reciever"] !=
                                          userName
                                      ? 50.w
                                      : 0,
                                  right: snapshot.data["data"][index]
                                              ["reciever"] ==
                                          userName
                                      ? 50.w
                                      : 0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: snapshot.data["data"][index]
                                              ["reciever"] !=
                                          userName
                                      ? Color(0xffFABD63)
                                      : Color(0xffF5F5F5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Text(
                                  snapshot.data["data"][index]["message"]
                                      .toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 71.h,
            // color: Colors.amber,
            child: GetBuilder<SalesChatController>(builder: (controller) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // print("object");
                      controller.sendMessage(userName);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Container(
                        // width: 46.w,
                        // height: 46.h,
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: Color(0xffFABD63),
                          borderRadius: BorderRadius.circular(360.r),
                        ),
                        child: Image.asset(
                          'assets/icons/send.png',
                          width: 26.w,
                          height: 26.h,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: SizedBox(
                      width: 320.w,
                      height: 46.h,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: controller.messageController,

                          // textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.black, //Color(0xff9A8B8B),
                            fontSize: 14.sp,
                            fontFamily: "Portada",
                          ),

                          decoration: InputDecoration(
                            fillColor: Color(0xffF5F5F5),
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 19.w),
                            hintText: "اكتب رسالتك",
                            hintStyle: TextStyle(
                              color: Color(0xFFA2ACAC), //Color(0xff9A8B8B),
                              fontSize: 14.sp,
                              fontFamily: "Portada",
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(360.r),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(360.r),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(360.r),
                              borderSide: BorderSide.none,
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
        ],
      ),
    );
  }
}

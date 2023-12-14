// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/chat/in%20room%20chat/previosChatController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';

class PreviosChat extends StatelessWidget {
  const PreviosChat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: Container(
          decoration: const BoxDecoration(
            // LinearGradient
            gradient: LinearGradient(
              colors: [
                const Color(0xFFF792F0),
                const Color(0xFFFABD63),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            leadingWidth: 200.w,
            title: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Text(
                  "الدردشات",
                  style: TextStyle(
                    color: Colors.white, //Color(0xff9A8B8B),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Portada",
                  ),
                ),
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  SizedBox(width: 10.w),
                  Image.asset('assets/icons/group.png', width: 30.sp),
                  Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                    size: 25.sp,
                  ),
                  Text(
                    "العودة إلى الدردشة العامة",
                    style: TextStyle(
                      fontFamily: 'Portada',
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: GetBuilder<PreviosChatController>(
        init: PreviosChatController(),
        builder: (controller) => FutureBuilder(
          future: controller.getChats(),
          builder: (context, snapshot) => StreamBuilder(
            stream: controller.streamController.stream,
            builder: (context, snapshot) => ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // print("object");
                    Get.toNamed(
                      "/privateMessageRoom",
                      arguments: {
                        "username": snapshot.data[index]["recieverUserRoom"]
                                    .toString() ==
                                userName
                            ? snapshot.data[index]["senderUserRoom"].toString()
                            : snapshot.data[index]["recieverUserRoom"]
                                .toString(),
                        "room_id": Get.arguments['roomId'],
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        // color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF43D0CA),
                          width: 1.w,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              // snapshot.data[0][index]["reciever_user"]
                              // .toString(),
                              snapshot.data[index]["recieverUserRoom"]
                                          .toString() ==
                                      userName
                                  ? snapshot.data[index]["senderUserRoom"]
                                      .toString()
                                  : snapshot.data[index]["recieverUserRoom"]
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15.sp),
                            ),
                            Text(
                              snapshot.data[index]["message"].toString(),
                              style: TextStyle(
                                  color: Color(0xff5C5E5E),
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14.sp),
                            ),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360.r),
                            border: Border.all(
                              color: Color(0xFF707070),
                              width: 1.w,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(360.r),
                            child: Image.network(
                              imageURL +
                                          snapshot.data[index]
                                                  ["recieverUserRoom"]
                                              .toString() ==
                                      userName
                                  ? snapshot.data[index]["senderUserRoom"]
                                      .toString()
                                  : snapshot.data[index]["recieverUserRoom"]
                                          .toString() +
                                      ".jpeg",
                              fit: BoxFit.cover,
                              width: 50.w,
                              height: 55.h,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                'https://lametnachat.com/upload/imageUser/anonymous.jpg',
                                width: 50.w,
                                height: 55.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// : Image.asset(
//                               'assets/icons/group.png',
//                               width: 30.sp,
//                             ),

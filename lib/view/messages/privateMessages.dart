// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/messages/privateMessagesController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';

class PrivateMessage extends StatelessWidget {
  const PrivateMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F1F1),
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
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  children: [
                    Text(
                      Get.arguments[1],
                      style: TextStyle(
                        color: Colors.white, //Color(0xff9A8B8B),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Portada",
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 45.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Color(0xff43D0CA),
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(360.r),
                        child: Image.network(
                          Get.arguments[0],
                          errorBuilder: (context, error, stackTrace) =>
                              ClipRRect(
                            borderRadius: BorderRadius.circular(360.r),
                            child: Image.network(
                              'https://lametnachat.com/upload/imageUser/anonymous.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<PrivateMessagesController>(
                init: PrivateMessagesController(),
                builder: (controller) {
                  return FutureBuilder(
                      future: controller.getData(),
                      builder: (context, snapshot) {
                        return StreamBuilder(
                          stream: controller.streamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListView.builder(
                                reverse: true,
                                itemBuilder: (context, index) {
                                  final message = snapshot.data["data"][index];
                                  final isSentByMe =
                                      message["sender"] == userId;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 16.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment: isSentByMe
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
                                      children: [
                                        isSentByMe
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        360.r),
                                                child: Image.network(
                                                  imageURL + userName + ".jpeg",
                                                  width: 50.w,
                                                  height: 50.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        360.r),
                                                child: Image.network(
                                                  imageURL +
                                                      Get.arguments[1] +
                                                      ".jpeg",
                                                  width: 50.w,
                                                  height: 50.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: isSentByMe ? 50.w : 0.w,
                                            right: isSentByMe ? 0.w : 50.w,
                                          ),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: Get.width * 0.75,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 24.w,
                                              vertical: 6.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isSentByMe
                                                  ? Color(0xffecd2ab)
                                                  : Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 6,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius: isSentByMe
                                                  ? BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(13.r),
                                                      topRight:
                                                          Radius.circular(13.r),
                                                      bottomLeft:
                                                          Radius.circular(13.r),
                                                    )
                                                  : BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(13.r),
                                                      bottomLeft:
                                                          Radius.circular(13.r),
                                                      bottomRight:
                                                          Radius.circular(13.r),
                                                    ),
                                            ),
                                            child: Text(
                                              message["text"].toString(),
                                              textAlign: !isSentByMe
                                                  ? TextAlign.right
                                                  : TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: snapshot.data["data"].length,
                              );
                            }
                          },
                        );
                      });
                }),
          ),
          textFormBuilder(),
        ],
      ),
    );
  }

  Row textFormBuilder() {
    return Row(
      children: [
        GetBuilder<PrivateMessagesController>(
            init: PrivateMessagesController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: GestureDetector(
                  onTap: () {
                    controller.sendMsg();
                  },
                  child: Container(
                    // width: 46.w,
                    // height: 46.h,
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: Color(0xffEFA11B),
                      borderRadius: BorderRadius.circular(360.r),
                    ),
                    child: Image.asset(
                      'assets/icons/send.png',
                      width: 24.sp,
                      height: 24.sp,
                    ),
                  ),
                ),
              );
            }),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: SizedBox(
            height: 50.h,
            width: 340.w,
            child: GetBuilder<PrivateMessagesController>(builder: (controller) {
              return TextFormField(
                controller: controller.messageController,
                textAlign: TextAlign.right,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF5F5F5),
                  // fillColor: Colors.green,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),

                  hintText: "اكتب رسالتك",
                  hintStyle: TextStyle(
                    fontSize: 15.sp,
                    // color: Colors.grey,s
                  ),

                  prefixIcon: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // added line
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(
                        Icons.mic,
                        size: 25.sp,
                        // color: Color(0xff43D0CA),
                        color: Colors.red[700],
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(
                        Icons.image,
                        size: 25.sp,
                        // color: Color(0xff43D0CA),
                        color: Colors.orange[700],
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(
                        Icons.emoji_emotions,
                        size: 25.sp,
                        // color: Color(0xff43D0CA),
                        color: Colors.yellow[700],
                      ),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23.r),
                    borderSide: BorderSide.none,
                  ),
                  // filled: true,
                  // fillColor: Colors.grey[200],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

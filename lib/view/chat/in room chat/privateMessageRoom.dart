// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/in%20room%20chat/PrivateMessageRoomController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';

class PrivateMessageRoom extends StatelessWidget {
  const PrivateMessageRoom({Key? key}) : super(key: key);

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
                Color(0xFFF792F0),
                Color(0xFFFABD63),
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
                child: GestureDetector(
                  onTap: () {
                    print(userName);
                    print("-------------------");
                    print(Get.arguments['username']);
                  },
                  child: Center(
                    child: Text(
                      Get.arguments["username"],
                      style: TextStyle(
                        color: Colors.white, //Color(0xff9A8B8B),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Portada",
                      ),
                    ),
                  ),
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
            child: GetBuilder<PrivateMessagesRoomController>(
                init: PrivateMessagesRoomController(),
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
                                  final message = snapshot.data["data"][(snapshot.data["data"].length ?? 0) - 1 - index];
                                  final isSentByMe = message["senderUserRoom"] == userName;
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: isSentByMe ? 15.w : 0.w,
                                            right: isSentByMe ? 0.w : 15.w,
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
                                                color: isSentByMe ? Colors.white : Color(0xffecd2ab),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius: isSentByMe
                                                    ? BorderRadius.only(
                                                        topLeft: Radius.circular(13.r),
                                                        bottomLeft: Radius.circular(13.r),
                                                        bottomRight: Radius.circular(13.r),
                                                      )
                                                    : BorderRadius.only(
                                                        bottomRight: Radius.circular(13.r),
                                                        topRight: Radius.circular(13.r),
                                                        bottomLeft: Radius.circular(13.r),
                                                      )),
                                            child: message["audio"] == "1"
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller.playRecording(message["message"].toString());
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.play_arrow_rounded),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Container(
                                                          // width: 00,
                                                          constraints: BoxConstraints(
                                                            maxWidth: Get.width * 0.50,
                                                          ),
                                                          height: 2,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text(
                                                    message["message"].toString(),
                                                    textAlign: !isSentByMe ? TextAlign.right : TextAlign.left,
                                                    style: TextStyle(color: Colors.black),
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
          buildMyNavBar(context)
        ],
      ),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return GetBuilder<PrivateMessagesRoomController>(
        init: PrivateMessagesRoomController(),
        builder: (controller) {
          return Container(
            height: 71.h,
            decoration: const BoxDecoration(
              // LinearGradient
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF792F0),
                  Color(0xFFFABD63),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RotatedBox(
                        quarterTurns: 2,
                        child: GestureDetector(
                          onTap: () {
                            controller.sendMsg();
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "🙂",
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    // width: 230.w,
                    height: 40.h,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: controller.messageRoomController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: Colors.black, //Color(0xff9A8B8B),
                          fontSize: 14.sp,
                          fontFamily: "Portada",
                        ),
                        // expands: true,
                        maxLines: 1,
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        onTap: () {},
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                          hintText: 'اكتب رسالة',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Portada",
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50.r)),
                          filled: true,
                          fillColor: Colors.white, // Color(0xff00000029),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // controller.playRecording();
                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          size: 25.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.mRecorder!.isRecording ? controller.stopRecorder : controller.record,
                        // onTap: () {
                        //   print("test");
                        //   controller.record();
                        // },
                        // onDoubleTap: () {
                        //   controller.stopRecorder();
                        // },
                        child: Icon(
                          controller.mRecorder!.isRecording ? Icons.mic_off : Icons.mic,
                          size: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  //
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/videoController.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/voiceController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/model/message.dart';
// import 'package:lametna/view/chat/room%20mangement/roomMangement.dart';
import 'package:lametna/view/messages/messages.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:lametna/view/side%20pages/scrollText.dart';
import 'package:http/http.dart' as http;

import 'package:lametna/controllers/userData/variables.dart';

var roomId = Get.arguments["room_id"];
var roomOwner = Get.arguments["owner"];

Widget messageBuilder({required BuildContext context, dynamic data, required bool guest}) {
  return GestureDetector(
    onLongPressStart: (LongPressStartDetails details) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          details.globalPosition.dx,
          details.globalPosition.dy,
          details.globalPosition.dx,
          0,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r))),
        items: <PopupMenuEntry>[
          if(data["image"] != "1" )PopupMenuItem<String>(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: data['message']));
                    // Get.back();
                  },
                  // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w),
                  value: '',
                  child: Center(
                    child: Text(
                      'نسخ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          PopupMenuDivider(height: 2),
        if(  data["userType"] == "3" ||
                  data["userType"] == "2" ||
                  data["userType"] == "1" ||
                  roomOwner == userName
        ) PopupMenuItem<String>(
                  onTap: () {
                    // sj();
                    var url = Uri.parse(deleteAllRoomMessages);
                    http.post(url, body: {
                      "roomId": roomId,
                    });
                  },
                  value: '',
                  child: Center(
                    child: Text(
                      'مسح النص للجميع',
                      // Get.arguments["room_id"].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ,
          PopupMenuDivider(),
        if(  data["senderName"] == userName
        ) PopupMenuItem<String>(
                  onTap: () {
                    //https://lametnachat.com/messages/deleteMessageInRoom.php
                    var url = Uri.parse(deleteMessage);
                    http.post(url, body: {
                      "senderName": userName,
                      "messageId": data["messageId"],
                    });
                  },
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w),
                  value: '',
                  child: Center(
                    child: Text(
                      'مسح النص',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ,
          PopupMenuDivider(),
          PopupMenuItem<String>(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w),
            value: '',
            child: Center(
              child: Text(
                data["senderName"],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
            value: '',
            child: Center(
              child: Text(
                "تبليغ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    },
    child: guest
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      // height: 20.h,
                      width: double.infinity,
                      color: Color(0xFFCAF8ED),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            data["senderName"] == guestUserName ||
                                    data["senderName"] == userName
                                ? 0.w
                                : 55.w,
                            5.h,
                            data["senderName"] == userName ||
                                    data["senderName"] == guestUserName
                                ? 55.w
                                : 0,
                            5.h),
                        child: Directionality(
                          textDirection: data["senderName"] == userName
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: data["userType"] == 'VIP' ||
                                          data["userType"] == 'VIPWithBG'
                                      ? 45.w
                                      : 10.w),
                              Text(
                                TimeOfDay.fromDateTime(
                                        DateTime.parse(data['time']).add(
                                            Duration(
                                                seconds: DateTime.now()
                                                    .timeZoneOffset
                                                    .inSeconds)))
                                    .format(context)
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              data["userType"] == "protected" ||
                                      data["userType"] == "protectedWithBG"
                                  ? Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 20.sp,
                                    )
                                  : data["userType"] == 'VIP' ||
                                          data["userType"] == 'VIPWithBG'
                                      ? Image.asset(
                                          'assets/images/crown.png',
                                          width: 20.sp,
                                        )
                                      : SizedBox(),
                              SizedBox(
                                width: 5.w,
                              ),
                              Stack(
                                children: [
                                  Text(
                                    data["senderName"].toString(),
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      letterSpacing: 1.2,
                                      // fontFamily:
                                      //     "Portada",
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 2
                                        ..color = data["userType"] != "0" ||
                                                data["userType"] != "1" ||
                                                data["userType"] != "2"
                                            ? Color(0xFFFAE635)
                                            : Colors.transparent,
                                    ),
                                  ),
                                  Text(
                                    data[
                                        "userType"], // data["userType"]  data["senderName"]
                                    textAlign: data["senderName"] == userName
                                        ? TextAlign.right
                                        : TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                      color: data["userType"] == "0"
                                          ? Color(0xFFF411EB)
                                          : data["userType"] == "1"
                                              ? Color(0xFF3B00E1)
                                              : data["userType"] == "2"
                                                  ? Color(0xFF11F435)
                                                  : data["userType"] == "3"
                                                      ? Color(0xFFFD6EB3)
                                                      : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (data["image"] == "1") {
                          // print("tapped");
                          Get.toNamed("/viewImage", arguments: {
                            "imageLink": imageSent + data["message"],
                          });
                        }
                      },
                      child: Container(
                        // height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // color: Colors.grey[300],
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFF792F0),
                              Color(0xFFF1F1F1),
                            ],
                            begin: data["senderName"] == userName
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            end: data["senderName"] == userName
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                          ),

                          borderRadius: data["senderName"] == userName
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(20.r),
                                )
                              : BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              data["senderName"] == userName ? 20.w : 60.w,
                              9.h,
                              data["senderName"] == userName ? 60.w : 20.w,
                              9.h),
                          child: data["image"] == "1"
                              ? Align(
                                  alignment: data["senderName"] == userName
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  // color: Colors.green,
                                  child: Image.network(
                                    imageSent + data["message"],
                                    // width: 80,
                                    // width: 80.w,
                                    height: 130.h,
                                    // fit: BoxFit.cover,
                                  ),
                                )
                              : Text(
                                  data["message"],
                                  textAlign: data["senderName"] == userName
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: TextStyle(
                                    fontSize: int.parse(data["fontSize"]).sp,
                                    fontWeight: data["isBold"] == "1"
                                        ? FontWeight.w800
                                        : FontWeight.normal,
                                    fontStyle: data["isItalic"] == "1"
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                    color: Color(int.parse(
                                            data["color"].substring(1, 7),
                                            radix: 16) +
                                        0xFF000000),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 3.h,
                  left: data["senderName"] == userName ? null : 10.w,
                  right: data["senderName"] == userName ? 10.w : null,
                  child: Container(
                    width: 35.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      // color: const Color(0xff7c94b6),
                      // image: DecorationImage(
                      //   onError: (exception, stackTrace) => NetworkImage(
                      //     "https://lametnachat.com/upload/imageUser/anonymous.jpg",
                      //   ),
                      //   image: NetworkImage(
                      //       "https://lametnachat.com/upload/imageUser/" +
                      //           data["userImage"]),
                      // fit: BoxFit.cover,
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: Color(0xff43D0CA),
                        width: 1.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360.r),
                      child: Image.network(
                        imageURL + data["senderName"] + ".jpeg",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.network(
                          "https://lametnachat.com/upload/imageUser/anonymous.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                data["userType"] == "VIP"
                    ? Positioned(
                        top: -7.h,
                        // right: isMe ? 10.w : null,
                        left: data["senderName"] == userName ? 10.w : null,
                        right: data["senderName"] == userName ? null : 10.w,
                        // right: isMe ? null : 10.w,
                        child: Image.asset(
                          "assets/images/vipBadge.png",
                          width: 28.w,
                          height: 60.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : data["userType"] == "VIPWithBG"
                        ? Positioned(
                            top: -7.h,
                            // right: isMe ? 10.w : null,
                            left: data["senderName"] == userName ? 10.w : null,
                            right: data["senderName"] == userName ? null : 10.w,
                            // right: isMe ? null : 10.w,
                            child: Image.asset(
                              "assets/images/vip.png",
                              width: 28.w,
                              height: 60.h,
                              fit: BoxFit.cover,
                            ),
                          )
                        : SizedBox()
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  width: double.infinity,
                  color: Color(0xFFCAF8ED),
                  child: Directionality(
                    textDirection: data["senderName"] == userName ||
                            data["senderName"] == guestUserName
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Row(
                      children: [
                        Container(
                          width: 25.w,
                          height: 27.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          data["senderName"],
                          textAlign: data["senderName"] == userName ||
                                  data["senderName"] == guestUserName
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          TimeOfDay.fromDateTime(DateTime.parse(data['time'])
                                  .add(Duration(
                                      seconds: DateTime.now()
                                          .timeZoneOffset
                                          .inSeconds)))
                              .format(context)
                              .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Color(0xff00000029).withOpacity(0.2),
                      offset: Offset(0, 3),
                      spreadRadius: 1,
                      blurRadius: 6,
                    )
                  ]),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        data["senderName"] == userName ||
                                data["senderName"] == guestUserName
                            ? 0.w
                            : 60.w,
                        9.h,
                        data["senderName"] == userName ||
                                data["senderName"] == guestUserName
                            ? 60.w
                            : 0.w,
                        9.h),
                    child: Text(
                      data["message"],
                      textAlign: data["senderName"] == userName ||
                              data["senderName"] == guestUserName
                          ? TextAlign.right
                          : TextAlign.left,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
  );
}

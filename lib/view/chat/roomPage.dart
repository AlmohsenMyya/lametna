// ignore_for_file: missing_return, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/voiceController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/view/chat/In%20Room%20Widgets/appBar.dart';
import 'package:lametna/view/chat/In%20Room%20Widgets/navbarBuilder.dart';
import 'package:lametna/view/chat/In%20Room%20Widgets/roomEndDrawer.dart';
import 'package:lametna/view/store/storeDetails.dart';

class Room extends StatefulWidget {
  const Room({Key? key}) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

final scaffoldKey = GlobalKey<ScaffoldState>();
bool isOwner = Get.arguments["owner"] != userName;

class _RoomState extends State<Room> with WidgetsBindingObserver {
  // Future<bool> result = isLockScreen();
  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Get.put(RoomsPageController()).isEndrawerOpen) {
          Get.back();
          return Future.value(false);
        } else {
          return closeAlert();
        }

        },
      child: Scaffold(
        key: scaffoldKey,
        appBar:appbar(),
        onEndDrawerChanged: (isOpened) {
          // print("object");
          if (isOpened) {
            Get.put(RoomsPageController()).getRoomMembers();

            Get.put(RoomsPageController()).isEndrawerOpen = true;
            Get.put(RoomsPageController()).update();
          } else {
            Get.put(RoomsPageController()).isEndrawerOpen = false;
            Get.put(RoomsPageController()).update();
          }
        },
        endDrawer: endDrawer(),

        body: Column(
          children: [
            GetBuilder<RoomsPageController>(
                init: RoomsPageController(),
                builder: (controller) {
                  return controller.themeColor == null
                      ? SizedBox()
                      : Container(
                          height: 80.h,
                          decoration: BoxDecoration(
                              // LinearGradient
                              color: Color(int.parse(controller.themeColor!.substring(1, 7), radix: 16) + 0xFF000000).withOpacity(0.2)),
                          child: StreamBuilder(
                              stream: controller.membersController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.data.length == 0) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      userInCall(),
                                      userInCall(),
                                      userInCall(),
                                      userInCall(),
                                      userInCall(),
                                    ],
                                  );
                                } else if (snapshot.data.length == 1) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      userInCall(userName: snapshot.data[0]['name']),
                                      userInCall(),
                                      userInCall(),
                                      userInCall(),
                                      userInCall(),
                                    ],
                                  );
                                } else if (snapshot.data.length == 2) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      userInCall(userName: snapshot.data[0]['name']),
                                      userInCall(userName: snapshot.data[1]['name']),
                                      userInCall(),
                                      userInCall(),
                                      userInCall(),
                                    ],
                                  );
                                } else if (snapshot.data.length == 3) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      userInCall(userName: snapshot.data[0]['name']),
                                      userInCall(userName: snapshot.data[1]['name']),
                                      userInCall(userName: snapshot.data[2]['name']),
                                      userInCall(),
                                      userInCall(),
                                    ],
                                  );
                                } else if (snapshot.data.length == 4) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      userInCall(userName: snapshot.data[0]['name']),
                                      userInCall(userName: snapshot.data[1]['name']),
                                      userInCall(userName: snapshot.data[2]['name']),
                                      userInCall(userName: snapshot.data[3]['name']),
                                      userInCall(),
                                    ],
                                  );
                                } else if (snapshot.data.length == 5) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      userInCall(userName: snapshot.data[0]['name']),
                                      userInCall(userName: snapshot.data[1]['name']),
                                      userInCall(userName: snapshot.data[2]['name']),
                                      userInCall(userName: snapshot.data[3]['name']),
                                      userInCall(userName: snapshot.data[4]['name']),
                                    ],
                                  );
                                }
                              return Container();
                              }

                              // Text(snapshot.data.toString()),

                              //   Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              // children: [
                              //   snapshot.data[0]["name"] ?? "",
                              //   // snapshot.data[1]["name"] ?? "",
                              //   // snapshot.data[2]["name"] ?? "",
                              //   // snapshot.data[3]["name"] ?? "",
                              //   // snapshot.data[4]["name"] ?? "",
                              //   // snapshot.data[5]["name"] ?? "",
                              //   // userInCall(
                              //   //   userName: snapshot.data[index],

                              //   // ),
                              // userInCall(),
                              // userInCall(),
                              // userInCall(),
                              // userInCall(),
                              // userInCall(),
                              // ].mapIndexed((e, i) => Text(e == null ? "" : e)).toList(),
                              ),
                        );
                }),
            GetBuilder<RoomsPageController>(
              init: RoomsPageController(),
              builder: (controller) => userName == controller.roomOwner
                  ? Container(
                      width: Get.width,
                      height: controller.waitingListStatus ? 200.h : 0,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: StreamBuilder(
                        stream: controller.roomLockController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.data.length <= 0) {
                            return Center(
                              child: Text(
                                "لا يوجد اعضاء في قائمة الانتظار",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                          return ListView.separated(
                            itemCount: snapshot.data.length ?? 0,
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.black,
                            ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  snapshot.data[index]["username"],
                                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "${snapshot.data[index]["macAddress"]} - ${snapshot.data[index]["country"]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                trailing: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Material(
                                        color: Colors.red, // Button color
                                        child: InkWell(
                                          splashColor: Colors.transparent, // Splash color
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            controller.acceptOrRejectWaitingList(name: snapshot.data[index]["username"], status: "1");
                                          },
                                          child: SizedBox(
                                            width: 50.sp,
                                            height: 50.sp,
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    ClipOval(
                                      child: Material(
                                        color: Colors.green, // Button color
                                        child: InkWell(
                                          splashColor: Colors.transparent, // Splash color
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            controller.acceptOrRejectWaitingList(name: snapshot.data[index]["username"], status: "0");
                                          },
                                          child: SizedBox(
                                            width: 50.sp,
                                            height: 50.sp,
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
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
                        },
                      ),
                    )
                  : SizedBox(),
            ),
            GetBuilder<RoomsPageController>(
                init: RoomsPageController(),
                builder: (controller) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // LinearGradient
                        gradient: controller.roomStatus
                            ? null
                            : LinearGradient(
                                colors: [
                                  Color(0xFFFABD63),
                                  Color(0xFFFABB64),
                                  Color(0xFFF792F0),
                                ],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                      ),
                      // child: Container(),
                      child: FutureBuilder(
                          future: controller.getData(),
                          builder: (context, snapshot) {
                            return StreamBuilder(
                              stream: controller.streamController.stream,
                              builder: (context, snapshot) {
                                // print(snapshot.data.length);
                                return snapshot.hasData
                                    ? NotificationListener(
                                        onNotification: (ScrollNotification scrollInfo) {
                                        if ( scrollInfo.metrics.pixels > 80) {
                                          controller.scrollDownButtonStatus(false);
                                          return false;
                                        } else {
                                          controller.scrollDownButtonStatus(true);
                                          return true;
                                        }
                                        },
                                        child: Container(
                                          // color: Colors.green,
                                          // height: 775.h,
                                          child: ListView(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            shrinkWrap: true,
                                            reverse: true,
                                            children: [
                                              ListView.builder(
                                                // controller: controller.scrollController,
                                                reverse: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  var data = snapshot.data[index];

                                                  if (data["senderName"] == "roomAlert" && !data["message"].toString().contains(userName)) {
                                                    return joinAndLeaveAlert(controller.roomStatus, data["joinOrLeave"] == "0" ? true : false,
                                                        data["senderName"].toString(), data["message"].toString());
                                                  } else if (data["senderName"] == "roomWelcome") {
                                                    return Text(
                                                      data["message"],
                                                      style: TextStyle(color: Colors.green),
                                                    );
                                                  } else if (data["senderName"] == "roomAlert" && data["message"].toString().contains(userName)) {
                                                    return SizedBox();
                                                  } else {
                                                    // return Text(
                                                    //   data["message"],
                                                    //   style: TextStyle(color: Colors.black),
                                                    // );
                                                    return messageBuilder(
                                                      context: context,
                                                      data: data,
                                                      guest: data["isGuest"] == "0" ? true : false,
                                                    );
                                                  }
                                                },
                                                itemCount: snapshot.data.length,
                                                // itemCount: 1,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 30.w),
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all((3.5).sp),
                                                  decoration: BoxDecoration(
                                                    // color: Color(0xffFf6472a),
                                                    border: Border.all(
                                                      color: Color(0xFFBABABA),
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFFABB64),
                                                        Color(0xFFF792F0),
                                                      ],
                                                      begin: Alignment.centerRight,
                                                      end: Alignment.centerLeft,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.r),
                                                  ),
                                                  child: Text(
                                                    "${controller.welcomeMsg!} $userName" ?? "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                child: Text(
                                                  controller.welcomeText ?? "",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Center(child: CircularProgressIndicator());
                              },
                            );
                          }),
                    ),
                  );
                }),
            buildMyNavBar(context),
          ],
        ),

        // floatingActionButton: GetBuilder<RoomsPageController>(
        //   builder: (controller) {
        //     return !controller.scrollDownButton
        //         ? SizedBox()
        //         : Padding(
        //             padding:
        //                 EdgeInsets.only(bottom: 60.h, right: 5.w, left: 10.w),
        //             child: GestureDetector(
        //               onTap: () {
        //                 controller.scrollController.animateTo(0,
        //                     duration: Duration(seconds: 1), curve: Curves.easeIn);
        //                 print("object");
        //               },
        //               child: Container(
        //                 // width: 148.w,
        //                 constraints: BoxConstraints(
        //                   maxWidth: Get.width * 0.35,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(20.r),
        //                   gradient: !controller.roomStatus
        //                       ? LinearGradient(
        //                           colors: [
        //                             Color(0xFF00E54C),
        //                             Color(0xFFDADADC),
        //                           ],
        //                           begin: Alignment.topCenter,
        //                           end: Alignment.bottomCenter,
        //                         )
        //                       : LinearGradient(
        //                           colors: [
        //                             Color(0xFFF792F0),
        //                             Color(0xFFFABD63),
        //                           ],
        //                           begin: Alignment.topCenter,
        //                           end: Alignment.bottomCenter,
        //                         ),
        //                 ),
        //                 padding: EdgeInsets.symmetric(horizontal: 8.w),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Padding(
        //                       padding: EdgeInsets.only(bottom: 7.h),
        //                       child: RotatedBox(
        //                         quarterTurns: 3,
        //                         child: Icon(
        //                           Icons.arrow_back_ios,
        //                           size: 20.sp,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: Text(
        //                         "الرسائل الجديدة",
        //                         style: TextStyle(
        //                           fontSize: 14.sp,
        //                           fontFamily: 'Segoe UI',
        //                         ),
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           );
        //   },
        // ),
      ),
    );
  }

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.r))),
          items: <PopupMenuEntry>[
            if(data["image"] != "1")
                 PopupMenuItem<String>(
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
                  )
                ,
            PopupMenuDivider(height: 2),
            if(data["userType"] == "3" || data["userType"] == "2" || data["userType"] == "1"
            )    //  ||Get.arguments["owner"] == userName
                 PopupMenuItem<String>(
                    onTap: () {
                      // sj();
                      var url = Uri.parse(deleteAllRoomMessages);
                      http.post(url, body: {
                        "roomId": Get.arguments["room_id"],
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
           if( data["senderName"] == userName)
                 PopupMenuItem<String>(
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
                          padding: EdgeInsets.fromLTRB(data["senderName"] == guestUserName || data["senderName"] == userName ? 0.w : 55.w, 5.h,
                              data["senderName"] == userName || data["senderName"] == guestUserName ? 55.w : 0, 5.h),
                          child: Directionality(
                            textDirection: data["senderName"] == userName ? TextDirection.ltr : TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: data["userType"] == 'VIP' || data["userType"] == 'VIPWithBG' ? 45.w : 10.w),
                                Text(
                                  TimeOfDay.fromDateTime(DateTime.parse(data['time']).add(Duration(seconds: DateTime.now().timeZoneOffset.inSeconds)))
                                      .format(context)
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                data["userType"] == "protected" || data["userType"] == "protectedWithBG"
                                    ? Icon(
                                        Icons.verified,
                                        color: Colors.blue,
                                        size: 20.sp,
                                      )
                                    : data["userType"] == 'VIP' || data["userType"] == 'VIPWithBG'
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
                                          ..color = data["userType"] != "0" || data["userType"] != "1" || data["userType"] != "2"
                                              ? Color(0xFFFAE635)
                                              : Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      data["senderName"], // data["userType"]  data["senderName"]
                                      textAlign: data["senderName"] == userName ? TextAlign.right : TextAlign.left,
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
                              begin: data["senderName"] == userName ? Alignment.centerLeft : Alignment.centerRight,
                              end: data["senderName"] == userName ? Alignment.centerRight : Alignment.centerLeft,
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
                                data["senderName"] == userName ? 20.w : 60.w, 9.h, data["senderName"] == userName ? 60.w : 20.w, 9.h),
                            child: data["image"] == "1"
                                ? Align(
                                    alignment: data["senderName"] == userName ? Alignment.centerRight : Alignment.centerLeft,
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
                                    textAlign: data["senderName"] == userName ? TextAlign.right : TextAlign.left,
                                    style: TextStyle(
                                      fontSize:
                                          data["message"].toString().contains("لقد تم حذف هذه الرسالة") ? 18.sp : int.parse(data["fontSize"]).sp,
                                      fontWeight: data["isBold"] == "1" ? FontWeight.w800 : FontWeight.normal,
                                      fontStyle: data["isItalic"] == "1" ? FontStyle.italic : FontStyle.normal,
                                      color: data["message"].toString().contains("لقد تم حذف هذه الرسالة")
                                          ? Colors.black
                                          : Color(int.parse(data["color"].substring(1, 7), radix: 16) + 0xFF000000),
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
                          "${imageURL + data["senderName"]}.jpeg",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.network(
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
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    width: double.infinity,
                    color: Color(0xFFCAF8ED),
                    child: Directionality(
                      textDirection: data["senderName"] == userName || data["senderName"] == guestUserName ? TextDirection.rtl : TextDirection.ltr,
                      child: Row(
                        children: [
                          Container(
                            width: 25.w,
                            height: 27.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
                            textAlign: data["senderName"] == userName || data["senderName"] == guestUserName ? TextAlign.right : TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Spacer(),
                          Text(
                            TimeOfDay.fromDateTime(DateTime.parse(data['time']).add(Duration(seconds: DateTime.now().timeZoneOffset.inSeconds)))
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
                      padding: EdgeInsets.fromLTRB(data["senderName"] == userName || data["senderName"] == guestUserName ? 0.w : 60.w, 9.h,
                          data["senderName"] == userName || data["senderName"] == guestUserName ? 60.w : 0.w, 9.h),
                      child: Text(
                        data["message"],
                        textAlign: data["senderName"] == userName || data["senderName"] == guestUserName ? TextAlign.right : TextAlign.left,
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

  Widget joinAndLeaveAlert(bool oldOrNew, bool joinOrLeave, String alert, String message) {
    return oldOrNew
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: joinOrLeave ? Color(0xFFE1FFE1) : Color(0xffFAE8E8),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  //#BABABA
                  color: Color(0xFFBABABA),
                  width: 1.w,
                ),
              ),
              child: Text(
                // TextSpan(
                //   style: TextStyle(color: Colors.black, fontSize: 36),
                //   children: <TextSpan>[
                //     // TextSpan(
                //     //     text: 'Woolha ', style: TextStyle(color: Colors.blue)),
                //     // TextSpan(
                //     //   text: message.toString().indexOf("انضم للغرف") != -1
                //     //       ? message.toString().substring(
                //     //           message.toString().indexOf("انضم للغرف"),
                //     //           z)
                //     //       : message.toString().substring(0, 5),
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 15.sp,
                //         fontFamily: "Segoe UI",
                //       ),
                //     ),
                //     // TextSpan(
                //     //     text: 'com',
                //     //     style: TextStyle(decoration: TextDecoration.underline))
                //   ],
                // ),
                // textScaleFactor: 0.5,
                message,
                textAlign: TextAlign.center,
                // joinOrLeave ? "$alert انضم للغرفة" : "$alert غادر للغرفة",
                // alert,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontFamily: "Segoe UI",
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 90.w),
            child: Container(
              padding: EdgeInsets.all(7.sp),
              decoration: BoxDecoration(
                color: joinOrLeave ? Color(0xff88d95d) : Color(0xffff6472a),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontFamily: "Segoe UI",
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Icon(joinOrLeave ? Icons.person : Icons.logout, color: Colors.white, size: 20.sp),
                ],
              ),
            ),
          );
  }

  Widget userInCall({String ?userName}) {
    return userName == null
        ? ClipOval(
            // borderRadius: BorderRadius.circular(50.r),
            child: Container(
                // padding: EdgeInsets.all(10.sp),
                color: Colors.white,
                // decoration: BoxDecoration(
                //   image: DecorationImage(image: NetworkImage(imageLink))
                // ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Icon(
                    Icons.lock,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                )),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.network(
                  '$imageURL$userName.jpeg',
                  fit: BoxFit.fill,
                  height: 50.sp,
                  width: 50.sp,
                  // fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          );
  }
}

closeAlert() {
  showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.r),
      ),
      actionsPadding: EdgeInsets.zero,
      title: Text(
        "هل تريد مغادرة الغرفة؟",
        textAlign: TextAlign.end,
        style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
      ),
      // content: ElevatedButton(onPressed: () {}, child: Text("data")),
      actions: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.black38, width: 1.sp),
            ),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 50,
                child: GestureDetector(
                  onTap: () async {
                    Get.back();
                  },
                  child: Text(
                    "الغاء",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w800,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 60.h,
                  child: VerticalDivider(
                    width: 2.sp,
                    color: Colors.black38,
                  ),
                ),
              ),
              GetBuilder<RoomsPageController>(
                  // init: RoomsPageController(),
                  builder: (controller) {
                return Expanded(
                  flex: 50,
                  child: GestureDetector(
                    onTap: () async {
                      Get.back();
                      await controller.onLeave();
                      // Get.put(VoiceController()).leave();
                      // Get.put(VoiceController()).agoraEngine.leaveChannel();
                      // Get.put(VoiceController()).agoraEngine = null;
                    },
                    child: Text(
                      "موافق",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        )
      ],
    ),
  );
}

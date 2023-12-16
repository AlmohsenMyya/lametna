// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sort_child_properties_last, missing_return

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/videoController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/room%20mangement/side%20pages/custom_expansion.dart';
import 'package:lametna/view/side%20pages/scrollText.dart';

// String roomOwner = Get.arguments["owner"];
// bool isOwner = roomOwner != userName;
final scaffoldKey = GlobalKey<ScaffoldState>();

PopupMenuItem<int> usersPopUpMenu(String name, {Function? f}) {
  return PopupMenuItem(
    onTap: (){
      if(f != null){
        f();
      }
    },
    height: 35.h,
    textStyle: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    value: 0,
    child: Align(
      alignment: Alignment.center,
      child: Text(
        name,
      ),
    ),
  );
}

Widget endDrawer() {
  return SafeArea(
    child: Container(
      height: double.infinity,
      width: Get.width * 0.85,
      color: Colors.white,
      child: GetBuilder<RoomsPageController>(
        init: RoomsPageController(),
        builder: (controller) {
          if (controller.userInRoom == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                  controller.userInRoom["data"].length,
                  (index) {
                    var data = controller.userInRoom["data"][index];
                    return PopupMenuButton<int>(
                      itemBuilder: (context) => [
                       if( data["username"] != userName)
                             usersPopUpMenu(
                                "محادثة خاصة",
                                f: () async {
                                  Get.back();
                                  Get.toNamed(
                                    "/privateMessageRoom",
                                    arguments: {
                                      "username": data["username"],
                                      "room_id": Get.arguments['room_id'],
                                    },
                                  );
                                },
                              ),
                        if(data["username"] != userName)  CustomPopupMenuDivider(thickness: 1, indent: 1, endIndent: 1, color: Colors.white,) as PopupMenuItem<int>,
                        // usersPopUpMenu("حظر", f: () {
                        //   controller.blockUser(data["username"], 1);
                        // }),
                       if( data["handIs"] == "1" && controller.roomOwner == userName)
                             usersPopUpMenu("قبول الطلب", f: () {
                                // Get.put(VoiceController()).forceJoinCall(data["username"], roomId); ////////////////////////////
                              })
                            ,
                       if( data["handIs"] == "1" && controller.roomOwner == userName)  usersPopUpMenu("رفض الطلب") ,
                        if(data["handIs"] == "1" && controller.roomOwner == userName)
                             CustomPopupMenuDivider(thickness: 1, indent: 1, endIndent: 1, color: Colors.white,) as PopupMenuItem<int>
                            ,
                        usersPopUpMenu("تبليغ"),
                        if(!(roleType == "" && controller.roomOwner != userName)) CustomPopupMenuDivider( color: Colors.white,thickness: 1, indent: 1, endIndent: 1)as PopupMenuItem<int>,
                        if(!(roleType == "" && controller.roomOwner != userName))
                             PopupMenuItem(
                                height: 35.h,
                                textStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                onTap: () {},
                                child: PopupMenuButton<int>(
                                  child: Text("خيارات الإشراف"),
                                  itemBuilder: (context) => [
                                    usersPopUpMenu(
                                      "معلومات المستخدم",
                                      f: () async {
                                        Get.back();
                                        userInfo(data);
                                        print(kick);
                                      },
                                    ),
                                    if(!(kick == false))  CustomPopupMenuDivider( color: Colors.white,thickness: 1, indent: 1, endIndent: 1)as PopupMenuItem<int>,
                                    if(!(stop == false))
                                         PopupMenuItem(
                                            height: 35.h,
                                            textStyle: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            child: Align(alignment: Alignment.center, child: Text("ايقاف")),
                                            onTap: () => controller.kickUser(
                                              data["username"],
                                            ),
                                          ),
                                    if(!(stop == false))  CustomPopupMenuDivider( color: Colors.white,thickness: 1, indent: 1, endIndent: 1) as PopupMenuItem<int>,
                                    if(!(kick == false))
                                         PopupMenuItem(
                                            height: 35.h,
                                            textStyle: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            child: Align(alignment: Alignment.center, child: Text("طرد")),
                                            onTap: () => controller.kickUser(
                                              data["username"],
                                            ),
                                          ),
                                   if(!( banDevice == false)) CustomPopupMenuDivider( color: Colors.white,thickness: 1, indent: 1, endIndent: 1)as PopupMenuItem<int>,
                                    if(!(banDevice == false))
                                         PopupMenuItem(
                                            height: 35.h,
                                            textStyle: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            child: PopupMenuButton<int>(
                                              child: Center(child: Text("حظر")),
                                              itemBuilder: (context) => [
                                                usersPopUpMenu("15 دقيقة", f: () {
                                                  controller.blockUser(data["username"], "1", data["macAddress"]);
                                                }),
                                                usersPopUpMenu("ساعة", f: () {
                                                  controller.blockUser(data["username"], "2", data["macAddress"]);
                                                }),
                                                usersPopUpMenu("6 ساعات", f: () {
                                                  controller.blockUser(data["username"], "3", data["macAddress"]);
                                                }),
                                                usersPopUpMenu("يوم", f: () {
                                                  controller.blockUser(data["username"], "4", data["macAddress"]);
                                                }),
                                                usersPopUpMenu("أسبوع", f: () {
                                                  controller.blockUser(data["username"], "5", data["macAddress"]);
                                                }),
                                                usersPopUpMenu("شهر", f: () {
                                                  controller.blockUser(data["username"], "6", data["macAddress"]);
                                                }),
                                                usersPopUpMenu("عام", f: () {
                                                  controller.blockUser(data["username"], "7", data["macAddress"]);
                                                }),
                                                usersPopUpMenu("دائما", f: () {
                                                  controller.blockUser(data["username"], "8", data["macAddress"]);
                                                }),
                                              ],
                                            ),
                                          ),
                                    CustomPopupMenuDivider( color: Colors.white,thickness: 1, indent: 1, endIndent: 1) as PopupMenuItem<int>,
                                    usersPopUpMenu("إرسال تحذير")
                                  ],
                                ),
                              ),
                      ],
                      child: Container(
                        padding: EdgeInsets.only(left: data["userType"] == "TopVIP" ? 0 : 10.w, right: 15.w),
                        height: data["userType"] == "protectedWithBG" || data["userType"] == "protected" || data["userType"] == ""
                            // controller.userInRoom["data"]
                            //         [index]["chatStatus"] ==
                            //     ""
                            ? 45.h
                            : 80.h,
                        decoration: BoxDecoration(
                          // color: Colors.green,

                          image: data["selectedBG"] == ""
                              ? null
                              : data["userType"] == "protected"
                                  ? null
                                  : DecorationImage(
                                      image: NetworkImage(backgroundImagesURL + data["selectedBG"]),
                                      fit: BoxFit.cover,
                                    ),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            data["userType"] == "protectedWithBG" || data["userType"] == "protected"
                                ? Center(
                                    child: Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 30.sp,
                                    ),
                                  )
                                : data["userType"] == "TopVIP"
                                    ? Center(
                                        child: Image.network(
                                          baseURL + "test/currentBanner.gif",
                                          height: 70.sp,
                                          width: 70.sp,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : data["userType"] == "VIP"
                                        ? Image.asset(
                                            'assets/images/vipBadge.png',
                                            height: 50.h,
                                            width: 31.w,
                                            // fit: BoxFit.cover,
                                          )
                                        : data["userType"] == "VIPWithBG"
                                            ? Image.asset(
                                                'assets/images/vip.png',
                                                height: 50.h,
                                                width: 31.w,
                                                // fit: BoxFit.cover,
                                              )
                                            : SizedBox(),
                            Spacer(),
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                SizedBox(
                                  width: 210.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            data["username"].toString(),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              // letterSpacing: 5,
                                              // fontFamily:
                                              //     "Portada",
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w700,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 3
                                                ..color = data["roleType"] == "3" ||
                                                        data["userType"] == "protected" ||
                                                        data["userType"] == "protectedWithBG" ||
                                                        data["userType"] == "VIP" ||
                                                        data["userType"] == "VIPWithBG" ||
                                                        data["userType"] == "TopVIP"
                                                    ? Color(0xFFFAE635)
                                                    : Colors.transparent,
                                            ),
                                          ),
                                          Text(
                                            data["username"].toString(),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700,
                                                // fontFamily:
                                                //     "Portada",
                                                color: data["roleType"] == "0"
                                                    ? Color(0xFFF411EB)
                                                    : data["roleType"] == "1"
                                                        ? Color(0xFF3B00E1)
                                                        : data["roleType"] == "2"
                                                            ? Color(0xFF11F435)
                                                            : data["roleType"] == "3"
                                                                ? Color(0xFFFD6EB3)
                                                                : Colors.black),
                                          ),
                                        ],
                                      ),
                                      data["userType"] == "VIPWithBG" || data["userType"] == "VIP" || data["userType"] == "TopVIP"
                                          ? data["chatStatus"] == ""
                                              ? SizedBox()
                                              : SizedBox(
                                                  width: 210.w,
                                                  height: 20.h,
                                                  child: ScrollingText(
                                                    text: data["chatStatus"],
                                                    ratioOfBlankToScreen: 0.37,
                                                    textStyle: TextStyle(fontSize: 12.sp, color: Colors.black),
                                                  ),
                                                )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 12.h),
                                  child: SizedBox(
                                    width: 110.w,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.center,
                                      children: [
                                        data["cameraIs"] == "0"
                                            ? SizedBox()
                                            : GetBuilder<VideoController>(
                                                init: VideoController(),
                                                builder: (c) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      // print("sk");
                                                      // c.joinAsViewer(
                                                      //     name: controller
                                                      //                 .userInRoom[
                                                      //             "data"][index]
                                                      //         ["username"],
                                                      //     token: controller
                                                      //                 .userInRoom[
                                                      //             "data"][
                                                      //         index]["token"]);
                                                    },
                                                    child: Image.asset(
                                                      'assets/icons/cam.png',
                                                      width: 20.w,
                                                    ),
                                                  );
                                                }),
                                        // Text(controller.userInRoom["data"]
                                        //     [index]["statusIs"]),
                                        data["micIs"] == "0"
                                            ? SizedBox()
                                            : Image.asset(
                                                'assets/icons/mic.png',
                                                width: 20.w,
                                              ),
                                        // Text(),
                                        data["MuteIs"] == "0"
                                            ? SizedBox()
                                            : Image.asset(
                                                'assets/icons/mute.png',
                                                width: 20.w,
                                              ),
                                        data["handIs"] == "0"
                                            ? SizedBox()
                                            : Icon(
                                                Icons.back_hand_rounded,
                                                size: 20.sp,
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            Center(
                              child: SizedBox(
                                width: 55.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360.r),
                                  child: data["userType"] == "protectedWithBG" || data["userType"] == "protected"
                                      ? Padding(
                                          padding: EdgeInsets.only(right: 6.w, left: 10.w),
                                          child: SizedBox(
                                            // height: 40.h,
                                            child: Container(
                                              width: 35.w,
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                // color: Colors.grey,

                                                borderRadius: BorderRadius.circular(360.r),
                                              ),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(360.r),
                                                  child: Icon(
                                                    Icons.person,
                                                    // color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(vertical: 2.h),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                width: data["userType"] == "VIP" || data["userType"] == "VIPWithBG"
                                                    ? 50.sp
                                                    : data["userType"] == "TopVIP"
                                                        ? 35.sp
                                                        : 45.sp, //45
                                                height: data["userType"] == "VIP" || data["userType"] == "VIPWithBG"
                                                    ? 50.sp
                                                    : data["userType"] == "TopVIP"
                                                        ? 35.sp
                                                        : 45.sp,
                                                child: ClipOval(
                                                  // borderRadius: BorderRadius.circular(360.r),
                                                  child: Image.network(
                                                    imageURL + data["username"] + ".jpeg",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) => Icon(Icons.person),
                                                  ),
                                                ),
                                              ),
                                              data["userType"] == "TopVIP"
                                                  ? Image.network(baseURL + "test/currentBadge.gif",
                                                      width: 57.5.sp, //45,
                                                      height: 70.sp,
                                                      fit: BoxFit.fitHeight)
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          // : ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: controller.userInRoom["data"].length,
          //     // separatorBuilder: (context, index) => Divider(
          //     //   color: Colors.grey,
          //     // ),
          //     itemBuilder: (context, index) =>
          //   );
        },
      ),
    ),
  );
}

Future<dynamic> userInfo(data) {
  return showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      titlePadding: EdgeInsets.zero,
      content: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${data["username"]} :اسم المستخدم ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Text(
            "${data["macAddress"]} :رقم الاي بي ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Text(
            "${data["country"]} :الدولة ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                // width: 84.51,
                // height: 21.90,
                decoration: ShapeDecoration(
                  color: Color(0xFFFABD63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                  child: Text(
                    "موافق",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    ),
  );
}

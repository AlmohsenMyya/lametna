// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lametna/controllers/chat/roomReportController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/view/chat/moments/viewComments.dart';

class RoomReport extends StatelessWidget {
  const RoomReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("سجل الغرفة", true, color: Get.arguments["color"]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //search bar
            GetBuilder<RoomReportController>(
                init: RoomReportController(),
                builder: (controller) {
                  return Container(
                    color: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000).withOpacity(0.2),
                    height: 70.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: controller.searchController,
                          onChanged: (value) {
                            controller.isEmptySearch();
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.mic,
                              color: Colors.grey,
                            ),
                            hintText: "ابحث عن اسم المستخدم",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.r),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            GetBuilder<RoomReportController>(
                init: RoomReportController(),
                builder: (controller) {
                  return FutureBuilder(
                    future: controller.getReport(),
                    builder: (context, snapshot) {
                      return controller.isSearching == true
                          ? ListView.separated(
                              shrinkWrap: true,
                              // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                              separatorBuilder: (context, index) => Divider(
                                height: 1.h,
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              itemCount: ( snapshot.data as List).length,
                              itemBuilder: (context, index) => ( snapshot.data as List)[index]["senderName"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(controller.searchController.text)
                                  ? Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerTheme: DividerThemeData(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: PopupMenuButton<int>(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            height: 40.h,
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(text: ( snapshot.data as List)[index]["senderName"].toString()));
                                            },
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "نسخ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            ),
                                            value: 0,
                                          ),
                                          PopupMenuDivider(),
                                          PopupMenuItem(
                                            height: 40.h,
                                            onTap: () {},
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "حظر الجهاز",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            value: 1,
                                          ),
                                          PopupMenuDivider(),
                                          PopupMenuItem(
                                            height: 40.h,
                                            onTap: () {},
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "حظر رقم الايبي",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            value: 2,
                                          ),
                                        ],
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000).withOpacity(0.2),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 150.w,
                                                child: Text(
                                                  ( snapshot.data as List)[index]["senderName"].toString(),
                                                  //VIP
                                                  //VIPWithBG
                                                  //protectedWithBG
                                                  //protected
                                                  //TopVIP
                                                  style: TextStyle(
                                                    color: ( snapshot.data as List)[index]["userType"] == "protected" ||
                                                            ( snapshot.data as List)[index]["userType"] == "protectedWithBG"
                                                        ? Colors.black
                                                        : ( snapshot.data as List)[index]["userType"] == "VIP"
                                                            ? Color(0xFF64BC3A)
                                                            : ( snapshot.data as List)[index]["userType"] == "VIPWithBG"
                                                                ? Color(0xFF4200FF)
                                                                : ( snapshot.data as List)[index]["userType"] == "TopVIP"
                                                                    ? Color(0xffFABD63)
                                                                    : Colors.black,
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 150.w,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          ( snapshot.data as List)[index]["country"].toString() ?? "nil",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.sp,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(Icons.credit_card, size: 20.sp),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    ( snapshot.data as List)[index]["messageId"].toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 150.w,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          ( snapshot.data as List)[index]["joinOrLeave"].toString() == "0"
                                                              ? Icons.call_made_sharp
                                                              : Icons.call_received_sharp,
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          ( snapshot.data as List)[index]["joinOrLeave"].toString() == "0" ? "انضمام" : "خروج",
                                                          style: TextStyle(
                                                            color: ( snapshot.data as List)[index]["joinOrLeave"].toString() == "0" ? Colors.green : Colors.red,
                                                            fontSize: 15.sp,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(Icons.timer_outlined, size: 20.sp),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Directionality(
                                                    textDirection: TextDirection.rtl,
                                                    child: Text(
                                                      convertTime(
                                                        ( snapshot.data as List)[index]["time"].toString(),
                                                      ),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.watch_later_outlined,
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    ( snapshot.data as List)[index]["time"].toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      // color: ( snapshot.data as List)[index]["joinOrLeave"].toString() == "0" ? Colors.green : Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                              separatorBuilder: (context, index) => Divider(
                                height: 1.h,
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              itemCount: ( snapshot.data as List).length,
                              itemBuilder: (context, index) => Theme(
                                data: Theme.of(context).copyWith(
                                  dividerTheme: DividerThemeData(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: PopupMenuButton<int>(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      height: 40.h,
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: ( snapshot.data as List)[index]["senderName"].toString()));
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "نسخ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                      value: 0,
                                    ),
                                    PopupMenuDivider(),
                                    PopupMenuItem(
                                      height: 40.h,
                                      onTap: () {},
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "حظر الجهاز",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      value: 1,
                                    ),
                                    PopupMenuDivider(),
                                    PopupMenuItem(
                                      height: 40.h,
                                      onTap: () {},
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "حظر رقم الايبي",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      value: 2,
                                    ),
                                  ],
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000).withOpacity(0.2),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: Text(
                                            ( snapshot.data as List)[index]["senderName"].toString(),
                                            //VIP
                                            //VIPWithBG
                                            //protectedWithBG
                                            //protected
                                            //TopVIP
                                            style: TextStyle(
                                              color: ( snapshot.data as List)[index]["userType"] == "protected" ||
                                                      ( snapshot.data as List)[index]["userType"] == "protectedWithBG"
                                                  ? Colors.black
                                                  : ( snapshot.data as List)[index]["userType"] == "VIP"
                                                      ? Color(0xFF64BC3A)
                                                      : ( snapshot.data as List)[index]["userType"] == "VIPWithBG"
                                                          ? Color(0xFF4200FF)
                                                          : ( snapshot.data as List)[index]["userType"] == "TopVIP"
                                                              ? Color(0xffFABD63)
                                                              : Colors.black,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150.w,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    ( snapshot.data as List)[index]["country"].toString() ?? "nil",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.credit_card, size: 20.sp),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              ( snapshot.data as List)[index]["messageId"].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 150.w,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    ( snapshot.data as List)[index]["joinOrLeave"].toString() == "0"
                                                        ? Icons.call_made_sharp
                                                        : Icons.call_received_sharp,
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    ( snapshot.data as List)[index]["joinOrLeave"].toString() == "0" ? "انضمام" : "خروج",
                                                    style: TextStyle(
                                                      color: ( snapshot.data as List)[index]["joinOrLeave"].toString() == "0" ? Colors.green : Colors.red,
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.timer_outlined, size: 20.sp),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                convertTime(
                                                  ( snapshot.data as List)[index]["time"].toString(),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.watch_later_outlined,
                                              size: 20.sp,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              ( snapshot.data as List)[index]["time"].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  );
                }),
          ],
        ),
      ),
      // bottomNavigationBar: GetBuilder<RoomReportController>(builder: (controller) {
      //   return Container(
      //     color: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000),
      //     height: 60.h,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           children: [
      //             IconButton(
      //               splashColor: Colors.transparent,
      //               highlightColor: Colors.transparent,
      //               icon: Icon(Icons.arrow_back_ios, color: controller.firstPage == 1 ? Colors.grey : Colors.white),
      //               onPressed: () {
      //                 controller.togglePageBackward();
      //               },
      //             ),
      //             IconButton(
      //               splashColor: Colors.transparent,
      //               highlightColor: Colors.transparent,
      //               icon: Icon(Icons.arrow_forward_ios,
      //                   color: (int.parse(controller.totalReports ?? 0) / 20).round() > controller.firstPage ? Colors.white : Colors.grey),
      //               onPressed: () {
      //                 controller.togglePageForward();
      //               },
      //             ),
      //           ],
      //         ),
      //         Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 9.w),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "عدد السجلات : ${controller.totalReports ?? 0}",
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 13.sp,
      //                 ),
      //               ),
      //               Text(
      //                 "رقم الصفحة : ${controller.firstPage}/${(int.parse(controller.totalReports) / 20).round()}",
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 13.sp,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   );
      // }),
    );
  }
}

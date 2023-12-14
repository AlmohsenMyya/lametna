// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/chat/roomInfoController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';

class RoomInfo extends StatelessWidget {
  RoomInfo({Key key}) : super(key: key);

  var titles = [
    {"إسم الغرفة", "room_name"},
    {"إسم المالك", "owner_username"},
    {"البريد", "email"},
    {"سعة الغرفة", "capacity"},
    {"المتصلين", "number_of_connections"},
    {"رقم الغرفة", "room_id"},
    {"تاريخ البداية", "start_date"},
    {"تاريخ الإنتهاء", "expiry_date"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("معلومات الغرفة", true, color: Get.arguments["color"]),
      body: SafeArea(
        child: GetBuilder<RoomInfoController>(
          init: RoomInfoController(),
          builder: (controller) {
            return FutureBuilder(
              future: controller.getData(),
              builder: (context, snapshot) => snapshot.hasData
                  ? ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        _builderRooms(context, Get.arguments["room_name"], snapshot.data["data"][0]["country_name"].toString()),
                        Divider(
                          thickness: (1).w,
                        ),
                        ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            // height: 2,
                            thickness: (1).w,
                          ),
                          shrinkWrap: true,
                          itemCount: titles.length,
                          itemBuilder: (context, index) {
                            return infoSetting(
                              titles[index].elementAt(0),
                              snapshot.data["data"][0][titles[index].elementAt(1)].toString(),
                            );
                          },
                        ),
                        Divider(
                          thickness: (1).w,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => infoSetting(
                                  controller.tiers[index]["name"].toString(),
                                  controller.tiers[index]["name"].toString() == "زائر"
                                      ? controller.guestTime.toString()
                                      : controller.tiers[index]["name"].toString() == "ممبر"
                                          ? controller.memberTime.toString()
                                          : controller.tiers[index]["name"].toString() == "أدمن"
                                              ? controller.adminTime.toString()
                                              : controller.tiers[index]["name"].toString() == "سوبر أدمن"
                                                  ? controller.superAdminTime.toString()
                                                  : controller.masterTime.toString(),
                                  color1: controller.tiers[index]["color"],
                                  color2: Colors.red,
                                  fontWeight1: FontWeight.w900,
                                ),
                            separatorBuilder: (context, index) => Divider(
                                  thickness: (1).w,
                                ),
                            itemCount: controller.tiers.length)
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  Widget infoSetting(String title, String subtitle,
      {Color color1 = Colors.black,
      Color color2 = Colors.black,
      int fontsize1 = 13,
      int fontsize2 = 15,
      FontWeight fontWeight1 = FontWeight.normal,
      FontWeight fontWeight2 = FontWeight.w900}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          subtitle,
          style: TextStyle(fontSize: fontsize1.sp, color: color2, fontWeight: fontWeight1, fontFamily: "Segoe UI"),
        ),
        Text(title, style: TextStyle(fontSize: fontsize2.sp, color: color1, fontWeight: fontWeight2, fontFamily: "Segoe UI")),
      ],
    );
  }

  Widget _builderRooms(BuildContext context, String name, String countryName, {Color color = Colors.white}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 58.h,
                    width: 57.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      // color: Colors.red,
                      border: Border.all(
                        color: Color(0xFF43d0ca),
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://media.istockphoto.com/id/1295072146/vector/mini-heart-korean-love-hand-finger-symbol-on-pink-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=eihpG3p1GoSvMjlSAQjCft50iff2I1AweF2a1MLI1SQ='),
                        fit: BoxFit.fill,
                        // height: 30,
                        // width: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    // height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 15.sp, color: Colors.black, fontFamily: "Segoe UI"),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Center(
                                child: Text("ID:0000000", style: TextStyle(fontSize: 7.sp, color: Colors.black, fontFamily: "Segoe UI")),
                              ),
                              width: 54.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF43D0CA),
                                  style: BorderStyle.solid,
                                  width: 1.0.w,
                                ),
                                borderRadius: BorderRadius.circular(9.0.sp),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/flags/palestine.png",
                              width: 25.w,
                              height: 16.h,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "| " + countryName,
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: "Segoe UI"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

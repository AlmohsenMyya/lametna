// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lametna/controllers/chat/room%20managment/advancedSettingsController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lametna/controllers/chat/roomPageSettingsController.dart';

class AdvancedSettings extends StatelessWidget {
  const AdvancedSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("إعدادات متقدمة", true, color: Get.arguments["color"]),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GetBuilder<AdvancedSettingsController>(
            init: AdvancedSettingsController(),
            builder: (controller) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60.w,
                      height: 50.h,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch.adaptive(
                          value: index == 0
                              ? controller.sendImage
                              : index == 1
                                  ? controller.sendText
                                  : index == 2
                                      ? controller.sendVoiceInPrivate
                                      : index == 3
                                          ? controller.sendAlerts
                                          : controller.roomEntries, onChanged: (bool value) {  },
                          // onChanged: (value) {
                          //   print(index);
                          //   index == 0
                          //       ? controller.changeSendImage(value)
                          //       : index == 1
                          //           ? controller.changeSendText(value)
                          //           : index == 2
                          //               ? controller.changeSendVoiceInPrivate(value)
                          //               : index == 3
                          //                   ? controller.changeSendAlerts(value)
                          //                   : controller.changeRoomEntries(value);
                          // },
                        ),
                      ),
                    ),
                    Text(
                      controller.items[index]["title"]!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    )
                  ],
                ),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.withOpacity(0.5),
                  thickness: 1,
                ),
                itemCount: controller.items.length,
              );
            }),
      ),
    );
  }
}

Widget switchmethod(
  String text,
) {
  return Padding(
    padding: EdgeInsets.only(right: 20.w, bottom: 5.w),
    child: SizedBox(
      height: 30.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<RoomsSettingPageController>(builder: (controller) {
            return Switch(
              onChanged: (value) {
                controller.toggleSwitch(value);
              },
              value: controller.isSwitched,
              activeColor: Colors.grey[300],
              activeTrackColor: Colors.black45,
              inactiveThumbColor: Colors.blue,
              inactiveTrackColor: Colors.blue,
            );
          }),
          Text(
            text,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Color(0xff140101), //Color(0xff9A8B8B),
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget? showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
          height: 183.h,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white,
                    ),
                    height: 200.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Color(0xFFFABD63),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                            child: Center(
                              child: Text(
                                "رسالة إبلاغ",
                                style: TextStyle(fontSize: 18.sp, color: Colors.white, decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Icon(
                          Icons.check_box_outlined,
                          size: 50.sp,
                          color: Colors.green,
                        ),
                        Text(
                          "تم الإبلاغ عن منار بنجاح",
                          style: TextStyle(
                            color: Color(0xff2ABC42),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ));
    },
  );
  return null;
}

Widget? showAlert2(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
          height: 193.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white,
                    ),
                    height: 200.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Color(0xFFFABD63),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                            child: Center(
                              child: Text(
                                "رسالة إبلاغ",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontFamily: "Portada",
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "لمتنا شات",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900,
                                fontFamily: "Portada",
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Image.asset(
                              "assets/images/Group.png",
                              width: 38.w,
                              height: 53.h,
                            ),
                          ],
                        ),
                        Text(
                          "هل تريد الإبلاغ عن منار",
                          style: TextStyle(
                            color: Color(0xffF50D0D),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Portada",
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 35.w,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffE34848),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                "إلغاء",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Portada",
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            SizedBox(width: 30.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 35.w),
                              decoration: BoxDecoration(
                                color: Color(0xff47A6E5),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showAlert(context);
                                },
                                child: Text(
                                  "موافق",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Portada",
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ));
    },
  );
  return null;
}

// class AdvancedSettings extends StatelessWidget {
//   const AdvancedSettings({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbarBuilder("إعدادات متقدمة", true),
//       body: ListView.separated(
//         separatorBuilder: (context, index) => Divider(
//           color: Color(0xff43D0CA),
//           thickness: 1.h,
//         ),
//         itemCount: 6, // Replace with the actual number of switches
//         itemBuilder: (context, index) {
//           final switchTexts = [
//             "السماح بإرسال االصور في النص العام",
//             "توقيف النص للجميع",
//             "السماح بإرسال الرسائل الصوتية بالخاص",
//             "السماح بارسال رسالة التحذير",
//             "السماح بإضافة ماستر",
//             "السماح بتعديل إعداد الغرفة",
//           ];
//           final switchText = switchTexts[index];
//           return switchmethod(switchText);
//         },
//       ),
//     );
//   }
//
//   Widget switchmethod(
//       String text,
//       ) {
//     return Padding(
//       padding: EdgeInsets.only(right: 20.w, bottom: 20.w),
//       child: SizedBox(
//         height: 30.h,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GetBuilder<RoomsSettingPageController>(
//               builder: (controller) {
//                 return Switch(
//                   onChanged: (value) {
//                     controller.toggleSwitch(value);
//                   },
//                   value: controller.isSwitched,
//                   activeColor: Colors.blue,
//                   activeTrackColor: Colors.blue,
//                   inactiveThumbColor: Colors.white,
//                   inactiveTrackColor: Colors.black45,
//                 );
//               },
//             ),
//             Text(
//               text,
//               textDirection: TextDirection.rtl,
//               style: TextStyle(
//                 color: Color(0xff140101), //Color(0xff9A8B8B),
//                 fontSize: 15.sp,
//                 fontFamily: "Segoe UI",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }}

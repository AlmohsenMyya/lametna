// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lametna/controllers/chat/room%20managment/roomSettingsController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

var setting = [
  {
    "name": "الصورة الشخصية الخاصة بالغرفة",
    "icon": Icons.photo,
  },
  {
    "name": "خلفية الغرفة",
    "icon": Icons.photo,
  },
  {
    "name": "الحالة",
    "icon": Icons.volume_up,
  },
  {
    "name": "رسالة ترحيب",
    "icon": Icons.email,
  },
  {
    "name": "التحدث",
    "icon": Icons.mic,
  },
  {
    "name": "الكاميرا",
    "icon": Icons.photo_camera_front,
  },
  {
    "name": "الرسائل الخاصة",
    "icon": Icons.message,
  },
  {
    "name": "قفل الغرفة",
    "icon": Icons.lock_outline,
  },
  {
    "name": "نمط الغرفة",
    "icon": Icons.color_lens,
  },
  {
    "name": "الغرف الصوتية",
    "icon": Icons.surround_sound_rounded,
  },
  {
    "name": "إعدادات متقدمة",
    "icon": Icons.settings,
  },
];

class RoomSettings extends StatelessWidget {
  // RoomSettingController controller = Get.put(RoomSettingController());

  const RoomSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appbarBuilder("إعدادات الغرفة", true),
          body: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  GetBuilder<RoomSettingController>(
                      init: RoomSettingController(),
                      builder: (controller) {
                        return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: GestureDetector(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        // print(controller.roomInfo);
                                        // controller.pickRoomImage();

                                        if (index == 0) {
                                          controller.uploadRoomImage(
                                              Get.arguments["room_id"]);
                                          // showDialog(
                                          //   context: context,
                                          //   barrierDismissible: false,
                                          //   useSafeArea: false,
                                          //   builder: (context) => WillPopScope(
                                          //     onWillPop: () => Future.value(false),
                                          //     child: Center(
                                          //         child: CircularProgressIndicator()),
                                          //   ),
                                          // );
                                          // AlertDialog(
                                          //   content: CircularProgressIndicator(),
                                          // );
                                        } else if (index == 1) {
                                          controller.uploadBackgroundRoomImage(
                                              Get.arguments["room_id"]);
                                        } else if (index == 2) {
                                          controller.alertDialog(
                                            setting[index]["name"],
                                            textEditingController:
                                                controller.statusController,
                                          );
                                        } else if (index == 3) {
                                          controller.alertDialog(
                                            setting[index]["name"],
                                            textEditingController:
                                                controller.helloController,
                                          );
                                        } else if (index == 5) {
                                          // print("object");
                                          controller.changeCameraStatus();
                                        } else if (index == 6) {
                                          // print("object");
                                          controller
                                              .changePrivateMessageStatus();
                                        } else if (index == 7) {
                                          // print("object");
                                          controller.changeRoomLockStatus();
                                        } else if (index == 8) {
                                          print("object");
                                          // controller.pickerColor;
                                          Get.defaultDialog(
                                            content: ColorPicker(
                                              showLabel: false,
                                              pickerColor:
                                                  controller.pickerColor,
                                              onColorChanged: (value) {
                                                controller
                                                    .updatePickerColor(value);
                                              },
                                            ),
                                            confirm: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "تم",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Portada'),
                                              ),
                                            ),
                                          );
                                        } else if (index == 10) {
                                          print("object");
                                          Get.toNamed('/advancedSettings',
                                              arguments: {
                                                "room_id":
                                                    Get.arguments["room_id"],
                                              });
                                          // controller.changeVoiceRoomStatus();
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w),
                                            child: Icon(
                                              setting[index]["icon"],
                                              color: Colors.black,
                                              size: 22.sp,
                                            ),
                                          ),
                                          Text(
                                            setting[index]["name"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontFamily: "Segoe UI",
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                              size: 20.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                                  color: Color(0xff43D0CA),
                                  thickness: 1,
                                ),
                            itemCount: setting.length);
                      }),
                  SizedBox(height: 60.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0.5,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                            color: Color(0xffDA8080),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Text(
                            "إلغاء",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Segoe UI",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30.w),
                      GetBuilder<RoomSettingController>(builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            print("test");
                            controller.changeSettings(Get.arguments["room_id"]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.5,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Color(0xff6BE05B),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "حفظ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Segoe UI",
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ],
          ),
        ),
        GetBuilder<RoomSettingController>(
            init: RoomSettingController(),
            builder: (controller) {
              return controller.isLoading
                  ? Container(
                      // height: Get.height,
                      // width: Get.width,
                      color: Colors.grey.withOpacity(0.6),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox();
            }),
      ],
    );
  }
}

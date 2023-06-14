// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/roomPageSettings.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:lametna/view/chat/appBar.dart';

class RoomSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("الإعدادات"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "إعدادات الخطوط",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.black, //Color(0xff9A8B8B),
                        fontSize: 15.sp,
                        fontFamily: "Portada",
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.black,
                        size: 25.sp,
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<RoomsSettingPageController>(
                  init: RoomsSettingPageController(),
                  builder: (controller) {
                    return Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: SizedBox(
                              width: 300.w,
                              child: Slider(
                                  activeColor: Color(0xff43d0ca),
                                  inactiveColor: Colors.grey[300],
                                  value: controller.sliderValue.toDouble(),
                                  min: 10,
                                  max: 50,
                                  onChanged: (value) {
                                    controller.updateSliderValue(value);
                                  }),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(1.5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xff707070)),
                                ),
                                child: Text(
                                  controller.sliderValue.toString(),
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 12.sp,
                                    fontFamily: "Segoe UI",
                                  ),
                                ),
                              ),
                              Text(
                                "حجم الخط:",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 15.sp,
                                  fontFamily: "Segoe UI",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: SizedBox(
                  height: 25.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                      Text(
                        "خط عريض",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: 15.sp,
                          fontFamily: "Segoe UI",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                    Text(
                      "خط مائل  ",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontSize: 15.sp,
                        fontFamily: "Segoe UI",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xffA7A7A7),
                thickness: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          // barrierColor: Colors.grey,
                          barrierDismissible: false,
                          context: context,
                          builder: (context) =>
                              GetBuilder<RoomsSettingPageController>(
                                  builder: (controller) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  // hexInputBar: true,
                                  // hexInputController:
                                  //     controller.hexaInputController,
                                  pickerAreaHeightPercent: 0.9,
                                  pickerAreaBorderRadius: BorderRadius.all(
                                    Radius.circular(360.r),
                                  ),
                                  showLabel: false,
                                  paletteType: PaletteType.hsl,
                                  pickerColor: controller.pickerColor,
                                  onColorChanged: (value) {
                                    controller.updatePickerColor(value);
                                  },
                                ),
                              ),
                              actions: [
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      //
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "تم",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                        fontFamily: "Segoe UI",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                      },
                      child: GetBuilder<RoomsSettingPageController>(
                          builder: (controller) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Container(
                            width: 28.w,
                            height: 28.h,
                            decoration: BoxDecoration(
                              color: controller.pickerColor,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        );
                      }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "لون الخط",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.black, //Color(0xff9A8B8B),
                            fontSize: 15.sp,
                            fontFamily: "Segoe UI",
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.color_lens,
                            color: Colors.black,
                            size: 35.sp,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                color: Color(0xffA7A7A7),
                thickness: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "إعدادات متقدمة",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.black, //Color(0xff9A8B8B),
                        fontSize: 15.sp,
                        fontFamily: "Segoe UI",
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 35.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, bottom: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "التنبيهات",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.black, //Color(0xff9A8B8B),
                        fontSize: 15.sp,
                        fontFamily: "Segoe UI",
                      ),
                    ),
                  ],
                ),
              ),
              switchmethod("إلغاء التنبيهات الصوتية"),
              switchmethod("إلغاء التنبيهات الصوتية"),
              switchmethod("إلغاء التنبيهات الصوتية أثناء التحدث"),
              switchmethod("تحويل الحالة لهاتف أثناء المكالمات الهاتفية"),
              switchmethod("عند وجود مكالمة هاتفية أسحب مني المايك"),
              switchmethod("إلغاء تنبيهات تدكير الأسم"),
              switchmethod("إلغاء تنبيهات الرسائل الخاصة"),
              switchmethod("تأثيرات الدخول"),
              switchmethod("تنبيهات الدخول والخروج"),
              Divider(
                color: Color(0xffA7A7A7),
                thickness: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "الرسائل الخاصة",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: "Portada",
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<RoomsSettingPageController>(
                  init: RoomsSettingPageController(),
                  builder: (controller) {
                    return Column(
                        children: [
                      "رفض جميع الرسائل الخاصة",
                      "قبول الرسائل الخاصة من الخاصة من الأعضاء والمسجلين فقط",
                      "قبول الرسائل الخاصة من الأعضاء فقط",
                    ]
                            .toList()
                            .map((e) => radioBuilder(controller, e))
                            .toList());
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        // Get.toNamed('/VIPRoom');
                        //  controller.changeRoomStatus();
                      },
                      child: SizedBox(
                        width: 96.w,
                        height: 37.h,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Color(0xFFDA8080),
                          ),
                          child: Text(
                            "خروج",
                            // controller.roomStatus
                            //     ? 'الروم الحديث'
                            //     : "مظهر قديم",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: "Portada",
                                color: Colors.white),
                          ),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        // Get.toNamed('/VIPRoom');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: 96.w,
                          height: 37.h,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: Color(0xFF6BE05B),
                            ),
                            child: Center(
                              child: Text(
                                "حفظ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "Portada",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox radioBuilder(RoomsSettingPageController controller, String text) {
    return SizedBox(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(text,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Color(0xFF707070),
                )),
            Radio(
              value: controller.value,
              groupValue: controller.value,
              onChanged: (value) {
                controller.RadioStatus();
              },
            ),
          ],
        ));
  }

  Widget switchmethod(
    String text,
  ) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, bottom: 20.w),
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
                activeColor: Colors.blue,
                activeTrackColor: Colors.blue,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.black45,
              );
            }),
            Text(
              text,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Color(0xff707070), //Color(0xff9A8B8B),
                fontSize: 15.sp,
                fontFamily: "Segoe UI",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

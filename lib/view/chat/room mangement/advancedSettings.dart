// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lametna/controllers/chat/room%20managment/advancedSettingsController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdvancedSettings extends StatelessWidget {
  const AdvancedSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("إعدادات متقدمة", true),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        children: [
          GetBuilder<AdvancedSettingsController>(
              init: AdvancedSettingsController(),
              builder: (controller) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      controller.getData();
                      // print(index == 0
                      //     ? controller.sendImage
                      //     : index == 1
                      //         ? controller.sendText
                      //         : index == 2
                      //             ? controller.sendVoiceInPrivate
                      //             : index == 3
                      //                 ? controller.sendAlerts
                      //                 : index == 4
                      //                     ? controller.allowAddMaster
                      //                     : controller.allowEditRoomSettings);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 60.w,
                          height: 50.h,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Switch(
                              value: index == 0
                                  ? controller.sendImage
                                  : index == 1
                                      ? controller.sendText
                                      : index == 2
                                          ? controller.sendVoiceInPrivate
                                          : index == 3
                                              ? controller.sendAlerts
                                              : index == 4
                                                  ? controller.allowAddMaster
                                                  : controller
                                                      .allowEditRoomSettings,
                              onChanged: (value) {
                                if (index == 0) {
                                  controller.changeSendImage(value);
                                } else if (index == 1) {
                                  controller.changeSendText(value);
                                } else if (index == 2) {
                                  controller.changeSendVoiceInPrivate(value);
                                } else if (index == 3) {
                                  controller.changeSendAlerts(value);
                                }
                                if (index == 4) {
                                  controller.changeAllowAddMaster(value);
                                } else if (index == 5) {
                                  controller.changeAllowEditRoomSettings(value);
                                }
                              },
                            ),
                          ),
                        ),
                        Text(
                          controller.items[index]["title"],
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Segoe UI',
                            fontSize: 15.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => index == 4
                      ? SizedBox()
                      : Divider(color: Color(0xFF43D0CA)),
                  itemCount: controller.items.length,
                );
              })
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lametna/controllers/chat/room%20managment/roomSettingsController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';

class CameraSettings extends StatelessWidget {
  const CameraSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("الكاميرا", true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<RoomSettingController>(builder: (controller) {
          return Column(
            children: [
              RadioListTile(
                title: Text(
                  "الجميع",
                  style: TextStyle(color: Colors.black),
                ),
                value: "all",
                groupValue: controller.cameraStatus,
                onChanged: (value) {
                  controller.changeCameraRadio(value);
                  // setState(() {});
                },
              ),
              RadioListTile(
                title: Text(
                  "الأعضاء والمشرفين فقط",
                  style: TextStyle(color: Colors.black),
                ),
                value: "membersAndAdmins",
                groupValue: controller.cameraStatus,
                onChanged: (value) {
                  controller.changeCameraRadio(value);
                  // setState(() {});
                },
              ),
              RadioListTile(
                title: Text(
                  "المشرفين فقط",
                  style: TextStyle(color: Colors.black),
                ),
                value: "adminsOnly",
                groupValue: controller.cameraStatus,
                onChanged: (value) {
                  controller.changeCameraRadio(value);
                  // setState(() {});
                },
              ),
              RadioListTile(
                title: Text(
                  "لا أحد",
                  style: TextStyle(color: Colors.black),
                ),
                value: "nobody",
                groupValue: controller.cameraStatus,
                onChanged: (value) {
                  // setState(() {});
                  controller.changeCameraRadio(value);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

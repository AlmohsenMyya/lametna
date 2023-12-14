import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lametna/controllers/chat/roomPageSettingsController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CloseRoom extends StatelessWidget {
  const CloseRoom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarBuilder("قفل الغرفة", true),
        body: GetBuilder<RoomsSettingPageController>(
          init: RoomsSettingPageController(),
          builder: (controller) {
            return Column(
              children: [
                "مفتوح",
                "الأعضاء والمشرفين فقط",
                "بوابة دخول",
              ].map((e) => radioBuilder(controller, e)).toList(),
            );
          },
        ));
  }

  SizedBox radioBuilder(RoomsSettingPageController controller, String text) {
    if (text == "الأعضاء والمشرفين فقط") {
      return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Divider(
              color: Color(0xff43D0CA),
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  text,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: "Segoe UI",
                    fontSize: 15.sp,
                    color: Colors.black,
                  ),
                ),
                Radio(
                  value: text,
                  groupValue: controller.value,
                  onChanged: (value) {
                    controller.RadioStatus();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 232.w,
                  height: 37.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFABD63),
                      style: BorderStyle.solid,
                      width: 1.0.w,
                    ),
                    borderRadius: BorderRadius.circular(10.0.sp),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "الغرفة مغلقة",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Segoe UI",
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(
              color: Color(0xff43D0CA),
              thickness: 1,
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: "Segoe UI",
                fontSize: 15.sp,
                color: Colors.black,
              ),
            ),
            // Radio(
            //   value: text,
            //   groupValue: controller.value,
            //   onChanged: (value) {
            //     controller.radioStatus(value);
            //   },
            // ),
          ],
        ),
      );
    }
  }
}

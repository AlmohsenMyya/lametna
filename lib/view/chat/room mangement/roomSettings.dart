import 'package:flutter/material.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var setting = [
  {"name": "الصورة الشخصية الخاصة بالغرفة", "icon": Icons.photo, "name2": ""},
  {"name": "خلفية الغرفة", "icon": Icons.photo, "name2": ""},
  {"name": "الحالة", "icon": Icons.volume_up, "name2": ""},
  {"name": "رسالة ترحيب", "icon": Icons.email, "name2": ""},
  {"name": "التحدث", "icon": Icons.mic, "name2": ""},
  {
    "name": "الكاميرا",
    "icon": Icons.photo_camera_front,
    "name2": "",
  },
  {"name": "الرسائل الخاصة", "icon": Icons.message, "name2": ""},
  {"name": "قفل الغرفة", "icon": Icons.lock_outline, "name2": "مغلق"},
  {"name": "نمط الغرفة", "icon": Icons.color_lens, "name2": ""},
  {"name": "الغرف الصوتية", "icon": Icons.surround_sound_rounded, "name2": ""},
  {"name": "إعدادات متقدمة", "icon": Icons.settings, "name2": ""},
];

class RoomSettings extends StatelessWidget {
  const RoomSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("إعدادات الغرفة", true),
      body: Column(
        children: [
          Container(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                            Row(
                              children: [
                                Text(
                                  setting[index]["name2"],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                    fontFamily: "Segoe UI",
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      color: Color(0xff43D0CA),
                      thickness: 1,
                    ),
                itemCount: setting.length),
          ),
          Divider(
            color: Color(0xff43D0CA),
            thickness: 1,
          ),
          SizedBox(height: 60.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 3.h),
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
              SizedBox(width: 30.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 3.h),
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
            ],
          )
        ],
      ),
    );
  }
}

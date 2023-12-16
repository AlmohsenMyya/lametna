// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:lametna/controllers/chat/room%20managment/roomSettingsController.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/view/chat/room%20mangement/side%20pages/callSettings.dart';
import 'package:lametna/view/chat/room%20mangement/side%20pages/custom_expansion.dart';

class RoomSettings extends StatelessWidget {
  // RoomSettingController controller = Get.put(RoomSettingController());

  RoomSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Get.arguments["color"];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarBuilder("إعدادات الغرفة", true, color: color),
      body: ListView(
        shrinkWrap: true,
        children: [
          GetBuilder<RoomSettingController>(
              init: RoomSettingController(),
              builder: (controller) {
                return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.withOpacity(0.5),
                          thickness: (0.5).h,
                        ),
                    itemBuilder: (context, index) {
                      return IgnorePointer(
                        ignoring: false,
                        child: Theme(
                          data: ThemeData().copyWith(
                            dividerColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // controller.changeExpansionTile(index: index);
                              print("object");
                            },
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: CustomExpansionTile(
                                  // backgroundColor: Colors.green,
                                  children: [controller.expansionTileChildren(index: index)],
                                  leading: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Icon(
                                      controller.setting[index]["icon"] as IconData?,
                                      color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                                      size: 28.sp,
                                    ),
                                  ),
                                  title: GestureDetector(
                                    onTap: () {
                                      // print("object");
                                      if (index == 0) {
                                        showMenu(
                                            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                                            constraints: BoxConstraints(
                                              minWidth: 135,
                                              maxWidth: 135,
                                            ),
                                            context: Get.context!,
                                            position: RelativeRect.fromLTRB(100.w, 130.h, 100.w, 100.h),
                                            items: [
                                              // PopupMenuItem(
                                              //   child: GestureDetector(
                                              //     onTap: () {
                                              //       // controller.();
                                              //       Get.back();
                                              //     },
                                              //     child: Row(
                                              //       children: [
                                              //         Icon(
                                              //           Icons.camera_alt,
                                              //           color: Colors.black,
                                              //           size: 20.sp,
                                              //         ),
                                              //         SizedBox(width: 10.w),
                                              //         Text(
                                              //           "التقاط صورة",
                                              //           style: TextStyle(
                                              //             color: Colors.black,
                                              //             fontSize: 16.sp,
                                              //             fontWeight: FontWeight.bold,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.getImageFromGallery().then((value) {
                                                      controller.uploadRoomImage(
                                                        Get.arguments["room_id"],
                                                      );
                                                    });
                                                    Get.back();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "اختيار صورة",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.image,
                                                        color: Colors.black,
                                                        size: 20.sp,
                                                      ),
                                                      SizedBox(width: 10.w),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]);
                                      } else if (index == 4) {
                                        Get.to(() => CallSettings(), arguments: {"color": color});
                                      } else {}
                                    },
                                    child: Text(
                                      controller.setting[index]["name"] as String,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  trailing: trailingBuilder(index, controller)),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.setting.length);
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
                    ),
                  ),
                ),
              ),
              SizedBox(width: 30.w),
              GetBuilder<RoomSettingController>(builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    print("test");
                  },
                  child: Container(
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
                      color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print("object");
                        controller.changeSettings(Get.arguments["room_id"]);
                        controller.getData();
                        // showSnackBar(context);
                      },
                      child: Text(
                        "حفظ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
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
    );
  }

  var len = 190;
  trailingBuilder(int index, RoomSettingController controller) {
    if (index == 0) {
      return Image.network(roomImagesURL + controller.roomInfo["room_img"]);
    } else if (index == 1) {
      return SizedBox(
        width: len.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              controller.room_plan == "1" ? "المظهر القديم" : "المظهر الجديد",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 30.sp,
            ),
          ],
        ),
      );
    } else if (index == 4) {
      return SizedBox(
        width: len.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              controller.speech as String,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 30.sp,
            ),
          ],
        ),
      );
    } else if (index == 5) {
      return SizedBox(
        width: len.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 100.w,
              child: Text(
                // controller.welcomeMsg.text.toString(),
                "",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 30.sp,
            ),
          ],
        ),
      );
    } else if (index == 6) {
      return SizedBox(
        width: len.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              controller.cameraRadio as String,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 30.sp,
            ),
          ],
        ),
      );
    } else if (index == 7) {
      return SizedBox(
        width: len.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              controller.privateMessageStatus as String,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 30.sp,
            ),
          ],
        ),
      );
    } else if (index == 8) {
      return SizedBox(
        width: len.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              controller.roomLock as String,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 30.sp,
            ),
          ],
        ),
      );
    } else if (index == 9) {
      return SizedBox(
        width: 130.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => controller.colorPicker(),
              child: Container(
                width: 30.sp,
                height: 30.sp,
                decoration: BoxDecoration(
                  color: controller.pickerColor,
                  borderRadius: BorderRadius.circular(360.r),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () => controller.colorPickerBuilder(),
              child: Container(
                width: 30.sp,
                height: 30.sp,
                decoration: BoxDecoration(
                  color: controller.pickerColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 30.sp,
            ),
          ],
        ),
      );
    } else {
      return Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
        size: 30.sp,
      );
    }
    // index == 0
    //     ? Image.network(roomImagesURL + controller.roomInfo["room_img"])
    //     : index == 9
    //         ? SizedBox(
    //             width: 130.w,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 GestureDetector(
    //                   onTap: () => controller.colorPicker(),
    //                   child: Container(
    //                     width: 30.sp,
    //                     height: 30.sp,
    //                     decoration: BoxDecoration(
    //                       color: controller.pickerColor,
    //                       borderRadius: BorderRadius.circular(360.r),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(width: 10.w),
    //                 GestureDetector(
    //                   onTap: () => controller.colorPickerBuilder(),
    //                   child: Container(
    //                     width: 30.sp,
    //                     height: 30.sp,
    //                     decoration: BoxDecoration(
    //                       color: controller.pickerColor,
    //                       borderRadius: BorderRadius.circular(4.r),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(width: 20.w),
    //                 Icon(
    //                   Icons.arrow_drop_down,
    //                   color: Colors.black,
    //                   size: 30.sp,
    //                 ),
    //               ],
    //             ),
    //           )
    //         : Icon(
    //             Icons.arrow_drop_down,
    //             color: Colors.black,
    //             size: 30.sp,
    //           );
  }
}

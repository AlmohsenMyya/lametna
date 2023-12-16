// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/room%20managment/roomSettingsController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var l = ['الجميع', 'الأعضاء والمشرفين فقط', 'المشرفين فقط', 'لا أحد'];

class CallSettings extends StatefulWidget {
  const CallSettings({Key? key}) : super(key: key);

  @override
  State<CallSettings> createState() => _CallSettingsState();
}

class _CallSettingsState extends State<CallSettings> {
  final List<double> values = [3, 5, 6];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    selectionBuilder() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          content: SizedBox(
            height: 265.h,
            width: 10.w,
            child: ListView.separated(
                // mainAxisSize: MainAxisSize.min,
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                    ),
                itemCount: l.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.find<RoomSettingController>().changeSpeech(
                          l[index],
                        );
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Center(
                          child: Text(
                            l[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appbarBuilder("التحدث", true, color: Get.arguments["color"]),
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          GetBuilder<RoomSettingController>(builder: (controller) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "من يستطيع التحدث",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("object");
                              selectionBuilder();
                            },
                            child: Row(
                              children: [
                                Text(
                                  controller.speech as String,
                                  style: TextStyle(color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),

                          // DropdownButton<String>(
                          //   value: controller.speech,
                          //   // icon: const Icon(Icons.arrow_downward),
                          //   iconSize: 24,
                          //   elevation: 16,
                          //   style: const TextStyle(color: Colors.black),
                          //   underline: Container(
                          //     height: 0,
                          //     color: Colors.transparent,
                          //   ),
                          //   onChanged: (String newValue) {
                          //     print(newValue);
                          //     controller.changeSpeech(newValue);
                          //   },
                          //   items: ['الجميع', 'الأعضاء والمشرفين فقط', 'المشرفين فقط', 'لا أحد'].map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          // ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "تفعيل المايكات بالغرفة",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Transform.scale(
                            scale: 1,
                            child: Switch(
                              value: controller.mic,
                              onChanged: (value) {
                                controller.changeMic(value);
                              },
                              activeTrackColor: Color(int.parse(Get.arguments["color"].toString().substring(1), radix: 16) + 0xFF000000),
                              activeColor: Color(int.parse(Get.arguments["color"].toString().substring(1), radix: 16) + 0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "عدد المايكات المسموح بها",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: SizedBox(
                              width: 150.w,
                              child: Slider(
                                thumbColor: Color(int.parse(Get.arguments["color"].toString().substring(1), radix: 16) + 0xFF000000),
                                activeColor: Color(int.parse(Get.arguments["color"].toString().substring(1), radix: 16) + 0xFF000000),
                                inactiveColor:
                                    Color(int.parse(Get.arguments["color"].toString().substring(1), radix: 16) + 0xFF000000).withOpacity(0.5),
                                value: selectedIndex.toDouble(),
                                min: 0,
                                max: double.parse((values.length - 1).toString()),
                                divisions: values.length - 1,
                                label: values[selectedIndex].toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    selectedIndex = value.toInt();
                                  });
                                  controller.selectedIndex = value.toInt();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          Divider(
            color: Color(0xffE4E4E4),
            thickness: 7,
          ),
          GetBuilder<RoomSettingController>(builder: (controller) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  {
                    "title": "زائر",
                    "value": controller.guestCallTime,
                    "color": Color(0xFF7F52A3),
                  },
                  {
                    "title": "ممبر",
                    "value": controller.memberTalkTime,
                    "color": Color(0xFF7F52A3),
                  },
                  {
                    "title": "أدمن",
                    "value": controller.adminTalkTime,
                    "color": Color(0xFF5D00FF),
                  },
                  {
                    "title": "سوبر أدمن",
                    "value": controller.superTalkTime,
                    "color": Color(0xFF00B041),
                  },
                  {
                    "title": "ماستر",
                    "value": controller.masterTalkTime,
                    "color": Color(0xFFE60000),
                  }
                ]
                    .map(
                      (e) => ListTile(
                        shape: Border(
                          bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
                        ),
                        title: Text(
                          e["title"] as String,
                          style: TextStyle(
                            color: e["color"] as Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () => controller.alertDialog(e["title"] as String),
                          child: SizedBox(
                            width: 70.w,
                            child: Row(
                              children: [
                                Text(
                                  e["value"] as String,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //  Column(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 20.w),
                      //       child: Row(
                      //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           SizedBox(
                      //             width: 170.w,
                      // child: Text(
                      //   e["title"],
                      //   style: TextStyle(
                      //     color: e["color"],
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 17.sp,
                      //   ),
                      // ),
                      //           ),
                      //           GestureDetector(
                      //             onTap: () => controller.alertDialog(e["title"]),
                      //             child: Center(
                      //               child: Container(
                      //                 // width: 35.w,
                      //                 // height: 35.h,
                      //                 padding: EdgeInsets.all(5.sp),
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(3.r),
                      //                   border: Border.all(
                      //                     color: Colors.black,
                      //                     width: 0.5.w,
                      //                   ),
                      //                 ),
                      //                 child: Center(
                      // child: Text(
                      //   e["value"],
                      //   style: TextStyle(
                      //     color: Colors.red,
                      //     fontSize: 17.sp,
                      //     fontWeight: FontWeight.w900,
                      //   ),
                      // ),
                      //                 ),
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     Divider(
                      //       color: Colors.grey.withOpacity(0.5),
                      //       thickness: 1,
                      //     ),
                      //   ],
                      // ),
                    )
                    .toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
  // return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 20.w),
  //           child: Text(
  //             "من يستطيع التحدث:",
  //             style: TextStyle(
  //               color: Colors.grey,
  //               fontSize: 15.sp,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         GetBuilder<RoomSettingController>(
  //             init: RoomSettingController(),
  //             builder: (controller) {
  //               return Directionality(
  //                 textDirection: TextDirection.rtl,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: ['الجميع', 'الأعضاء والمشرفين فقط', 'المشرفين فقط', 'لا أحد']
  //                       .map(
  //                         (e) => RadioListTile(
  //                           dense: true,
  //                           visualDensity: VisualDensity(vertical: -4, horizontal: -4),
  //                           value: e,
  //                           title: Text(
  //                             e,
  //                             style: TextStyle(
  //                               color: Colors.black,
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 15.sp,
  //                             ),
  //                           ),
  //                           groupValue: speech,
  //                           selected: true,
  //                           activeColor: Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000),
  //                           onChanged: (value) {
  //                             print(value);
  //                             speech = value;
  //                             update();
  //                           },
  //                         ),
  //                       )
  //                       .toList(),
  //                 ),
  //               );
  //             }),
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 20.w),
  //           child: Text(
  //             "مدة التحدث:",
  //             style: TextStyle(
  //               color: Colors.grey,
  //               fontSize: 15.sp,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
          // Column(
          //   children: [
          //     {
          //       "title": "زائر",
          //       "value": guestCallTime,
          //       "color": Color(0xFF7F52A3),
          //     },
          //     {
          //       "title": "ممبر",
          //       "value": memberTalkTime,
          //       "color": Color(0xFF7F52A3),
          //     },
          //     {
          //       "title": "أدمن",
          //       "value": adminTalkTime,
          //       "color": Color(0xFF5D00FF),
          //     },
          //     {
          //       "title": "سوبر أدمن",
          //       "value": superTalkTime,
          //       "color": Color(0xFF00B041),
          //     },
          //     {
          //       "title": "ماستر",
          //       "value": masterTalkTime,
          //       "color": Color(0xFFE60000),
          //     }
          //   ]
          //       .map(
          //         (e) => Column(
          //           children: [
          //             Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 20.w),
          //               child: Row(
          //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   SizedBox(
          //                     width: 170.w,
          //                     child: Text(
          //                       e["title"],
          //                       style: TextStyle(
          //                         color: e["color"],
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: 17.sp,
          //                       ),
          //                     ),
          //                   ),
          //                   GestureDetector(
          //                     onTap: () => alertDialog(e["title"]),
          //                     child: Center(
          //                       child: Container(
          //                         // width: 35.w,
          //                         // height: 35.h,
          //                         padding: EdgeInsets.all(5.sp),
          //                         decoration: BoxDecoration(
          //                           borderRadius: BorderRadius.circular(3.r),
          //                           border: Border.all(
          //                             color: Colors.black,
          //                             width: 0.5.w,
          //                           ),
          //                         ),
          //                         child: Center(
          //                           child: Text(
          //                             e["value"],
          //                             style: TextStyle(
          //                               color: Colors.red,
          //                               fontSize: 17.sp,
          //                               fontWeight: FontWeight.w900,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ),
  //                     Divider(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       thickness: 1,
  //                     ),
  //                   ],
  //                 ),
  //               )
  //               .toList(),
  //         ),
        
        
  //       ],
  //     );
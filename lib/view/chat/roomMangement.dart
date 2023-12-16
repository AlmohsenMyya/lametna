// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, implementation_imports, depend_on_referenced_packages, file_names
import 'package:flutter/material.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/view/side%20pages/scrollText.dart';

var table1 = [
  {
    "name": "معلومات الغرفة",
    "icon": Icons.info,
    // "page":
  },
  {
    "name": "إدارة الحسابات",
    "icon": Icons.people,
    "page": "",
  },
  {
    "name": "الحظر",
    "icon": Icons.block,
    "page": "",
  }
];

class RoomMangement extends StatelessWidget {
  const RoomMangement({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var table2 = [
      {
        "name": "إعدادت الغرفة",
        "icon": Icons.settings,
      },
      {
        "name": "إعدادت متقدمة",
        "icon": Icons.people,
      },
      {
        "name": "سجل الغرفة",
        "icon": Icons.login,
      },
      {
        "name": "تقارير الغرفة",
        "icon": Icons.description,
      },
      {
        "name": "دعم فني",
        "icon": Icons.support_agent,
      }
    ];
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: appbarBuilder("إدارة الغرفة", true, color: Get.arguments["color"]),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  SizedBox(
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 265,
                    height: 50,
                    child: ScrollingText(
                      text: Get.arguments["room_name"],
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Text(
                  //   Get.arguments["room_name"],
                  // style: TextStyle(
                  //   color: Colors.black,
                  //   fontSize: 20.sp,
                  //   fontWeight: FontWeight.bold,
                  //   fontFamily: "Segoe UI",
                  // ),
                  // ),
                  Spacer(),
                  Image.asset(
                    "assets/icons/logo.png",
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: GestureDetector(
                        onTap: () {
                          // print(table1[index]["page"]);
                          if (index == 0) {
                            Get.toNamed('/roomInfo', arguments: {
                              "room_name": Get.arguments["room_name"],
                              "room_id": Get.arguments["room_id"],
                              "color": Get.arguments["color"],
                            });
                          } else if (index == 1) {
                            if (accountMangment) {
                              Get.toNamed('/addAccount', arguments: {
                                "room_id": Get.arguments["room_id"],
                                // "owner": Get.arguments['owner'],
                                "roomOwner": Get.arguments["roomOwner"],
                                "color": Get.arguments["color"],
                              });
                            } else {
                              permissionsdenied();
                            }
                          } else if (index == 2) {
                            if (removeBan) {
                              Get.toNamed('/blockPage', arguments: {
                                "room_id": Get.arguments["room_id"],
                                "color": Get.arguments["color"],
                                // "owner": Get.arguments['owner'],
                              });
                            } else {
                              permissionsdenied();
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Icon(
                                  table1[index]["icon"] as IconData,
                                  color: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000),
                                  size: 28.sp,
                                ),
                              ),
                              Text(
                                table1[index]["name"] as String,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000),
                                  size: 23.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: table1.length),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            if (roomSettings) {
                              Get.toNamed('/roomSetting', arguments: {
                                "room_id": Get.arguments["room_id"],
                                "color": Get.arguments["color"],
                              });
                            } else {
                              permissionsdenied();
                            }
                          } else if (index == 1) {
                            Get.toNamed('/advancedSettings', arguments: {
                              "room_id": Get.arguments["room_id"],
                              "color": Get.arguments["color"],
                            });
                          } else if (index == 2) {
                            if (logRecord) {
                              Get.toNamed('/roomReport', arguments: {
                                "room_id": Get.arguments["room_id"],
                                "color": Get.arguments["color"],
                              });
                            } else {
                              permissionsdenied();
                            }
                          } else if (index == 3) {
                            if (adminReport) {
                            } else {
                              permissionsdenied();
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Icon(
                                  table2[index]["icon"] as IconData,
                                  color: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000),
                                  size: 28.sp,
                                ),
                              ),
                              Text(
                                table2[index]["name"] as String,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(int.parse(Get.arguments["color"].substring(1, 7), radix: 16) + 0xFF000000),
                                  size: 23.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: table2.length),
            ),
            Spacer(),
            Text(
              "Lametna - Audio And Video Chat Rooms ® 2023/2024",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  permissionsdenied() {
    return Get.snackbar(
      'تنبية',
      'ليس لديك صلاحية ',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      titleText: Text(
        'تنبية',
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        'ليس لديك صلاحية ',
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}

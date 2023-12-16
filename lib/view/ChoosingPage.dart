// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/view/LoginPage.dart';

class choosingPage extends StatefulWidget {
  const choosingPage({Key? key}) : super(key: key);

  @override
  State<choosingPage> createState() => _choosingPageState();
}

class _choosingPageState extends State<choosingPage> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            ));
  }

  // const choosingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF792F0),
            const Color(0xFFFABD63),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            buildBackgroundImage("phone.png", -37.sp, -51.sp, 210.sp),
            buildBackgroundImage("heart.png", 214.sp, 0.sp, 202.sp, opacity: 1),
            buildBackgroundImage("message.png", 260.sp, 135.sp, 179),
            buildBackgroundImage("phone.png", 274.sp, 353.sp, 210.sp),
            buildBackgroundImage("recipt.png", 41.sp, 651.sp, 201.sp, opacity: 1),
            buildBackgroundImage("heart.png", 274.sp, 700.sp, 202.sp, opacity: 1),
            buildBackgroundImage("heart.png", -101.sp, 231.sp, 202.sp, opacity: 1),
            buildBackgroundImage("message.png", 0.sp, 300.sp, 179.sp),
            Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Center(
                    child: Image.asset(
                      'assets/icons/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed("/loginPage");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                      child: Text(
                        "تخطي",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


// Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color(0xFFF792F0),
//             const Color(0xFFFABD63),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: SafeArea(
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: Center(
//                 child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 107.h),
//                   child: Text(
//                     "أختر نوع الدردشة",
//                     style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Portada"),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 13.h),
//                   child: Text(
//                     "ودردش مع لمتنا",
//                     style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Portada"),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Get.toNamed("/loginPage");
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 50.h),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.r),
//                         gradient: LinearGradient(
//                           tileMode: TileMode.clamp,
//                           colors: [
//                             Color(0xFFFABD63),
//                             Color(0xFFFABD63),
//                             Color(0xFFF6F6F6),
//                           ],
//                           begin: Alignment.bottomRight,
//                           end: Alignment.topLeft,
//                           transform: GradientRotation(0.4),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(top: 15.h, left: 58.w, right: 59.w),
//                             child: Text(
//                               "الغرف الكتابية",
//                               style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Portada"),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 14.h),
//                             child: Image.asset(
//                               "assets/images/message.png",
//                               width: 220.w,
//                               height: 120.h,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 37.h),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20.r),
//                       gradient: LinearGradient(
//                         tileMode: TileMode.clamp,
//                         colors: [
//                           Color(0xFFF792F0),
//                           Color(0xFFF792F0),
//                           // Colors.green,
//                           Color(0xFFF6F6F6),
//                         ],
//                         begin: Alignment.bottomRight,
//                         end: Alignment.topLeft,
//                         transform: GradientRotation(0.4),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: 15.h, left: 58.w, right: 59.w),
//                           child: Text(
//                             "الغرف الصوتية",
//                             style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Portada"),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(bottom: 14.h),
//                           child: Image.asset(
//                             "assets/images/phone.png",
//                             width: 220.w,
//                             height: 120.h,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             )),
//           ),
//         ),
//       ),
//     );
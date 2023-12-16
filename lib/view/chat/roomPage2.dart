// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, missing_return, use_full_hex_values_for_flutter_colors, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks
//
// import 'dart:async';
// import 'package:floating_draggable_widget/floating_draggable_widget.dart';
// import 'package:flutter/foundation.dart' as foundation;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:lametna/controllers/chat/roomsPageController.dart';
// import 'package:lametna/controllers/chat/voice%20and%20video/videoController.dart';
// import 'package:lametna/controllers/chat/voice%20and%20video/voiceController.dart';
// import 'package:lametna/model/message.dart';
// import 'package:lametna/view/chat/In%20Room%20Widgets/messageBuilder.dart';
// import 'package:lametna/view/chat/In%20Room%20Widgets/navbarBuilder.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:lametna/view/chat/In%20Room%20Widgets/roomEndDrawer.dart';
// // import 'package:lametna/view/chat/room%20mangement/roomMangement.dart';
// import 'package:lametna/view/messages/messages.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:lametna/view/side%20pages/scrollText.dart';
//
// import '../../controllers/userData/userCredentials.dart';
// import 'package:http/http.dart' as http;
// import 'package:lametna/controllers/userData/variables.dart';
//
// GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
// class RoomPage extends StatefulWidget {
//   const RoomPage({required foundation.Key key}) : super(key: key);
//
//   // RoomPage({Key key}) : super(key: key);
//
//   @override
//   State<RoomPage> createState() => _RoomPageState();
// }
//
// // String Get.arguments["owner"] = Get.arguments["owner"];
//
// class _RoomPageState extends State<RoomPage> with WidgetsBindingObserver {
//   AppLifecycleState? _lastLifecycleState;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
//     switch (state) {
//       case AppLifecycleState.inactive:
//         print("inactive");
//         break;
//       case AppLifecycleState.paused:
//         print("paused");
//
//         break;
//       case AppLifecycleState.detached:
//         Get.put(RoomsPageController()).onLeave();
//
//         print("detached");
//         break;
//       case AppLifecycleState.resumed:
//         await print("resumed");
//         break;
//     }
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.detached) return;
//     bool isBackground = state == AppLifecycleState.paused;
//     bool isBackground2 = state == AppLifecycleState.inactive;
//     if (isBackground2) {
//       print("detached");
//       // Get.put(RoomsPageController()).onLeave();
//     }
//     if (isBackground && pickingImage == false) {
//       print("paused");
//       if (_scaffoldKey.currentState.isEndDrawerOpen) {
//         _scaffoldKey.currentState.closeEndDrawer();
//       }
//       // Get.put(RoomsPageController()).onLeave();
//     }
//
//     setState(() {
//       _lastLifecycleState = state;
//     });
//   }
//
//   // bool isOwner = Get.arguments["owner"] != userName;
//
//   // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return FloatingDraggableWidget(
//       screenHeight: Get.height,
//       screenWidth: Get.width,
//       floatingWidgetHeight: 150.h,
//       floatingWidgetWidth: 150.w,
//       speed: 5,
//       autoAlign: false,
//       dx: 0,
//       dy: 80,
//       floatingWidget: SizedBox(),
//
//       //  GetBuilder<VideoController>(
//       //   init: VideoController(),
//       //   builder: (controller) => Positioned(
//       //     right: 0,
//       //     child: SizedBox(
//       //       width: 151.w,
//       //       height: 130.h,
//       //       child: controller.videoPanel(),
//       //     ),
//       //   ),
//       // ),
//       mainScreenWidget: SafeArea(
//         child: WillPopScope(
//           onWillPop: () {
//             print(Get.arguments);
//             //  await controller.onLeave();
//             //
//             //                         Get.put(VoiceController()).leave();
//
//             // Get.defaultDialog(
//             //   title: "هل تريد مغادرة الغرفة؟",
//             //   titleStyle: TextStyle(
//             //       color: Colors.black,
//             //     ),
//             //   content: null,
//             //   confirm: ElevatedButton(onPressed: (){}, child: Text("data")),
//             //   //  Text(
//             //   //   "هل تريد مغادرة الغرفة؟",
//             //     // style: TextStyle(
//             //     //   color: Colors.black,
//             //     // ),
//             //   // ),
//             // );
//             // Get.put(RoomsPageController()).onLeave();
//             // AppLifecycleState isBackground = _lastLifecycleState;
//             // if (isBackground == AppLifecycleState.paused) {
//             //   print("paused");
//             // } else if (isBackground == AppLifecycleState.detached) {
//             //   print("detached");
//             // } else if (isBackground == AppLifecycleState.inactive) {
//             //   print("inactive");
//             // }
//             // return Future.value(true);
//             // return true;
//           },
//           child: Scaffold(
//             key: _scaffoldKey,
//             onEndDrawerChanged: (isOpened) {
//               // print("object");
//               if (isOpened) {
//                 Get.put(RoomsPageController()).getRoomMembers();
//               }
//             },
//             // resizeToAvoidBottomInset: false,
//
//             drawerScrimColor: Colors.transparent,
//             endDrawer: Padding(
//               padding: EdgeInsets.symmetric(vertical: 70.h),
//               child: Container(
//                   height: double.infinity,
//                   width: Get.width * 0.85,
//                   color: Colors.white,
//                   child: GetBuilder<RoomsPageController>(
//                       init: RoomsPageController(),
//                       builder: (controller) {
//                         return controller.userInRoom == null
//                             ? Center(
//                                 child: CircularProgressIndicator(),
//                               )
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: controller.userInRoom["data"].length,
//                                 // separatorBuilder: (context, index) => Divider(
//                                 //   color: Colors.grey,
//                                 // ),
//                                 itemBuilder: (context, index) =>
//                                     PopupMenuButton(
//                                   child: Container(
//                                     padding: EdgeInsets.only(
//                                         left: controller.userInRoom["data"]
//                                                     [index]["userType"] ==
//                                                 "TopVIP"
//                                             ? 0
//                                             : 10.w,
//                                         right: 15.w),
//                                     height: controller.userInRoom["data"][index]
//                                                     ["userType"] ==
//                                                 "protectedWithBG" ||
//                                             controller.userInRoom["data"][index]
//                                                     ["userType"] ==
//                                                 "protected" ||
//                                             controller.userInRoom["data"][index]
//                                                     ["userType"] ==
//                                                 ""
//                                         // controller.userInRoom["data"]
//                                         //         [index]["chatStatus"] ==
//                                         //     ""
//                                         ? 55.h
//                                         : 80.h,
//                                     decoration: BoxDecoration(
//                                       // color: Colors.green,
//
//                                       image: controller.userInRoom["data"]
//                                                   [index]["selectedBG"] ==
//                                               ""
//                                           ? null
//                                           : controller.userInRoom["data"][index]
//                                                       ["userType"] ==
//                                                   "protected"
//                                               ? null
//                                               : DecorationImage(
//                                                   image: NetworkImage(
//                                                       backgroundImagesURL +
//                                                           controller.userInRoom[
//                                                                   "data"][index]
//                                                               ["selectedBG"]),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                       border: Border(
//                                         bottom: BorderSide(
//                                           color: Colors.grey.withOpacity(0.7),
//                                         ),
//                                       ),
//                                     ),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         controller.userInRoom["data"][index]
//                                                         ["userType"] ==
//                                                     "protectedWithBG" ||
//                                                 controller.userInRoom["data"]
//                                                         [index]["userType"] ==
//                                                     "protected"
//                                             ? Center(
//                                                 child: Icon(
//                                                   Icons.verified,
//                                                   color: Colors.blue,
//                                                   size: 30.sp,
//                                                 ),
//                                               )
//                                             : controller.userInRoom["data"]
//                                                         [index]["userType"] ==
//                                                     "TopVIP"
//                                                 ? Center(
//                                                     child: Image.network(
//                                                       baseURL +
//                                                           "test/currentBanner.gif",
//                                                       height: 70.sp,
//                                                       width: 70.sp,
//                                                       fit: BoxFit.fitHeight,
//                                                     ),
//                                                   )
//                                                 : controller.userInRoom["data"]
//                                                                 [index]
//                                                             ["userType"] ==
//                                                         "VIP"
//                                                     ? Image.asset(
//                                                         'assets/images/vipBadge.png',
//                                                         height: 50.h,
//                                                         width: 31.w,
//                                                         // fit: BoxFit.cover,
//                                                       )
//                                                     : controller.userInRoom["data"]
//                                                                     [index]
//                                                                 ["userType"] ==
//                                                             "VIPWithBG"
//                                                         ? Image.asset(
//                                                             'assets/images/vip.png',
//                                                             height: 50.h,
//                                                             width: 31.w,
//                                                             // fit: BoxFit.cover,
//                                                           )
//                                                         : SizedBox(),
//                                         Spacer(),
//                                         Stack(
//                                           alignment: Alignment.topLeft,
//                                           children: [
//                                             SizedBox(
//                                               width: 210.w,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Stack(
//                                                     alignment: Alignment.center,
//                                                     children: [
//                                                       Text(
//                                                         controller
//                                                             .userInRoom["data"]
//                                                                 [index]
//                                                                 ["username"]
//                                                             .toString(),
//                                                         style: TextStyle(
//                                                           fontSize: 14.sp,
//                                                           // letterSpacing: 5,
//                                                           // fontFamily:
//                                                           //     "Portada",
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           fontWeight:
//                                                               FontWeight.w700,
//                                                           foreground: Paint()
//                                                             ..style =
//                                                                 PaintingStyle
//                                                                     .stroke
//                                                             ..strokeWidth = 3
//                                                             ..color = controller.userInRoom["data"][index]["roleType"] ==
//                                                                         "3" ||
//                                                                     controller.userInRoom["data"][index]["userType"] ==
//                                                                         "protected" ||
//                                                                     controller.userInRoom["data"][index]["userType"] ==
//                                                                         "protectedWithBG" ||
//                                                                     controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "userType"] ==
//                                                                         "VIP" ||
//                                                                     controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "userType"] ==
//                                                                         "VIPWithBG" ||
//                                                                     controller.userInRoom["data"][index]
//                                                                             ["userType"] ==
//                                                                         "TopVIP"
//                                                                 ? Color(0xFFFAE635)
//                                                                 : Colors.transparent,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         controller
//                                                             .userInRoom["data"]
//                                                                 [index]
//                                                                 ["username"]
//                                                             .toString(),
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: TextStyle(
//                                                             fontSize: 14.sp,
//                                                             fontWeight:
//                                                                 FontWeight.w700,
//                                                             // fontFamily:
//                                                             //     "Portada",
//                                                             color: controller.userInRoom["data"]
//                                                                             [index]
//                                                                         [
//                                                                         "roleType"] ==
//                                                                     "0"
//                                                                 ? Color(
//                                                                     0xFFF411EB)
//                                                                 : controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "roleType"] ==
//                                                                         "1"
//                                                                     ? Color(
//                                                                         0xFF3B00E1)
//                                                                     : controller.userInRoom["data"][index]["roleType"] ==
//                                                                             "2"
//                                                                         ? Color(
//                                                                             0xFF11F435)
//                                                                         : controller.userInRoom["data"][index]["roleType"] == "3"
//                                                                             ? Color(0xFFFD6EB3)
//                                                                             : Colors.black),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   controller.userInRoom["data"]
//                                                                       [index][
//                                                                   "userType"] ==
//                                                               "VIPWithBG" ||
//                                                           controller.userInRoom["data"]
//                                                                       [index][
//                                                                   "userType"] ==
//                                                               "VIP" ||
//                                                           controller.userInRoom["data"]
//                                                                       [index][
//                                                                   "userType"] ==
//                                                               "TopVIP"
//                                                       ? controller.userInRoom["data"]
//                                                                       [index]
//                                                                   ["chatStatus"] ==
//                                                               ""
//                                                           ? SizedBox()
//                                                           : SizedBox(
//                                                               width: 210.w,
//                                                               height: 20.h,
//                                                               child:
//                                                                   ScrollingText(
//                                                                 text: controller
//                                                                             .userInRoom[
//                                                                         "data"][index]
//                                                                     [
//                                                                     "chatStatus"],
//                                                                 ratioOfBlankToScreen:
//                                                                     0.37,
//                                                                 textStyle: TextStyle(
//                                                                     fontSize:
//                                                                         12.sp,
//                                                                     color: Colors
//                                                                         .black),
//                                                               ),
//                                                             )
//                                                       : SizedBox(),
//                                                 ],
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(top: 12.h),
//                                               child: SizedBox(
//                                                 width: 110.w,
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceEvenly,
//                                                   // crossAxisAlignment:
//                                                   //     CrossAxisAlignment.center,
//                                                   children: [
//                                                     controller.userInRoom[
//                                                                         "data"]
//                                                                     [index]
//                                                                 ["cameraIs"] ==
//                                                             "0"
//                                                         ? SizedBox()
//                                                         : GetBuilder<
//                                                                 VideoController>(
//                                                             init:
//                                                                 VideoController(),
//                                                             builder: (c) {
//                                                               return GestureDetector(
//                                                                 onTap: () {
//                                                                   // print("sk");
//                                                                   // c.joinAsViewer(
//                                                                   //     name: controller
//                                                                   //                 .userInRoom[
//                                                                   //             "data"][index]
//                                                                   //         ["username"],
//                                                                   //     token: controller
//                                                                   //                 .userInRoom[
//                                                                   //             "data"][
//                                                                   //         index]["token"]);
//                                                                 },
//                                                                 child:
//                                                                     Image.asset(
//                                                                   'assets/icons/cam.png',
//                                                                   width: 20.w,
//                                                                 ),
//                                                               );
//                                                             }),
//                                                     Text(controller
//                                                             .userInRoom["data"]
//                                                         [index]["statusIs"]),
//                                                     controller.userInRoom[
//                                                                         "data"]
//                                                                     [index]
//                                                                 ["micIs"] ==
//                                                             "0"
//                                                         ? SizedBox()
//                                                         : Image.asset(
//                                                             'assets/icons/mic.png',
//                                                             width: 20.w,
//                                                           ),
//                                                     // Text(),
//                                                     controller.userInRoom[
//                                                                         "data"]
//                                                                     [index]
//                                                                 ["MuteIs"] ==
//                                                             "0"
//                                                         ? SizedBox()
//                                                         : Image.asset(
//                                                             'assets/icons/mute.png',
//                                                             width: 20.w,
//                                                           ),
//                                                     controller.userInRoom[
//                                                                         "data"]
//                                                                     [index]
//                                                                 ["handIs"] ==
//                                                             "0"
//                                                         ? SizedBox()
//                                                         : Icon(
//                                                             Icons
//                                                                 .back_hand_rounded,
//                                                             size: 20.sp,
//                                                           ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           width: 7.w,
//                                         ),
//                                         Center(
//                                           child: SizedBox(
//                                             width: 55.w,
//                                             child: ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(360.r),
//                                               child: controller.userInRoom[
//                                                                   "data"][index]
//                                                               ["userType"] ==
//                                                           "protectedWithBG" ||
//                                                       controller.userInRoom[
//                                                                   "data"][index]
//                                                               ["userType"] ==
//                                                           "protected"
//                                                   ? Padding(
//                                                       padding: EdgeInsets.only(
//                                                           right: 6.w,
//                                                           left: 10.w),
//                                                       child: SizedBox(
//                                                         // height: 40.h,
//                                                         child: Container(
//                                                           width: 35.w,
//                                                           height: 40.h,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             // color: Colors.grey,
//                                                             gradient:
//                                                                 LinearGradient(
//                                                               begin: Alignment(
//                                                                   0.00, -1.00),
//                                                               end: Alignment(
//                                                                   0, 1),
//                                                               colors: [
//                                                                 Color(
//                                                                     0xFF2FDDE8),
//                                                                 Color(
//                                                                     0xF900E3F2)
//                                                               ],
//                                                             ),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         360.r),
//                                                           ),
//                                                           child: ClipRRect(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           360.r),
//                                                               child: Icon(
//                                                                 Icons.person,
//                                                                 color: Colors
//                                                                     .white,
//                                                               )),
//                                                         ),
//                                                       ),
//                                                     )
//                                                   : Padding(
//                                                       padding:
//                                                           EdgeInsets.symmetric(
//                                                               vertical: 2.h),
//                                                       child: Stack(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         children: [
//                                                           SizedBox(
//                                                             width: controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "userType"] ==
//                                                                         "VIP" ||
//                                                                     controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "userType"] ==
//                                                                         "VIPWithBG"
//                                                                 ? 50.sp
//                                                                 : controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "userType"] ==
//                                                                         "TopVIP"
//                                                                     ? 35.sp
//                                                                     : 45.sp, //45
//                                                             height: controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "userType"] ==
//                                                                         "VIP" ||
//                                                                     controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "userType"] ==
//                                                                         "VIPWithBG"
//                                                                 ? 50.sp
//                                                                 : controller.userInRoom["data"][index]
//                                                                             [
//                                                                             "userType"] ==
//                                                                         "TopVIP"
//                                                                     ? 35.sp
//                                                                     : 45.sp,
//                                                             child: ClipRRect(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           360.r),
//                                                               child:
//                                                                   Image.network(
//                                                                 imageURL +
//                                                                     controller.userInRoom["data"]
//                                                                             [
//                                                                             index]
//                                                                         [
//                                                                         "username"] +
//                                                                     ".jpeg",
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                                 errorBuilder: (context,
//                                                                         error,
//                                                                         stackTrace) =>
//                                                                     Image
//                                                                         .network(
//                                                                   "https://lametnachat.com/upload/imageUser/anonymous.jpg",
//                                                                   fit: BoxFit
//                                                                       .cover,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           controller.userInRoom[
//                                                                               "data"]
//                                                                           [
//                                                                           index]
//                                                                       [
//                                                                       "userType"] ==
//                                                                   "TopVIP"
//                                                               ? Image.network(
//                                                                   baseURL +
//                                                                       "test/currentBadge.gif",
//                                                                   width: 57.5
//                                                                       .sp, //45,
//                                                                   height: 70.sp,
//                                                                   fit: BoxFit
//                                                                       .fitHeight)
//                                                               : SizedBox(),
//                                                         ],
//                                                       ),
//                                                     ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   itemBuilder: (context) => [
//                                     controller.userInRoom["data"][index]
//                                                 ["username"] ==
//                                             userName
//                                         ? null
//                                         : usersPopUpMenu(
//                                             "محادثة خاصة",
//                                             f: () async {
//                                               await Get.back();
//                                               Get.toNamed(
//                                                 "/privateMessageRoom",
//                                                 arguments: {
//                                                   "username": controller
//                                                           .userInRoom["data"]
//                                                       [index]["username"],
//                                                   "room_id":
//                                                       Get.arguments['room_id'],
//                                                 },
//                                               );
//                                             },
//                                           ),
//                                     usersPopUpMenu(controller.userInRoom["data"]
//                                         [index]["username"]),
//                                     usersPopUpMenu("الإبلاغ عن الستخدم", f: () {
//                                       // print(Get.arguments["owner"]);
//                                     }),
//                                     // if (!isOwner || roleType == "3" || roleType == "2")
//                                     //   PopupMenuItem(
//                                     //     value: 0,
//                                     //     height: 25.h,
//                                     //     textStyle: TextStyle(
//                                     //       fontSize: 10.sp,
//                                     //       fontWeight: FontWeight.bold,
//                                     //       fontFamily: "Portada",
//                                     //       color: Color(0xFF43D0CA),
//                                     //     ),
//                                     //     child: PopupMenuButton(
//                                     //       child: Align(
//                                     //         alignment: Alignment.center,
//                                     //         child: Text(
//                                     //           "خيارات الإشراف",
//                                     //         ),
//                                     //       ),
//                                     //       itemBuilder: (context) => [
//                                     //         // usersPopUpMenu('معلومات المستخدم'),
//                                     //         isOwner
//                                     //             ? null
//                                     //             : PopupMenuItem(
//                                     //                 value: 0,
//                                     //                 height: 25.h,
//                                     //                 textStyle: TextStyle(
//                                     //                   fontSize: 10.sp,
//                                     //                   fontWeight: FontWeight.bold,
//                                     //                   fontFamily: "Portada",
//                                     //                   color: Color(0xFF43D0CA),
//                                     //                 ),
//                                     //                 child: PopupMenuButton(
//                                     //                   child: Align(
//                                     //                     alignment: Alignment.center,
//                                     //                     child: Text(
//                                     //                       "معلومات المستخدم",
//                                     //                     ),
//                                     //                   ),
//                                     //                   itemBuilder: (context) => [
//                                     //                     usersPopUpMenu(
//                                     //                       'اسم المستخدم',
//                                     //                     ),
//                                     //                     usersPopUpMenu('رقم الاي بي',
//                                     //                         f: () {
//                                     //                       controller.getUserIP();
//                                     //                     }),
//                                     //                     usersPopUpMenu('نوع الجهاز',
//                                     //                         f: () {
//                                     //                       controller.getUserDeviceType();
//                                     //                     }),
//                                     //                     usersPopUpMenu('الدول', f: () {
//                                     //                       controller.getUserCountry();
//                                     //                     }),
//                                     //                   ],
//                                     //                 ),
//                                     //               ),
//
//                                     //         // usersPopUpMenu('طرد'),
//                                     //         PopupMenuItem(
//                                     //           height: 25.h,
//                                     //           child: Align(
//                                     //             alignment: Alignment.center,
//                                     //             child: Text("طرد",
//                                     //                 style: TextStyle(
//                                     //                   fontSize: 10.sp,
//                                     //                   fontWeight: FontWeight.bold,
//                                     //                   fontFamily: "Portada",
//                                     //                   color: Color(0xFF43D0CA),
//                                     //                 )),
//                                     //           ),
//                                     //           textStyle: TextStyle(
//                                     //             fontSize: 10.sp,
//                                     //             fontWeight: FontWeight.bold,
//                                     //             fontFamily: "Portada",
//                                     //             color: Color(0xFF43D0CA),
//                                     //           ),
//                                     //           onTap: () {
//                                     //             controller.kickUser(
//                                     //                 controller.userInRoom["data"][index]
//                                     //                     ["username"],
//                                     //                 controller.userInRoom["data"][index]
//                                     //                     ["roomId"]);
//                                     //           },
//                                     //         ),
//                                     //         // usersPopUpMenu(''),
//                                     //         PopupMenuItem(
//                                     //           value: 0,
//                                     //           height: 25.h,
//                                     //           textStyle: TextStyle(
//                                     //             fontSize: 10.sp,
//                                     //             fontWeight: FontWeight.bold,
//                                     //             fontFamily: "Portada",
//                                     //             color: Color(0xFF43D0CA),
//                                     //           ),
//                                     //           child: PopupMenuButton(
//                                     //             child: Align(
//                                     //               alignment: Alignment.center,
//                                     //               child: Text(
//                                     //                 "حظر",
//                                     //               ),
//                                     //             ),
//                                     //             itemBuilder: (context) => [
//                                     //               usersPopUpMenu('١٥  دقيقة', f: () {
//                                     //                 controller.blockUser(
//                                     //                     controller.userInRoom["data"]
//                                     //                         [index]["username"],
//                                     //                     0);
//                                     //               }),
//                                     //               usersPopUpMenu('ساعة', f: () {
//                                     //                 controller.blockUser(
//                                     //                     controller.userInRoom["data"]
//                                     //                         [index]["username"],
//                                     //                     1);
//                                     //               }),
//                                     //               usersPopUpMenu('٦ ساعة', f: () {
//                                     //                 controller.blockUser(
//                                     //                     controller.userInRoom["data"]
//                                     //                         [index]["username"],
//                                     //                     2);
//                                     //               }),
//                                     //               usersPopUpMenu('يوم', f: () {
//                                     //                 controller.blockUser(
//                                     //                     controller.userInRoom["data"]
//                                     //                         [index]["username"],
//                                     //                     3);
//                                     //               }),
//                                     //               usersPopUpMenu('اسبوع', f: () {
//                                     //                 controller.blockUser(
//                                     //                     controller.userInRoom["data"]
//                                     //                         [index]["username"],
//                                     //                     4);
//                                     //               }),
//                                     //               usersPopUpMenu('شهر', f: () {
//                                     //                 controller.blockUser(
//                                     //                     controller.userInRoom["data"]
//                                     //                         [index]["username"],
//                                     //                     5);
//                                     //               }),
//                                     //               usersPopUpMenu('دائم', f: () {
//                                     //                 controller.blockUser(
//                                     //                     controller.userInRoom["data"]
//                                     //                         [index]["username"],
//                                     //                     6);
//                                     //               }),
//                                     //             ],
//                                     //           ),
//                                     //         ),
//                                     //         usersPopUpMenu('إيقاف'),
//                                     //         !isOwner
//                                     //             ? usersPopUpMenu('إرسال تحذير')
//                                     //             : null,
//                                     //         usersPopUpMenu('مسح النص للجميع'),
//
//                                     //         // usersPopUpMenu('دائم'),
//                                     //       ],
//                                     //     ),
//                                     //   )
//                                     // else
//                                     //   null,
//                                   ],
//                                 ),
//                               );
//                       })),
//             ),
//
//             // appBar:
//             body: Stack(
//               children: [
//                 // Image.network(
//                 //   roomBackgroundImagesURL +
//                 //       Get.arguments['room_id'] +
//                 //       ".jpeg",
//                 //   height: double.infinity,
//                 //   width: double.infinity,
//                 //   fit: BoxFit.fill,
//                 //   errorBuilder: (context, error, stackTrace) => SizedBox(),
//                 // ),
//                 Column(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         children: [
//                           // GetBuilder<RoomsPageController>(
//                           //     init: RoomsPageController(),
//                           //     builder: (controller) {
//                           //       return Container(
//                           //         height: 70.h,
//                           //         decoration: BoxDecoration(
//                           //           // LinearGradient
//                           //           gradient: controller.roomStatus
//                           //               ? LinearGradient(
//                           //                   colors: [
//                           //                     Color(0xFFFFFFFF),
//                           //                     Color(0xFFA2ACAC),
//                           //                   ],
//                           //                   begin: Alignment.centerLeft,
//                           //                   end: Alignment.centerRight,
//                           //                 )
//                           //               : LinearGradient(
//                           //                   colors: [
//                           //                     Color(0xFFFFFFFF),
//                           //                     Color(0xFFFABD63),
//                           //                   ],
//                           //                   begin: Alignment.centerLeft,
//                           //                   end: Alignment.centerRight,
//                           //                 ),
//                           //         ),
//                           //         child: Row(
//                           //           children: [
//                           //             SizedBox(
//                           //               width: 21.w,
//                           //             ),
//                           //             isOwner
//                           //                 ? SizedBox(
//                           //                     width: 65.w,
//                           //                   )
//                           //                 : GestureDetector(
//                           //                     onTap: () {
//                           //                       // Get.toNamed('/VIPRoom');
//                           //                       controller.changeRoomStatus();
//                           //                     },
//                           //                     child: SizedBox(
//                           //                       width: 65.w,
//                           //                       child: Container(
//                           //                         padding:
//                           //                             EdgeInsets.symmetric(
//                           //                                 vertical: 5.h),
//                           //                         decoration: BoxDecoration(
//                           //                           borderRadius:
//                           //                               BorderRadius.circular(
//                           //                                   20.r),
//                           //                           color: controller
//                           //                                   .roomStatus
//                           //                               ? Color(0xffF792F0)
//                           //                               : Color(0xFFFABD63),
//                           //                         ),
//                           //                         child: Text(
//                           //                           controller.roomStatus
//                           //                               ? 'الروم الحديث'
//                           //                               : "مظهر قديم",
//                           //                           textAlign:
//                           //                               TextAlign.center,
//                           //                           style: TextStyle(
//                           //                               fontSize: 9.sp,
//                           //                               fontFamily: "Portada",
//                           //                               color: Colors.white),
//                           //                         ),
//                           //                       ),
//                           //                     ),
//                           //                   ),
//                           //             SizedBox(
//                           //               width: 50.w,
//                           //             ),
//                           //             GetBuilder<VoiceController>(
//                           //                 init: VoiceController(),
//                           //                 builder: (controller) {
//                           //                   return Text(
//                           //                       controller
//                           //                           .formatSecondsToTime(
//                           //                               controller
//                           //                                   .currentTime),
//                           //                       style: TextStyle(
//                           //                           fontSize: 9.sp,
//                           //                           fontFamily: "Portada",
//                           //                           color: Colors.black));
//                           //                 }),
//                           //             SizedBox(
//                           //               width: 10.w,
//                           //             ),
//                           //             SizedBox(
//                           //               width: 240.w,
//                           //               child: StreamBuilder(
//                           //                   stream: controller
//                           //                       .membersController.stream,
//                           //                   builder: (context, snapshot) {
//                           //                     return snapshot.data != null
//                           //                         ? ListView.builder(
//                           //                             shrinkWrap: true,
//                           //                             scrollDirection:
//                           //                                 Axis.horizontal,
//                           //                             itemBuilder:
//                           //                                 (context, index) {
//                           //                               return Padding(
//                           //                                 padding: EdgeInsets
//                           //                                     .symmetric(
//                           //                                         horizontal:
//                           //                                             8.w),
//                           //                                 child: Column(
//                           //                                   children: [
//                           //                                     ClipRRect(
//                           //                                       borderRadius:
//                           //                                           BorderRadius
//                           //                                               .circular(
//                           //                                                   50.r),
//                           //                                       child:
//                           //                                           Container(
//                           //                                         padding: EdgeInsets
//                           //                                             .all(10
//                           //                                                 .sp),
//                           //                                         color: Colors
//                           //                                             .white,
//                           //                                         child: Icon(
//                           //                                           Icons
//                           //                                               .person,
//                           //                                           color: Colors
//                           //                                               .black,
//                           //                                           size:
//                           //                                               24.sp,
//                           //                                         ),
//                           //                                       ),
//                           //                                     ),
//                           //                                     Text(
//                           //                                       snapshot.data[
//                           //                                               index]
//                           //                                               [
//                           //                                               "name"]
//                           //                                           .toString(),
//                           //                                       style: TextStyle(
//                           //                                           color: Colors
//                           //                                               .black),
//                           //                                     ),
//                           //                                   ],
//                           //                                 ),
//                           //                               );
//                           //                             },
//                           //                             itemCount: snapshot
//                           //                                 .data.length,
//                           //                           )
//                           //                         : SizedBox();
//                           //                   }),
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       );
//                           //     }),
//                           GetBuilder<RoomsPageController>(
//                               init: RoomsPageController(),
//                               builder: (controller) {
//                                 return Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       // LinearGradient
//                                       gradient: controller.roomStatus
//                                           ? null
//                                           : LinearGradient(
//                                               colors: [
//                                                 Color(0xFFFABD63),
//                                                 Color(0xFFFABB64),
//                                                 Color(0xFFF792F0),
//                                               ],
//                                               begin: Alignment.centerRight,
//                                               end: Alignment.centerLeft,
//                                             ),
//                                     ),
//                                     // child: Container(),
//                                     child: FutureBuilder(
//                                         future: controller.getData(),
//                                         builder: (context, snapshot) {
//                                           return StreamBuilder(
//                                             stream: controller
//                                                 .streamController.stream,
//                                             builder: (context, snapshot) {
//                                               // print(snapshot.data.length);
//                                               return snapshot.hasData
//                                                   ? NotificationListener(
//                                                       onNotification:
//                                                           (ScrollNotification
//                                                               scrollInfo) {
//                                                         scrollInfo.metrics
//                                                                     .pixels >
//                                                                 80
//                                                             ? controller
//                                                                 .scrollDownButtonStatus(
//                                                                     false)
//                                                             : controller
//                                                                 .scrollDownButtonStatus(
//                                                                     true);
//                                                       },
//                                                       child: ListView.builder(
//                                                         controller: controller
//                                                             .scrollController,
//                                                         reverse: true,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           if (snapshot.data[
//                                                                           "data"]
//                                                                       [index][
//                                                                   "senderName"] ==
//                                                               "roomAlert") {
//                                                             return snapshot
//                                                                     .data["data"]
//                                                                         [index][
//                                                                         "message"]
//                                                                     .toString()
//                                                                     .contains(
//                                                                         userName)
//                                                                 ? SizedBox()
//                                                                 : joinAndLeaveAlert(
//                                                                     controller
//                                                                         .roomStatus,
//                                                                     snapshot.data["data"][index]["joinOrLeave"] == "0"
//                                                                         ? true
//                                                                         : false,
//                                                                     snapshot
//                                                                         .data["data"]
//                                                                             [index][
//                                                                             "senderName"]
//                                                                         .toString(),
//                                                                     snapshot
//                                                                         .data["data"]
//                                                                             [index]
//                                                                             ["message"]
//                                                                         .toString());
//                                                           } else if (snapshot.data[
//                                                                           "data"]
//                                                                       [index][
//                                                                   "senderName"] ==
//                                                               "roomWelcome") {
//                                                             return !controller
//                                                                     .roomStatus
//                                                                 ? SizedBox()
//                                                                 : snapshot.data[
//                                                                             "data"]
//                                                                             [
//                                                                             index]
//                                                                             [
//                                                                             "message"]
//                                                                         .toString()
//                                                                         .contains(
//                                                                             userName)
//                                                                     ? Column(
//                                                                         children: [
//                                                                           Container(
//                                                                               width: double.infinity,
//                                                                               padding: EdgeInsets.all(10.sp),
//                                                                               decoration: BoxDecoration(
//                                                                                 color: Colors.black12,
//                                                                                 border: Border.symmetric(
//                                                                                     vertical: BorderSide(
//                                                                                   color: Color(0xFFFFFFD9),
//                                                                                   width: 5.w,
//                                                                                 )),
//                                                                               ),
//                                                                               child: AnimatedTextKit(
//                                                                                 animatedTexts: [
//                                                                                   TypewriterAnimatedText(
//                                                                                     // Get.arguments.toString(),
//                                                                                     snapshot.data["data"][index]["message"].toString().substring(
//                                                                                           0,
//                                                                                           snapshot.data["data"][index]["message"].toString().indexOf(userName),
//                                                                                         ),
//                                                                                     textAlign: TextAlign.center,
//                                                                                     textStyle: TextStyle(
//                                                                                       fontSize: 33.sp,
//                                                                                       color: Colors.black,
//                                                                                       fontWeight: FontWeight.bold,
//                                                                                     ),
//                                                                                     speed: const Duration(milliseconds: 100),
//                                                                                   ),
//                                                                                 ],
//                                                                                 // totalRepeatCount: 4,
//                                                                                 // pause: const Duration(milliseconds: 1000),
//                                                                                 displayFullTextOnTap: false,
//
//                                                                                 // stopPauseOnTap: true,
//                                                                                 isRepeatingAnimation: false,
//                                                                               )),
//                                                                           SizedBox(
//                                                                             height:
//                                                                                 10.h,
//                                                                           ),
//                                                                           Padding(
//                                                                             padding:
//                                                                                 EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
//                                                                             child:
//                                                                                 Container(
//                                                                               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//                                                                               width: double.infinity,
//                                                                               decoration: BoxDecoration(
//                                                                                 color: Color(0xFFFFFFD9),
//                                                                                 borderRadius: BorderRadius.circular(10.r),
//                                                                                 border: Border.all(
//                                                                                   //#BABABA
//                                                                                   color: Color(0xFFBABABA),
//                                                                                   width: 1.w,
//                                                                                 ),
//                                                                               ),
//                                                                               child: Text(
//                                                                                 snapshot.data["data"][index]["message"],
//                                                                                 textAlign: TextAlign.center,
//                                                                                 style: TextStyle(
//                                                                                   color: Colors.black,
//                                                                                   fontSize: 12.sp,
//                                                                                   fontFamily: "Segoe UI",
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       )
//                                                                     : SizedBox();
//                                                           } else {
//                                                             if (controller
//                                                                 .roomStatus) {
//                                                               return messageBuilder(
//                                                                   context:
//                                                                       context,
//                                                                   data: snapshot
//                                                                               .data[
//                                                                           "data"]
//                                                                       [index],
//                                                                   guest: snapshot.data["data"][index]
//                                                                               [
//                                                                               "isGuest"] ==
//                                                                           "0"
//                                                                       ? true
//                                                                       : false);
//                                                             } else {
//                                                               return GestureDetector(
//                                                                 onTap: () {
//                                                                   print("dd");
//                                                                 },
//                                                                 child: messageVIPBuilder(
//                                                                     context,
//                                                                     snapshot.data[
//                                                                             "data"]
//                                                                         [index],
//                                                                     snapshot.data["data"][index]["isGuest"] ==
//                                                                             "0"
//                                                                         ? true
//                                                                         : false),
//                                                               );
//                                                             }
//                                                           }
//                                                         },
//                                                         itemCount: snapshot
//                                                             .data["data"]
//                                                             .length,
//                                                         // itemCount: 1,
//                                                       ),
//                                                     )
//                                                   : Center(
//                                                       child:
//                                                           CircularProgressIndicator());
//                                             },
//                                           );
//                                         }),
//                                   ),
//                                 );
//                               }),
//                         ],
//                       ),
//                     ),
//                     buildMyNavBar(context),
//                     emojiPickerBuilder()
//                   ],
//                 ),
//                 // GetBuilder<VoiceController>(
//                 //     init: VoiceController(),
//                 //     builder: (controller) {
//                 //       return !controller.micWidget
//                 //           ? SizedBox()
//                 //           : Positioned(
//                 //               bottom: 73.h,
//                 //               left: 0.w,
//                 //               child: Container(
//                 //                 height: 80.h,
//                 //                 width: 250.w,
//                 //                 decoration: BoxDecoration(
//                 //                     color: Colors.white,
//                 //                     borderRadius: BorderRadius.circular(15.r),
//                 //                     boxShadow: [
//                 //                       BoxShadow(
//                 //                         color: Colors.grey.withOpacity(0.5),
//                 //                         spreadRadius: 0,
//                 //                         blurRadius: 10.r,
//                 //                         offset: Offset(0,
//                 //                             3), // changes position of shadow
//                 //                       ),
//                 //                     ]),
//                 //                 child: Row(
//                 //                   mainAxisAlignment:
//                 //                       MainAxisAlignment.spaceEvenly,
//                 //                   crossAxisAlignment:
//                 //                       CrossAxisAlignment.center,
//                 //                   children: [
//                 //                     GestureDetector(
//                 //                       onTap: () {
//                 //                         // controller.join();
//                 //                         // controller.checkIfUserIsJoined();
//                 //                         // controller.checkIfUserIsJoined();
//                 //                         // controller.joinLeaveCalls();
//                 //                       },
//                 //                       onDoubleTap: () {
//                 //                         controller.leave();
//                 //                         // controller.timer.cancel();
//                 //                       },
//                 //                       onLongPress: () {
//                 //                         // controller.checkIfUserIsJoined();
//                 //                       },
//                 //                       child: Column(
//                 //                         mainAxisAlignment:
//                 //                             MainAxisAlignment.center,
//                 //                         children: [
//                 //                           Center(
//                 //                             child: Icon(
//                 //                               Icons.mic,
//                 //                               color: Colors.black,
//                 //                             ),
//                 //                           ),
//                 //                           Text(
//                 //                             "التحدث",
//                 //                             style: TextStyle(
//                 //                                 fontSize: 12.sp,
//                 //                                 color: Colors.black),
//                 //                           )
//                 //                         ],
//                 //                       ),
//                 //                     ),
//                 //                     GestureDetector(
//                 //                       onTap: () {
//                 //                         controller.toggleMic();
//                 //                         // controller.micStatus();
//                 //                         // controller.leave();
//                 //                         // controller.checkIfUserIsJoined();
//                 //                       },
//                 //                       child: Column(
//                 //                         mainAxisAlignment:
//                 //                             MainAxisAlignment.center,
//                 //                         children: [
//                 //                           Center(
//                 //                             child: Icon(
//                 //                               Icons.mic_off,
//                 //                               color: Colors.black,
//                 //                             ),
//                 //                           ),
//                 //                           Text(
//                 //                             "كتم المايك",
//                 //                             style: TextStyle(
//                 //                                 fontSize: 12.sp,
//                 //                                 color: Colors.black),
//                 //                           )
//                 //                         ],
//                 //                       ),
//                 //                     ),
//                 //                     GestureDetector(
//                 //                       onTap: () {
//                 //                         // controller.agoraEngineVideo
//                 //                         //     .disableVideo();
//                 //                       },
//                 //                       child: Column(
//                 //                         mainAxisAlignment:
//                 //                             MainAxisAlignment.center,
//                 //                         children: [
//                 //                           Center(
//                 //                             child: Icon(
//                 //                               Icons.music_note,
//                 //                               color: Colors.black,
//                 //                             ),
//                 //                           ),
//                 //                           Text(
//                 //                             "موسيقي",
//                 //                             style: TextStyle(
//                 //                                 fontSize: 12.sp,
//                 //                                 color: Colors.black),
//                 //                           )
//                 //                         ],
//                 //                       ),
//                 //                     ),
//                 //                   ],
//                 //                 ),
//                 //               ),
//                 //             );
//                 //     }),
//
//                 GetBuilder<VideoController>(
//                     init: VideoController(),
//                     builder: (controller) {
//                       return controller.cameraWidget
//                           ? SizedBox()
//                           : Positioned(
//                               bottom: 73.h,
//                               left: 0.w,
//                               child: Container(
//                                 height: 80.h,
//                                 width: 180.w,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(15.r),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.5),
//                                         spreadRadius: 0,
//                                         blurRadius: 10.r,
//                                         offset: Offset(
//                                             0, 3), // changes position of shadow
//                                       ),
//                                     ]),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         // controller.checkIfUserIsJoined();
//                                         // controller.join();
//                                         // controller.enterOrLeaveQueue();
//                                         // controller.cameraToggle();
//                                         if (controller.joinedAsAdmin ||
//                                             controller.joinedAsViwer) {
//                                           if (controller.joinedAsAdmin) {
//                                             controller.leaveAsAdmin();
//                                           } else {
//                                             controller.leaveAsViewer();
//                                           }
//                                         } else {
//                                           controller.joinAsAdmin();
//                                         }
//
//                                         // controller.join();
//
//                                         // if (controller.inCall) {
//                                         //   controller.leave();
//                                         // } else {
//                                         //   controller.join();
//                                         // }
//                                         // controller.enterQueue();
//                                         // if (controller.isHost) {
//                                         //   controller.checkIfUserIsJoined();
//                                         // } else {
//                                         //   controller.enterQueue();
//                                         // }
//                                       },
//                                       onDoubleTap: () {
//                                         // controller.joinAsViewer();
//                                         // controller.leave();
//                                         // controller.leaveQueue(userName);
//                                       },
//                                       onLongPress: () {
//                                         // controller.leave();
//                                       },
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Center(
//                                             child: Icon(
//                                               Icons.videocam_sharp,
//                                               color: Colors.red,
//                                             ),
//                                           ),
//                                           Text(
//                                             "الكاميرا",
//                                             style: TextStyle(
//                                               fontSize: 12.sp,
//                                               color: Colors.black,
//                                               fontFamily: 'Segoe UI',
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         // controller.leaveVideoChannel();
//                                         // controller.leave();
//                                         controller.sendImage();
//                                       },
//                                       onDoubleTap: () {
//                                         // controller.leave();
//                                       },
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Center(
//                                             child: Icon(
//                                               Icons.photo_library,
//                                               color: Colors.green,
//                                             ),
//                                           ),
//                                           Text(
//                                             "إرسال صورة",
//                                             style: TextStyle(
//                                               fontSize: 12.sp,
//                                               color: Colors.black,
//                                               fontFamily: 'Segoe UI',
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                     }),
//                 GetBuilder<VideoController>(
//                   init: VideoController(),
//                   builder: (controller) => StreamBuilder(
//                       // stream: Stream.periodic(Duration(seconds: 2), (i) {
//                       //   return controller.getvideoRequest();
//                       // }),
//                       builder: (context, snapshot) {
//                     return Positioned(
//                       right: 0,
//                       child: SizedBox(
//                         width: 151.w,
//                         height: 130.h,
//                         child: controller.videoPanel(),
//                       ),
//                     );
//                   }),
//                 ),
//                 GetBuilder<RoomsPageController>(
//                   builder: (c) => AnimatedPositioned(
//                     duration: Duration(seconds: 2),
//                     left: c.isVisible
//                         ? MediaQuery.of(context).size.width / 2 - 50
//                         : -100,
//                     // right: c.isVisible ? MediaQuery.of(context).size.width / 2 - 50 : -100,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       color: Colors.blue,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             floatingActionButton: GetBuilder<RoomsPageController>(
//               builder: (controller) {
//                 return controller.scrollDownButton
//                     ? SizedBox()
//                     : Padding(
//                         padding: EdgeInsets.only(
//                             bottom: 60.h, right: 5.w, left: 10.w),
//                         child: GestureDetector(
//                           onTap: () {
//                             controller.scrollController.animateTo(0,
//                                 duration: Duration(seconds: 1),
//                                 curve: Curves.easeIn);
//                           },
//                           child: Container(
//                             // width: 148.w,
//                             constraints: BoxConstraints(
//                               maxWidth: Get.width * 0.35,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.r),
//                               gradient: !controller.roomStatus
//                                   ? LinearGradient(
//                                       colors: [
//                                         Color(0xFF00E54C),
//                                         Color(0xFFDADADC),
//                                       ],
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                     )
//                                   : LinearGradient(
//                                       colors: [
//                                         Color(0xFFF792F0),
//                                         Color(0xFFFABD63),
//                                       ],
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                     ),
//                             ),
//                             padding: EdgeInsets.symmetric(horizontal: 8.w),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(bottom: 7.h),
//                                   child: RotatedBox(
//                                     quarterTurns: 3,
//                                     child: Icon(
//                                       Icons.arrow_back_ios,
//                                       size: 20.sp,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "الرسائل الجديدة",
//                                     style: TextStyle(
//                                       fontSize: 14.sp,
//                                       fontFamily: 'Segoe UI',
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//               },
//             ),
//             // bottomNavigationBar: ,
//           ),
//         ),
//       ),
//     );
//   }
//
//   PopupMenuItem<String> statusBuilder(String title, {Widget icon}) {
//     return PopupMenuItem(
//         height: 40.h,
//         // padding: EdgeInsets.zero,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black),
//             ),
//             icon
//           ],
//         ),
//         value: title);
//   }
//
//   Widget emojiPickerBuilder() {
//     return GetBuilder<RoomsPageController>(builder: (controller) {
//       return Offstage(
//         offstage: controller.emojiStatus,
//         child: SizedBox(
//           height: 300.h,
//           child: EmojiPicker(
//             onEmojiSelected: (Category category, Emoji emoji) {
//               // Do something when emoji is tapped (optional)
//             },
//             onBackspacePressed: () {
//               // Do something when the user taps the backspace button (optional)
//               // Set it to null to hide the Backspace-Button
//             },
//             textEditingController: controller
//                 .messageController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
//             config: Config(
//               columns: 7,
//               emojiSizeMax: 32 *
//                   (foundation.defaultTargetPlatform == TargetPlatform.iOS
//                       ? 1.30
//                       : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
//               verticalSpacing: 0,
//               horizontalSpacing: 0,
//               gridPadding: EdgeInsets.zero,
//               initCategory: Category.RECENT,
//               bgColor: Color(0xFFF2F2F2),
//               indicatorColor: Colors.blue,
//               iconColor: Colors.grey,
//               iconColorSelected: Colors.blue,
//               backspaceColor: Colors.blue,
//               skinToneDialogBgColor: Colors.white,
//               skinToneIndicatorColor: Colors.grey,
//               enableSkinTones: true,
//               recentTabBehavior: RecentTabBehavior.RECENT,
//               recentsLimit: 28,
//               noRecents: const Text(
//                 'No Recents',
//                 style: TextStyle(fontSize: 20, color: Colors.black26),
//                 textAlign: TextAlign.center,
//               ), // Needs to be const Widget
//               loadingIndicator:
//                   const SizedBox.shrink(), // Needs to be const Widget
//               tabIndicatorAnimDuration: kTabScrollDuration,
//               categoryIcons: const CategoryIcons(),
//               buttonMode: ButtonMode.MATERIAL,
//             ),
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget userInCall() {
//     return SizedBox(
//       width: 50.w,
//       height: 50.h,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(50.r),
//         child: Container(
//           padding: EdgeInsets.all(10.sp),
//           color: Colors.white,
//           child: Icon(
//             Icons.lock,
//             color: Colors.black,
//             size: 24.sp,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget buildMyNavBar(BuildContext context) {
//   // return Container(
//   //   height: 71.h,
//   //   decoration: const BoxDecoration(
//   //     // LinearGradient
//   //     gradient: LinearGradient(
//   //       colors: [
//   //         const Color(0xFFF792F0),
//   //         const Color(0xFFFABD63),
//   //       ],
//   //       begin: Alignment.bottomCenter,
//   //       end: Alignment.topCenter,
//   //     ),
//   //   ),
//   //   child: Row(
//   //     children: [
//   //       Expanded(
//   //         flex: 2,
//   //         child: GetBuilder<RoomsPageController>(builder: (controller) {
//   //           return Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //             children: [
//   //               !controller.messageStatus
//   //                   ? RotatedBox(
//   //                       quarterTurns: 2,
//   //                       child: GestureDetector(
//   //                         onTap: () {
//   //                           controller.sendMessage(
//   //                               controller.messageController.text);
//   //                         },
//   //                         child: Icon(
//   //                           Icons.send,
//   //                           color: Colors.white,
//   //                           size: 25.sp,
//   //                         ),
//   //                       ),
//   //                     )
//   //                   : SizedBox(
//   //                       width: 20.w,
//   //                       height: 20.h,
//   //                       child: CircularProgressIndicator(
//   //                         color: Colors.white,
//   //                         strokeWidth: 2,
//   //                         // valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//   //                       ),
//   //                     ),
//   //               GestureDetector(
//   //                 onTap: () {
//   //                   controller.changeEmojiStatus(!controller.emojiStatus);
//   //                 },
//   //                 child: Text(
//   //                   "🙂",
//   //                   style: TextStyle(fontSize: 25.sp),
//   //                 ),
//   //               ),
//   //             ],
//   //           );
//   //         }),
//   //       ),
//   //       Expanded(
//   //         flex: 7,
//   //         child: SizedBox(
//   //           height: 40.h,
//   //           child: Directionality(
//   //             textDirection: TextDirection.rtl,
//   //             child: GetBuilder<RoomsPageController>(
//   //               builder: (controller) {
//   //                 return TextFormField(
//   //                   cursorColor: Colors.black,
//   //                   controller: controller.messageController,
//   //                   style: TextStyle(
//   //                     color: Colors.black, //Color(0xff9A8B8B),
//   //                     fontSize: 14.sp,
//   //                     fontFamily: "Portada",
//   //                   ),
//   //                   // expands: true,
//   //                   maxLines: 1,
//   //                   onFieldSubmitted: (value) => controller
//   //                       .sendMessage(controller.messageController.text),
//   //                   onTapOutside: (event) => FocusScope.of(context).unfocus(),
//   //                   onTap: () {
//   //                     if (!controller.emojiStatus) {
//   //                       controller.changeEmojiStatus(true);
//   //                     }
//   //                   },
//   //                   decoration: InputDecoration(
//   //                     contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
//   //                     hintText: 'اكتب رسالة',
//   //                     hintStyle: TextStyle(
//   //                       fontSize: 12.sp,
//   //                       fontFamily: "Portada",
//   //                     ),
//   //                     border: OutlineInputBorder(
//   //                         borderSide: BorderSide.none,
//   //                         borderRadius: BorderRadius.circular(50.r)),
//   //                     filled: true,
//   //                     fillColor: Colors.white, // Color(0xff00000029),
//   //                   ),
//   //                 );
//   //               },
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //       Expanded(
//   //         flex: 2,
//   //         child: Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //           children: [
//   //             GetBuilder<VideoController>(
//   //                 init: VideoController(),
//   //                 builder: (controller) {
//   //                   return GestureDetector(
//   //                     onTap: () {
//   //                       controller.toggleCamera();
//   //                     },
//   //                     child: Icon(
//   //                       Icons.add_circle_outline,
//   //                       size: 25.sp,
//   //                     ),
//   //                   );
//   //                 }),
//   //             GetBuilder<VoiceController>(
//   //                 init: VoiceController(),
//   //                 builder: (controller) {
//   //                   return GestureDetector(
//   //                     onTap: () {
//   //                       // controller.join();
//   //                       controller.toogleMic();
//   //                     },
//   //                     child: Icon(
//   //                       Icons.mic,
//   //                       size: 25.sp,
//   //                     ),
//   //                   );
//   //                 }),
//   //           ],
//   //         ),
//   //       ),
//   //     ],
//   //   ),
//   // );
//   // }
//
//   Widget messageBuilder({BuildContext context, dynamic data, bool guest}) {
//     return GestureDetector(
//       onLongPressStart: (LongPressStartDetails details) {
//         showMenu(
//           context: context,
//           position: RelativeRect.fromLTRB(
//             details.globalPosition.dx,
//             details.globalPosition.dy,
//             details.globalPosition.dx,
//             0,
//           ),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20.r))),
//           items: <PopupMenuEntry>[
//             data["image"] != "1"
//                 ? PopupMenuItem<String>(
//                     onTap: () {
//                       Clipboard.setData(ClipboardData(text: data['message']));
//                       // Get.back();
//                     },
//                     // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w),
//                     value: '',
//                     child: Center(
//                       child: Text(
//                         'نسخ',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   )
//                 : null,
//             PopupMenuDivider(height: 2),
//             data["userType"] == "3" ||
//                     data["userType"] == "2" ||
//                     data["userType"] == "1"
//                 //  ||Get.arguments["owner"] == userName
//                 ? PopupMenuItem<String>(
//                     onTap: () {
//                       // sj();
//                       var url = Uri.parse(deleteAllRoomMessages);
//                       http.post(url, body: {
//                         "roomId": Get.arguments["room_id"],
//                       });
//                     },
//                     value: '',
//                     child: Center(
//                       child: Text(
//                         'مسح النص للجميع',
//                         // Get.arguments["room_id"].toString(),
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   )
//                 : null,
//             PopupMenuDivider(),
//             data["senderName"] == userName
//                 ? PopupMenuItem<String>(
//                     onTap: () {
//                       //https://lametnachat.com/messages/deleteMessageInRoom.php
//                       var url = Uri.parse(deleteMessage);
//                       http.post(url, body: {
//                         "senderName": userName,
//                         "messageId": data["messageId"],
//                       });
//                     },
//                     padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w),
//                     value: '',
//                     child: Center(
//                       child: Text(
//                         'مسح النص',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   )
//                 : null,
//             PopupMenuDivider(),
//             PopupMenuItem<String>(
//               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 6.w),
//               value: '',
//               child: Center(
//                 child: Text(
//                   data["senderName"],
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             PopupMenuDivider(),
//             PopupMenuItem<String>(
//               padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
//               value: '',
//               child: Center(
//                 child: Text(
//                   "تبليغ",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//       child: guest
//           ? Padding(
//               padding: EdgeInsets.symmetric(vertical: 5.h),
//               child: Stack(
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         // height: 20.h,
//                         width: double.infinity,
//                         color: Color(0xFFCAF8ED),
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(
//                               data["senderName"] == guestUserName ||
//                                       data["senderName"] == userName
//                                   ? 0.w
//                                   : 55.w,
//                               5.h,
//                               data["senderName"] == userName ||
//                                       data["senderName"] == guestUserName
//                                   ? 55.w
//                                   : 0,
//                               5.h),
//                           child: Directionality(
//                             textDirection: data["senderName"] == userName
//                                 ? TextDirection.ltr
//                                 : TextDirection.rtl,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 SizedBox(
//                                     width: data["userType"] == 'VIP' ||
//                                             data["userType"] == 'VIPWithBG'
//                                         ? 45.w
//                                         : 10.w),
//                                 Text(
//                                   TimeOfDay.fromDateTime(
//                                           DateTime.parse(data['time']).add(
//                                               Duration(
//                                                   seconds: DateTime.now()
//                                                       .timeZoneOffset
//                                                       .inSeconds)))
//                                       .format(context)
//                                       .toString(),
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 data["userType"] == "protected" ||
//                                         data["userType"] == "protectedWithBG"
//                                     ? Icon(
//                                         Icons.verified,
//                                         color: Colors.blue,
//                                         size: 20.sp,
//                                       )
//                                     : data["userType"] == 'VIP' ||
//                                             data["userType"] == 'VIPWithBG'
//                                         ? Image.asset(
//                                             'assets/images/crown.png',
//                                             width: 20.sp,
//                                           )
//                                         : SizedBox(),
//                                 SizedBox(
//                                   width: 5.w,
//                                 ),
//                                 Stack(
//                                   children: [
//                                     Text(
//                                       data["senderName"].toString(),
//                                       style: TextStyle(
//                                         fontSize: 15.sp,
//                                         letterSpacing: 1.2,
//                                         // fontFamily:
//                                         //     "Portada",
//                                         overflow: TextOverflow.ellipsis,
//                                         fontWeight: FontWeight.w700,
//                                         foreground: Paint()
//                                           ..style = PaintingStyle.stroke
//                                           ..strokeWidth = 2
//                                           ..color = data["userType"] != "0" ||
//                                                   data["userType"] != "1" ||
//                                                   data["userType"] != "2"
//                                               ? Color(0xFFFAE635)
//                                               : Colors.transparent,
//                                       ),
//                                     ),
//                                     Text(
//                                       data[
//                                           "senderName"], // data["userType"]  data["senderName"]
//                                       textAlign: data["senderName"] == userName
//                                           ? TextAlign.right
//                                           : TextAlign.left,
//                                       style: TextStyle(
//                                         fontSize: 15.sp,
//                                         letterSpacing: 1.2,
//                                         fontWeight: FontWeight.bold,
//                                         color: data["userType"] == "0"
//                                             ? Color(0xFFF411EB)
//                                             : data["userType"] == "1"
//                                                 ? Color(0xFF3B00E1)
//                                                 : data["userType"] == "2"
//                                                     ? Color(0xFF11F435)
//                                                     : data["userType"] == "3"
//                                                         ? Color(0xFFFD6EB3)
//                                                         : Colors.black,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           if (data["image"] == "1") {
//                             // print("tapped");
//                             Get.toNamed("/viewImage", arguments: {
//                               "imageLink": imageSent + data["message"],
//                             });
//                           }
//                         },
//                         child: Container(
//                           // height: 50.h,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             // color: Colors.grey[300],
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color(0xFFF792F0),
//                                 Color(0xFFF1F1F1),
//                               ],
//                               begin: data["senderName"] == userName
//                                   ? Alignment.centerLeft
//                                   : Alignment.centerRight,
//                               end: data["senderName"] == userName
//                                   ? Alignment.centerRight
//                                   : Alignment.centerLeft,
//                             ),
//
//                             borderRadius: data["senderName"] == userName
//                                 ? BorderRadius.only(
//                                     bottomLeft: Radius.circular(20.r),
//                                   )
//                                 : BorderRadius.only(
//                                     bottomRight: Radius.circular(20.r),
//                                   ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.fromLTRB(
//                                 data["senderName"] == userName ? 20.w : 60.w,
//                                 9.h,
//                                 data["senderName"] == userName ? 60.w : 20.w,
//                                 9.h),
//                             child: data["image"] == "1"
//                                 ? Align(
//                                     alignment: data["senderName"] == userName
//                                         ? Alignment.centerRight
//                                         : Alignment.centerLeft,
//                                     // color: Colors.green,
//                                     child: Image.network(
//                                       imageSent + data["message"],
//                                       // width: 80,
//                                       // width: 80.w,
//                                       height: 130.h,
//                                       // fit: BoxFit.cover,
//                                     ),
//                                   )
//                                 : Text(
//                                     data["message"],
//                                     textAlign: data["senderName"] == userName
//                                         ? TextAlign.right
//                                         : TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: int.parse(data["fontSize"]).sp,
//                                       fontWeight: data["isBold"] == "1"
//                                           ? FontWeight.w800
//                                           : FontWeight.normal,
//                                       fontStyle: data["isItalic"] == "1"
//                                           ? FontStyle.italic
//                                           : FontStyle.normal,
//                                       color: Color(int.parse(
//                                               data["color"].substring(1, 7),
//                                               radix: 16) +
//                                           0xFF000000),
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Positioned(
//                     top: 3.h,
//                     left: data["senderName"] == userName ? null : 10.w,
//                     right: data["senderName"] == userName ? 10.w : null,
//                     child: Container(
//                       width: 35.w,
//                       height: 40.h,
//                       decoration: BoxDecoration(
//                         // color: const Color(0xff7c94b6),
//                         // image: DecorationImage(
//                         //   onError: (exception, stackTrace) => NetworkImage(
//                         //     "https://lametnachat.com/upload/imageUser/anonymous.jpg",
//                         //   ),
//                         //   image: NetworkImage(
//                         //       "https://lametnachat.com/upload/imageUser/" +
//                         //           data["userImage"]),
//                         // fit: BoxFit.cover,
//                         // ),
//                         borderRadius: BorderRadius.all(Radius.circular(50.0)),
//                         border: Border.all(
//                           color: Color(0xff43D0CA),
//                           width: 1.5,
//                         ),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(360.r),
//                         child: Image.network(
//                           imageURL + data["senderName"] + ".jpeg",
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Image.network(
//                             "https://lametnachat.com/upload/imageUser/anonymous.jpg",
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   data["userType"] == "VIP"
//                       ? Positioned(
//                           top: -7.h,
//                           // right: isMe ? 10.w : null,
//                           left: data["senderName"] == userName ? 10.w : null,
//                           right: data["senderName"] == userName ? null : 10.w,
//                           // right: isMe ? null : 10.w,
//                           child: Image.asset(
//                             "assets/images/vipBadge.png",
//                             width: 28.w,
//                             height: 60.h,
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                       : data["userType"] == "VIPWithBG"
//                           ? Positioned(
//                               top: -7.h,
//                               // right: isMe ? 10.w : null,
//                               left:
//                                   data["senderName"] == userName ? 10.w : null,
//                               right:
//                                   data["senderName"] == userName ? null : 10.w,
//                               // right: isMe ? null : 10.w,
//                               child: Image.asset(
//                                 "assets/images/vip.png",
//                                 width: 28.w,
//                                 height: 60.h,
//                                 fit: BoxFit.cover,
//                               ),
//                             )
//                           : SizedBox()
//                 ],
//               ),
//             )
//           : Padding(
//               padding: EdgeInsets.symmetric(vertical: 5.h),
//               child: Column(
//                 children: [
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//                     width: double.infinity,
//                     color: Color(0xFFCAF8ED),
//                     child: Directionality(
//                       textDirection: data["senderName"] == userName ||
//                               data["senderName"] == guestUserName
//                           ? TextDirection.rtl
//                           : TextDirection.ltr,
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 25.w,
//                             height: 27.h,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(50.0)),
//                               border: Border.all(
//                                 color: Colors.black,
//                                 width: 1.5,
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.person,
//                               color: Colors.black,
//                               size: 20.sp,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5.w,
//                           ),
//                           Text(
//                             data["senderName"],
//                             textAlign: data["senderName"] == userName ||
//                                     data["senderName"] == guestUserName
//                                 ? TextAlign.right
//                                 : TextAlign.left,
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             TimeOfDay.fromDateTime(DateTime.parse(data['time'])
//                                     .add(Duration(
//                                         seconds: DateTime.now()
//                                             .timeZoneOffset
//                                             .inSeconds)))
//                                 .format(context)
//                                 .toString(),
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     // height: 50.h,
//                     width: double.infinity,
//                     decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                       BoxShadow(
//                         color: Color(0xff00000029).withOpacity(0.2),
//                         offset: Offset(0, 3),
//                         spreadRadius: 1,
//                         blurRadius: 6,
//                       )
//                     ]),
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(
//                           data["senderName"] == userName ||
//                                   data["senderName"] == guestUserName
//                               ? 0.w
//                               : 60.w,
//                           9.h,
//                           data["senderName"] == userName ||
//                                   data["senderName"] == guestUserName
//                               ? 60.w
//                               : 0.w,
//                           9.h),
//                       child: Text(
//                         data["message"],
//                         textAlign: data["senderName"] == userName ||
//                                 data["senderName"] == guestUserName
//                             ? TextAlign.right
//                             : TextAlign.left,
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
//
//   Widget messageVIPBuilder(BuildContext context, dynamic data, bool guest) {
//     return data["isGuest"] == "0"
//         ? Padding(
//             padding: EdgeInsets.only(bottom: 7.h),
//             child: Directionality(
//               textDirection: TextDirection.rtl,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     children: [
//                       // Container(
//                       //   decoration: BoxDecoration(
//                       //     borderRadius: BorderRadius.circular(50.r),
//                       //     color: Colors.white,
//                       //     image: DecorationImage(
//
//                       //       image: NetworkImage(
//                       //         imageURL +
//                       //             (data["senderName"] + ".jpeg").toString(),
//                       //       ),
//                       //       fit: BoxFit.cover,
//                       //     ),
//                       //   ),
//                       // ),
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(360.r),
//                             child: Image.network(
//                               imageURL +
//                                   (data["senderName"] + ".jpeg").toString(),
//                               errorBuilder: (context, error, stackTrace) =>
//                                   Image.network(
//                                 "https://lametnachat.com/upload/imageUser/anonymous.jpg",
//                                 width: 50.w,
//                                 height: 50.h,
//                                 fit: BoxFit.cover,
//                               ),
//                               width: 50.w,
//                               height: 50.h,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Image.asset(
//                             "assets/images/badge4.png",
//                             width: 70.w,
//                             height: 70.h,
//                             // fit: BoxFit.cover,
//                           ),
//                         ],
//                       ),
//                       // Text(data["senderName"])
//                       Stack(
//                         children: [
//                           // Implement the stroke
//                           Text(
//                             data["senderName"].toString(),
//                             style: TextStyle(
//                               fontSize: 12,
//                               // letterSpacing: 5,
//                               fontWeight: FontWeight.bold,
//                               foreground: Paint()
//                                 ..style = PaintingStyle.stroke
//                                 ..strokeWidth = 2
//                                 ..color = Colors.red,
//                             ),
//                           ),
//                           // The text inside
//                           Text(
//                             data["senderName"].toString(),
//                             style: TextStyle(
//                               fontSize: 12,
//                               // letterSpacing: 5,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.amber,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                   Container(
//                     width: Get.width * .70,
//                     padding: EdgeInsets.all(15.sp),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         color: Color(0xFFFBF205),
//                         width: 4,
//                       ),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.r),
//                         bottomLeft: Radius.circular(20.r),
//                         bottomRight: Radius.circular(20.r),
//                       ),
//                     ),
//                     child: data["image"] == "1"
//                         ? Align(
//                             alignment: data["senderName"] == userName
//                                 ? Alignment.centerRight
//                                 : Alignment.centerLeft,
//                             child: Image.network(
//                               imageSent + data["message"],
//                               // width: 80,
//                               height: 130.h,
//                               // fit: BoxFit.cover,
//                             ),
//                           )
//                         : Text(
//                             data["message"],
//                             // "",
//                             style: TextStyle(
//                               fontSize: int.parse(data["fontSize"]).sp,
//                               fontWeight: data["isBold"] == "1"
//                                   ? FontWeight.w800
//                                   : FontWeight.normal,
//                               fontStyle: data["isItalic"] == "1"
//                                   ? FontStyle.italic
//                                   : FontStyle.normal,
//                               fontFamily: "Portada",
//                               color: Color(int.parse(
//                                       data["color"].substring(1, 7),
//                                       radix: 16) +
//                                   0xFF000000),
//                               // color: Colors.black,
//                               // fontFamily: "Portada",
//                               // fontSize: 12.sp,
//                             ),
//                           ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         : Padding(
//             padding: EdgeInsets.only(bottom: 7.h, right: 5.w),
//             child: Directionality(
//               textDirection: TextDirection.rtl,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       //  Icon(Icons),
//                       CircleAvatar(
//                         backgroundColor: Color(0xFF2CCFB6),
//                         child: Text(
//                           data["senderName"]
//                               .toString()
//                               .substring(0, 1)
//                               .toUpperCase(),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ), //////error
//                       SizedBox(width: 10.w),
//                       Text(
//                         data["senderName"],
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: "Portada",
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12.sp,
//                         ),
//                       )
//                     ],
//                   ),
//                   Container(
//                     width: Get.width * .70,
//                     padding: EdgeInsets.all(15.sp),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       // border: Border.all(
//                       //   color: Color(0xFFFBF205),
//                       //   width: 4,
//                       // ),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.r),
//                         bottomLeft: Radius.circular(20.r),
//                         // topRight: Radius.circular(20.r),
//                         bottomRight: Radius.circular(20.r),
//                       ),
//                     ),
//                     child: Text(
//                       data["message"],
//                       style: TextStyle(
//                         // fontSize: int.parse(data["fontSize"]).sp,
//                         //             fontWeight: data["isBold"] == "1"
//                         //                 ? FontWeight.w800
//                         //                 : FontWeight.normal,
//                         //             fontStyle: data["isItalic"] == "1"
//                         //                 ? FontStyle.italic
//                         //                 : FontStyle.normal,
//                         //             fontFamily: "Portada",
//                         // color: Color(int.parse(data["color"].substring(1, 7),
//                         //         radix: 16) +
//                         //     0xFF000000),
//                         color: Colors.black,
//                         fontFamily: "Portada",
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//   }
//
//   Widget joinAndLeaveAlert(
//       bool oldOrNew, bool joinOrLeave, String alert, String message) {
//     return oldOrNew
//         ? Padding(
//             padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: joinOrLeave ? Color(0xFFE1FFE1) : Color(0xffFAE8E8),
//                 borderRadius: BorderRadius.circular(10.r),
//                 border: Border.all(
//                   //#BABABA
//                   color: Color(0xFFBABABA),
//                   width: 1.w,
//                 ),
//               ),
//               child: Text(
//                 // TextSpan(
//                 //   style: TextStyle(color: Colors.black, fontSize: 36),
//                 //   children: <TextSpan>[
//                 //     // TextSpan(
//                 //     //     text: 'Woolha ', style: TextStyle(color: Colors.blue)),
//                 //     // TextSpan(
//                 //     //   text: message.toString().indexOf("انضم للغرف") != -1
//                 //     //       ? message.toString().substring(
//                 //     //           message.toString().indexOf("انضم للغرف"),
//                 //     //           z)
//                 //     //       : message.toString().substring(0, 5),
//                 //       style: TextStyle(
//                 //         color: Colors.black,
//                 //         fontSize: 15.sp,
//                 //         fontFamily: "Segoe UI",
//                 //       ),
//                 //     ),
//                 //     // TextSpan(
//                 //     //     text: 'com',
//                 //     //     style: TextStyle(decoration: TextDecoration.underline))
//                 //   ],
//                 // ),
//                 // textScaleFactor: 0.5,
//                 message,
//                 textAlign: TextAlign.center,
//                 // joinOrLeave ? "$alert انضم للغرفة" : "$alert غادر للغرفة",
//                 // alert,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 12.sp,
//                   fontFamily: "Segoe UI",
//                 ),
//               ),
//             ),
//           )
//         : Padding(
//             padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 90.w),
//             child: Container(
//               padding: EdgeInsets.all(7.sp),
//               decoration: BoxDecoration(
//                 color: joinOrLeave ? Color(0xff88d95d) : Color(0xffFf6472a),
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     message,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12.sp,
//                       fontFamily: "Segoe UI",
//                     ),
//                   ),
//                   SizedBox(width: 5.w),
//                   Icon(joinOrLeave ? Icons.person : Icons.logout,
//                       color: Colors.white, size: 20.sp),
//                 ],
//               ),
//             ),
//           );
//   }
// }

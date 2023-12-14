// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_full_hex_values_for_flutter_colors

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/chat/moments/postMomentController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';
import 'package:lametna/view/chat/moments/viewComments.dart';
import 'package:lametna/view/chat/room%20mangement/roles/addRole.dart';

class Moments extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // var page = 0;
  // var appBar = 0;

  Moments({Key key, this.appBar = 0}) : super(key: key);
  final int appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("اللحظات", false),
      backgroundColor: Colors.white.withOpacity(0.95),
      body: ListView(
        children: [
          SizedBox(
            height: 15.h,
          ),
          GetBuilder<PostMomentController>(
            init: PostMomentController(),
            builder: (controller) {
              return FutureBuilder(
                future: controller.getAllStories(),
                builder: (context, snapshot) {
                  return StreamBuilder(
                    stream: controller.streamController.stream,
                    builder: (context, snapshot) => snapshot.data == null
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            reverse: true,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) => Directionality(
                              textDirection: TextDirection.rtl,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed("/viewComments", arguments: snapshot.data[index]);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                                  child: Container(
                                      // height: 175.h,
                                      width: 366.w,
                                      padding: EdgeInsets.symmetric(vertical: 15.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.r),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color:
                                        //         Color(0xFF00000029).withOpacity(0.2),
                                        //     spreadRadius: 0.5,
                                        //     blurRadius: 7,
                                        //     offset: Offset(
                                        //         0, 3), // changes position of shadow
                                        //   ),
                                        // ]
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            dense: true,
                                            horizontalTitleGap: 5.w,
                                            leading: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100.r),
                                              ),
                                              child: SizedBox(
                                                width: 47.w,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(360.r),
                                                        border: Border.all(
                                                          // color: Color(0xff2CCFB6),
                                                          color: Colors.black,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(360.r),
                                                        child: Image.network(
                                                          imageURL + snapshot.data[index]["username"].toString() + ".jpeg",
                                                          height: 39.sp,
                                                          width: 39.sp,
                                                          // height: double.infinity,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context, error, stackTrace) => Image.network(
                                                            "https://lametnachat.com/upload/imageUser/anonymous.jpg",
                                                            // fit: BoxFit.cover,
                                                            height: 39.sp,
                                                            width: 39.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 0,
                                                      bottom: 0,
                                                      child: Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            size: 25.sp,
                                                            color: Colors.white,
                                                          ),
                                                          Icon(
                                                            Icons.verified,
                                                            size: 22.sp,
                                                            color: Colors.blue,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            title: SizedBox(
                                              height: 25.h,
                                              child: Text(
                                                snapshot.data[index]["username"].toString(),
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    // fontFamily: "Portada",
                                                    // fontFamily: "Montserrat",
                                                    color: Color(0xff000000)),
                                              ),
                                            ),
                                            subtitle: SizedBox(
                                              height: 20.h,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    convertTime(snapshot.data[index]["timeafter"]).toString(),
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        // fontWeight: FontWeight.bold,
                                                        color: Color(0xff000000)),
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Icon(
                                                    CommunityMaterialIcons.earth,
                                                    size: 17.sp,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: GestureDetector(
                                                onTap: () {
                                                  // controller.deleteStories();
                                                  showDialog<void>(
                                                    context: context,
                                                    // barrierDismissible:
                                                    //     false, // user must tap button!
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.r),
                                                        ),
                                                        content: SingleChildScrollView(
                                                          child: Directionality(
                                                            textDirection: TextDirection.rtl,
                                                            child: ListBody(
                                                              children: <Widget>[
                                                                snapshot.data[index]["username"] == userName
                                                                    ? ListTile(
                                                                        onTap: () {
                                                                          if (snapshot.data[index]["username"].toString() == userName) {
                                                                            controller.deleteStory(snapshot.data[index]["id"].toString());
                                                                          }
                                                                        },
                                                                        leading: Icon(Icons.delete, color: Colors.black),
                                                                        horizontalTitleGap: 0.w,
                                                                        title: Text(
                                                                          "مسح",
                                                                          style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 18.sp,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox(),
                                                                ListTile(
                                                                  leading: Icon(Icons.report, color: Colors.red),
                                                                  horizontalTitleGap: 0.w,
                                                                  title: Text(
                                                                    "تبليغ",
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 18.sp,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        // actions: <Widget>[
                                                        //   TextButton(
                                                        //     child:
                                                        //         Text('Approve'),
                                                        //     onPressed: () {
                                                        //       Navigator.of(
                                                        //               context)
                                                        //           .pop();
                                                        //     },
                                                        //   ),
                                                        // ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Icon(Icons.more_vert)),
                                          ),
                                          snapshot.data[index]["text"].toString() == ""
                                              ? SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 5.h),
                                                  child: Text(
                                                    snapshot.data[index]["text"].toString(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.w400,
                                                      // fontFamily: "Montserrat",
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                          snapshot.data[index]["image"].toString() == ""
                                              ? SizedBox()
                                              : GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      "/viewImage",
                                                      arguments: {
                                                        "imageLink": storiesImage + snapshot.data[index]["image"].toString(),
                                                      },
                                                    );
                                                  },
                                                  child: Image.network(
                                                    storiesImage + snapshot.data[index]["image"].toString(),
                                                    height: 400.h,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 23.h,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                snapshot.data[index]["likeCount"].toString() + " اعجاب ",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Color(0xFFA2ACAC),
                                                ),
                                              ),
                                              Text(
                                                snapshot.data[index]["commentCount"].toString() + " تعليقا ",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Color(0xFFA2ACAC),
                                                ),
                                              ),
                                              Text(
                                                '0' + " مشاهدة ",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Color(0xFFA2ACAC),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller.likeStory(snapshot.data[index]["id"].toString());
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      snapshot.data[index]["liked"] ? Icons.favorite : Icons.favorite_border,
                                                      color: snapshot.data[index]["liked"] ? Colors.red : Colors.black,
                                                      size: 25.r,
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                      "اعجبني",
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        // fontWeight: FontWeight.w400,
                                                        // fontFamily: "Montserrat",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/viewComments", arguments: snapshot.data[index]);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CommunityMaterialIcons.comment_text_outline,
                                                      color: Colors.black,
                                                      size: 25.r,
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                      'تعليق',
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.w400,
                                                        // fontFamily: "Montserrat",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/viewComments", arguments: snapshot.data[index]);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CommunityMaterialIcons.eye_outline,
                                                      color: Colors.black,
                                                      size: 25.r,
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                      'مشاهدة',
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.w400,
                                                        // fontFamily: "Montserrat",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                          // Padding(
                                          //   padding: EdgeInsets.symmetric(
                                          //       horizontal: 29.w),
                                          //   child: Row(
                                          //     children: [
                                          //       Spacer(),
                                          //       Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.center,
                                          //         crossAxisAlignment:
                                          //             CrossAxisAlignment.center,
                                          //         children: [
                                          //           GestureDetector(
                                          //               onTap: () {
                                          //                 controller.likeStory(
                                          //                     snapshot
                                          //                         .data[index]
                                          //                             ["id"]
                                          //                         .toString());
                                          //               },
                                          //               child: Icon(
                                          //                   snapshot.data[index]
                                          //                           ["liked"]
                                          //                       ? Icons.favorite
                                          //                       : Icons
                                          //                           .favorite_border,

                                          //                   // Icons.favorite,
                                          //                   color: snapshot.data[
                                          //                               index]
                                          //                           ["liked"]
                                          //                       ? Colors.red
                                          //                       : Colors.black,
                                          //                   size: 29.sp)),
                                          //           SizedBox(
                                          //             width: 3.w,
                                          //           ),
                                          // Text(
                                          //   snapshot.data[index]
                                          //           ["likeCount"]
                                          //       .toString(),
                                          //   style: TextStyle(
                                          //     fontSize: 17.sp,
                                          //     color:
                                          //         Color(0xFFA2ACAC),
                                          //   ),
                                          // ),
                                          //         ],
                                          //       ),
                                          //       SizedBox(
                                          //         width: 20.w,
                                          //       ),
                                          //       Row(
                                          //         children: [
                                          //           Icon(
                                          //               CommunityMaterialIcons
                                          //                   .comment_outline,
                                          //               color: Colors.black,
                                          //               size: 23.sp),
                                          //           SizedBox(
                                          //             width: 5.w,
                                          //           ),
                                          //           Padding(
                                          //             padding: EdgeInsets.only(
                                          //                 top: 5.h),
                                          //             child: Text(
                                          //               snapshot.data[index]
                                          //                   ["commentCount"],
                                          //               style: TextStyle(
                                          //                 color:
                                          //                     Color(0xFFA2ACAC),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                          ),
                  );
                },
              );
            },
          ),
          // momentsBuilder("ميار"),
          // SizedBox(
          //   height: 25.h,
          // ),
          // momentsBuilder("محمود"),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: isGuest == false && isRole == false
          ? FloatingActionButton(
              onPressed: () {
                Get.toNamed('/postMoment');
              },
              child: Icon(Icons.edit),
              backgroundColor: Color(0xffFFC700),
            )
          : null,
    );
  }

  // Widget momentsBuilder(String name, String message, String image,
  //     String likeCount, bool isLiked) {
  //   return
  // }

  Widget buildMyNavBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 46.h,
        width: 366.w,
        child: SizedBox(
          width: 366.w,
          height: 46.h,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black, //Color(0xff9A8B8B),
                fontSize: 14.sp,
                fontFamily: "Portada",
              ),
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                hintText: 'اكتب شيئا',

                hintStyle: TextStyle(fontSize: 11.sp, fontFamily: "Portada", color: Color(0xffA2ACAC)),
                border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffFABD63)), borderRadius: BorderRadius.circular(16.r)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffFABD63)), borderRadius: BorderRadius.circular(16.r)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffFABD63)), borderRadius: BorderRadius.circular(10.r)),
                filled: true,
                fillColor: Colors.white, // Color(0xff00000029),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

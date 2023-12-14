// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, void_checks

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lametna/controllers/chat/moments/viewCommentsController.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewComments extends StatelessWidget {
  const ViewComments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 30.sp,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
          title: Text(
            'محتوي اللحظة',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontFamily: 'Portada ARA',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () {
                      // test();

                      // Get.toNamed("/viewComments",
                      //     arguments: snapshot.data[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 17.w, vertical: 12.h),
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
                              // dense: true,
                              horizontalTitleGap: 0.w,
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  border: Border.all(
                                    color: Color(0xff2CCFB6),
                                    width: 2.w,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360.r),
                                  child: Image.network(
                                    imageURL +
                                        Get.arguments["username"] +
                                        ".jpeg",
                                    height: 45.h,
                                    width: 45.w,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              title: SizedBox(
                                // height: 15.h,
                                child: Text(
                                  // snapshot.data[index]["username"].toString(),
                                  Get.arguments["username"],
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Portada",
                                      color: Color(0xff000000)),
                                ),
                              ),

                              // contentPadding:
                              //     EdgeInsets.symmetric(horizontal: 10.w),
                              // minVerticalPadding: 0,

                              subtitle: Row(
                                children: [
                                  Text(
                                    // snapshot.data[index]["time"].toString(),
                                    convertTime(Get.arguments["timeafter"])
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color(0xff000000).withOpacity(0.5)),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Icon(
                                    CommunityMaterialIcons.earth,
                                    size: 20.sp,
                                    color: Color(0xff000000).withOpacity(0.5),
                                  ),
                                ],
                              ),
                              trailing: GestureDetector(
                                  onTap: () {
                                    // controller.deleteStories();
                                    // if (snapshot.data[index]["username"]
                                    //         .toString() ==
                                    //     userName) {
                                    //   controller.deleteStory(
                                    //       snapshot.data[index]["id"].toString());
                                    // }
                                  },
                                  child: Icon(Icons.more_vert)),
                            ),
                            Get.arguments["text"].toString() == ""
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 29.w, vertical: 5.h),
                                    child: Text(
                                      Get.arguments["text"],
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                            Get.arguments["image"].toString() == ""
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      // Get.toNamed(
                                      //   "/viewImage",
                                      //   arguments: {
                                      //     "imageLink": storiesImage +
                                      //         snapshot.data[index]["image"]
                                      //             .toString(),
                                      //   },
                                      // );
                                    },
                                    child: Image.network(
                                      storiesImage +
                                          Get.arguments["image"].toString(),
                                      height: 400.h,
                                      width: double.infinity,
                                    ),
                                  ),
                            SizedBox(
                              height: 23.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 29.w),
                              child: Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GetBuilder<ViewCommentsController>(
                                        init: ViewCommentsController(),
                                        builder: (controller) {
                                          return GestureDetector(
                                              onTap: () {
                                                controller.likeStory(Get
                                                    .arguments["id"]
                                                    .toString());
                                              },
                                              child: Icon(
                                                  Get.arguments["liked"]
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,

                                                  // Icons.favorite,
                                                  color: Get.arguments["liked"]
                                                      ? Colors.red
                                                      : Colors.black,
                                                  size: 29.sp));
                                        },
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        Get.arguments["likeCount"].toString(),
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Color(0xFFA2ACAC),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                          CommunityMaterialIcons
                                              .comment_outline,
                                          color: Colors.black,
                                          size: 23.sp),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.h),
                                        child: Text(
                                          Get.arguments["commentCount"]
                                              .toString(),
                                          style: TextStyle(
                                            color: Color(0xFFA2ACAC),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      // height: 100.h,
                      width: double.infinity,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Text(
                              'التعليقات',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 15.sp,
                                fontFamily: 'Portada',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                            ),
                          ),
                          GetBuilder<ViewCommentsController>(
                              builder: (controller) {
                            return FutureBuilder(
                                future: controller.getComments(
                                    Get.arguments["id"].toString()),
                                builder: (context, snapshot) => StreamBuilder(
                                    stream: controller.streamController.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.black,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Color(0xff2CCFB6)),
                                            ),
                                          ),
                                        );
                                      } else if (snapshot.data["data"].length ==
                                          0) {
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(12.sp),
                                            child: Text(
                                              "لا يوجد تعليقات",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return ListView.separated(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data["data"].length,
                                          separatorBuilder: (context, index) =>
                                              Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Container(
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    width: 0.50,
                                                    strokeAlign: BorderSide
                                                        .strokeAlignCenter,
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          itemBuilder: (context, index) =>
                                              snapshot.data["data"].length ==
                                                      null
                                                  ? Text(
                                                      "data",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  : ListTile(
                                                      // dense: true,
                                                      horizontalTitleGap: 0.w,
                                                      leading: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100.r),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xff2CCFB6),
                                                            width: 2.w,
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      360.r),
                                                          child: Image.network(
                                                            imageURL +
                                                                snapshot.data[
                                                                            "data"]
                                                                        [index][
                                                                    "username"] +
                                                                ".jpeg",
                                                            height: 45.h,
                                                            width: 45.w,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                Icon(
                                                              Icons.person,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      title: SizedBox(
                                                        // height: 15.h,
                                                        child: Text(
                                                          // snapshot.data["data"][index]["username"].toString(),
                                                          snapshot.data["data"]
                                                                  [index]
                                                              ["username"],
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Portada",
                                                              color: Color(
                                                                  0xff000000)),
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        snapshot.data["data"]
                                                            [index]["comment"],
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.699999988079071),
                                                          fontSize: 12.sp,
                                                          fontFamily: 'Portada',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      trailing: Text(
                                                        // snapshot.data[index]["time"].toString(),
                                                        convertTime(snapshot.data[
                                                                        "data"]
                                                                    [index]
                                                                ["timestamp"])
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.4000000059604645),
                                                          fontSize: 12,
                                                          fontFamily: 'Portada',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                        );
                                      }
                                    }));
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 71.h,
              color: Colors.white,
              child: GetBuilder<ViewCommentsController>(
                  init: ViewCommentsController(),
                  builder: (controller) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: GestureDetector(
                              onTap: () {
                                controller.postComment();
                                controller.commentController.clear();
                                // controller.getComments(
                                //     Get.arguments["id"].toString());
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.black,
                                size: 25.sp,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 13,
                          child: SizedBox(
                            height: 50.h,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextFormField(
                                cursorColor: Colors.black,
                                controller: controller.commentController,
                                style: TextStyle(
                                  color: Colors.black, //Color(0xff9A8B8B),
                                  fontSize: 14.sp,
                                  fontFamily: "Portada",
                                ),
                                // expands: true,
                                maxLines: 1,
                                // onFieldSubmitted: (value) => controller
                                //     .sendMessage(controller.messageController.text),
                                onTapOutside: (event) =>
                                    FocusScope.of(context).unfocus(),
                                onTap: () {
                                  // if (!controller.emojiStatus) {
                                  //   controller.changeEmojiStatus(true);
                                  // }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  hintText: 'اكتب رسالة',
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "Portada",
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  filled: true,
                                  fillColor: Colors
                                      .grey.shade100, // Color(0xff00000029),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
        // bottomNavigationBar:
      ),
    );
  }
}

convertTime(String time) {
  var dateTime = DateTime.now();
  var val = DateTime.parse(time);
  var offset = dateTime.timeZoneOffset;
  var hours = offset.inSeconds; // For fixing divide by 0

  var val2 = val.add(Duration(seconds: hours));
  // print(dateTime.difference(val2).inSeconds);
  return formatTimeAgo(
      int.parse(dateTime.difference(val2).inSeconds.toString()));
}

String formatTimeAgo(int seconds) {
  if (seconds < 60) {
    return '$seconds ثانية ';
  } else if (seconds < 3600) {
    int minutes = (seconds / 60).floor();
    return '$minutes دقيقة';
  } else if (seconds < 86400) {
    int hours = (seconds / 3600).floor();
    return '$hours ساعة';
  } else {
    int days = (seconds / 86400).floor();
    return '$days يوم';
  }
}

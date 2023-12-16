// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/profile/profileController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  // const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(100.h),
        //   child: Container(
        //     color: Colors.red,
        //   ),

        // ),
        body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    color: Color(0xFFF1F1F1),
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: Colors.grey,
                          expandedHeight: 360.h,
                          leading: GestureDetector(
                              onTap: () {
                                // Get.toNamed('/editProfile');
                                Get.toNamed('/editPersonalProfile');
                                //route to page
                                // MaterialPageRoute(builder: (context) => Navigator,)
                                // print("object");
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => EditPersonalProfile(),
                                //   ),
                                // );

                                //EditPersonalProfile()
                                // MaterialPageRoute(builder: (context) => ,)
                              },
                              child: Icon(Icons.settings, size: 25.sp)),
                          title: GetBuilder<ProfileController>(
                            builder: (controller) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      controller.data["start_date"]
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.red,
                                        fontFamily: 'Portada',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      " متبقي  ${DateTime.parse(controller.data["expiry_date"].toString().substring(0, 10).toString()).difference(DateTime.parse(controller.data["start_date"].toString().substring(0, 10).toString())).inDays.toString()}  ايام  ",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Color(0xFFA2ACAC),
                                        fontFamily: 'Portada',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.data["expiry_date"]
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.green,
                                        fontFamily: 'Portada',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 31.sp,
                            ),
                            SizedBox(width: 10.w),
                          ],
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(0.h),
                            child: GetBuilder<ProfileController>(
                                // init: ProfileController(),
                                builder: (controller) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 130.h),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          child: Image.network(
                                            "https://lametnachat.com/upload/imageUser/" +
                                                userName.toString() +
                                                ".jpeg",
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              child: Image.network(
                                                  "https://lametnachat.com/upload/imageUser/anonymous.jpg",
                                                  width: 65.w,
                                                  height: 70.h,
                                                  fit: BoxFit.fill),
                                            ),
                                            width: 65.w,
                                            height: 70.h,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                          height: 95.h,
                                          child: Image.asset(
                                            'assets/images/basicFrame.png',
                                            width: 130,
                                            height: 130,
                                            // fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                      child: Text(
                                        controller.data["username"].toString(),
                                        style: TextStyle(
                                          fontFamily: 'Portada',
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                    ),
                                    controller.data["nickname"].toString() == ""
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 30.h,
                                            child: Text(
                                              controller.data["nickname"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Portada',
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            }),
                          ),
                          flexibleSpace: GetBuilder<ProfileController>(
                              init: ProfileController(),
                              builder: (controller) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: controller.data["image"] != ""
                                        ? DecorationImage(
                                            fit: BoxFit.fill,
                                            opacity: 160,
                                            image: NetworkImage(
                                              "https://lametnachat.com/upload/imageUser/" +
                                                  controller.data["image"],
                                            ),
                                          )
                                        : null,
                                    gradient: controller.data["image"] == ""
                                        ? LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFFFABD63),
                                              Color(0xFFF792F0),
                                            ],
                                          )
                                        : null,
                                  ),
                                  child: FlexibleSpaceBar(
                                    centerTitle: true,
                                    title: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 35.w),
                                      child: GetBuilder<ProfileController>(
                                          builder: (controller) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            statusBuilder(
                                                controller.data["likes"],
                                                "اعجابات"),
                                            statusBuilder(
                                                controller.data["views"],
                                                "المشاهدات"),
                                            statusBuilder(
                                                controller.data["presenceTime"],
                                                "مدة التواجد"),
                                            statusBuilder(
                                                controller.data["speakTime"],
                                                "مدة اتحدث"),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SliverToBoxAdapter(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0, 10.h, 15.w, 10.h),
                                child: GetBuilder<ProfileController>(
                                    builder: (controller) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        itemBuilder(
                                            controller.data["sex"], "gender"),
                                        itemBuilder(
                                            controller.data["status"], "heart"),
                                        itemBuilder(controller.data["gender"],
                                            "planet"),
                                        itemBuilder(
                                            controller.data["birthday"] ==
                                                    "0000-00-00"
                                                ? ""
                                                : controller.data["birthday"],
                                            "cake"),
                                        itemBuilder(controller.data["sign"],
                                            "astrology"),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  // width: 85.sw,
                                  height: 85.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "تعديل",
                                        style: TextStyle(
                                            color: Color(0xFF5C5E5E),
                                            fontSize: 10.sp),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEFA11B),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10.r),
                                            bottomRight: Radius.circular(10.r),
                                          ),
                                        ),
                                        child: Text(
                                          "الحالة",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontFamily: 'Portada',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                height: 400,
                                child: Column(
                                  children: [
                                    GetBuilder<ProfileController>(
                                        // init: ProfileController(),
                                        builder: (controller) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30.w,
                                          vertical: 15.h,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.changePage(false);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: !controller.pageIndex
                                                      ? Color(0xFFEFA11B)
                                                      : Colors.white,
                                                  border: Border.all(
                                                    color: controller.pageIndex
                                                        ? Color(0xFFEFA11B)
                                                        : Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7.w),
                                                  child: Text(
                                                    "الصور",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: controller
                                                              .pageIndex
                                                          ? Color(0xFFEFA11B)
                                                          : Colors.white,
                                                      fontFamily: 'Portada',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.changePage(true);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: controller.pageIndex
                                                        ? Color(0xFFEFA11B)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    border: Border.all(
                                                      color: !controller
                                                              .pageIndex
                                                          ? Color(0xFFEFA11B)
                                                          : Colors.white,
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7.w),
                                                  child: Text(
                                                    "اللحظات",
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: !controller
                                                              .pageIndex
                                                          ? Color(0xFFEFA11B)
                                                          : Colors.white,
                                                      fontFamily: 'Portada',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    Expanded(child: Container()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFEFA11B),
          onPressed: () {},
          child: Icon(Icons.edit),
        ),
      ),
    );
  }

  Row itemBuilder(String title, String image) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/profile/$image.png',
          width: 18,
        ),
        SizedBox(
          width: 60.w,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.black,
              fontFamily: 'Portada',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Container statusBuilder(String num, String text) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "0",
            style: TextStyle(
              color: Colors.black,
              fontSize: 8.sp,
            ),
          ),
          Text(
            "اعجابات",
            style: TextStyle(
              color: Colors.black,
              fontSize: 8.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

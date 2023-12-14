// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:lametna/controllers/chat/blockController.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/view/chat/room%20mangement/block/countries.dart';

var color = Get.arguments["color"];

class Blocked extends StatelessWidget {
  const Blocked({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("المحظورون", true, color: color),
      body: Container(
        color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000).withOpacity(0.2),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(
              height: 10.h,
            ),
            GetBuilder<BlockController>(
                init: BlockController(),
                builder: (controller) {
                  return Container(
                    // color: Color(0xFFFABD63),
                    decoration: BoxDecoration(
                      color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            // padding: EdgeInsets.zero,
                            foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                            splashFactory: NoSplash.splashFactory,
                            shadowColor: Colors.transparent,
                            backgroundColor: controller.currentIndex == 3 ? Colors.white : Colors.transparent, // Text color
                            // backgroundColor: ``,
                            side: BorderSide.none, // Border color
                          ),
                          onPressed: () {
                            // Add your action for Button 3 here
                            controller.changeIndex(3);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Text(
                              'الدول',
                              style: TextStyle(
                                color: controller.currentIndex == 3 ? Colors.black : Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add some spacing between buttons
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            // padding: EdgeInsets.zero,
                            // padding: EdgeInsets.symmetric(horizontal: 7.w),
                            foregroundColor: Colors.black, splashFactory: NoSplash.splashFactory,
                            shadowColor: Colors.transparent,
                            backgroundColor: controller.currentIndex == 2 ? Colors.white : Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)), // Text color
                            // backgroundColor: ``,
                            side: BorderSide.none, // Border color
                          ),
                          onPressed: () {
                            // Add your action for Button 3 here
                            controller.changeIndex(2);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Text(
                              'أي بي',
                              style: TextStyle(
                                color: controller.currentIndex == 2 ? Colors.black : Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add some spacing between buttons
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            // padding: EdgeInsets.zero,
                            // padding: EdgeInsets.symmetric(horizontal: 7.w),
                            foregroundColor: Colors.black, splashFactory: NoSplash.splashFactory,
                            shadowColor: Colors.transparent,
                            backgroundColor: controller.currentIndex == 1 ? Colors.white : Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)), // Text color
                            // backgroundColor: ``,
                            side: BorderSide.none, // Border color
                          ),
                          onPressed: () {
                            // Add your action for Button 3 here
                            controller.changeIndex(1);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Text(
                              'أي دي',
                              style: TextStyle(
                                color: controller.currentIndex == 1 ? Colors.black : Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: Get.height - 180.h,
              width: Get.width,
              child: GetBuilder<BlockController>(builder: (controller) {
                return PageView(
                  reverse: true,
                  controller: controller.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    FutureBuilder(
                      future: controller.getBlockedUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.separated(
                          itemCount: snapshot.data.length,
                          separatorBuilder: (context, index) => Divider(
                            height: (0.5).h,
                            color: Colors.black,
                          ),
                          itemBuilder: (context, index) => PopupMenuButton<int>(
                            constraints: BoxConstraints(
                              maxWidth: 130.h,
                              minWidth: 130.h,
                            ),
                            offset: Offset(0, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                // padding: EdgeInsets.all(0),
                                onTap: () {
                                  // Get.back();
                                  controller.removeBan(snapshot.data[index]["username"].toString());
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "الغاء الحظر",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                value: 1,
                              ),
                              PopupMenuDivider(
                                height: 1.h,
                              ),
                              PopupMenuItem(
                                // padding: EdgeInsets.all(0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "حظر اي بي",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                value: 2,
                              ),
                            ],
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index]["username"].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.black,
                                              size: 25.sp,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              // Get.arguments.toString(),
                                              snapshot.data[index]["country"].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.credit_card,
                                            color: Colors.black,
                                            size: 25.sp,
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            snapshot.data[index]["macAddress"].toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 9.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.black,
                                              size: 25.sp,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              snapshot.data[index]["userBan"].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 60.h,
                                      // ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer_outlined,
                                            color: Colors.black,
                                            size: 25.sp,
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            snapshot.data[index]["banType"].toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: Colors.black,
                                        size: 25.sp,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        snapshot.data[index]["endTime"].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
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
                    ),
                    FutureBuilder(
                      future: controller.getBlockedUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.separated(
                          itemCount: snapshot.data.length,
                          separatorBuilder: (context, index) => Divider(
                            height: (0.5).h,
                            color: Colors.black,
                          ),
                          itemBuilder: (context, index) => PopupMenuButton<int>(
                            constraints: BoxConstraints(
                              maxWidth: 130.h,
                              minWidth: 130.h,
                            ),
                            offset: Offset(0, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                // padding: EdgeInsets.all(0),
                                onTap: () {
                                  // Get.back();
                                  controller.removeBan(snapshot.data[index]["username"].toString());
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "الغاء الحظر",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                value: 1,
                              ),
                              PopupMenuDivider(
                                height: 1.h,
                              ),
                              PopupMenuItem(
                                // padding: EdgeInsets.all(0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "حظر اي دي",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                value: 2,
                              ),
                            ],
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index]["username"].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.black,
                                              size: 25.sp,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              // Get.arguments.toString(),
                                              snapshot.data[index]["country"].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.credit_card,
                                            color: Colors.black,
                                            size: 25.sp,
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            snapshot.data[index]["macAddress"].toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 9.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.black,
                                              size: 25.sp,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              snapshot.data[index]["userBan"].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 60.h,
                                      // ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer_outlined,
                                            color: Colors.black,
                                            size: 25.sp,
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            snapshot.data[index]["banType"].toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: Colors.black,
                                        size: 25.sp,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        snapshot.data[index]["endTime"].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
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
                    ),
                    Container(
                      child: Column(
                        // physics: NeverScrollableScrollPhysics(),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Expanded(
                              // flex: 75,
                              child: FutureBuilder(
                                future: controller.getBannedCountry(),
                                builder: (context, snapshot) => ListView.separated(
                                  itemCount: snapshot.data.length,
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey.withOpacity(0.8),
                                    height: 1,
                                  ),
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          'https://flagsapi.com/${snapshot.data[index]["countryCode"]}/flat/64.png',
                                          width: 30.sp,
                                          height: 30.sp,
                                          errorBuilder: (context, error, stackTrace) => Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          snapshot.data[index]["countryAr"].toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            controller.deleteBannedCountry(snapshot.data[index]["id"].toString());
                                          },
                                          child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => chooseCountry(controller),
                            child: Container(
                              width: 50.sp, // Set the width and height as needed
                              height: 50.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000), // Set the background color as desired
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white, // Set the icon color
                                  size: 40.sp, // Set the icon size as desired
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

chooseCountry(BlockController controller) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
    ),
    builder: (context) => FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        // height: 500.h,
        child: SingleChildScrollView(
          child: Column(
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                  Text(
                    "اختر الدولة",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      // Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
              SizedBox(
                // width: 50.w,
                // height: 30.h,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TextFormField(
                      controller: controller.searchController,
                      onChanged: (value) => controller.updateSearchValue(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        // isDense: true,
                        hintText: "بحث",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      ),
                    ),
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  // color: Colors.grey.withOpacity(0.8),
                  height: 1.h,
                ),
                cacheExtent: double.parse(countriesData.length.toString()),
                physics: NeverScrollableScrollPhysics(),
                itemCount: countriesData.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    print(countriesData[index]["nameAr"]);
                    controller.countryBan(
                        countryAr: countriesData[index]["nameAr"],
                        countryEn: countriesData[index]["name"],
                        countryCode: countriesData[index]["code"]);
                  },
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Row(
                        children: [
                          Image.network(
                            'https://flagsapi.com/${countriesData[index]["code"]}/flat/64.png',
                            width: 30.sp,
                            height: 30.sp,
                            // cacheHeight: 30,
                            // cacheWidth: 30,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            countriesData[index]["nameAr"],
                            style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

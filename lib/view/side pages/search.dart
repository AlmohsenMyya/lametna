// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/side%20pages/searchController.dart';

class Search extends StatelessWidget {
  Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "البحث",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Portada",
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            GetBuilder<SearchController>(
                init: SearchController(),
                builder: (controller) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.w),
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13.r),
                          border: Border.all(
                            color: Color(0xFFFABD63),
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          // enabled: false,
                          // readOnly: true,
                          controller: controller.searchController,
                          // onChanged: (value) => controller.search(),
                          onEditingComplete: () => controller.search(),

                          autofocus: false,
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            hintText: "البحث",
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey,
                            ),
                            // suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(height: 20.h),
            GetBuilder<SearchController>(builder: (controller) {
              return SizedBox(
                height: Get.height * .06,
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Container(
                      // height: 70.h,
                      decoration: controller.selectedIndex == index
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFF792F0),
                                  Color(0xFFFABD63),
                                ],
                              ),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: Color(0xFFFABD63),
                              ),
                            ),
                      child: TextButton(
                        onPressed: () {
                          controller.changeIndex(index);
                        },
                        child: Text(
                          controller.list[index],
                          style: controller.selectedIndex == index
                              ? TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                )
                              : TextStyle(
                                  color: Color(0xFFFABD63),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: controller.list.length,
                ),
              );
            }),
            GetBuilder<SearchController>(
              builder: (controller) => controller.data == null
                  ? SizedBox()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Card(
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: Text(
                            controller.selectedIndex == 0
                                ? controller.data["data"][index]["username"]
                                    .toString()
                                : controller.data["data"][index]["room_name"]
                                    .toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      itemCount: controller.data["data"].length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

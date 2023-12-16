// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/moments/postMomentController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostMoment extends StatelessWidget {
  const PostMoment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: Image.network(
                  imageURL + userName + ".jpeg",
                  width: 50.w,
                  height: 55.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    child: Image.network(
                      "https://lametnachat.com/upload/imageUser/anonymous.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              title: Text(
                userName,
                style: TextStyle(color: Colors.black, fontFamily: 'Portada'),
              ),
            ),
            GetBuilder<PostMomentController>(
                init: PostMomentController(),
                builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: TextFormField(
                      controller: controller.textEditingController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border:
                            InputBorder.none, // This removes the default lines
                        hintText: 'قل شيئأ',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                  );
                }),
            GetBuilder<PostMomentController>(
                // init: PostMomentController(),
                builder: (controller) {
              if (controller.pickedFile == null) {
                return GestureDetector(
                  onTap: () => controller.getImageFromGallery(),
                  child: Padding(
                    padding: EdgeInsets.all(30.sp),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 40.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                );
              } else {
                return Stack(
                  children: [
                    Image.file(
                      controller.imagePath,
                      width: double.infinity,
                      height: 350.h,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            controller.deleteImage();
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.sp),
                            decoration: BoxDecoration(
                              // color: Colors.green,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        )
                      ],
                    ),
                  ],
                );
              }
            }),
            SizedBox(
              height: 70.h,
            ),
            GetBuilder<PostMomentController>(builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: GestureDetector(
                  onTap: () {
                    controller.postStory();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF792F0),
                          Color(0xFFFABD63),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.h),
                        child: Text(
                          "نشر",
                          style: TextStyle(
                              fontFamily: 'Portada',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

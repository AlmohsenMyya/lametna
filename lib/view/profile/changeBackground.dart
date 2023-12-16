import 'package:flutter/material.dart';
import 'package:lametna/controllers/profile/changeBackgroundController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeBackground extends StatelessWidget {
  const ChangeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("تغيير خلفية الاسم", true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12.h,
            ),
            Center(
              child: Text(
                "اختر خلفية",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Portada",
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GetBuilder<ChangeBackgroundController>(
              init: ChangeBackgroundController(),
              builder: (controller) => FutureBuilder(
                  future: controller.getData(),
                  builder: (context, snapshot) => (snapshot.data as Map) == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 20,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  controller.changeUserBackground(
                                      (snapshot.data as Map)["data"][index]["name"]);
                                  // Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 30.h),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        backgroundImagesURL +
                                            (snapshot.data as Map)["data"][index]
                                                ["name"],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        userName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Portada',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Image.asset(
                                        'assets/icons/profile.png',
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          // Image.network(
                          //     backgroundImagesURL +
                          //         (snapshot.data as Map)["data"][index]["name"]),
                          )

                  // Text(
                  //   (snapshot.data as Map)["data"][0]["name"].toString(),
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  //  Image.network(
                  //     backgroundImagesURL +
                  //         (snapshot.data as Map)["data"][index]["name"]),
                  // ),
                  ),
            )
            // StyleContainer(),
            // StyleContainer()
          ],
        ),
      ),
    );
  }
}

Widget StyleContainer() {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      height: 83.h,
      padding: EdgeInsets.all(7.sp),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        // color: Color(0xFFE1E1E1),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFFA2ACAC),
          ],
        ),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 53.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(360.r),
            ),
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 30.sp,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "احمد حسن",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontFamily: "Portada",
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0.h, left: 20.w),
            child: Image.asset(
              "assets/images/vipBadge.png",
              width: 60.w,
              height: 60.h,
            ),
          ),
        ],
      ),
    ),
  );
}

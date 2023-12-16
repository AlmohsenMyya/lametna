// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lametna/controllers/store/storeDetailsController.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/view/side%20pages/dottedDivider.dart';

// StoreDetailsController controller = Get.put(StoreDetailsController());

class StoreDetails extends StatelessWidget {
  const StoreDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbarBuilder("المتجر", false),
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(27.r),
          //   bottomRight: Radius.circular(27.r),
          // ),
          gradient: LinearGradient(
            colors: [
              Color(0xFFF792F0),
              Color(0xFFFABD63),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // color: Colors.green,
                child: GetBuilder<StoreDetailsController>(
                    init: StoreDetailsController(),
                    builder: (controller) {
                      return PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: controller.upperSectionController,
                        children: [
                          PageView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: controller.roomUpperSectionController,
                            children: [
                              roomStyleBuilder(isColored: true),
                              roomStyleBuilder(isColored: false),
                              roomStyleBuilder(isColored: false),
                              SizedBox()
                            ],
                          ),
                          PageView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: controller.namesUpperSectionController,
                            children: [
                              nameStyleBuilder(index: 0),
                              nameStyleBuilder(index: 1),
                              nameStyleBuilder(index: 2),
                              nameStyleBuilder(index: 3),
                              nameStyleBuilder(index: 4),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(60.sp),
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.verified,
                                      color: Color(0xFFF8BA33),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "lametna",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Icon(Icons.person),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.purple,
                            padding: EdgeInsets.all(30.sp),
                            child: controller.selectedFrameImage == ""
                                ? SizedBox()
                                : Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Icon(Icons.person_2, size: 100.sp),
                                      Image.network(controller.selectedFrameImage),
                                    ],
                                  ),
                          ),
                          Container(
                            // color: Colors.purple,
                            padding: EdgeInsets.all(30.sp),
                            child: controller.selectedEntryImage == ""
                                ? SizedBox()
                                : Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      // Icon(Icons.person_2, size: 100.sp),
                                      Image.network(controller.selectedEntryImage),
                                    ],
                                  ),
                          ),
                          Container(
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: controller.vipUpperSectionController,
                              children: [
                                Container(
                                  color: Colors.purple,
                                ),
                                Container(
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white.withOpacity(0.92),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          tabsBuilder(title: "Vip", index: 6),
                          tabsBuilder(title: "الدخوليات", index: 5),
                          tabsBuilder(title: "الإطارات", index: 4),
                          tabsBuilder(title: "الروتات", index: 3),
                          tabsBuilder(title: "الأسماء المسجلة", index: 2),
                          tabsBuilder(title: "الغرف الكتابية", index: 1),
                        ],
                      ),
                    ),
                    GetBuilder<StoreDetailsController>(
                      init: StoreDetailsController(),
                      builder: (controller) {
                        return SizedBox(
                          height: 570.h,
                          child: PageView(
                            physics: NeverScrollableScrollPhysics(),

                            controller: controller.pageController,
                            // onPageChanged: (index) {
                            //   StoreDetailsController().changeSelectedPage(index);
                            // },
                            children: [
                              Container(
                                // color: Colors.transparent,
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        roomTabBuilder(title: "العروض", index: 3),
                                        roomTabBuilder(title: "غرف فضية", index: 2),
                                        roomTabBuilder(title: "غرف دهبية", index: 1),
                                        roomTabBuilder(title: "غرف مميزة", index: 0),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 460.h,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                                        child: PageView(
                                          physics: NeverScrollableScrollPhysics(),
                                          controller: controller.roomController,
                                          children: [
                                            roomOfferBuilder(title: "VIP غرفة مميزة 500 مستخدم", prices: [300, 300, 300, 300, 300], roomPrice: 90),
                                            roomOfferBuilder(title: "غرفة ذهبية 150 مستخدم", prices: [300, 300, 300, 300, 300], roomPrice: 60),
                                            roomOfferBuilder(title: "غرفة فضية 80 مستخدم", prices: [300, 300, 300, 300, 300], roomPrice: 40),
                                            Container()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                // color: Colors.transparent,
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        namesTabBuilder(title: "محمي عادي", index: 4),
                                        namesTabBuilder(title: "vip محمي مميز", index: 3),
                                        namesTabBuilder(title: "ملكي عادي", index: 2),
                                        namesTabBuilder(title: "vip ملكي مميز", index: 1),
                                        namesTabBuilder(title: "Top Won", index: 0),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 495.h,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                                        child: PageView(
                                          physics: NeverScrollableScrollPhysics(),
                                          controller: controller.namesController,
                                          children: [
                                            namesOfferBuilder(
                                                title: "Top Won",
                                                items: [
                                                  "ملف شخصي",
                                                  "حالة تحت الأسم",
                                                  "صورة شخصية بجانب الأسم",
                                                  "إشارة VIP ",
                                                  "يمكنك أخيار أكثر من 90 خلفية"
                                                ],
                                                price: 170,
                                                index: 0),
                                            namesOfferBuilder(
                                                title: "vip ملكي مميز",
                                                items: [
                                                  "ملف شخصي",
                                                  "حالة تحت الأسم",
                                                  "صورة شخصية بجانب الأسم",
                                                  "إشارة VIP ",
                                                  "يمكنك أخيار أكثر من 90 خلفية"
                                                ],
                                                price: 100,
                                                index: 1),
                                            namesOfferBuilder(
                                                title: "ملكي عادي",
                                                items: [
                                                  "ملف شخصي",
                                                  "حالة تحت الأسم",
                                                  "صورة شخصية بجانب الأسم",
                                                ],
                                                price: 60,
                                                index: 2),
                                            namesOfferBuilder(
                                                title: "vip محمي مميز",
                                                items: [
                                                  "ملف شخصي",
                                                ],
                                                price: 50,
                                                index: 3),
                                            namesOfferBuilder(
                                                title: "محمي عادي",
                                                items: [
                                                  "ملف شخصي",
                                                ],
                                                price: 35,
                                                index: 4),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Container(),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                                child: namesOfferBuilder(
                                  title: "الروت",
                                  items: ['يحتوي على صلاحيات كاملة'],
                                  index: 0,
                                  isDialog: false,
                                  price: 20,
                                  isRoot: true,
                                ),
                              ),

                              // Container(),

                              FutureBuilder(
                                  // future: controller.frames(),
                                  future: null,
                                  // stream: controller.framesController.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: controller.selectedFrameImage == "" ? 0 : 60.h),
                                          child: GridView.builder(
                                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                            itemCount: controller.framesList.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10.w,
                                              mainAxisSpacing: 10.h,
                                            ),
                                            itemBuilder: (context, index) => framesBuilder(
                                              title: "إطار مميز",
                                              imageUrl: framesUrl + controller.framesList[index]['image'],
                                              price: controller.framesList[index]['price'],
                                            ),
                                          ),
                                        ),
                                        if (controller.selectedFrameImage == "")
                                          SizedBox()
                                        else
                                          Container(
                                            color: Color(0xFFFABD63),
                                            width: double.infinity,
                                            height: 60.h,
                                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => buyOptionModalBuilder(isFrame: true),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20.r),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 1.h),
                                                    child: Text(
                                                      "شراء",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 3.h),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/store/dollar.png',
                                                        height: 22.sp,
                                                        width: 22.sp,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      SizedBox(width: 3.w),
                                                      Text(
                                                        controller.selectedFramePrice,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                  }),

                              // Container(),

                              FutureBuilder(
                                  // future: controller.enties(),
                                  future: null,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: controller.selectedEntryImage == "" ? 0 : 60.h),
                                          child: GridView.builder(
                                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                            physics: BouncingScrollPhysics(),
                                            itemCount: controller.entriesList.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10.w,
                                              mainAxisSpacing: 10.h,
                                            ),
                                            itemBuilder: (context, index) => framesBuilder(
                                              title: "دخولية مميزة",
                                              imageUrl: entriesUrl + controller.framesList[index]['image'],
                                              price: controller.framesList[index]['price'],
                                              isFrame: false,
                                            ),
                                          ),
                                        ),
                                        if (controller.selectedEntryImage == "")
                                          SizedBox()
                                        else
                                          Container(
                                            color: Color(0xFFFABD63),
                                            width: double.infinity,
                                            height: 60.h,
                                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => buyOptionModalBuilder(),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(20.r),
                                                    ),
                                                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 1.h),
                                                    child: Text(
                                                      "شراء",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 3.h),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/store/dollar.png',
                                                        height: 22.sp,
                                                        width: 22.sp,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      SizedBox(width: 3.w),
                                                      Text(
                                                        controller.selectedEntryPrice,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.sp,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                  }),

                              Container(),

                              // Container(
                              //   // color: Colors.purple,
                              //   child: Column(
                              //     children: [
                              //       Padding(
                              //         padding: EdgeInsets.symmetric(horizontal: 70.w),
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //           children: [
                              //             vipTabBuilder(title: "vip الدخوليات", index: 1),
                              //             vipTabBuilder(title: "vip الإطارات", index: 0),
                              //           ],
                              //         ),
                              //       ),
                              //       Expanded(
                              //         child: PageView(
                              //           physics: NeverScrollableScrollPhysics(),
                              //           controller: controller.upperSectionController,
                              //           children: [
                              //             GridView.builder(
                              //               padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                              //               itemCount: controller.framesList.length,
                              //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //                 crossAxisCount: 3,
                              //                 crossAxisSpacing: 10.w,
                              //                 mainAxisSpacing: 10.h,
                              //               ),
                              //               itemBuilder: (context, index) => framesBuilder(
                              //                 title: "إطار مميز",
                              //                 imageUrl: framesUrl + controller.framesList[index]['image'],
                              //                 price: controller.framesList[index]['price'],
                              //               ),
                              //             ),
                              //             GridView.builder(
                              //               padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                              //               itemCount: controller.entriesList.length,
                              //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //                 crossAxisCount: 3,
                              //                 crossAxisSpacing: 10.w,
                              //                 mainAxisSpacing: 10.h,
                              //               ),
                              //               itemBuilder: (context, index) => framesBuilder(
                              //                 title: "دخولية مميزة",
                              //                 imageUrl: entriesUrl + controller.framesList[index]['image'],
                              //                 price: controller.framesList[index]['price'],
                              //                 isFrame: false,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget framesBuilder({required String title, required String imageUrl, required String price, bool isFrame = true}) {
    return GetBuilder<StoreDetailsController>(builder: (c) {
      return GestureDetector(
        // onTap: () => showDialog(
        //   context: Get.context,
        //   builder: (context) => AlertDialog(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10.r),
        //     ),
        //     title: Text(
        //       "تأكيد الشراء",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         color: Colors.black,
        //         fontSize: 20.sp,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     content: SizedBox(
        //       width: 200.w,
        //       child: SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 50.w),
        //               child: Container(
        //                 width: 150.w,
        //                 height: 150.h,
        //                 decoration: BoxDecoration(
        //                   gradient: LinearGradient(
        //                     colors: [
        //                       Color(0xFFFABD63),
        //                       Color(0xFFF792F0),
        //                     ],
        //                     begin: Alignment.topCenter,
        //                     end: Alignment.bottomCenter,
        //                   ),
        //                   border: Border.all(
        //                     color: Color(0xFFFBF205),
        //                   ),
        //                   boxShadow: [
        //                     BoxShadow(
        //                       color: Colors.grey.withOpacity(0.5),
        //                     ),
        //                     BoxShadow(
        //                       color: Colors.grey.withOpacity(0.5),
        //                       blurRadius: 10.r,
        //                       spreadRadius: -10.r,
        //                       // offset: Offset(0, 3), // changes position of shadow
        //                     ),
        //                   ],
        //                 ),
        //                 padding: EdgeInsets.all(12.sp),
        //                 child: Image.network(
        //                   imageUrl,
        //                   width: 70.w,
        //                 ),
        //               ),
        //             ),
        //             SizedBox(
        //               height: 25.h,
        //             ),
        //             Center(
        //               child: Container(
        //                 // onPressed: () => Get.back(),
        //                 width: 280.w,
        //                 padding: EdgeInsets.symmetric(horizontal: 20.w),
        //                 decoration: BoxDecoration(
        //                   color: Color(0xffF1F1F1),
        //                   borderRadius: BorderRadius.circular(25.r),
        //                   border: Border.all(
        //                     color: Color(0xFFFBF205),
        //                   ),
        //                 ),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         Image.asset('assets/icons/store/dollar.png'),
        //                         SizedBox(width: 3.w),
        //                         Text(
        //                           price,
        //                           textAlign: TextAlign.center,
        //                           style: TextStyle(
        //                             color: Colors.black,
        //                             fontSize: 15.sp,
        //                             fontWeight: FontWeight.bold,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     Text(
        //                       "فترة الصلاحية:7 ايام",
        //                       style: TextStyle(
        //                         color: Colors.black,
        //                         fontSize: 15.sp,
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     actionsAlignment: MainAxisAlignment.center,
        //     actions: [
        //       Container(
        //         decoration: BoxDecoration(
        //           gradient: LinearGradient(
        //             colors: [
        //               Color(0xFFFABD63),
        //               Color(0xFFF792F0),
        //             ],
        //             begin: Alignment.topCenter,
        //             end: Alignment.bottomCenter,
        //           ),
        //           borderRadius: BorderRadius.circular(20.r),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.grey.withOpacity(0.5),
        //               blurRadius: 10.r,
        //               spreadRadius: 3.r,
        //               // offset: Offset(0, 3), // changes position of shadow
        //             ),
        //           ],
        //         ),
        //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
        //         child: Text(
        //           "هدية",
        //           style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 15.sp,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //       Container(
        //         decoration: BoxDecoration(
        //           gradient: LinearGradient(
        //             colors: [
        //               Color(0xFFFABD63),
        //               Color(0xFFF792F0),
        //             ],
        //             begin: Alignment.topCenter,
        //             end: Alignment.bottomCenter,
        //           ),
        //           borderRadius: BorderRadius.circular(20.r),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.grey.withOpacity(0.5),
        //               blurRadius: 10.r,
        //               spreadRadius: 3.r,
        //               // offset: Offset(0, 3), // changes position of shadow
        //             ),
        //           ],
        //         ),
        //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
        //         child: Text(
        //           "طلب الأن",
        //           style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 15.sp,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        onTap: () {
          // buyOptionModalBuilder();
          print("object");
          !isFrame ? c.updateSelectedEntryImage(imageUrl, price) : c.updateSelectedFrameImage(imageUrl, price);
          // controller.x = "imageUrl";
          // controller.update();
        },
        child: Container(
          decoration: BoxDecoration(
            color: c.selectedFrameImage == imageUrl || c.selectedEntryImage == imageUrl ? Colors.yellow.withOpacity(.70) : Color(0xFFEEE3E3),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFABD63),
                      Color(0xFFF792F0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Image.network(
                imageUrl,
                width: 70.w,
                height: 70.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFABD63),
                      Color(0xFFF792F0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/store/dollar.png'),
                    SizedBox(width: 3.w),
                    Text(
                      price,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget roomStyleBuilder({isColored = false}) {
    return Padding(
      padding: EdgeInsets.all(30.sp),
      child: Container(
        // padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Container(
            // height: 100.h,
            // width: 100.w,
            decoration: BoxDecoration(
              // color: Color(0xFFFABB64),
              color: isColored ? Color(0xFFFABB64) : Colors.white,
              boxShadow: isColored
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10.r,
                        spreadRadius: 3.r,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Lametna chat",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Image.asset(
                      'assets/images/flags/palestine.png',
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 240.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " 300 ",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: 17.sp,
                            height: 17.sp,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/icons/waves.gif"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Lametna chat",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    "https://media.istockphoto.com/id/1295072146/vector/mini-heart-korean-love-hand-finger-symbol-on-pink-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=eihpG3p1GoSvMjlSAQjCft50iff2I1AweF2a1MLI1SQ=",
                    fit: BoxFit.cover,
                    // width: 50.w,
                    height: 90.h,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget roomOfferBuilder({required String title, required List prices, required int roomPrice}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     blurRadius: 10.r,
        //     spreadRadius: 3.r,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFABD63),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Column(
                  children: [
                    ":عدد المستخدمين",
                    ":عدد السوبر أدمن",
                    ":عدد الأدمن",
                    ":عدد الماستر",
                    ":عدد المميز",
                  ]
                      .mapIndexed(
                        (e, i) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            width: 280.w,
                            color: Color(0xFFDADADC),
                            child: Text(
                              "${prices[i]}$e",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    width: 280.w,
                    color: Color(0xFFFDE742).withOpacity(.35),
                    child: RichText(
                      text: TextSpan(
                        // text: ,

                        style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: roomPrice.toString(),
                          ),
                          TextSpan(
                            text: " دولار كل 3 أشهر ",
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () {
                    // buyOptionModalBuilder();
                    buyRoom();
                  },
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      // color: Color(0xFF6EE1DC),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFABD63),
                          Color(0xFFF792F0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10.r,
                          spreadRadius: 3.r,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "شراء",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget roomTabBuilder({required String title, required int index}) {
    return GetBuilder<StoreDetailsController>(
        init: StoreDetailsController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              controller.changeRoomIndex(index);
            },
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                controller.roomIndex == index
                    ? Container(
                        width: 55.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFABD63),
                              Color(0xFFF792F0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          );
        });
  }

  Widget namesTabBuilder({required String title, required int index}) {
    return GetBuilder<StoreDetailsController>(
        init: StoreDetailsController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              controller.changeNamesIndex(index);
            },
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                controller.namesIndex == index
                    ? Container(
                        width: 55.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFABD63),
                              Color(0xFFF792F0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          );
        });
  }

  Widget vipTabBuilder({required String title, required int index}) {
    return GetBuilder<StoreDetailsController>(
        init: StoreDetailsController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              controller.changeVipIndex(index);
            },
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                controller.vipIndex == index
                    ? Container(
                        width: 55.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFABD63),
                              Color(0xFFF792F0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          );
        });
  }

  Widget namesOfferBuilder({required String title, required List items, required int index, bool isDialog = false, int price = 30, bool isRoot = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),

        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     blurRadius: 10.r,
        //     spreadRadius: 3.r,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFFABD63),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 7.h),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Column(
                  children: items
                      .mapIndexed(
                        (e, i) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            width: 280.w,
                            color: Color(0xFFDADADC),
                            child: Text(
                              "$e",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    width: 280.w,
                    color: Color(0xFFFDE742).withOpacity(.35),
                    child: RichText(
                      text: TextSpan(
                        // text: ,

                        style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: price.toString(),
                          ),
                          TextSpan(
                            text: isRoot == true ? " دولار كل 3 أشهر " : " دولار المدة سنة",
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      width: 280.w,
                      height: 80.h,
                      color: Color(0xFFDADADC),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              Icons.person,
                              size: 33.sp,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * .40,
                            child: Column(
                              mainAxisAlignment: index < 3 && !isRoot ? MainAxisAlignment.end : MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Spacer(),
                                Text(
                                  "Lametna",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                index < 3 && !isRoot
                                    ? Center(
                                        child: Text(
                                          "الحاله",
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                          // Spacer(),
                          isRoot
                              ? Center(
                                  child: Icon(
                                    Icons.verified,
                                    color: Color(0xFFF8BA33),
                                  ),
                                )
                              : index == 0
                                  ? Center(
                                      child: Image.network("${baseURL}test/currentBanner.gif",
                                          // width: 57.5.sp, //45,
                                          height: 40.sp,
                                          fit: BoxFit.fitHeight),
                                    )
                                  : index == 1
                                      ? Image.asset('assets/images/vip.png', height: 45.sp, fit: BoxFit.fitHeight)
                                      : index == 2
                                          ? Image.asset('assets/images/vipBadge.png', height: 45.sp, fit: BoxFit.fitHeight)
                                          : Center(
                                              child: Icon(
                                                Icons.verified,
                                                color: Colors.blue,
                                              ),
                                            )
                        ],
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                isDialog
                    ? SizedBox()
                    : GestureDetector(
                        // onTap: () => showDialog(
                        //   context: Get.context,
                        //   builder: (context) => AlertDialog(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10.r),
                        //     ),
                        //     title: Text(
                        //       "تأكيد الشراء",
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 20.sp,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     content: SingleChildScrollView(
                        //       child: SizedBox(
                        //         width: 300.w,
                        //         child: Container(
                        //           // padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //           decoration: BoxDecoration(boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.withOpacity(0.5),
                        //               blurRadius: 10.r,
                        //               spreadRadius: 3.r,
                        //               offset: Offset(0, 3), // changes position of shadow
                        //             ),
                        //           ]),
                        //           child: namesOfferBuilder(
                        //             index: index,
                        //             items: items,
                        //             title: title,
                        //             isDialog: true,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     actions: [
                        //       Center(
                        //         child: Container(
                        //           // onPressed: () => Get.back(),
                        //           width: 280.w,
                        //           padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //           decoration: BoxDecoration(
                        //             color: Color(0xffF1F1F1),
                        //             borderRadius: BorderRadius.circular(25.r),
                        //             border: Border.all(
                        //               color: Color(0xFFFBF205),
                        //             ),
                        //           ),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //                   Image.asset('assets/icons/store/dollar.png'),
                        //                   SizedBox(width: 3.w),
                        //                   Text(
                        //                     "320",
                        //                     textAlign: TextAlign.center,
                        //                     style: TextStyle(
                        //                       color: Colors.black,
                        //                       fontSize: 15.sp,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Text(
                        //                 "فترة الصلاحية:7 ايام",
                        //                 style: TextStyle(
                        //                   color: Colors.black,
                        //                   fontSize: 15.sp,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        onTap: () {
                          print("object");
                          // buyOptionModalBuilder();
                          isRoot ? buyRoot() : buyAccount();
                        },
                        child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            // color: Color(0xFF6EE1DC),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFABD63),
                                Color(0xFFF792F0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10.r,
                                spreadRadius: 3.r,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "شراء",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> buyOptionModalBuilder({bool isFrame = false}) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      context: Get.context!,
      builder: (context) => SizedBox(
        height: (Get.height * .40).h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: (Get.width * .10).w, vertical: 20.h),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  isFrame ? buyFrame(isForMe: true) : buyEntries(isForMe: true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFFABD63), width: 3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(5.sp),
                  child: Text(
                    "الشراء لنفسك",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: (Get.width * .10).w, vertical: 20.h),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  isFrame ? buyFrame(isForMe: false) : buyEntries(isForMe: false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFFABD63), width: 3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(5.sp),
                  child: Text(
                    "إهداء لصديق",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: (Get.width * .10).w, vertical: 20.h),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFFABD63), width: 3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(5.sp),
                  child: Text(
                    "إلغاء",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabsBuilder({required String title, required int index}) {
    return GetBuilder<StoreDetailsController>(
        init: StoreDetailsController(),
        builder: (c) {
          return GestureDetector(
            onTap: () {
              c.changeSelectedPage(index);
              print(c.selectedPage);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFFFE048),
                ),
                color: c.selectedPage == index ? Color(0xFF6EE1DC) : Colors.white,
                gradient: c.selectedPage == index
                    ? LinearGradient(
                        colors: [
                          Color(0xFFFABD63),
                          Color(0xFFF792F0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: title == "Vip" ? 10.h : 8.w, vertical: title == "Vip" ? 9.h : 5.h),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget nameStyleBuilder({required int index}) {
    return Padding(
      padding: EdgeInsets.all(50.sp),
      child: Container(
        // color: Colors.green,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xFF43D0CA),
          ),
          image: index == 0 || index == 1 ? DecorationImage(image: NetworkImage("${baseURL}test/1.png"), fit: BoxFit.cover) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Image.asset('assets/images/vip.png', height: 33.sp, fit: BoxFit.fitHeight),
            Padding(
              padding: EdgeInsets.only(bottom: index == 2 || index == 1 ? 30.h : 0),
              child: index == 0
                  ? Image.network("${baseURL}test/currentBanner.gif",
                      // width: 57.5.sp, //45,
                      height: 45.sp,
                      fit: BoxFit.fitHeight)
                  : index == 1
                      ? Image.asset('assets/images/vip.png', height: 50.sp, fit: BoxFit.fitHeight)
                      : index == 2
                          ? Image.asset('assets/images/vipBadge.png', height: 50.sp, fit: BoxFit.fitHeight)
                          : Icon(
                              Icons.verified,
                              color: Colors.blue,
                            ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Spacer(),
                Spacer(),
                Stack(
                  children: [
                    index == 0
                        ? Text(
                            "Lametna Chat",
                            style: TextStyle(
                              fontSize: 17.sp,
                              // letterSpacing: 5,
                              // fontFamily:
                              //     "Portada",
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Color(0xFF91FF00),
                            ),
                          )
                        : SizedBox(),
                    Text(
                      "Lametna Chat",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "الحالة",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),

            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.red,
                  size: 35.sp,
                ),
                index == 0
                    ? Image.network(
                        "${baseURL}test/currentBadge.gif",
                        height: 70.sp,
                        width: 70.sp,
                        fit: BoxFit.fitHeight,
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future buyRoom() {
    return showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: Get.height * .64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Spacer(),

                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 35.sp,
                  ),
                ),

                Center(
                  child: Text(
                    "شراء غرفة",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.close,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            MySeparator(
              height: 5.h,
              color: Color(0xFFFABD63),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GetBuilder<StoreDetailsController>(
                  init: StoreDetailsController(),
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "أسم الغرفة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "المدة",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  // height: 30,
                                  width: 100.w,
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                              color: Color(0xFFFABD63),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.r),
                                            ),
                                          ),
                                          color: Color(0xFFE7E7E7),
                                        ),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            isDense: true,

                                            value: controller.roomTime,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 24.sp,
                                            // elevation: 16,

                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                            ),
                                            onChanged: (String? newValue) {
                                              controller.updateRoomTime(newValue!);
                                            },
                                            items: <String>['شهر', '٣ شهور', '٦ شهور', "سنة"].map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Center(
                                                  child: Text(
                                                    value,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "نوع الغرفة",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  // height: 30,
                                  width: 100.w,
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                              color: Color(0xFFFABD63),
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20.r)),
                                          ),
                                          color: Color(0xFFE7E7E7),
                                        ),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            isDense: true,
                                            value: controller.roomType,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 24.sp,
                                            // elevation: 16,

                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                            ),
                                            onChanged: (String? newValue) {
                                              controller.updateRoomType(newValue!);
                                            },
                                            items: <String>['مميزة', 'دهبية', 'فضية'].map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Center(child: Text(value)),
                                              );
                                            }).toList(),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "المدة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          // height: 30,
                          width: Get.width,
                          child: DropdownButtonHideUnderline(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Color(0xFFFABD63),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                  ),
                                  color: Color(0xFFE7E7E7),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,

                                    value: controller.country,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24.sp,
                                    // elevation: 16,

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.updateCountry(newValue!);
                                    },
                                    items: <String>['الجزائر', "مصر", "العراق", "المغرب", "فلسطين", "إسبانيا", "السودان", "سوريا", "تونس", "اليمن"]
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            value,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: Text(
                            "هده المنتج سوف يكلفك 100000 نقطة",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          color: Color(0xFFFFFFD9).withOpacity(.51),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "ملاحظة",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(text: "* يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي "),
                                    TextSpan(text: " master Code"),
                                  ],
                                ),
                                // InlineSpan()
                                // ' يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي ',
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(height: 5.h),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(text: "* "),
                                    TextSpan(
                                        text:
                                            " اعطائك اسماء اشرافات أو اسماء روت بكامل الصلاحيات لاشخاص غير معروفين ويسبب بتخريب غرفتك يؤدي لالغاء اشتراكك أو قد يترتب عليك رسوم اضافية لاعادة تفعيل الاشتراك او تصليح الاخطاء"),
                                  ],
                                ),
                                // InlineSpan()
                                // ' يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي ',
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFfDA8080),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "إلغاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                    ),
                                    actionsPadding: EdgeInsets.zero,
                                    title: Center(
                                      child: Text(
                                        "هل انت متأكد من شراء غرفة",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // content: ElevatedButton(onPressed: () {}, child: Text("data")),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: Color(0xFFFABD63), width: 1.sp),
                                          ),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  errorBuilder();
                                                },
                                                child: Text(
                                                  "الغاء",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 60.h,
                                                child: VerticalDivider(
                                                  width: 2.sp,
                                                  color: Color(0xFFFABD63),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  successBuilder();
                                                },
                                                child: Text(
                                                  "موافق",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFf47A6E5),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "انشاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Future buyAccount() {
    return showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: Get.height * .64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Spacer(),

                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 35.sp,
                  ),
                ),

                Center(
                  child: Text(
                    "شراء أسم مسجل",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.close,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            MySeparator(
              height: 5.h,
              color: Color(0xFFFABD63),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GetBuilder<StoreDetailsController>(
                  init: StoreDetailsController(),
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "الأسم المسجل",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "المدة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          // height: 30,
                          width: 100.w,
                          child: DropdownButtonHideUnderline(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Color(0xFFFABD63),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                  ),
                                  color: Color(0xFFE7E7E7),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,

                                    value: controller.roomTime,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24.sp,
                                    // elevation: 16,

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.updateRoomTime(newValue!);
                                    },
                                    items: <String>['شهر', '٣ شهور', '٦ شهور', "سنة"].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            value,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "رقم اللوحة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: Text(
                            "هده المنتج سوف يكلفك 100000 نقطة",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          color: Color(0xFFFFFFD9).withOpacity(.51),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "ملاحظة",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(text: "* "),
                                    TextSpan(
                                        text:
                                            "يمنع الاشتراك باسم محمي او ملكي شبيه بشكل الأحرف لأي اسم مسجل مسبقا وفي هذه الحالة سيتم حذف اشتراك الاسم وتبديله وخصم مدة  شهرين من تاريخ اشتراك الاسم"),
                                  ],
                                ),
                                // InlineSpan()
                                // ' يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي ',
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFfDA8080),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "إلغاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                    ),
                                    actionsPadding: EdgeInsets.zero,
                                    title: Center(
                                      child: Text(
                                        "هل انت متأكد من شراء أسم مسجل",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // content: ElevatedButton(onPressed: () {}, child: Text("data")),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: Color(0xFFFABD63), width: 1.sp),
                                          ),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  errorBuilder();
                                                },
                                                child: Text(
                                                  "الغاء",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 60.h,
                                                child: VerticalDivider(
                                                  width: 2.sp,
                                                  color: Color(0xFFFABD63),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  successBuilder();
                                                },
                                                child: Text(
                                                  "موافق",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFf47A6E5),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "انشاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Future buyRoot() {
    return showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: Get.height * .64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Spacer(),

                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 35.sp,
                  ),
                ),

                Center(
                  child: Text(
                    "شراء روت",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.close,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            MySeparator(
              height: 5.h,
              color: Color(0xFFFABD63),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GetBuilder<StoreDetailsController>(
                  init: StoreDetailsController(),
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "أسم الروت",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "رقم اللوحة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "المدة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          // height: 30,
                          width: 100.w,
                          child: DropdownButtonHideUnderline(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Color(0xFFFABD63),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                  ),
                                  color: Color(0xFFE7E7E7),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,

                                    value: controller.roomTime,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24.sp,
                                    // elevation: 16,

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.updateRoomTime(newValue!);
                                    },
                                    items: <String>['شهر', '٣ شهور', '٦ شهور', "سنة"].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            value,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),

                        // SizedBox(height: 10.h),
                        Center(
                          child: Text(
                            "هده المنتج سوف يكلفك 100000 نقطة",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          color: Color(0xFFFFFFD9).withOpacity(.51),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "ملاحظة",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(text: "* "),
                                    TextSpan(text: "يتمتع الروت بكافة الصلاحيات"),
                                  ],
                                ),
                                // InlineSpan()
                                // ' يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي ',
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFfDA8080),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "إلغاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                    ),
                                    actionsPadding: EdgeInsets.zero,
                                    title: Center(
                                      child: Text(
                                        "هل انت متأكد من شراء روت",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // content: ElevatedButton(onPressed: () {}, child: Text("data")),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: Color(0xFFFABD63), width: 1.sp),
                                          ),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  errorBuilder();
                                                },
                                                child: Text(
                                                  "الغاء",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 60.h,
                                                child: VerticalDivider(
                                                  width: 2.sp,
                                                  color: Color(0xFFFABD63),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  successBuilder();
                                                },
                                                child: Text(
                                                  "موافق",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFf47A6E5),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "انشاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Future buyFrame({isForMe = true}) {
    return showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: Get.height * .64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Spacer(),

                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 35.sp,
                  ),
                ),

                Center(
                  child: Text(
                    isForMe ? "شراء إطار" : "إرسال إطار هدية لصديق",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.close,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            MySeparator(
              height: 5.h,
              color: Color(0xFFFABD63),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GetBuilder<StoreDetailsController>(
                  init: StoreDetailsController(),
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "أٍسم المستخدم أو الأيدي",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "رقم اللوحة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "المدة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          // height: 30,
                          width: 100.w,
                          child: DropdownButtonHideUnderline(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Color(0xFFFABD63),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                  ),
                                  color: Color(0xFFE7E7E7),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,

                                    value: controller.roomTime,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24.sp,
                                    // elevation: 16,

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.updateRoomTime(newValue!);
                                    },
                                    items: <String>['شهر', '٣ شهور', '٦ شهور', "سنة"].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            value,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),

                        // SizedBox(height: 10.h),
                        Center(
                          child: Text(
                            "هده المنتج سوف يكلفك 100000 نقطة",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          color: Color(0xFFFFFFD9).withOpacity(.51),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "ملاحظة",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(text: "* "),
                                    TextSpan(
                                        text:
                                            "عند إتمام عملية الشراء سوف يتم خصم النقاط من حسابك وتحويل المنتج إلى محفظتك وإرسال إشعار بإتمام العملية"),
                                  ],
                                ),
                                // InlineSpan()
                                // ' يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي ',
                                textDirection: TextDirection.rtl,
                              ),
                              !isForMe
                                  ? SizedBox()
                                  : RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                        children: [
                                          TextSpan(text: "* "),
                                          TextSpan(text: "عند إرسال لصديق سوف يتم خصم من رصيدك وإرسال المنتج بشكل سريع لمحفظته "),
                                        ],
                                      ),
                                      // InlineSpan()
                                      // ' يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي ',
                                      textDirection: TextDirection.rtl,
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFfDA8080),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "إلغاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                    ),
                                    actionsPadding: EdgeInsets.zero,
                                    title: Center(
                                      child: Text(
                                        "هل انت متأكد من شراء روت",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // content: ElevatedButton(onPressed: () {}, child: Text("data")),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: Color(0xFFFABD63), width: 1.sp),
                                          ),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  errorBuilder();
                                                },
                                                child: Text(
                                                  "الغاء",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 60.h,
                                                child: VerticalDivider(
                                                  width: 2.sp,
                                                  color: Color(0xFFFABD63),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  successBuilder();
                                                },
                                                child: Text(
                                                  "موافق",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFf47A6E5),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "انشاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Future buyEntries({isForMe = true}) {
    return showModalBottomSheet(
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: Get.height * .64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Spacer(),

                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 35.sp,
                  ),
                ),

                Center(
                  child: Text(
                    isForMe ? "شراء دخولية" : "إرسال دخولية هدية لصديق",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.close,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            MySeparator(
              height: 5.h,
              color: Color(0xFFFABD63),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GetBuilder<StoreDetailsController>(
                  init: StoreDetailsController(),
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          "أٍسم المستخدم أو الأيدي",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "رقم اللوحة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xFFE7E7E7),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFABD63),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Color(0xFFFABD63), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "المدة",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          // height: 30,
                          width: 100.w,
                          child: DropdownButtonHideUnderline(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Color(0xFFFABD63),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                  ),
                                  color: Color(0xFFE7E7E7),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    isDense: true,

                                    value: controller.roomTime,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24.sp,
                                    // elevation: 16,

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.updateRoomTime(newValue!);
                                    },
                                    items: <String>['شهر', '٣ شهور', '٦ شهور', "سنة"].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            value,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),

                        // SizedBox(height: 10.h),
                        Center(
                          child: Text(
                            "هده المنتج سوف يكلفك 100000 نقطة",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          color: Color(0xFFFFFFD9).withOpacity(.51),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "ملاحظة",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                  children: [
                                    TextSpan(text: "* "),
                                    TextSpan(
                                        text:
                                            "عند إتمام عملية الشراء سوف يتم خصم النقاط من حسابك وتحويل المنتج إلى محفظتك وإرسال إشعار بإتمام العملية"),
                                  ],
                                ),
                                // InlineSpan()
                                // ' يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي ',
                                textDirection: TextDirection.rtl,
                              ),
                              !isForMe
                                  ? SizedBox()
                                  : RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                        children: [
                                          TextSpan(text: "* "),
                                          TextSpan(text: "عند إرسال لصديق سوف يتم خصم من رصيدك وإرسال المنتج بشكل سريع لمحفظته "),
                                        ],
                                      ),
                                      // InlineSpan()
                                      // ' يعني الغاء اشتراكك فقدانك لكود الماستر الرئيسي ',
                                      textDirection: TextDirection.rtl,
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFfDA8080),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "إلغاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.r),
                                    ),
                                    actionsPadding: EdgeInsets.zero,
                                    title: Center(
                                      child: Text(
                                        "هل انت متأكد من شراء روت",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // content: ElevatedButton(onPressed: () {}, child: Text("data")),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(color: Color(0xFFFABD63), width: 1.sp),
                                          ),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  errorBuilder();
                                                },
                                                child: Text(
                                                  "الغاء",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 60.h,
                                                child: VerticalDivider(
                                                  width: 2.sp,
                                                  color: Color(0xFFFABD63),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 50,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  Get.back();
                                                  successBuilder();
                                                },
                                                child: Text(
                                                  "موافق",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFf47A6E5),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                  ),
                                ),
                                child: Text(
                                  "انشاء",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Future<dynamic> successBuilder() {
    return showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
        actionsPadding: EdgeInsets.zero,
        title: Column(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: 60.sp,
              color: Colors.green,
            ),
            Text(
              "تم الشراء بنجاح",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // content: ElevatedButton(onPressed: () {}, child: Text("data")),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFFABD63), width: 1.sp),
              ),
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: GestureDetector(
              onTap: () async {
                Get.back();
              },
              child: Text(
                "موافق",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 17.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> errorBuilder() {
    return showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        ),
        actionsPadding: EdgeInsets.zero,
        title: Column(
          children: [
            Icon(
              Icons.cancel,
              size: 60.sp,
              color: Colors.red,
            ),
            Text(
              "عذرا رصيدك غير كافي للشراء الرجاء التوجه لقسم المبيعات ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // content: ElevatedButton(onPressed: () {}, child: Text("data")),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFFABD63), width: 1.sp),
              ),
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: GestureDetector(
              onTap: () async {
                Get.back();
              },
              child: Text(
                "موافق",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 17.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but the callback has index as second argument
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

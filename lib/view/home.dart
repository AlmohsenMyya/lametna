// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/bottomNavitionBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/view/side%20pages/drawer.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavitionBarController>(
        init: BottomNavitionBarController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              endDrawer: homeDrawer(),
              endDrawerEnableOpenDragGesture: false,
              body: controller.pages[controller.selectedIndex],
              bottomNavigationBar: controller.isShow
                  ? Directionality(
                      textDirection: TextDirection.rtl,
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        currentIndex: controller.selectedIndex,
                        unselectedFontSize: 0,
                        selectedFontSize: 0,
                        onTap: controller.onItemTapped,
                        elevation: 10,
                        useLegacyColorScheme: false,
                        selectedIconTheme: IconThemeData(
                            // color: Colors.red,
                            size: 30.w,
                            weight: 400.0,
                            opticalSize: 33),
                        unselectedIconTheme: IconThemeData(
                          color: Color(0xFFA2ACAC),
                          size: 30.w,
                          weight: 400.0,
                          opticalSize: 33,
                        ),
                        items: !isGuest
                            ? [
                                BottomNavigationBarItem(
                                  // icon: Icon(Icons.home),
                                  icon: ShaderMask(
                                      shaderCallback: (rect) => LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors:
                                                controller.selectedIndex == 0
                                                    ? [
                                                        Color(0xFFF792F0),
                                                        Color(0xFFFABD63),
                                                      ]
                                                    : [
                                                        Color(0xFFA2ACAC),
                                                        Color(0xFFA2ACAC)
                                                      ],
                                            tileMode: TileMode.repeated,
                                          ).createShader(rect),
                                      child: Image.asset(
                                        'assets/icons/home.png',
                                        width: 24.w,
                                        color: controller.selectedIndex == 0
                                            ? Colors.white
                                            : Color(0xFFA2ACAC),
                                        // height: 30.h,
                                      )),

                                  label: '',
                                ),
                                BottomNavigationBarItem(
                                  icon: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: controller.selectedIndex == 1
                                            ? [
                                                Color(0xFFF792F0),
                                                Color(0xFFFABD63),
                                              ]
                                            : [
                                                Color(0xFFA2ACAC),
                                                Color(0xFFA2ACAC)
                                              ],
                                      ).createShader(bounds);
                                    },
                                    child: Image.asset(
                                      'assets/icons/planet.png',
                                      color: controller.selectedIndex == 1
                                          ? Colors.white
                                          : Color(0xFFA2ACAC),
                                      width: 34.w,
                                      // height: 30.h,
                                    ),
                                  ),
                                  label: '',
                                ),
                                BottomNavigationBarItem(
                                  icon: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: controller.selectedIndex == 2
                                            ? [
                                                Color(0xFFF792F0),
                                                Color(0xFFFABD63),
                                              ]
                                            : [
                                                Color(0xFFA2ACAC),
                                                Color(0xFFA2ACAC)
                                              ],
                                      ).createShader(bounds);
                                    },
                                    child: Image.asset(
                                      'assets/icons/chat.png',
                                      color: controller.selectedIndex == 2
                                          ? Colors.white
                                          : Color(0xFFA2ACAC),
                                      width: 24.w,
                                      // height: 30.h,
                                    ),
                                  ),
                                  label: '',
                                ),
                                BottomNavigationBarItem(
                                  icon: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: controller.selectedIndex == 3
                                            ? [
                                                Color(0xFFF792F0),
                                                Color(0xFFFABD63),
                                              ]
                                            : [
                                                Color(0xFFA2ACAC),
                                                Color(0xFFA2ACAC)
                                              ],
                                      ).createShader(bounds);
                                    },
                                    child: Image.asset(
                                      'assets/icons/bag.png',
                                      color: controller.selectedIndex == 3
                                          ? Colors.white
                                          : Color(0xFFA2ACAC),
                                      width: 24.w,
                                      // height: 30.h,
                                    ),
                                  ),
                                  label: '',
                                ),
                              ]
                            : [
                                BottomNavigationBarItem(
                                  // icon: Icon(Icons.home),
                                  icon: ShaderMask(
                                      shaderCallback: (rect) => LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors:
                                                controller.selectedIndex == 0
                                                    ? [
                                                        Color(0xFFF792F0),
                                                        Color(0xFFFABD63),
                                                      ]
                                                    : [
                                                        Color(0xFFA2ACAC),
                                                        Color(0xFFA2ACAC)
                                                      ],
                                            tileMode: TileMode.repeated,
                                          ).createShader(rect),
                                      child: Image.asset(
                                        'assets/icons/home.png',
                                        width: 24.w,
                                        color: controller.selectedIndex == 0
                                            ? Colors.white
                                            : Color(0xFFA2ACAC),
                                        // height: 30.h,
                                      )),

                                  label: '',
                                ),
                                BottomNavigationBarItem(
                                  icon: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: controller.selectedIndex == 1
                                            ? [
                                                Color(0xFFF792F0),
                                                Color(0xFFFABD63),
                                              ]
                                            : [
                                                Color(0xFFA2ACAC),
                                                Color(0xFFA2ACAC)
                                              ],
                                      ).createShader(bounds);
                                    },
                                    child: Image.asset(
                                      'assets/icons/planet.png',
                                      color: controller.selectedIndex == 1
                                          ? Colors.white
                                          : Color(0xFFA2ACAC),
                                      width: 34.w,
                                      // height: 30.h,
                                    ),
                                  ),
                                  label: '',
                                ),
                                BottomNavigationBarItem(
                                  icon: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: controller.selectedIndex == 3
                                            ? [
                                                Color(0xFFF792F0),
                                                Color(0xFFFABD63),
                                              ]
                                            : [
                                                Color(0xFFA2ACAC),
                                                Color(0xFFA2ACAC)
                                              ],
                                      ).createShader(bounds);
                                    },
                                    child: Image.asset(
                                      'assets/icons/bag.png',
                                      color: controller.selectedIndex == 3
                                          ? Colors.white
                                          : Color(0xFFA2ACAC),
                                      width: 24.w,
                                      // height: 30.h,
                                    ),
                                  ),
                                  label: '',
                                ),
                              ],
                      ),
                    )
                  : null,
            ),
          );
        });
  }

  Widget MainAppBar(GlobalKey scaffordKey) {
    return PreferredSize(
      preferredSize: Size.fromHeight(300.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(27.r),
            bottomRight: Radius.circular(27.r),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFFFABD63),
              Color(0xFFF792F0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leadingWidth: 130.w,
            leading: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
              ],
            ),
            title: Text(
              "Lametna",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Image.asset(
                "assets/images/trophy.png",
                width: 55.w,
                height: 30.h,
              ),
              IconButton(
                  onPressed: () {
                    print("object");
                    // Scaffold.of(context).openDrawer();
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                  icon: Icon(Icons.menu)),
            ],
            // actions: [
            //   Image.asset(
            //     "assets/images/trophy.png",
            //     width: 55.w,
            //     height: 30.h,
            //   ),
            //   IconButton(
            //       onPressed: () {
            //         print("object");
            //         Scaffold.of(context).openDrawer();
            //         _scaffoldKey.currentState.openEndDrawer();
            //       },
            //       icon: Icon(Icons.menu)),
            // ],

            bottom: PreferredSize(
                preferredSize: Size.fromHeight(0.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 45.h),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 150.h,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.asset(
                            "assets/images/banner.png",
                            // width: 100.w,
                            // height: 100.h,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ))),
      ),
    );
  }
}

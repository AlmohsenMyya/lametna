// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/bottomNavitionBar.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavitionBarController>(
        init: BottomNavitionBarController(),
        builder: (controller) {
          return Scaffold(
            body: controller.pages[controller.selectedIndex],
            bottomNavigationBar: Directionality(
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
                  color: Colors.black,
                  size: 30.w,
                  weight: 400.0,
                  opticalSize: 33,
                ),
                items: [
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.home),
                    icon: ShaderMask(
                        shaderCallback: (rect) => LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color(0xFFF792F0),
                                Color(0xFFFABD63),
                              ],
                              tileMode: TileMode.repeated,
                            ).createShader(rect),
                        child: Image.asset(
                          'assets/icons/home.png',
                          color: controller.selectedIndex == 0
                              ? Colors.white
                              : Colors.black,
                          width: 24.w,
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
                          colors: [
                            Color(0xFFF792F0),
                            Color(0xFFFABD63),
                          ],
                        ).createShader(bounds);
                      },
                      child: Image.asset(
                        'assets/icons/planet.png',
                        color: controller.selectedIndex == 1
                            ? Colors.white
                            : Colors.black,
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
                          colors: [
                            Color(0xFFF792F0),
                            Color(0xFFFABD63),
                          ],
                        ).createShader(bounds);
                      },
                      child: Image.asset(
                        'assets/icons/chat.png',
                        color: controller.selectedIndex == 2
                            ? Colors.white
                            : Colors.black,
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
                          colors: [
                            Color(0xFFF792F0),
                            Color(0xFFFABD63),
                          ],
                        ).createShader(bounds);
                      },
                      child: Image.asset(
                        'assets/icons/bag.png',
                        color: controller.selectedIndex == 3
                            ? Colors.white
                            : Colors.black,
                        width: 24.w,
                        // height: 30.h,
                      ),
                    ),
                    label: '',
                  ),
                ],
              ),
            ),
          );
        });
  }
}

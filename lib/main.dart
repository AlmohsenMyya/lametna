// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/test.dart';
import 'package:lametna/view/ChoosingPage.dart';
import 'package:lametna/view/LoginPage.dart';
import 'package:get/get.dart';
import 'package:lametna/view/chat/about.dart';
import 'package:lametna/view/chat/moments.dart';
import 'package:lametna/view/chat/roomInfo.dart';
import 'package:lametna/view/chat/roomMangement.dart';
import 'package:lametna/view/chat/roomPageSettings.dart';
import 'package:lametna/view/chatHomePage.dart';
import 'package:lametna/view/customer%20service/ComplaintsSuggestions.dart';
import 'package:lametna/view/customer%20service/customerServiceChat.dart';
import 'package:lametna/view/customer%20service/customerServiceHomePage.dart';
import 'package:lametna/view/customer%20service/salesChat.dart';
import 'package:lametna/view/home.dart';
import 'package:lametna/view/chat/roomPage.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:lametna/view/messages/privateMessages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    DevicePreview(
      builder: (context) => MyApp(),
      enabled: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: Size(428, 926),
      // minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(name: '/loginPage', page: () => LoginPage()),
            GetPage(name: '/choosingPage', page: () => choosingPage()),
            GetPage(name: "/chatHomePage", page: () => ChatHomePage()),
            GetPage(name: "/home", page: () => Home()),
            GetPage(name: '/room', page: () => RoomPage()),
            GetPage(name: '/customerService', page: () => CustomerService()),
            GetPage(name: '/roomMangement', page: () => RoomMangement()),
            GetPage(name: '/roomSettingsPage', page: () => RoomSettingsPage()),
            GetPage(
                name: '/customerServiceChat',
                page: () => CustomerServiceChat()),
            GetPage(name: '/salesChat', page: () => SalesChat()),
            GetPage(
                name: '/complaintsSuggestions',
                page: () => ComplaintsSuggestions()),
            GetPage(name: '/about', page: () => About()),
            GetPage(name: '/moments', page: () => Moments()),
            GetPage(name: '/roomInfo', page: () => RoomInfo()),
            GetPage(name: '/privateMessage', page: () => PrivateMessage()),
          ],
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: test(),
    );
  }
}

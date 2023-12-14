// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/side%20pages/trophy..dart';
import 'package:lametna/test.dart';
import 'package:lametna/view/ChoosingPage.dart';
import 'package:lametna/view/LoginPage.dart';
import 'package:get/get.dart';
import 'package:lametna/view/chat/about.dart';
import 'package:lametna/view/chat/in%20room%20chat/previousChats.dart';
import 'package:lametna/view/chat/moments/postMoment.dart';
import 'package:lametna/view/chat/moments/viewComments.dart';
import 'package:lametna/view/chat/room%20mangement/accountMangement.dart';
import 'package:lametna/view/chat/moments/moments.dart';
import 'package:lametna/view/chat/room%20mangement/advancedSettings.dart';
import 'package:lametna/view/chat/room%20mangement/block/block.dart';
import 'package:lametna/view/chat/room%20mangement/roles/addRole.dart';
import 'package:lametna/view/chat/room%20mangement/roles/editRole.dart';
import 'package:lametna/view/chat/room%20mangement/roomSettings.dart';
import 'package:lametna/view/chat/room%20mangement/side%20pages/callSettings.dart';
import 'package:lametna/view/chat/room%20mangement/side%20pages/cameraSettings.dart';
import 'package:lametna/view/chat/roomInfo.dart';
import 'package:lametna/view/chat/roomMangement.dart';
import 'package:lametna/view/chat/roomPageSettings.dart';
import 'package:lametna/view/chat/roomReport/roomReport.dart';
import 'package:lametna/view/chatHomePage.dart';
import 'package:lametna/view/controller%20panel/controlPanel.dart';
import 'package:lametna/view/countries.dart';
import 'package:lametna/view/customer%20service/ComplaintsSuggestions.dart';
import 'package:lametna/view/customer%20service/customerServiceChat.dart';
import 'package:lametna/view/customer%20service/customerServiceHomePage.dart';
import 'package:lametna/view/customer%20service/salesChat.dart';
import 'package:lametna/view/favourite/favourite.dart';
import 'package:lametna/view/home.dart';
import 'package:lametna/view/chat/roomPage.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:lametna/view/messages/privateMessages.dart';
import 'package:lametna/view/profile/changeBackground.dart';
import 'package:lametna/view/profile/editBackground.dart';
import 'package:lametna/view/profile/editPerson.dart';
import 'package:lametna/view/profile/editPersonalProfile.dart';
import 'package:lametna/view/profile/profile.dart';
import 'package:lametna/view/profile/editProfile.dart';
import 'package:lametna/view/side%20pages/search.dart';
import 'package:lametna/view/side%20pages/viewImage.dart';
import 'package:lametna/view/store/storeDetails.dart';
import 'package:lametna/view/store/test.dart';

import 'view/chat/messagesRoom.dart';
import 'view/chat/in room chat/privateMessageRoom.dart';
import 'view/chat/room mangement/side pages/privateMessages.dart';
// import 'view/controller panel/add root.dart';
// import 'view/controller panel/changePasswordRoom.dart';
// import 'view/controller panel/mainControllerPanel.dart';

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
            GetPage(name: "/countries", page: () => Countries()),
            GetPage(name: "/home", page: () => Home()),
            GetPage(name: '/room', page: () => Room()),
            GetPage(name: '/customerService', page: () => CustomerService()),
            GetPage(name: '/roomMangement', page: () => RoomMangement()),
            GetPage(name: '/roomSettingsPage', page: () => RoomSettingsPage()),
            GetPage(name: '/customerServiceChat', page: () => CustomerServiceChat()),
            GetPage(name: '/salesChat', page: () => SalesChat()),
            GetPage(name: '/complaintsSuggestions', page: () => ComplaintsSuggestions()),
            GetPage(name: '/about', page: () => About()),
            GetPage(name: '/moments', page: () => Moments()),
            GetPage(name: '/roomInfo', page: () => RoomInfo()),
            GetPage(name: '/privateMessage', page: () => PrivateMessage()),
            GetPage(name: '/addAccount', page: () => AddAccount()),
            GetPage(name: '/roles', page: () => RolesPage()),
            GetPage(name: "/search", page: () => Search()),
            GetPage(name: "/roomSetting", page: () => RoomSettings()),
            GetPage(name: "/favourite", page: () => Favourite()),
            GetPage(name: "/trophy", page: () => Trophy()),
            GetPage(name: "/changeBackground", page: () => ChangeBackground()),
            GetPage(name: "/editBackground", page: () => EditBackground()),
            GetPage(name: "/editPerson", page: () => EditPerson()),
            GetPage(name: "/profile", page: () => Profile()),
            GetPage(name: "/editProfile", page: () => EditProfileAccount()),
            GetPage(name: "/mainControllerPanel", page: () => ControlPanel()),
            // GetPage(name: "/changePasswordRoom", page: () => ChangePasswordRoom()),
            GetPage(name: "/privateMessageRoom", page: () => PrivateMessageRoom()),
            // GetPage(name: "/addRoot", page: () => AddRoot()),
            GetPage(name: "/postMoment", page: () => PostMoment()),
            GetPage(name: "/viewImage", page: () => ViewImage()),
            GetPage(
              name: '/previousChat',
              page: () => PreviosChat(),
            ),
            GetPage(name: "/advancedSettings", page: () => AdvancedSettings()),
            GetPage(name: "/cameraSettings", page: () => CameraSettings()),
            GetPage(name: "/callSettings", page: () => CallSettings()),
            GetPage(name: "/blockPage", page: () => Blocked()),
            GetPage(name: "/viewComments", page: () => ViewComments()),
            GetPage(name: "/editPersonalProfile", page: () => EditPersonalProfile()),
            GetPage(name: "/privateMessagesSettings", page: () => PrivateMessages()),
            GetPage(name: "/roomReport", page: () => RoomReport()),
            GetPage(name: "/storeDetails", page: () => StoreDetails()),
            GetPage(name: "/editRole", page: () => EditRole()),
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
      // child: SimpleRecorder(),
      child: choosingPage(), //////////////////
      // child: test(),
    );
  }
}

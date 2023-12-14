// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/chat/room%20managment/advancedSettingsController.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lametna/view/chat/In%20Room%20Widgets/appBar.dart';
import 'package:lametna/view/chat/room%20mangement/side%20pages/callSettings.dart';
import 'package:lametna/view/chat/room%20mangement/side%20pages/custom_expansion.dart';
import 'package:lametna/view/store/storeDetails.dart';

class RoomSettingController extends GetxController {
  // var color = Get.arguments["color"];

  TextEditingController statusController = TextEditingController();
  TextEditingController helloController = TextEditingController();
  TextEditingController welcomeMsg = TextEditingController();

  var callDuration = TextEditingController();
  File roomImage;
  File backgroundRoomImage;
  var roomInfo;
  Color pickerColor = Colors.black;
  var timeFormat = "0";
  // bool cameraStatus = false;
  // bool privateMessageStatus = false;
  // bool roomLockStatus = false;
  bool mic = false;

  bool isLoading = false;
  TextEditingController dialogController = TextEditingController();

  String cameraRadio;
  String privateMessageStatus;
  String roomLock;
  String roomType;
  String speech;
  String roomImageUrl;

  String guestCallTime;
  String memberTalkTime;
  String adminTalkTime;
  String superTalkTime;
  String masterTalkTime;
  String room_plan;
  String roomLockResone;
  TextEditingController controllertext = TextEditingController();
  var setting = [
    {
      "name": "الصورة الشخصية الخاصة بالغرفة",
      "icon": Icons.photo,
      "isExpanded": false,
    },
    {
      "name": "الغرف الصوتية",
      "icon": Icons.volume_up_rounded,
      "isExpanded": false,
    },
    {
      "name": "الحالة",
      "icon": Icons.mood,
      "isExpanded": false,
    },
    {
      "name": "رسالة ترحيب",
      "icon": Icons.email,
      "isExpanded": false,
    },
    {
      "name": "التحدث",
      "icon": Icons.mic,
      "isExpanded": false,
    },
    {
      "name": "رسالة الدخول",
      "icon": Icons.email,
      "isExpanded": false,
    },
    {
      "name": "الكاميرا",
      "icon": Icons.photo_camera_front,
      "isExpanded": false,
    },
    {
      "name": "الرسائل الخاصة",
      "icon": Icons.voice_chat,
      "isExpanded": false,
    },
    {
      "name": "قفل الغرفة",
      "icon": Icons.lock_outline,
      "isExpanded": false,
    },
    {
      "name": "نمط الغرفة",
      "icon": Icons.color_lens,
      "isExpanded": false,
    },
    {
      "name": "صلاحيات الماستر",
      "icon": Icons.star_border_rounded,
      "isExpanded": false,
    },
    {
      "name": "خيارات الارسال",
      "icon": Icons.block,
      "isExpanded": false,
    },
  ];

  List colorToPick = [
    "#b0b0b0",
    "#a2979b",
    "#8a8a8a",
    "#9c8188",
    "#8c6e62",
    "#5d4038",
    "#bbc644",
    "#c0b654",
    "#96a57a",
    "#c39c61",
    "#fec400",
    "#e3a945",
    "#7cc3d3",
    "#4ab6b8",
    "#4da98a",
    "#208647",
    "#465a65",
    "#506c94",
    "#608fc4",
    "#1693c3",
    "#6b7ce4",
    "#283593",
    "#c96bdb",
    "#cb34ff",
    "#d7bde2",
    "#c29bd2",
    "#8b6c96",
    "#ac70df",
    "#954fe3",
    "#953fc6",
    "#ec90d7",
    "#e05eb4",
    "#b4529d",
    "#a4359b",
    "#820182",
    "#ac1457",
    "#e699a3",
    "#f48fb1",
    "#e46e94",
    "#e05e5e",
    "#c65b7b",
    "#a1416e",
  ];
  int selectedIndex = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getData();
  }

  getData() async {
    var url = Uri.parse(roomInfoUrl);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);

    if (response.statusCode == 200) {
      // dataBody = dataBody["data"][0];
      roomInfo = await dataBody["data"][0];
      guestCallTime = dataBody["data"][0]["guestCallTime"];
      memberTalkTime = dataBody["data"][0]["memberCallTime"];
      adminTalkTime = dataBody["data"][0]["adminCallTime"];
      superTalkTime = dataBody["data"][0]["superAdminCallTime"];
      masterTalkTime = dataBody["data"][0]["masterCallTime"];
      roomLock = dataBody["data"][0]["roomLock"];
      statusController.text = roomInfo["description"];
      helloController.text = roomInfo["hello_msg"];
      // cameraStatus = roomInfo["camera"] == "true" ? true : false;
      privateMessageStatus = roomInfo["privateMessages"];
      roomImageUrl = roomImagesURL + roomInfo["room_img"];
      welcomeMsg.text = dataBody["data"][0]["welcomeMsg"];
      room_plan = dataBody["data"][0]["room_plan"];
      roomLockResone = dataBody["data"][0]["roomLockResone"];
      // print(roomImageUrl);
      // roomLockStatus = roomInfo["roomLock"] == "true" ? true : false;

      // pickerColor = Color(int.parse(roomInfo["background_color"]));
      pickerColor = Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000); //////////////////
      cameraRadio = roomInfo["camera"];
      roomType = roomInfo["room_type"];
      speech = roomInfo["speech"];
      mic = dataBody["data"][0]["isMic"] == "true" ? true : false;
      // selectedIndex = int.parse(roomInfo["numberOfMic"]);
      if (roomInfo["numberOfMic"] == "3") {
        selectedIndex = 0;
      }
      if (roomInfo["numberOfMic"] == "5") {
        selectedIndex = 1;
      }
      if (roomInfo["numberOfMic"] == "6") {
        selectedIndex = 2;
      }
      // print(pickerColor.toString() + "---------");

      // await update();
      update();
      controllertext.text = roomLockResone;
      print(roomInfo);
      print("-----");
    }
  }

  changeSelectedIndex(double index) {
    selectedIndex = index.toInt();
    update();
  }

  Future<File> getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  uploadRoomImage(String roomId) async {
    isLoading = true;
    update();
    final image = await getImageFromGallery();
    if (image == null) {
      isLoading = false;
      update();
    } else {
      var request = http.MultipartRequest('POST', Uri.parse(roomImageUrl));
      request.fields['room_id'] = roomId;
      request.files.add(
        await http.MultipartFile.fromPath(
          'room_img',
          image.path,
          filename: "$roomId.jpeg".toString(),
        ),
      );
      var res = await request.send();

      if (res.statusCode == 200) {
        print("Uploaded!--");
        isLoading = false;
        update();

        Get.snackbar("title", "uploaded");
      } else {
        print("Failed!");
      }
    }
  }

  changeMic(bool value) {
    mic = value;
    update();
  }

  uploadBackgroundRoomImage(String roomId) async {
    // pickBackgroundRoomImage();
    // isLoading = true;
    // update();
    final image = await getImageFromGallery();
    if (image == null) {
      isLoading = false;
      update();
    } else {
      var request = http.MultipartRequest('POST', Uri.parse(roomBackgroundImage));
      request.fields['room_id'] = roomId;
      request.files.add(
        await http.MultipartFile.fromPath(
          'background_img',
          image.path,
          filename: "$roomId.jpeg".toString(),
        ),
      );
      var res = await request.send();

      if (res.statusCode == 200) {
        print("Uploaded!");
        // Get.back();
        isLoading = false;
        update();
        Get.snackbar("title", "uploaded");
      } else {
        print("Failed!");
      }
    }
  }

  changeSettings(String roomId) async {
    var request = http.MultipartRequest('POST', Uri.parse(roomSetting));
    request.fields['room_id'] = roomId;
    request.fields['description'] = statusController.text.trim();
    request.fields['hello_msg'] = helloController.text.trim();
    request.fields['camera'] = cameraRadio.toString();
    request.fields['roomLock'] = roomLock.toString();
    request.fields['privateMessages'] = privateMessageStatus.toString();
    request.fields['speech'] = speech.toString();
    request.fields['guestCallTime'] = guestCallTime.toString();
    request.fields['memberCallTime'] = memberTalkTime.toString();
    request.fields['adminCallTime'] = adminTalkTime.toString();
    request.fields['superAdminCallTime'] = superTalkTime.toString();
    request.fields['masterCallTime'] = masterTalkTime.toString();
    request.fields['background_color'] = "#" + pickerColor.toString().substring(10, 16);
    request.fields['welcomeMsg'] = welcomeMsg.text;
    request.fields['roomLockResone'] = controllertext.text;
    request.fields['isMic'] = mic.toString();

    if (selectedIndex == 0) {
      request.fields['numberOfMic'] = "3";
    }
    if (selectedIndex == 1) {
      request.fields['numberOfMic'] = "5";
    }
    if (selectedIndex == 2) {
      request.fields['numberOfMic'] = "6";
    }

    // request.fields['roomLock'] = roomLockStatus.toString();

    // request.fields['background_color'] =
    //     '#ffffff'; // replace with actual color code
    var res = await request.send();

    if (res.statusCode == 200) {
      print("Uploaded!");
      // Get.snackbar("title", "uploaded");
      void showSnackBar(BuildContext context) {
        final snackBar = SnackBar(
          width: 170.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          content: Center(
            child: Text(
              'تم تعديل اعدادات الغرفة',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.grey[100],
          behavior: SnackBarBehavior.floating,
          // margin: EdgeInsets.all(50),
          padding: EdgeInsets.all(10.sp),
          duration: Duration(milliseconds: 1000),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      showSnackBar(Get.context);
    } else {
      print("Failed!");
    }
  }

  void updatePickerColor(String color) {
    pickerColor = Color(int.parse(color.toString().substring(1), radix: 16) + 0xFF000000);

    update();
    // print(pickerColor.toString());
  }

  void alertDialog(
    String title, {
    String controller,
  }) {
    showDialog(
      context: Get.context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "مدة تحدث لل$title",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                (title == "زائر")
                    ? intToTimeLeft(int.parse(guestCallTime))
                    : (title == "ممبر")
                        ? intToTimeLeft(int.parse(memberTalkTime))
                        : (title == "أدمن")
                            ? intToTimeLeft(int.parse(adminTalkTime))
                            : (title == "سوبر أدمن")
                                ? intToTimeLeft(int.parse(superTalkTime))
                                : intToTimeLeft(
                                    int.parse(masterTalkTime),
                                  ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.w),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    onChanged: (v) {
                      controller = v;
                      update();
                      print("upadted");
                      intToTimeLeft(int.parse(dialogController.text.trim()));
                    },
                    onEditingComplete: () {
                      controller = dialogController.text.trim();
                      update();
                      print(dialogController.text.trim());
                      intToTimeLeft(int.parse(dialogController.text.trim()));
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    controller: dialogController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      // enabledBorder: InputBorder,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // print(controller.toString());
                  if (title == "زائر") {
                    if (dialogController.text.trim() != "") {
                      guestCallTime = dialogController.text.trim();
                    }
                  }
                  if (title == "ممبر") {
                    if (dialogController.text.trim() != "") {
                      memberTalkTime = dialogController.text.trim();
                    }
                  }
                  if (title == "أدمن") {
                    if (dialogController.text.trim() != "") {
                      adminTalkTime = dialogController.text.trim();
                    }
                  }
                  if (title == "سوبر أدمن") {
                    if (dialogController.text.trim() != "") {
                      superTalkTime = dialogController.text.trim();
                    }
                  }
                  if (title == "ماستر") {
                    if (dialogController.text.trim() != "") {
                      masterTalkTime = dialogController.text.trim();
                    }
                  }
                  update();
                  Get.back();
                  dialogController.clear();
                  // update();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    // color: Color(0xFFE60000),
                    color: Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000),

                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "موافق",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String result = "$h:$m:$s";

    // timeFormat = result;
    // update();
    return result;
  }

  changeExpansionTileStatus(int index) {
    setting[index]["isExpanded"] = !setting[index]["isExpanded"];
    update();
  }

  colorPickerBuilder() {
    showDialog(
      context: Get.context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(10.sp),
        content: Builder(
          builder: (context) {
            return SizedBox(
              // insetPadding: EdgeInsets.zero,
              width: Get.width,
              height: Get.height * 0.46,
              // width: 200.w,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: colorToPick.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Get.back();
                    print(colorToPick[index]);
                    print(pickerColor.toString().substring(10, 16));
                    updatePickerColor(colorToPick[index].toString());
                  },
                  child: Container(
                    // padding: EdgeInsets.all(20.w),
                    color: Color(int.parse(colorToPick[index].toString().substring(1), radix: 16) + 0xFF000000),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  colorPicker() {
    showDialog(
      context: Get.context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          // child: ColorPicker(
          //   pickerColor: pickerColor,
          //   onColorChanged: (value) {
          // print(value.toString().substring(10, value.toString().length - 1));
          // updatePickerColor("#" + value.toString().substring(10, value.toString().length - 1));
          //   },
          //   displayThumbColor: false,
          //   // enableAlpha: false,
          //   hexInputBar: false,

          // ),
          child: ColorPicker(
            pickerColor: pickerColor,
            paletteType: PaletteType.hueWheel,
            onColorChanged: (value) {
              print(value.toString().substring(10, value.toString().length - 1));
              updatePickerColor("#" + value.toString().substring(10, value.toString().length - 1));
            },
            enableAlpha: false,
            labelTypes: const [],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('نعم'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  dialog(String title, String pastTime) {
    showDialog(
      context: Get.context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Stack(
          // overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.lightBlue),
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Text("You can make cool stuff!", style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
            ),
            Positioned(
              top: -100,
              child: Image.network("https://i.imgur.com/2yaf2wb.png", width: 150, height: 150),
            )
          ],
        ),
      ),
    );
  }

  changeCameraRadio(String value) {
    cameraRadio = value;
    // print(cameraRadio);
    update();
  }

  changePrivateMessagesRadio(String value) {
    privateMessageStatus = value;
    // print(privateMessagesRadio);
    update();
  }

  changeSpeech(String value) {
    speech = value;
    // print(speechRadio);
    update();
  }

  expansionTileChildren({int index}) {
    if (index == 0) {
      return Container();
    } else if (index == 1) {
      return Container(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['المظهر الحديث', 'المظهر القديم']
                .mapIndexed(
                  (e, i) => RadioListTile<String>(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                    value: i.toString(),
                    title: Text(
                      e,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    groupValue: room_plan,
                    activeColor: Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000),
                    onChanged: (value) {
                      print(value);
                      // privateMessageStatus = value;
                      room_plan = value.toString();
                      Get.put(RoomsPageController()).changeRoomStatus();
                      update();
                    },
                  ),
                )
                .toList(),
          ),
        ),
      );
    } else if (index == 2) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "عنوان الحالة:",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: statusController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.25),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (index == 3) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "عنوان الرسالة الترحيب:",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: helloController,
                maxLines: 7,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.25),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (index == 4) {
      // Get.to(() => CallSettings());retu
      return SizedBox();
      // return {
      //   Get.to(() => CallSettings()),
      // };
    } else if (index == 5) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "عنوان رسالة الدخول:",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                controller: welcomeMsg,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.25),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (index == 6) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "من يستطيع بث الكاميرة:",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['الجميع', 'الأعضاء والمشرفين فقط', 'المشرفين فقط', 'لا أحد']
                  .map(
                    (e) => RadioListTile(
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                      value: e,
                      title: Text(
                        e,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      groupValue: cameraRadio,
                      selected: true,
                      activeColor: Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000),
                      onChanged: (value) {
                        print(value);
                        cameraRadio = value;
                        update();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );
    } else if (index == 7) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "من يستطيع بدا محادثة خاصة:",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['الجميع', 'الأعضاء والمشرفين فقط', 'المشرفين فقط', 'لا أحد']
                  .map(
                    (e) => RadioListTile(
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                      value: e,
                      title: Text(
                        e,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      groupValue: privateMessageStatus,
                      selected: true,
                      activeColor: Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000),
                      onChanged: (value) {
                        print(value);
                        privateMessageStatus = value;
                        update();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );
    } else if (index == 8) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "مفتوح",
            "الاعضاء والمشرفين فقط",
            "بوابة دخول",
          ]
              .mapIndexed(
                (e, i) => i == 2
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: TextFormField(
                              controller: controllertext,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.sp),
                                hintText: 'سبب القفل',
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          RadioListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                            value: e,
                            title: Text(
                              e,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                            groupValue: roomLock,
                            activeColor: Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000),
                            selected: true,
                            onChanged: (value) {
                              // print(value["value"].toString());
                              roomLock = value;
                              update();
                            },
                          ),
                        ],
                      )
                    : RadioListTile(
                        dense: true,
                        visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                        value: e,
                        title: Text(
                          e,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        groupValue: roomLock,
                        activeColor: Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000),
                        selected: true,
                        onChanged: (value) {
                          // print(value["value"].toString());
                          roomLock = value;
                          update();
                        },
                      ),
              )
              .toList(),
        ),
      );
    } else if (index == 9) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: GestureDetector(
            onTap: () {
              print(roomInfo["background_color"]);
            },
            child: AppBar(
              // backgroundColor: Color(int.parse(roomInfo["themeColor"].toString().substring(2), radix: 16) + 0xFF000000),
              backgroundColor: pickerColor,
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              actions: [
                Icon(Icons.volume_up),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Image.asset(
                    'assets/icons/chat.png',
                    color: Colors.white,
                    width: 20.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Image.asset(
                    'assets/icons/group.png',
                    width: 30.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (index == 10) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "قفل اللوحة / صلاحيات الماستر",
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
            GetBuilder<AdvancedSettingsController>(
              init: AdvancedSettingsController(),
              builder: (controller) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // index = 3;
                    return SizedBox(
                      width: 60.w,
                      height: 50.h,
                      child: SwitchListTile(
                        title: Text(
                          controller.masterOption[index]["title"],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        // activeColor: Colors.black,
                        dense: true,
                        // controlAffinity: ListTileControlAffinity.leading,
                        value: index == 0 ? controller.allowAddMaster : controller.allowEditRoomSettings,
                        onChanged: (value) {
                          print(index);
                          index == 0 ? controller.changeAllowAddMaster(value) : controller.changeAllowEditRoomSettings(value);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                    );
                  },
                  itemCount: controller.masterOption.length,
                );
              },
            ),
          ],
        ),
      );
    } else if (index == 11) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GetBuilder<AdvancedSettingsController>(
          init: AdvancedSettingsController(),
          builder: (controller) {
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // index = 3;
                return CustomExpansionTile(
                  title: Text(
                    controller.sendOption[index]["title"],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  children: ['الجميع', 'الأعضاء والمشرفين فقط', 'المشرفين فقط', 'لا أحد']
                      .map(
                        (e) => RadioListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                          value: e,
                          title: Text(
                            e,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                          groupValue: index == 0
                              ? controller.sendImage
                              : index == 1
                                  ? controller.sendText
                                  : index == 2
                                      ? controller.sendVoiceInPrivate
                                      : index == 3
                                          ? controller.sendAlerts
                                          : controller.roomEntries,
                          selected: true,
                          activeColor: Color(int.parse(roomInfo["themeColor"].toString().substring(1), radix: 16) + 0xFF000000),
                          onChanged: (value) {
                            print(value);
                            index == 0
                                ? controller.changeSendImage(value)
                                : index == 1
                                    ? controller.changeSendText(value)
                                    : index == 2
                                        ? controller.changeSendVoiceInPrivate(value)
                                        : index == 3
                                            ? controller.changeSendAlerts(value)
                                            : controller.changeRoomEntries(value);
                            update();
                          },
                        ),
                      )
                      .toList(),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 30.sp,
                  ),

                  // contentPadding: EdgeInsets.zero,
                  // activeColor: Colors.black,
                  // dense: true,
                  // // controlAffinity: ListTileControlAffinity.leading,
                  // value: index == 0
                  //     ? controller.sendImage
                  //     : index == 1
                  //         ? controller.sendText
                  //         : index == 2
                  //             ? controller.sendVoiceInPrivate
                  //             : index == 3
                  //                 ? controller.sendAlerts
                  //                 : controller.roomEntries,
                  // onChanged: (value) {
                  //   print(index);

                  // },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey.withOpacity(0.5),
                  thickness: 1,
                );
              },
              itemCount: controller.sendOption.length,
            );
          },
        ),
      );
    }
  }
}

// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class RoomSettingController extends GetxController {
  TextEditingController statusController = TextEditingController();
  TextEditingController helloController = TextEditingController();
  File roomImage;
  File backgroundRoomImage;
  var roomInfo;
  Color pickerColor = Colors.black;
  bool cameraStatus = false;
  bool privateMessageStatus = false;
  bool roomLockStatus = false;

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getData();
    // Timer.periodic(Duration(seconds: 10), (timer) {
    //   // print(channelName);
    //   // print(token);
    //   toggleLoading();

    //   // return getData();
    // });
  }

  getData() async {
    var url = Uri.parse(roomInfoUrl);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);

    if (response.statusCode == 200) {
      roomInfo = dataBody;
      statusController.text = dataBody["data"][0]["description"];
      helloController.text = dataBody["data"][0]["hello_msg"];
      cameraStatus = dataBody["data"][0]["camera"] == "true" ? true : false;
      privateMessageStatus =
          dataBody["data"][0]["privateMessages"] == "true" ? true : false;
      roomLockStatus = dataBody["data"][0]["roomLock"] == "true" ? true : false;
      update();
    }
  }

  Future<File> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
        // Get.back();
        isLoading = false;
        update();

        Get.snackbar("title", "uploaded");
      } else {
        print("Failed!");
      }
    }
  }

  uploadBackgroundRoomImage(String roomId) async {
    // pickBackgroundRoomImage();
    isLoading = true;
    update();
    final image = await getImageFromGallery();
    if (image == null) {
      isLoading = false;
      update();
    } else {
      var request =
          http.MultipartRequest('POST', Uri.parse(roomBackgroundImage));
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
    var request = http.MultipartRequest('POST', Uri.parse(roomSettings));
    request.fields['room_id'] = roomId;
    request.fields['description'] = statusController.text.trim();
    request.fields['hello_msg'] = helloController.text.trim();
    request.fields['camera'] = cameraStatus.toString();
    request.fields['privateMessages'] = privateMessageStatus.toString();
    request.fields['roomLock'] = roomLockStatus.toString();

    // request.fields['background_color'] =
    //     '#ffffff'; // replace with actual color code
    var res = await request.send();

    if (res.statusCode == 200) {
      print("Uploaded!");
      Get.snackbar("title", "uploaded");
    } else {
      print("Failed!");
    }
  }

  void updatePickerColor(Color color) {
    pickerColor = color;
    update();
    // print(fontColor);
  }

  pickColor() {
    Get.defaultDialog(
      content: ColorPicker(
        showLabel: false,
        pickerColor: pickerColor,
        onColorChanged: (value) {
          updatePickerColor(value);
        },
      ),
    );
  }

  changeCameraStatus() {
    cameraStatus = !cameraStatus;
    update();
    Get.snackbar(
        "الكاميرا", cameraStatus ? "تم فتح الكاميرا" : "تم قفل الكاميرا");
  }

  changePrivateMessageStatus() {
    privateMessageStatus = !privateMessageStatus;
    update();
    Get.snackbar(
        "الرسائل الخاصة",
        privateMessageStatus
            ? "تم فتح الرسائل الخاصة"
            : "تم قفل الرسائل الخاصة");
  }

  changeRoomLockStatus() {
    roomLockStatus = !roomLockStatus;
    update();
    Get.snackbar(
        "قفل الغرفة", roomLockStatus ? "تم فتح قفل الغرفة" : "تم قفل الغرفة");
  }

  void alertDialog(
    String title, {
    TextEditingController textEditingController,
  }) {
    Get.defaultDialog(
      title: "تعديل $title",
      titleStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'Portada',
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            style: TextStyle(color: Colors.black),
            controller: textEditingController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
              border: OutlineInputBorder(),
              hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Portada',
              ),
            ),
          ),
        ),
      ),
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          "حسنا",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Portada',
          ),
        ),
      ),
    );
  }

  // Future<void> sndSetting() async {
  //   var url = Uri.parse(roomSettings);
  //   var request = http.MultipartRequest('POST', url);
  //   request.fields['room_id'] = "1";
  //   request.fields['status'] = statusController.text.trim();
  //   request.fields['hello_msg'] = helloController.text.trim();
  //   request.fields['background_color'] =
  //       '#ffffff'; // replace with actual color code
  //   if (_image != null) {
  //     var stream = http.ByteStream(_image.openRead());
  //     var length = await _image.length();
  //     var multipartFile = http.MultipartFile(
  //       'background_img',
  //       stream,
  //       length,
  //       filename: _image.path.split('/').last,
  //     );
  //     request.files.add(multipartFile);
  //   }

  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     final dataBody = json.decode(await response.stream.bytesToString());
  //     if (dataBody['status'] == 'success') {
  //       print('Success');
  //       print('room_id');
  //     } else {
  //       print('Error');
  //     }
  //   } else {
  //     print('Error: ${response.reasonPhrase}');
  //   }
  // }

  // Future<void> sendImageToBackend(File image) async {
  //   // final url = sendSetting;
  //   final request = http.MultipartRequest('POST', Uri.parse(roomSettings));
  //   final imageStream = http.ByteStream(image.openRead());
  //   final imageLength = await image.length();
  //   final multipartFile = http.MultipartFile(
  //     'image',
  //     imageStream,
  //     imageLength,
  //     filename: image.path.split('/').last,
  //   );
  //   request.fields['room_id'] = '1';
  //   request.files.add(multipartFile);

  //   final response = await request.send();
  //   if (response.statusCode == 200) {
  //     print('Image uploaded successfully!');
  //   } else {
  //     print('Failed to upload image. Error code: ${response.statusCode}');
  //   }
  // }
}

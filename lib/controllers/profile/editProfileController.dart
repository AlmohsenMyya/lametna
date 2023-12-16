// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/profile/profileController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lametna/controllers/userData/variables.dart';

class EditProfileController extends GetxController {
  // List roles = [];
  var data;
  String dropdownValue = 'اعزب';
  TextEditingController nameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController asrologyController = TextEditingController();
  TextEditingController chatStatusController = TextEditingController();

  //password
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // File _selectedImage;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getData();
    isLoading = true;
  }

  Future getData() async {
    var url = Uri.parse(userInfo);
    var response = await http.post(url, body: {
      "username": userName,
    });
    if (response.statusCode == 200) {
      final dataBody = json.decode(response.body);
      data = dataBody["data"];
      print(dataBody);
      isLoading = false;
      update();
      // roles.add(data["data"])
      // print(json.decode(response.body));
    }
  }

  Future<File?> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // void pickImage() async {
  //   final image = await getImageFromGallery();
  //   _selectedImage = image;
  //   update();
  // }

  void sendImageToAPI() async {
    // await pickImage();
    final image = await getImageFromGallery();

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(updateUserImage));

    // Set headers if required
    request.fields['userid'] = userId;

    // Add the image file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image!.path,
        filename: "$userName.jpeg".toString(),
      ),
    );

    // Add additional parameters

    // Send the request
    var response = await request.send();
    print("object");

    // Process the response
    if (response.statusCode == 200) {
      // Image successfully uploaded
      print('Image uploaded!');
      Get.put(ProfileController()).getData();
      getData();
    } else {
      // Error occurred
      print('Error uploading image. Status code: ${response.statusCode}');
    }
  }

  editPassword() async {
    var url = Uri.parse(changePassword);

    if (passwordController.text.trim().isNotEmpty &&
        newPasswordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty) {
      //  var response = await http.post(url,)
      if (newPasswordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        // var response = await http.post(url, body: {
        //   "userid": userId,
        //   "password": passwordController.text.trim(),
        //   "newPassword": newPasswordController.text.trim(),
        // });
      } else {
        Get.snackbar(
          "",
          "",
          backgroundColor: Color(0xFFDC3545),
          titleText: Text(
            "تنبية",
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 22.sp),
          ),
          messageText: Text(
            "كلمة المرور غير متطابقة",
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 22.sp, color: Colors.white),
          ),
        );
      }
    }
  }

  sendData() async {
    var url = Uri.parse(editUserInfo);

    var response = await http.post(url, body: {
      "userid": userId,
      "nickname": nameController.text.trim().isEmpty
          ? data["nickname"]
          : nameController.text.trim(),
      "sex": sexController.text.trim().isEmpty
          ? data["sex"]
          : sexController.text.trim(),
      "birthday": birthdayController.text.trim().isEmpty
          ? data["birthday"]
          : birthdayController.text.trim(),
      "gender": nationalityController.text.trim().isEmpty
          ? data["gender"]
          : nationalityController.text.trim(),
      "status": dropdownValue,
      "sign": asrologyController.text.trim().isEmpty
          ? data["sign"]
          : asrologyController.text.trim(),
      "chatStatus": chatStatusController.text.trim().isEmpty
          ? data["chatStatus"]
          : chatStatusController.text.trim(),
    });
    if (response.statusCode == 200) {
      getData();
      editPassword();
      Get.put(ProfileController()).getData();
      Get.snackbar(
        "",
        "",
        backgroundColor: Color(0xFF198754),
        titleText: Text(
          "تنبية",
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 22.sp),
        ),
        messageText: Text(
          "عملية ناجيحة",
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 22.sp, color: Colors.white),
        ),
      );
    }
  }

  changeDropdownValue(String value) {
    dropdownValue = value;
    update();
  }
}

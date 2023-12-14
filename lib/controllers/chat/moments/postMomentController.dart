// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/profile/profileController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/userData/variables.dart';

class PostMomentController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  StreamController streamController = StreamController();
  var pickedFile;
  var imagePath;
  bool withImage = false;
  getImageFromGallery() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = File(pickedFile.path);
      withImage = true;
      update();
      // return File(pickedFile.path);
    }
  }

  deleteImage() {
    pickedFile = null;
    imagePath = null;
    withImage = false;

    update();
  }

  storyWithTextOnly() async {
    // addStoryWithImage
    // addStory
    if (textEditingController.text != "") {
      var res = await http.post(Uri.parse(addStory), body: {
        "username": userName,
        "text": textEditingController.text,
      });
      var dataBody = json.decode(res.body);

      print(dataBody);
    }
  }

  void storyWithImage() async {
    // await pickImage();
    // final image = await getImageFromGallery();

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(addStoryWithImage));

    // Set headers if required
    request.fields['username'] = userName;
    request.fields['text'] = textEditingController.text;

    // Add the image file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imagePath.path,
        // filename: "${userName}.jpeg".toString(),
      ),
    );
    var response = await request.send();
    print("object");

    // Process the response
    if (response.statusCode == 200) {
      // Image successfully uploaded
      print('Image uploaded!');
      // Get.put(ProfileController()).getData();
      // getData();
    } else {
      // Error occurred
      print('Error uploading image. Status code: ${response.statusCode}');
    }
  }

  getAllStories() async {
    var res = await http.post(Uri.parse('https://lametnachat.com/stories/viewstories.php'), body: {
      "username": userName,
    });
    var dataBody = json.decode(res.body);
    streamController.sink.add(dataBody["data"]);
    update();
    // print(dataBody);
    // return dataBody["data"];
  }

  postStory() async {
    if (withImage) {
      await storyWithImage();
    } else {
      await storyWithTextOnly();
    }
    textEditingController.clear();
    Get.back();
  }

  deleteStory(String storyId) async {
    var res = await http.post(Uri.parse(deleteStoryUrl), body: {
      // "username": userName,
      "storyId": storyId,
    });
    var dataBody = json.decode(res.body);
    if (res.statusCode == 200) {
      Get.snackbar("تم", "تم حذف القصة بنجاح", snackPosition: SnackPosition.BOTTOM);
      // print(dataBody);
    }
    // getAllStories();
    print("deleted");

    // return dataBody["data"];
  }

  likeStory(String storyId) async {
    if (isGuest == false && isRole == false) {
      var res = await http.post(Uri.parse(likeStoryUrl), body: {
        "username": userName,
        "storyId": storyId,
      });
      var dataBody = json.decode(res.body);
      if (res.statusCode == 200) {
        Get.snackbar("تم", dataBody["message"], snackPosition: SnackPosition.BOTTOM);
        // print(dataBody);
      }
    } else {
      Get.defaultDialog(
        barrierDismissible: false,
        title: "تنبيه",
        titleStyle: TextStyle(
          fontSize: 22.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        content: Text(
          "الاعجاب متاح للمستخدمين فقط",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        confirm: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              // LinearGradient
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF792F0),
                  Color(0xFFFABD63),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              "حسنا",
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.white,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    // getAllStories();
    // print("liked");

    // return dataBody["data"];
  }
}

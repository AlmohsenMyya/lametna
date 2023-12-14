// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lametna/controllers/userData/userCredentials.dart';
// import 'package:lametna/controllers/userData/variables.dart';
// import 'package:http/http.dart' as http;
// class RoomSettingController extends GetxController {
//   TextEditingController statusController = TextEditingController();
//   TextEditingController helloController = TextEditingController();
//   File _image;
//
//   Future<void> sndSetting() async {
//     var url = Uri.parse(sendSetting);
//     var request = http.MultipartRequest('POST', url);
//     request.fields['room_id'] = "1";
//     request.fields['status'] = statusController.text.trim();
//     request.fields['hello_msg'] = helloController.text.trim();
//     request.fields['background_color'] = '#ffffff'; // replace with actual color code
//     if (_image != null) {
//       var stream = http.ByteStream(_image.openRead());
//       var length = await _image.length();
//       var multipartFile = http.MultipartFile(
//         'background_img',
//         stream,
//         length,
//         filename: _image.path.split('/').last,
//       );
//       request.files.add(multipartFile);
//     }
//
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       final dataBody = json.decode(await response.stream.bytesToString());
//       if (dataBody['status'] == 'success') {
//         print('Success');
//         print('room_id');
//       } else {
//         print('Error');
//       }
//     } else {
//       print('Error: ${response.reasonPhrase}');
//     }
//   }
//
//   Future<void> sendImageToBackend(File image) async {
//     final url = sendSetting;
//     final request = http.MultipartRequest('POST', Uri.parse(url));
//     final imageStream = http.ByteStream(image.openRead());
//     final imageLength = await image.length();
//     final multipartFile = http.MultipartFile(
//       'image',
//       imageStream,
//       imageLength,
//       filename: image.path.split('/').last,
//     );
//     request.fields['room_id'] = '1';
//     request.files.add(multipartFile);
//
//     final response = await request.send();
//     if (response.statusCode == 200) {
//       print('Image uploaded successfully!');
//     } else {
//       print('Failed to upload image. Error code: ${response.statusCode}');
//     }
//   }
//
// }
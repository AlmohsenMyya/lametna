// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/voiceController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

const String appId = "e151cc863dd34adc9f76f085e4fb7b78";

class VideoController extends GetxController {
  String channelName;
  String token;

  int uid = 0; // uid of the local user

  int _remoteUid; // uid of the remote user
  bool _isJoined = true; // Indicates if the local user has joined the channel
  bool _isHost = Get.arguments["owner"] ==
      userName; // Indicates whether the user has joined as a host or audience
  RtcEngine agoraEngine; // Agora engine instance
  Timer timer;
  bool cameraWidget = true;
  bool inQueue = false;
  bool inCall = false;
  String roomId = Get.arguments["room_id"];

  @override
  Future<void> onInit() async {
    super.onInit();
    roomId = await Get.arguments["room_id"];
    await getRoomInformation();

    setupVideoSDKEngine();
    leave();
    _isHost = await Get.arguments["owner"] == userName;
    // timer =
    //     Timer.periodic(Duration(seconds: 2), (Timer t) => getvideoRequest());
  }

  // Release the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    await timer.cancel();

    super.dispose();
  }

  @override
  Future<void> onClose() async {
    print("close");
    await timer.cancel();
    super.onClose();
  }

  getRoomInformation() async {
    var url = Uri.parse(roomInfoUrl);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = await json.decode(response.body);
    channelName = dataBody["data"][0]["Channel_Name"];
    token = dataBody["data"][0]["Token"];
    update();
    // print();
  }

  getvideoRequest() async {
    // var url = ;
    var res = await http.post(
        Uri.parse('https://lametnachat.com/rooms/getVideoRequest.php'),
        body: {
          "roomId": Get.arguments["room_id"],
        });
    final dataBody = json.decode(res.body);
    print(dataBody);

    print("----------");
    if (_isHost) {
      // join();
      if (dataBody["data"].length > 0) {
        for (var e in dataBody["data"]) {
          if (e["status"] == "" && e["name"] != Get.arguments["owner"]) {
            await Get.defaultDialog(
              // title: "Video Request",
              barrierDismissible: false,
              onWillPop: () {},

              middleText: e["name"].toString(),
              middleTextStyle: TextStyle(color: Colors.black),
              content: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360.r),
                      border: Border.all(
                        color: Color(0xFF43D0CA),
                        width: 1.w,
                      ),
                    ),
                    padding: EdgeInsets.all(10.sp),
                    child: Image.network(
                      imageURL + e["name"] + ".jpeg",
                      width: 55.w,
                      height: 55.h,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network(
                        imageURL + "anonymous.jpg",
                        width: 55.w,
                        height: 55.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    dataBody["data"][0]["name"],
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Portada',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var url = Uri.parse(
                              'https://lametnachat.com/rooms/updateRequestStatus.php'); //https://lametnachat.com/rooms/deleteVideoRequest.php //videoRequest
                          http.post(url, body: {
                            // "roomId": Get.arguments["room_id"],
                            "name": e["name"],
                            "status": "rejected",
                          });
                          await http.post(Uri.parse(toggleHands), body: {
                            "roomId": roomId,
                            "username": e["name"],
                            // "status": "",
                          });
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFF50D0D),
                              borderRadius: BorderRadius.circular(20.r)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Text(
                            "رفض",
                            style: TextStyle(
                              fontFamily: 'Portada',
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var url = Uri.parse(
                              'https://lametnachat.com/rooms/updateRequestStatus.php'); //https://lametnachat.com/rooms/deleteVideoRequest.php //videoRequest
                          http.post(url, body: {
                            // "roomId": Get.arguments["room_id"],
                            "name": e["name"],
                            "status": "ignored",
                          });
                          await http.post(Uri.parse(toggleHands), body: {
                            "roomId": roomId,
                            "username": e["name"],
                            // "status": "",
                          });
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFB00E02),
                              borderRadius: BorderRadius.circular(20.r)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Text(
                            "تجاهل",
                            style: TextStyle(
                              fontFamily: 'Portada',
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var url = Uri.parse(
                              'https://lametnachat.com/rooms/updateRequestStatus.php'); //https://lametnachat.com/rooms/deleteVideoRequest.php //videoRequest
                          http.post(url, body: {
                            // "roomId": Get.arguments["room_id"],
                            "name": e["name"],
                            "status": "accepted",
                          });
                          await http.post(Uri.parse(toggleHands), body: {
                            "roomId": roomId,
                            "username": e["name"],
                            // "status": "",
                          });
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF00E54C),
                              borderRadius: BorderRadius.circular(20.r)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Text(
                            "قبول",
                            style: TextStyle(
                              fontFamily: 'Portada',
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
            update();
          }
        }
      }
    } else {
      for (var e in dataBody["data"]) {
        if (e["name"] == userName && e["status"] == "accepted") {
          join();
          // Get.snackbar("title", "message");
        } else if (e["name"] == userName && e["status"] == "rejected") {
          // leave();
          await leaveQueue(e["name"]);
          Get.snackbar("title", "rejected");
        }
      }
    }
    return dataBody;
  }

  // showMessage(String message) {
  //   // Get.snackbar("message", message);
  // }
  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          _isJoined = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          _remoteUid = remoteUid;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          _remoteUid = null;
          update();
        },
      ),
    );
  }

  Widget videoPanel() {
    if (!_isJoined) {
      return Text(
        'Join a channel',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.green),
      );
    } else if (_isHost) {
      // Show local video preview
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      // Show remote video
      if (_remoteUid != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: agoraEngine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: RtcConnection(channelId: channelName),
          ),
        );
      } else {
        return Text(
          'Waiting for a host to join',
          style: TextStyle(color: Colors.green),
          textAlign: TextAlign.center,
        );
      }
    }
  }

  void join() async {
    // Set channel options
    ChannelMediaOptions options;
    // Get.snackbar("message", "join");

    // Set channel profile and client role
    if (Get.arguments["owner"] == userName) {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      await agoraEngine.startPreview();
    } else {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
    }

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
    inCall = true;
    update();
  }

  void leave() {
    _isJoined = false;
    _remoteUid = null;
    inCall = false;
    update();
    agoraEngine.leaveChannel();
    // Get.snackbar("message", "left");
    // leaveQueue();
  }

  enterQueue() async {
    if (_isHost) {
      join();
    } else {
      var url = Uri.parse(
          'https://lametnachat.com/rooms/videoRequest.php'); //https://lametnachat.com/rooms/deleteVideoRequest.php //videoRequest
      await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
        "name": userName,
        "status": "",
      });
      //  var url = ; //https://lametnachat.com/rooms/deleteVideoRequest.php //videoRequest
      await http.post(Uri.parse(toggleHands), body: {
        "roomId": Get.arguments["room_id"],
        "username": userName,
        // "status": "",
      });
    }

    inQueue = true;
    update();
  }

  leaveQueue(String name) async {
    var url = Uri.parse(
        'https://lametnachat.com/rooms/deleteVideoRequest.php'); //https://lametnachat.com/rooms/deleteVideoRequest.php //videoRequest
    await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "name": name,
      // "status": "",
    });
    leave();

    inQueue = false;
    update();
  }

  enterOrLeaveQueue() {
    // enterQueue();
    if (inQueue) {
      leaveQueue(userName);
      print("leave");
    } else {
      enterQueue();
      print("enter");
    }
  }

  checkIfUserIsJoined() {
    if (!_isJoined) {
      print("not join");
      leave();
    } else {
      print(" join");
      join();
    }
  }

  void toggleCamera() {
    cameraWidget = !cameraWidget;
    update();
  }

  Future<File> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  sendImage() async {
    // isLoading = true;
    update();
    final image = await getImageFromGallery();
    if (image == null) {
      // isLoading = false;
      // update();
    } else {
      var request = http.MultipartRequest('POST', Uri.parse(sendImageInRoom));
      request.fields['roomId'] = Get.arguments["room_id"];
      request.fields['senderName'] = userName;
      request.fields['joinOrLeave'] = "9";
      request.fields['isGuest'] = isGuest && !isRole ? "1" : "0";
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
          filename: "${image.path}".toString(),
        ),
      );
      var res = await request.send();
      var dataBody = await jsonDecode(await res.stream.bytesToString());
      print(dataBody);
      if (dataBody["status"] == "success") {
        // Get.snackbar("title", "uploaded");
      } else {
        Get.snackbar("تنبية", dataBody["message"]);
      }
    }
  }
  // checkMikeStatus(){

  // }

  cameraToggle() async {
    var url = Uri.parse(toggleCameraUrl);
    await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "username": userName,
    });
  }
}

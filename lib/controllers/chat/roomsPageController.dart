import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/model/message.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import '../userData/variables.dart';

class RoomsPageController extends GetxController {
  bool roomStatus = true;
  Crud crud = Crud();
  StreamController streamController = StreamController();
  Timer _timer;
  TextEditingController messageController = TextEditingController();
  bool scrollDownButton = false;
  ScrollController scrollController = ScrollController();
  bool messageStatus = false;
  bool emojiStatus = true;

  //voice room
  // String channelName = "";
  // String token = "";

  // final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  //     GlobalKey<ScaffoldMessengerState>();

  // int uid = 0; // uid of the local user

  // int _remoteUid; // uid of the remote user
  // bool _isJoined = false; // Indicates if the local user has joined the channel
  // RtcEngine agoraEngine; // Agora engine instance
  // showMessage(String message) {
  //   scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // }

  // Future<void> setupVoiceSDKEngine() async {
  //   // retrieve or request microphone permission
  //   await [Permission.microphone].request();

  //   //create an instance of the Agora engine
  //   agoraEngine = createAgoraRtcEngine();
  //   await agoraEngine.initialize(
  //       const RtcEngineContext(appId: 'e151cc863dd34adc9f76f085e4fb7b78'));

  //   // Register the event handler
  //   agoraEngine.registerEventHandler(
  //     RtcEngineEventHandler(
  //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //         showMessage(
  //             "Local user uid:${connection.localUid} joined the channel");
  //         _isJoined = true;
  //         update();
  //       },
  //       onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
  //         showMessage("Remote user uid:$remoteUid joined the channel");

  //         _remoteUid = remoteUid;
  //         update();
  //       },
  //       onUserOffline: (RtcConnection connection, int remoteUid,
  //           UserOfflineReasonType reason) {
  //         showMessage("Remote user uid:$remoteUid left the channel");

  //         _remoteUid = null;
  //         update();
  //       },
  //     ),
  //   );
  // }

  // void join() async {
  //   // Set channel options including the client role and channel profile
  //   ChannelMediaOptions options = const ChannelMediaOptions(
  //     clientRoleType: ClientRoleType.clientRoleBroadcaster,
  //     channelProfile: ChannelProfileType.channelProfileCommunication,
  //   );
  //   Get.snackbar("تم الانضمام", "تم الانضمام للغرفة بنجاح",
  //       snackPosition: SnackPosition.BOTTOM);

  //   await agoraEngine.joinChannel(
  //     token: token,
  //     channelId: channelName,
  //     options: options,
  //     uid: uid,
  //   );
  // }

  // void leave() {
  //   _isJoined = false;
  //   _remoteUid = null;
  //   update();
  //   Get.snackbar("sucess", "leave");
  //   agoraEngine.leaveChannel();
  // }

  @override
  Future<void> onInit() async {
    super.onInit();
    onJoin();
    await getRoomInformation();
    // setupVoiceSDKEngine();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) => getData());

    // getData();
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    await streamController.close();
    _timer.cancel();
    // await agoraEngine.leaveChannel();
    super.dispose();
  }

  @override
  void onClose() {
    print("close");
    // onJoinOrLeave(false);
    streamController.close();

    _timer.cancel();
    super.onClose();
  }

  getRoomInformation() async {
    var url = Uri.parse(roomInfoUrl);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);
    // channelName = dataBody["data"][0]["Channel_Name"];
    // token = dataBody["data"][0]["Token"];
    update();
    // print();
  }

  onJoin() async {
    var url = Uri.parse(joinRoom);
    var url2 = Uri.parse(sendRoomMessage);
    await http.post(url2, body: {
      "roomId": Get.arguments["room_id"],
      "senderName": "roomAlert",
      "message": "${isGuest ? guestUserName : userName} انضم للغرفة",
      "joinOrLeave": "0", //left 1 joined 0
    });

    await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "userName": userName,
    });
  }

  onLeave() async {
    var url = Uri.parse(leaveRoom);
    var url2 = Uri.parse(sendRoomMessage);
    await http.post(url2, body: {
      "roomId": Get.arguments["room_id"],
      "senderName": "roomAlert",
      "message": "${isGuest ? guestUserName : userName} غادر للغرفة",
      "joinOrLeave": "1", //left 1 joined 0
    });
    await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "userName": userName,
    });
    print("leave");
    // isGuest = false;
    Get.back();
  }

  Future<dynamic> getData() async {
    try {
      var url = Uri.parse(getRoomMessagesUrl);
      var response = await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
      });
      final dataBody = json.decode(response.body);

      if (dataBody["roomPlan"][0]["room_plan"] == "0") {
        roomStatus = false;
      } else {
        roomStatus = true;
      }
      update();
      streamController.sink.add(dataBody);
    } catch (e) {}
  }

  sendMessage(String message) async {
    if (message != "") {
      messageStatus = true;
      update();
      var url = Uri.parse(sendRoomMessage);
      var response = await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
        "senderName": isGuest ? guestUserName : userName,
        "message": message,
        "isGuest": isGuest ? "1" : "0",
        "joinOrLeave": "9", //left 1 joined 0
      });

      final dataBody = json.decode(response.body);
      print(dataBody);
      if (dataBody["status"] == "success") {
        messageController.clear();
        messageStatus = false;
        update();
      }
    }
  }

  getRoomMembers() async {
    try {
      var url = Uri.parse(roomMember);
      var response = await http.post(url, body: {
        "roomid": Get.arguments["room_id"],
      });
      final dataBody = json.decode(response.body);
      print(dataBody);
      return dataBody;
    } catch (e) {
      print("object");
    }
  }

  scrollDownButtonStatus(bool status) {
    scrollDownButton = status;
    update();
  }

  Future<void> changeRoomStatus() async {
    var url = Uri.parse(changeRoomPlan);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);
    print(dataBody);
    if (dataBody["status"] == "success") {
      roomStatus = !roomStatus;
    }
    update();
    // print(roomStatus);
  }

  void changeEmojiStatus(bool status) {
    emojiStatus = status;
    update();
  }
}

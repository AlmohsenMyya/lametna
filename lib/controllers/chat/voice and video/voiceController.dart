import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

const String appId = "e151cc863dd34adc9f76f085e4fb7b78";

class VoiceController extends GetxController {
  String channelName;
  String token;
  int uid = 0; // uid of the local user

  int _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  RtcEngine agoraEngine; // Agora engine instance

  bool micWidget = false;
  bool muteMic = false;
  int currentTime = 0;
  Timer timer;

  @override
  void onInit() {
    super.onInit();
    getRoomInformation();
    // setupVoiceSDKEngine();
    // l.forEach((element) {
    //   element["status"] = "55";
    // });
  }

  @override
  void dispose() async {
    // await agoraEngine.leaveChannel();
    super.dispose();
  }

  getRoomInformation() async {
    var url = Uri.parse(roomInfoUrl);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);
    channelName = dataBody["data"][0]["Channel_Name"];
    token = dataBody["data"][0]["Token"];
    update();
    // print();
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));
    // agoraEngi
    await agoraEngine.disableVideo();

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

  // Widget _status() {
  //   String statusText;

  //   if (!_isJoined)
  //     statusText = 'Join a channel';
  //   else if (_remoteUid == null)
  //     statusText = 'Waiting for a remote user to join...';
  //   else
  //     statusText = 'Connected to remote user, uid:$_remoteUid';

  //   return Text(
  //     statusText,
  //   );
  // }
  getCurrentTime() {
    // DateTime now = DateTime.now();
    currentTime = currentTime + 1;
    //     "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    update();
    print(currentTime);
  }

  String formatSecondsToTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  void join() async {
    await setupVoiceSDKEngine();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    await agoraEngine.disableVideo();

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
    _isJoined = true;
    update();
    await http.post(
      Uri.parse(toggleMicUrl),
      body: {
        "roomId": Get.arguments["room_id"],
        "username": userName,
      },
    );
    var response = await http.post(
      Uri.parse(membersInCall),
      body: {
        "roomId": Get.arguments["room_id"],
        "name": userName,
      },
    );

    if (response.statusCode == 200) {
      print("joined");
      Get.snackbar("message", "joined");
      timer = await Timer.periodic(Duration(seconds: 1), (timer) {
        getCurrentTime();
      });
    }
  }

  Future<void> leave() async {
    await agoraEngine.leaveChannel();

    _isJoined = false;
    _remoteUid = null;
    update();
    // agoraEngine.leaveChannel();
    await http.post(
      Uri.parse(toggleMicUrl),
      body: {
        "roomId": Get.arguments["room_id"],
        "username": userName,
      },
    );

    var response = await http.post(
      Uri.parse(deleteMemberInCall),
      body: {
        "roomId": Get.arguments["room_id"],
        "name": userName,
      },
    );
    if (response.statusCode == 200) {
      print("left");
      Get.snackbar("message", "left");
      timer.cancel();
      currentTime = 0;
    }
  }

  toogleMic() {
    micWidget = !micWidget;
    update();
  }

  checkIfUserIsJoined() {
    if (!_isJoined) {
      print("join");
      join();
    } else {
      print("not join");
      leave();
    }
  }

  toggleMic() async {
    muteMic = !muteMic;
    update();
    await http.post(
      Uri.parse(toggleMute),
      body: {
        "roomId": Get.arguments["room_id"],
        "username": userName,
      },
    );
    if (muteMic) {
      agoraEngine.muteLocalAudioStream(true);
    } else {
      agoraEngine.muteLocalAudioStream(false);
      // agoraEngine.
    }
    // agoraEngine.muteLocalAudioStream(true);
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

const String appId = "977621c3bde5423ebb3782aaf5b6edbc"; //e151cc863dd34adc9f76f085e4fb7b78

class VoiceController extends GetxController {
  String? channelName;
  String? token;
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  RtcEngine? agoraEngine; // Agora engine instance
  bool micWidget = false;
  bool muteMic = false;
  bool isJoined = true;
  bool inCall = false;
  int currentTime = 0;
  Timer? timer;
  String? talkStatus;
  String? memberTalkTime;
  String? adminTalkTime;
  String? superAdminTalkTime;
  String? masterTalkTime;
  String? owner;

  Timer? talkTimer;

  RoomsPageController roomPageController = Get.put(RoomsPageController());

  @override
  Future<void> onInit() async {
    super.onInit();
    await getRoomInformation();
    await setupVoiceSDKEngine();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime = currentTime + 1;
      update();
    });
    // join();
  }

  @override
  void dispose() async {
    // await agoraEngine.leaveChannel();
    // agoraEngine = null;
    // leave();
    leaveCall();
    super.dispose();
    // leave();
  }

  getRoomInformation() async {
    var url = Uri.parse(roomInfoUrl);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);
    channelName = dataBody["data"][0]["Channel_Name"];
    token = dataBody["data"][0]["Token"];
    memberTalkTime = dataBody["data"][0]["memberCallTime"];
    adminTalkTime = dataBody["data"][0]["adminCallTime"];
    superAdminTalkTime = dataBody["data"][0]["superAdminCallTime"];
    masterTalkTime = dataBody["data"][0]["masterCallTime"];
    talkStatus = dataBody["data"][0]["speech"];
    owner = dataBody["data"][0]["owner_username"];
    // roomId =

    update();
    // print();
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine!.initialize(const RtcEngineContext(appId: appId));
    agoraEngine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          _isJoined = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          _remoteUid = remoteUid;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          _remoteUid = null;
          update();
        },
      ),
    );
  }

  // getMemberInCall() async {
  //   var url = Uri.parse('https://lametnachat.com/messages/getMembersInCall.php');
  //   var response = await http.post(url, body: {
  //     "roomId": Get.arguments["room_id"],
  //   });
  //   final dataBody = json.decode(response.body);
  //   print(dataBody);
  //   roomPageController.memberInCall = dataBody["data"];
  //   update();
  // }

  // getCurrentTime() {
  //   // DateTime now = DateTime.now();
  //   currentTime = currentTime + 1;
  //   //     "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  //   update();
  //   print(currentTime);
  // }

  // String formatSecondsToTime(int seconds) {
  //   int hours = seconds ~/ 3600;
  //   int minutes = (seconds % 3600) ~/ 60;
  //   int remainingSeconds = seconds % 60;

  //   String formattedTime = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

  //   return formattedTime;
  // }

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    // agoraEngine.disableVideo();
    // agoraEngine.muteLocalAudioStream(true);
    var url = Uri.parse('https://lametnachat.com/messages/addMembersInCall.php');
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "name": userName,
      "userType": "1",
      // "joinOrLeave": "9", //left 1 joined 0
    });

    await agoraEngine!.joinChannel(
      token: token!,
      channelId: channelName!,
      options: options,
      uid: uid,
    );

    Get.snackbar("message", "تم الانضمام للمكالمة");
  }

  Future<void> leave() async {
    _isJoined = false;
    _remoteUid = null;
    var url = Uri.parse('https://lametnachat.com/messages/deleteMembersInCall.php');
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "name": userName,
      // "joinOrLeave": "9", //left 1 joined 0
    });
    update();
    agoraEngine!.leaveChannel();
    Get.snackbar("message", "leave");
  }

  // Future<void> leave() async {
  //   _isJoined = false;
  //   _remoteUid = null;
  //   update();
  //   await agoraEngine.leaveChannel();
  // }

  // joinCall() async {
  //   if (inCall) {
  //   } else {
  //     var url = Uri.parse('https://lametnachat.com/messages/addMembersInCall.php');
  //     var response = await http.post(url, body: {
  //       "roomId": Get.arguments["room_id"],
  //       "name": userName,
  //       "userType": "1",

  //       // "joinOrLeave": "9", //left 1 joined 0
  //     });
  //     ChannelMediaOptions options = const ChannelMediaOptions(
  //       clientRoleType: ClientRoleType.clientRoleBroadcaster,
  //       channelProfile: ChannelProfileType.channelProfileCommunication,
  //     );

  //     await agoraEngine.joinChannel(
  //       token: token,
  //       channelId: channelName,
  //       options: options,
  //       uid: uid,
  //     );
  //   }
  // }

  leaveCall() async {
    //deleteMemberInCall
    inCall = false;
    update();

    var url = Uri.parse('https://lametnachat.com/messages/deleteMembersInCall.php');
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      "name": userName,
      // "joinOrLeave": "9", //left 1 joined 0
    });
    if (response.statusCode == 200) {
      agoraEngine!.muteLocalAudioStream(true);
    }
  }

  // forceJoinCall(String name, String roomId) async {
  //   // print(roomPageController.memberInCall);
  //   Get.back();
  //   var url = Uri.parse('https://lametnachat.com/messages/addMembersInCall.php');
  //   var response = await http.post(url, body: {
  //     "roomId": roomId,
  //     "name": name,
  //     "userType": "user",
  //     // "joinOrLeave": "9", //left 1 joined 0
  //   });
  //   // if (response.statusCode == 200) {
  //   //   agoraEngine.muteLocalAudioStream(false);
  //   //   inCall = true;
  //   //   update();
  //   // }
  // }

  // toogleMic() {
  //   if (micWidget) {
  //     joinCall();
  //   } else {
  //     agoraEngine.muteLocalAudioStream(true);
  //     leaveCall();
  //   }
  // }

  // // checkIfUserIsJoined() async {
  // //   print("isRole" + isRole.toString());
  // //   print("isGuest" + isGuest.toString());
  // //   print("inCall" + inCall.toString());
  // //   // print(isGuest);
  // //   print(inCall);
  // //   // print(_isJoined);
  // //   if (inCall == false) {
  // //     // join();
  // //     // print(isRole);
  // //     // print(isGuest);
  // //     if (talkStatus == "الجميع") {
  // //       join();
  // //       inCall = !inCall;
  // //     } else if (talkStatus == "الأعضاء والمشرفين فقط" &&
  // //             isGuest == false &&
  // //             isRole == true ||
  // //         userName == owner ||
  // //         isGuest == false && isRole == false) {
  // //       join();
  // //       inCall = !inCall;
  // //     } else if (talkStatus == "المشرفين فقط" && isRole == true ||
  // //         userName == owner) {
  // //       join();
  // //       inCall = !inCall;
  // //     } else if (talkStatus == "لا أحد") {
  // //       if (owner == userName) {
  // //         join();
  // //         inCall = !inCall;
  // //       }
  // //     } else {
  // //       Get.snackbar("message", "لا يمكنك الانضمام لهذه الغرفة");
  // //       // join();
  // //     }
  // //     if (isRole) {
  // //       if (roleType == "0") {
  // //         talkTimer = Timer.periodic(
  // //             Duration(minutes: int.parse(memberTalkTime)), (timer) {
  // //           print("close");
  // //           leave();
  // //         });
  // //       } else if (roleType == " 1") {
  // //         talkTimer = Timer.periodic(
  // //             Duration(minutes: int.parse(adminTalkTime)), (timer) {
  // //           print("close");
  // //           leave();
  // //         });
  // //       } else if (roleType == "2") {
  // //         talkTimer = Timer.periodic(
  // //             Duration(minutes: int.parse(superAdminTalkTime)), (timer) {
  // //           leave();
  // //           print("close");
  // //         });
  // //       } else if (roleType == "3") {
  // //         talkTimer = Timer.periodic(
  // //             Duration(minutes: int.parse(masterTalkTime)), (timer) {
  // //           leave();
  // //           print("close");
  // //         });
  // //       }
  // //     }
  // //   } else {
  // //     leave();
  // //     if (isRole == true || talkTimer != null) {
  // //       talkTimer.cancel();
  // //       talkTimer = null;
  // //     }
  // //     inCall = !inCall;
  // //   }
  // //   update();
  // // }

  // toggleMic() async {
  //   muteMic = !muteMic;
  //   update();
  //   await http.post(
  //     Uri.parse(toggleMute),
  //     body: {
  //       "roomId": Get.arguments["room_id"],
  //       "username": userName,
  //     },
  //   );
  //   if (muteMic) {
  //     agoraEngine.muteLocalAudioStream(true);
  //   } else {
  //     agoraEngine.muteLocalAudioStream(false);
  //     // agoraEngine.
  //   }
  //   // agoraEngine.muteLocalAudioStream(true);
  // }
}

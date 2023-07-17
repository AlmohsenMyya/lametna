// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lametna/controllers/Crud.dart';
import 'package:lametna/controllers/chathomePageController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/model/message.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:lametna/view/chat/addAccount.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:lametna/view/chatHomePage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../userData/variables.dart';

const String APP_ID = "e151cc863dd34adc9f76f085e4fb7b78";

class RoomsPageController extends GetxController {
  bool roomStatus = true;
  Crud crud = Crud();
  StreamController streamController = StreamController();
  StreamController membersController = StreamController();
  OverlayEntry entry;
  Timer _timer;
  TextEditingController messageController = TextEditingController();
  bool scrollDownButton = true;
  ScrollController scrollController = ScrollController();
  bool messageStatus = false;
  bool emojiStatus = true;
  bool cameraWidget = false;
  bool micWidget = false;
  bool mute = false;
  bool inCall = false;

  var userInRoom;
  String roomId = Get.arguments["roomId"];

  //blocktime
  String quarterHour = DateTime.now()
      .add(Duration(minutes: 15))
      .toString()
      .substring(0, 19)
      .toString();
  String hour = DateTime.now()
      .add(Duration(minutes: 60))
      .toString()
      .substring(0, 19)
      .toString();
  String sixHours = DateTime.now()
      .add(Duration(hours: 6))
      .toString()
      .substring(0, 19)
      .toString();
  String day = DateTime.now()
      .add(Duration(days: 1))
      .toString()
      .substring(0, 19)
      .toString();

  String week = DateTime.now()
      .add(Duration(days: 7))
      .toString()
      .substring(0, 19)
      .toString();
  String month = DateTime.now()
      .add(Duration(days: 30))
      .toString()
      .substring(0, 19)
      .toString();
  String forever = DateTime.now()
      .add(Duration(days: 365))
      .toString()
      .substring(0, 19)
      .toString();
  bool isKicked = false;

  //voice room
  String channelName = "";
  String token = "";
  // String channelName = "2";
  // String token =
  //     "007eJxTYKh99aOr7HP0FNmPLzgVK1YnqwZP1vVbq75dyuf/pVtvzu5WYEg1NDVMTrYwM05JMTZJTEm2TDM3SzOwME01SUsyTzK30P28MKUhkJHhg74DEyMDBIL4jAxGDAwAlBAgUQ==";

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  int uid = 0; // uid of the local user
  //voice room
  int _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  RtcEngine agoraEngine; // Agora engine instance
  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    onJoin();
    isKicked = false;
    await getRoomInformation();
    // setupVoiceSDKEngine();
    // setupVideoSDKEngine();
    // print(Get.arguments["room_id"]);
    roomId = Get.arguments["room_id"];

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // print(channelName);
      // print(token);

      return getData();
    });

    // getData();
  }

  //video
  int _remoteUidVideo; // uid of the remote user
  bool _isJoinedVideo =
      false; // Indicates if the local user has joined the channel
  bool _isHost = Get.arguments["owner"] == userName;
  RtcEngine agoraEngineVideo; // Agora engine instance

  Future setupVideoSDKEngine() async {
    await [Permission.microphone, Permission.camera].request();
    agoraEngineVideo = createAgoraRtcEngine();
    await agoraEngineVideo.initialize(const RtcEngineContext(appId: APP_ID));
    agoraEngineVideo.enableVideo();

    // Register the event handler
    agoraEngineVideo.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          _isJoinedVideo = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");

          _remoteUidVideo = remoteUid;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");

          _remoteUidVideo = null;
          update();
        },
      ),
    );
  }

  void joinVideoChannel() async {
    await setupVideoSDKEngine();
    ChannelMediaOptions options;
    if (_isHost) {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      await agoraEngineVideo.startPreview();
    } else {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
    }
    await agoraEngineVideo.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leaveVideoChannel() {
    _isJoinedVideo = false;
    _remoteUidVideo = null;
    update();
    agoraEngineVideo.leaveChannel();
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: APP_ID));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          _isJoined = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");

          _remoteUid = remoteUid;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");

          _remoteUid = null;
          update();
        },
      ),
    );
  }

  Widget videoPanel() {
    if (!_isJoinedVideo) {
      return SizedBox();
    } else if (_isHost) {
      // Show local video preview
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngineVideo,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      // Show remote video
      if (_remoteUidVideo != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: agoraEngineVideo,
            canvas: VideoCanvas(uid: _remoteUidVideo),
            connection: RtcConnection(channelId: channelName),
          ),
        );
      } else {
        return Text(
          "data 2",
          style: TextStyle(color: Colors.green),
        );
      }
    }
  }

  void join() async {
    // Set channel options including the client role and channel profile
    // setupVoiceSDKEngine();
    var response = await http.post(Uri.parse(membersInCall), body: {
      "roomId": Get.arguments["room_id"],
      "name": isGuest ? guestUserName : userName,
    });
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );
    Get.snackbar("تم الانضمام", "تم الانضمام للغرفة بنجاح",
        snackPosition: SnackPosition.BOTTOM);

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  Future<void> leave() async {
    _isJoined = false;
    _remoteUid = null;
    update();
    // agoraEngine.leaveChannel();
    // agoraEngine.release();
    // agoraEngineVideo.leaveChannel();
    // agoraEngineVideo.release();
    var response = await http.post(Uri.parse(deleteMemberInCall), body: {
      "roomId": Get.arguments["room_id"],
      "name": isGuest ? guestUserName : userName,
    });
    Get.snackbar("sucess", "leave");
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose
    // getActiveOrDefualtBask
    //  emitTypingChange(0);
    await streamController.close();
    _timer.cancel();
    await agoraEngineVideo.leaveChannel();
    await agoraEngineVideo.release();
    await agoraEngine.leaveChannel();
    await agoraEngine.release();
    onLeave();
    // await agoraEngine.leaveChannel();
    super.dispose();
  }

  @override
  Future<void> onClose() async {
    print("close");

    // onJoinOrLeave(false);
    await agoraEngineVideo.leaveChannel();
    await agoraEngineVideo.release();
    await agoraEngine.leaveChannel();
    await agoraEngine.release();
    streamController.close();
    onLeave();
    _timer.cancel();
    super.onClose();
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

  onJoin() async {
    var url = Uri.parse(joinRoom);
    var url2 = Uri.parse(sendRoomMessage);
    await http.post(url2, body: {
      "roomId": Get.arguments["room_id"],
      "senderName": "roomAlert",
      "message": "${userName} انضم للغرفة",
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
      "message": "$userName غادر للغرفة",
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
      // print(dataBody["banuser"]);
      // print(dataBody["roomPlan"][0]["room_plan"]);
      for (var element in dataBody["banuser"]) {
        if (element == (isGuest ? guestUserName : userName) &&
            isKicked == false) {
          onLeave();
          isKicked = true;
          update();
        }
      }
      // print("-------------------");

      membersController.sink.add(dataBody["membersInCall"]);
      // print(dataBody["membersInCall"]);
      streamController.sink.add(dataBody);
    } catch (e) {}
  }

  sendMessage(String message) async {
    print(isRole);
    print(isGuest);
    if (message != "") {
      messageStatus = true;
      update();
      var url = Uri.parse(sendRoomMessage);
      var response = await http.post(url, body: {
        "roomId": Get.arguments["room_id"],
        "senderName": userName,
        "message": message,
        "isGuest": isGuest && !isRole ? "1" : "0",
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
      // usersInRoom.sink.close();
      var url = Uri.parse(roomMember);
      var response = await http.post(url, body: {
        "roomid": Get.arguments["room_id"],
      });
      final dataBody = json.decode(response.body);
      // print(dataBody);
      // usersInRoom.sink.add(dataBody);
      userInRoom = dataBody;
      update();
      // usersInRoom = ;
      // for (var e in dataBody["data"]) {
      //   print(e);
      // }
      // print("object");
      // update();
      // return dataBody;
    } catch (e) {
      print("object");
    }
  }

  blockUser(String name, int selection) async {
    // Get.back();
    // Get.back();
    // Get.back();
    // Get.back();
    var url = Uri.parse(banUser);
    var response = await http.post(url, body: {
      "roomId": roomId,
      "username": name,
      "endTime": selection == 0
          ? quarterHour
          : selection == 1
              ? hour
              : selection == 2
                  ? sixHours
                  : selection == 3
                      ? day
                      : selection == 4
                          ? week
                          : selection == 5
                              ? month
                              : forever,
    });

    if (response.statusCode == 200) {
      print("blocked");
    }

    Get.defaultDialog(
        middleText: "تم حظر هذا المستخدم",
        middleTextStyle: TextStyle(color: Colors.green),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));
  }

  kickUser(String name) async {
    Get.defaultDialog(
        middleText: "هل تريد طرد هذا المستخدم؟",
        middleTextStyle: TextStyle(color: Colors.green),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));

    var url = Uri.parse(banUser);
    var response = await http.post(url, body: {
      "roomId": roomId,
      "username": name,
      "endTime": DateTime.now()
          .add(Duration(seconds: 1))
          .toString()
          .substring(0, 19)
          .toString()
    });
    if (response.statusCode == 200) {
      print("kicked");
    }
  }

  scrollDownButtonStatus(bool status) {
    scrollDownButton = status;
    update();
  }

  Future<void> changeRoomStatus() async {
    // print(Get.arguments["room_id"]);
    print("changed");

    var url = Uri.parse(changeRoomPlan);
    var response = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
    });
    final dataBody = json.decode(response.body);
    print(dataBody);
    if (dataBody["status"] == "success") {
      print("changed");
      roomStatus = !roomStatus;
    }
    update();
    // print(roomStatus);
  }

  void changeEmojiStatus(bool status) {
    emojiStatus = status;
    update();
  }

  toggleMic() {
    if (cameraWidget) {
      toggleCamera();
    }
    micWidget = !micWidget;
    update();
    // agoraEngine.muteLocalAudioStream(mic);
  }

  micStatus() {
    if (mute) {
      agoraEngine.muteLocalAudioStream(false);
    } else {
      agoraEngine.muteLocalAudioStream(true);
    }
    mute = !mute;
    update();
  }

  toggleCamera() {
    if (micWidget) {
      toggleMic();
    }
    cameraWidget = !cameraWidget;
    update();
  }

  joinLeaveCalls() {
    if (!inCall) {
      join();
    } else {
      leave();
    }
    inCall = !inCall;
    update();
    print(inCall);
  }

  getUserIP() async {
    var ipAddress = IpAddress(type: RequestType.json);
    dynamic data = await ipAddress.getIpAddress();

    Get.defaultDialog(
        title: "IP",
        middleText: data["ip"].toString(),
        middleTextStyle: TextStyle(color: Colors.black),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));
  }

  getUserDeviceType() async {
    String os = await Platform.operatingSystem;
    // Or, use a predicate getter.
    Get.defaultDialog(
        title: "IP",
        middleText: os,
        middleTextStyle: TextStyle(color: Colors.black),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));
  }

  getUserCountry() async {
    String localeName = await Platform.localeName;

    print(localeName);
    Get.defaultDialog(
        title: "IP",
        middleText: localeName,
        middleTextStyle: TextStyle(color: Colors.black),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("حسنا"),
        ));
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// // import 'package:agora_uikit/agora_uikit.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// class VoiceChat extends StatefulWidget {
//   const VoiceChat({Key key}) : super(key: key);

//   @override
//   State<VoiceChat> createState() => _VoiceChatState();
// }

// class _VoiceChatState extends State<VoiceChat> {
//   String channelName = "2";
//   String token =
//       "007eJxTYKh99aOr7HP0FNmPLzgVK1YnqwZP1vVbq75dyuf/pVtvzu5WYEg1NDVMTrYwM05JMTZJTEm2TDM3SzOwME01SUsyTzK30P28MKUhkJHhg74DEyMDBIL4jAxGDAwAlBAgUQ==";

//   int uid = 0; // uid of the local user

//   int _remoteUid; // uid of the remote user
//   bool _isJoined = false; // Indicates if the local user has joined the channel
//   RtcEngine agoraEngine; // Agora engine instance

//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

//   showMessage(String message) {
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Set up an instance of Agora engine
//     setupVoiceSDKEngine();
//     // initAgora();
//   }

//   // Clean up the resources when you leave
//   @override
//   void dispose() async {
//     await agoraEngine.leaveChannel();
//     super.dispose();
//   }

//   // AgoraClient client = AgoraClient(
//   //   agoraConnectionData: AgoraConnectionData(
//   //     appId: 'e151cc863dd34adc9f76f085e4fb7b78',
//   //     channelName: '2',
//   //     tempToken:
//   //         '007eJxTYKh99aOr7HP0FNmPLzgVK1YnqwZP1vVbq75dyuf/pVtvzu5WYEg1NDVMTrYwM05JMTZJTEm2TDM3SzOwME01SUsyTzK30P28MKUhkJHhg74DEyMDBIL4jAxGDAwAlBAgUQ==',
//   //     uid: 0,
//   //   ),
//   // );

//   Future<void> setupVoiceSDKEngine() async {
//     // retrieve or request microphone permission
//     await [Permission.microphone].request();

//     //create an instance of the Agora engine
//     agoraEngine = createAgoraRtcEngine();
//     await agoraEngine.initialize(
//         const RtcEngineContext(appId: 'e151cc863dd34adc9f76f085e4fb7b78'));

//     // Register the event handler
//     agoraEngine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           showMessage(
//               "Local user uid:${connection.localUid} joined the channel");
//           setState(() {
//             _isJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           showMessage("Remote user uid:$remoteUid joined the channel");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           showMessage("Remote user uid:$remoteUid left the channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );
//   }

//   void join() async {
//     // Set channel options including the client role and channel profile
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

//   void leave() {
//     setState(() {
//       _isJoined = false;
//       _remoteUid = null;
//     });
//     agoraEngine.leaveChannel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       scaffoldMessengerKey: scaffoldMessengerKey,
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Get started with Voice Calling'),
//           ),
//           body: ListView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//             children: [
//               // Status text
//               Container(height: 40, child: Center(child: _status())),
//               // Button Row
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: ElevatedButton(
//                       child: const Text("Join"),
//                       onPressed: () => {join()},
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       child: const Text("Leave"),
//                       onPressed: () => {leave()},
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )),
//     );
//   }

//   Widget _status() {
//     String statusText;

//     if (!_isJoined)
//       statusText = 'Join a channel';
//     else if (_remoteUid == null)
//       statusText = 'Waiting for a remote user to join...';
//     else
//       statusText = 'Connected to remote user, uid:$_remoteUid';

//     return Text(
//       statusText,
//     );
//   }
// }

// // ignore_for_file: prefer_const_constructors

// /////////////////////////////////////////////////////////////////////////////////////////////////
// // import 'package:flutter/material.dart';
// // import 'package:flutter/src/foundation/key.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter/src/widgets/placeholder.dart';
// // import 'package:lametna/controllers/userData/userCredentials.dart';
// // // import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// // import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
// // // import 'package:zego_express_engine/zego_express_engine.dart';
// // import 'dart:math' as math;

// // class VoiceChat extends StatefulWidget {
// //   const VoiceChat({Key key}) : super(key: key);

// //   @override
// //   State<VoiceChat> createState() => _VoiceChatState();
// // }

// // final userIdvoice = math.Random().nextInt(1000000).toString();

// // class _VoiceChatState extends State<VoiceChat> {
// //   final callId = TextEditingController();
// //   final username = TextEditingController();
// //   bool isHost = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: EdgeInsets.symmetric(horizontal: 20),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               "username",
// //               style: TextStyle(color: Colors.black, fontSize: 20),
// //             ),
// //             TextFormField(
// //               controller: username,
// //               style: TextStyle(
// //                 color: Colors.black,
// //               ),
// //               decoration: InputDecoration(
// //                 hintText: "username",
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 10,
// //             ),
// //             Text(
// //               "channel number",
// //               style: TextStyle(color: Colors.black, fontSize: 20),
// //             ),
// //             TextFormField(
// //               controller: callId,
// //               style: TextStyle(
// //                 color: Colors.black,
// //               ),
// //               decoration: InputDecoration(
// //                 hintText: "Enter Channel Name",
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text(
// //                   "Is Host ?",
// //                   style: TextStyle(color: Colors.black, fontSize: 20),
// //                 ),
// //                 Switch(
// //                   value: isHost,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       isHost = value;
// //                     });
// //                   },
// //                 ),
// //               ],
// //             ),
// //             Center(
// //               child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => LivePage(
// //                           roomID: callId.text,
// //                           isHost: isHost,
// //                           username: username.text,
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                   child: Text("Join")),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class LivePage extends StatelessWidget {
// //   final String roomID;
// //   final bool isHost;
// //   final String username;

// //   const LivePage(
// //       {Key key, @required this.roomID, this.isHost = false, this.username})
// //       : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: ZegoUIKitPrebuiltLiveAudioRoom(
// //         appID:
// //             1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
// //         appSign:
// //             '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
// //         userID: userIdvoice,
// //         userName: username,
// //         roomID: roomID,
// //         config: (isHost
// //             ? (ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
// //               ..takeSeatIndexWhenJoining = 0)
// //             : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience()
// //           ..innerText.memberListTitle = 'member list'
// //           ..role.index)
// //           ..hostSeatIndexes = [0]
// //           ..seatConfig = ZegoLiveAudioRoomSeatConfig()
// //           ..layoutConfig.rowConfigs = [
// //             ZegoLiveAudioRoomLayoutRowConfig(
// //                 count: 4,
// //                 alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
// //           ]
// //           ..bottomMenuBarConfig = ZegoBottomMenuBarConfig(
// //             hostButtons: [
// //               ZegoMenuBarButtonName.toggleMicrophoneButton,
// //               ZegoMenuBarButtonName.showMemberListButton,
// //             ],
// //             speakerButtons: [
// //               ZegoMenuBarButtonName.toggleMicrophoneButton,
// //               // ZegoMenuBarButtonName.showMemberListButton,
// //             ],
// //           ),
// //       ),
// //     );
// //   }
// // }

// // class LivePage extends StatelessWidget {
// //   const LivePage({Key key, @required this.roomID, this.isHost = false})
// //       : super(key: key);

// //   final String roomID;
// //   final bool isHost;

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: ZegoUIKitPrebuiltLiveAudioRoom(
// //         appID:
// //             1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
// //         appSign:
// //             '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
// //         userID: userIdvoice,
// //         userName: 'user_$userIdvoice',
// //         roomID: roomID,

// //         // Modify your custom configurations here.
// //         config: isHost
// //             ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
// //             : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience()
// //           ..seatConfig = (ZegoLiveAudioRoomSeatConfig()
// //             ..backgroundBuilder = backgroundBuilder
// //             ..foregroundBuilder = foregroundBuilder),
// //       ),
// //     );
// //   }

// //   bool isAttributeHost(Map<String, String> userInRoomAttributes) {
// //     return (userInRoomAttributes[attributeKeyRole] ?? "") ==
// //         ZegoLiveAudioRoomRole.host.index.toString();
// //   }

// //   Widget backgroundBuilder(
// //       BuildContext context, Size size, ZegoUIKitUser user, Map extraInfo) {
// //     if (!isAttributeHost(user.inRoomAttributes )) {
// //       return Container();
// //     }
// //     return Positioned(
// //       top: -8,
// //       left: 0,
// //       child: Container(
// //         width: size.width,
// //         height: size.height,
// //         decoration: BoxDecoration(
// //           color: Colors.black.withOpacity(0.1),
// //           borderRadius: BorderRadius.circular(4),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget foregroundBuilder(
// //       BuildContext context, Size size, ZegoUIKitUser user, Map extraInfo) {
// //     var userName = user.name.isEmpty ?? true
// //         ? Container()
// //         : Positioned(
// //             bottom: 0,
// //             left: 0,
// //             right: 0,
// //             child: Text(
// //               user?.name ?? "",
// //               overflow: TextOverflow.ellipsis,
// //               textAlign: TextAlign.center,
// //               style: TextStyle(
// //                 backgroundColor: Colors.black.withOpacity(0.1),
// //                 fontSize: 9,
// //                 fontWeight: FontWeight.w600,
// //                 decoration: TextDecoration.none,
// //               ),
// //             ),
// //           );

// //     if (!isAttributeHost(user.inRoomAttributes)) {
// //       return userName;
// //     }

// //     var hostIconSize = Size(size.width / 3, size.height / 3);
// //     var hostIcon = Positioned(
// //       bottom: 3,
// //       right: 0,
// //       child: Container(
// //         width: hostIconSize.width,
// //         height: hostIconSize.height,
// //         // decoration: BoxDecoration(
// //         //   image: YourHostFlagIcon(),
// //         // ),
// //       ),
// //     );

// //     return Stack(children: [userName, hostIcon]);
// //   }
// // }

// // class CallPage extends StatelessWidget {
// //   final String callId;
// //   const CallPage({Key key, this.callId}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return

// //         // Container();
// //         //     ZegoUIKitPrebuiltCall(
// //         //   appID:
// //         //       1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
// //         //   appSign:
// //         //       '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
// //         //   userID: userIdvoice,
// //         //   userName: 'user_$userIdvoice',
// //         //   callID: callId,
// //         //   appDesignSize: Size(375, 812),

// //         //   // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
// //         //   config: ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
// //         //     // ..onOnlySelfInRoom = f(context),
// //         //     ..turnOnCameraWhenJoining = false
// //         //     ..turnOnMicrophoneWhenJoining = false
// //         //     ..useSpeakerWhenJoining = true,
// //         // );
// //         ZegoUIKitPrebuiltLiveAudioRoom(
// //       appID:
// //           1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
// //       appSign:
// //           '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
// //       userID: userIdvoice,
// //       userName: 'user_$userIdvoice',
// //       roomID: "1",
// //       config: false
// //           ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
// //           : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
// //     );
// //     //     ZegoUIKitPrebuiltCall(
// //     //   appID: 1424211637,
// //     //   appSign:
// //     //       '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e',
// //     //   userID: userIdvoice,
// //     //   userName: 'user_$userIdvoice',
// //     //   callID: callId,

// //     //   // Modify your custom configurations here.
// //     //   config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
// //     // ..turnOnCameraWhenJoining = false
// //     // ..turnOnMicrophoneWhenJoining = false
// //     // ..useSpeakerWhenJoining = true,
// //     // );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:permission_handler/permission_handler.dart';

// class VideoCall extends StatefulWidget {
//   // const VideoCall({super.key});

//   @override
//   State<VideoCall> createState() => _VideoCallState();
// }

// class _VideoCallState extends State<VideoCall> {
//   final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//       appId: "e151cc863dd34adc9f76f085e4fb7b78",
//       channelName: "2",
//       uid: 0,
//       tempToken:
//           '007eJxTYLjpp6x02ULs6jSmN59YQ3Kaz9RyNqf+/JvEGbzwwLvpDv8VGFINTQ2Tky3MjFNSjE0SU5It08zN0gwsTFNN0pLMk8wtFgYuSWkIZGTQTeplYWSAQBCfkcGIgQEAE0Yemw==',
//     ),
//     enabledPermission: [
//       Permission.camera,
//       Permission.microphone,
//     ],
//   );

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   void initAgora() async {
//     await client.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Stack(
//             children: [
//               AgoraVideoViewer(
//                 client: client,
//                 layoutType: Layout.floating,
//                 enableHostControls: true, // Add this to enable host controls
//               ),
//               AgoraVideoButtons(
//                 client: client,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

const String appId = "e151cc863dd34adc9f76f085e4fb7b78";

class VideoCall extends StatefulWidget {
  const VideoCall({Key key}) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  String channelName = "2";
  String token =
      "007eJxTYGhO/yryzGD9HbfHX3ONdFrPNvb93LjkgtTPFeW56xpXvtuswJBqaGqYnGxhZpySYmySmJJsmWZulmZgYZpqkpZknmRuce3TspSGQEaGe9EzGRihEMRnZDBiYAAAJwUjBg==";

  int uid = 0; // uid of the local user

  int _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  bool _isHost =
      true; // Indicates whether the user has joined as a host or audience
  RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

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
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVideoSDKEngine();
  }

  void join() async {
    // Set channel options
    ChannelMediaOptions options;

    // Set channel profile and client role
    if (_isHost) {
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
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

// Release the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    super.dispose();
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Get started with Interactive Live Streaming'),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            children: [
              // Container for the local video
              Container(
                height: 240,
                decoration: BoxDecoration(border: Border.all()),
                child: Center(child: _videoPanel()),
              ),
              // Radio Buttons
              Row(children: <Widget>[
                Radio<bool>(
                  value: true,
                  groupValue: _isHost,
                  onChanged: (value) => _handleRadioValueChange(value),
                ),
                const Text('Host'),
                Radio<bool>(
                  value: false,
                  groupValue: _isHost,
                  onChanged: (value) => _handleRadioValueChange(value),
                ),
                const Text('Audience'),
              ]),
              // Button Row
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: const Text("Join"),
                      onPressed: () => {join()},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text("Leave"),
                      onPressed: () => {leave()},
                    ),
                  ),
                ],
              ),
              // Button Row ends
            ],
          )),
    );
  }

  Widget _videoPanel() {
    if (!_isJoined) {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
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
        return const Text(
          'Waiting for a host to join',
          textAlign: TextAlign.center,
        );
      }
    }
  }

// Set the client role when a radio button is selected
  void _handleRadioValueChange(bool value) async {
    setState(() {
      _isHost = (value == true);
    });
    if (_isJoined) leave();
  }
}















// ignore_for_file: avoid_print

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:lametna/controllers/Crud.dart';
// import 'package:lametna/controllers/userData/userCredentials.dart';
// import 'package:lametna/model/message.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../userData/variables.dart';

// class RoomsPageController extends GetxController {
//   bool roomStatus = true;
//   Crud crud = Crud();
//   StreamController streamController = StreamController();
//   StreamController membersController = StreamController();
//   Timer _timer;
//   TextEditingController messageController = TextEditingController();
//   bool scrollDownButton = true;
//   ScrollController scrollController = ScrollController();
//   bool messageStatus = false;
//   bool emojiStatus = true;
//   bool inCall = false;
//   bool micWidget = false;
//   bool cameraWidget = false;
//   bool mute = false;

//   //voice room
//   String channelName = "";
//   String token = "";
//   // String channelName = "2";
//   // String token =
//   //     "007eJxTYKh99aOr7HP0FNmPLzgVK1YnqwZP1vVbq75dyuf/pVtvzu5WYEg1NDVMTrYwM05JMTZJTEm2TDM3SzOwME01SUsyTzK30P28MKUhkJHhg74DEyMDBIL4jAxGDAwAlBAgUQ==";

//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();

//   int uid = 0; // uid of  the local user
//   //voice
//   int _remoteUidVoice; // uid of the remote user
//   bool _isJoinedVoice =
//       false; // Indicates if the local user has joined the channel
//   RtcEngine agoraEngineVoice; // Agora engine instance
//   RtcEngine agoraEngineVideo; // Agora engine instance
//   showMessage(String message) {
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }

//   //video
//   int _remoteUidVideo; // uid of the remote user
//   bool _isJoinedVideo =
//       false; // Indicates if the local user has joined the channel
//   bool _isHostVideo = false;

//   Future<void> setupVideoSDKEngine() async {
//     // retrieve or request camera and microphone permissions
//     await [Permission.microphone, Permission.camera].request();
//     //create an instance of the Agora engine
//     agoraEngineVideo = createAgoraRtcEngine();
//     await agoraEngineVideo.initialize(
//         const RtcEngineContext(appId: 'e151cc863dd34adc9f76f085e4fb7b78'));
//     await agoraEngineVideo.enableVideo();
//     // Register the event handler
//     agoraEngineVideo.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           showMessage(
//               "Local user uid:${connection.localUid} joined the channel");

//           _isJoinedVideo = true;
//           update();
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           showMessage("Remote user uid:$remoteUid joined the channel");
//           _remoteUidVideo = remoteUid;
//           update();
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           showMessage("Remote user uid:$remoteUid left the channel");
//           _remoteUidVideo = null;
//           update();
//         },
//       ),
//     );
//   }

//   Future<void> setupVoiceSDKEngine() async {
//     // retrieve or request microphone permission
//     await [Permission.microphone].request();

//     //create an instance of the Agora engine
//     agoraEngineVoice = createAgoraRtcEngine();
//     await agoraEngineVoice.initialize(
//         const RtcEngineContext(appId: 'e151cc863dd34adc9f76f085e4fb7b78'));

//     // Register the event handler
//     agoraEngineVoice.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           showMessage(
//               "Local user uid:${connection.localUid} joined the channel");
//           _isJoinedVoice = true;
//           update();
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           showMessage("Remote user uid:$remoteUid joined the channel");

//           _remoteUidVoice = remoteUid;
//           update();
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           showMessage("Remote user uid:$remoteUid left the channel");

//           _remoteUidVoice = null;
//           update();
//         },
//       ),
//     );
//   }

//   void joinVoiceCall() async {
//     // Set channel options including the client role and channel profile
//     // ChannelMediaOptions options = const ChannelMediaOptions(
//     //   clientRoleType: ClientRoleType.clientRoleBroadcaster,
//     //   channelProfile: ChannelProfileType.channelProfileCommunication,
//     // );
//     var url = Uri.parse(membersInCall);
//     var response = await http.post(url, body: {
//       "roomId": Get.arguments["room_id"],
//       "name": userName,
//     });
//     if (response.statusCode == 200) {
//       print("joined");
//     }
//     Get.snackbar("تم الانضمام", "تم الانضمام للغرفة بنجاح",
//         snackPosition: SnackPosition.BOTTOM);

//     // await agoraEngine.joinChannel(
//     //   token: token,
//     //   channelId: channelName,
//     //   options: options,
//     //   uid: uid,
//     // );
//   }

//   Future<void> leaveVoiceCall() async {
//     // _isJoined = false;
//     // _remoteUid = null;
//     // update();
//     // agoraEngine.leaveChannel();
//     var url = Uri.parse(deleteMemberInCall);
//     var response = await http.post(url, body: {
//       "roomId": Get.arguments["room_id"],
//       "name": userName,
//     });
//     if (response.statusCode == 200) {
//       print("leaved");
//     }
//     Get.snackbar("sucess", "leave");
//   }

//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     onJoin();
//     await getRoomInformation();
//     setupVoiceSDKEngine();
//     setupVideoSDKEngine();

//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       // print(channelName);
//       // print(token);
//       print(_isHostVideo);
//       print("----------");
//       return getData();
//     });

//     // getData();
//   }

//   @override
//   Future<void> dispose() async {
//     // TODO: implement dispose
//     await streamController.close();
//     _timer.cancel();
//     // await agoraEngine.leaveChannel();
//     await agoraEngineVideo.leaveChannel();
//     agoraEngineVideo.release();
//     await agoraEngineVoice.leaveChannel();
//     agoraEngineVoice.release();
//     super.dispose();
//   }

//   @override
//   void onClose() {
//     print("close");
//     // onJoinOrLeave(false);
//     streamController.close();
//     onLeave();

//     _timer.cancel();
//     super.onClose();
//   }

//   getRoomInformation() async {
//     var url = Uri.parse(roomInfoUrl);
//     var response = await http.post(url, body: {
//       "roomId": Get.arguments["room_id"],
//     });
//     final dataBody = json.decode(response.body);
//     channelName = dataBody["data"][0]["Channel_Name"];
//     token = dataBody["data"][0]["Token"];
//     update();
//     // print();
//   }

//   onJoin() async {
//     var url = Uri.parse(joinRoom);
//     var url2 = Uri.parse(sendRoomMessage);
//     await http.post(url2, body: {
//       "roomId": Get.arguments["room_id"],
//       "senderName": "roomAlert",
//       "message": "${isGuest ? guestUserName : userName} انضم للغرفة",
//       "joinOrLeave": "0", //left 1 joined 0
//     });

//     await http.post(url, body: {
//       "roomId": Get.arguments["room_id"],
//       "userName": userName,
//     });
//   }

//   onLeave() async {
//     var url = Uri.parse(leaveRoom);
//     var url2 = Uri.parse(sendRoomMessage);
//     await http.post(url2, body: {
//       "roomId": Get.arguments["room_id"],
//       "senderName": "roomAlert",
//       "message": "${isGuest ? guestUserName : userName} غادر للغرفة",
//       "joinOrLeave": "1", //left 1 joined 0
//     });
//     await http.post(url, body: {
//       "roomId": Get.arguments["room_id"],
//       "userName": userName,
//     });
//     print("leave");
//     // isGuest = false;
//     Get.back();
//   }

//   Future<dynamic> getData() async {
//     try {
//       var url = Uri.parse(getRoomMessagesUrl);
//       var response = await http.post(url, body: {
//         "roomId": Get.arguments["room_id"],
//       });
//       final dataBody = json.decode(response.body);

//       if (dataBody["roomPlan"][0]["room_plan"] == "0") {
//         roomStatus = false;
//         _handleRadioValueChange(false);
//       } else {
//         roomStatus = true;
//         _handleRadioValueChange(true);
//       }

//       // print(dataBody["membersInCall"]);
//       // print("-----------");
//       update();
//       membersController.sink.add(dataBody["membersInCall"]);
//       streamController.sink.add(dataBody);
//     } catch (e) {}
//   }

//   sendMessage(String message) async {
//     if (message != "") {
//       messageStatus = true;
//       update();
//       var url = Uri.parse(sendRoomMessage);
//       var response = await http.post(url, body: {
//         "roomId": Get.arguments["room_id"],
//         "senderName": isGuest ? guestUserName : userName,
//         "message": message,
//         "isGuest": isGuest ? "1" : "0",
//         "joinOrLeave": "9", //left 1 joined 0
//       });

//       final dataBody = json.decode(response.body);
//       print(dataBody);
//       if (dataBody["status"] == "success") {
//         messageController.clear();
//         messageStatus = false;
//         update();
//       }
//     }
//   }

//   getRoomMembers() async {
//     try {
//       var url = Uri.parse(roomMember);
//       var response = await http.post(url, body: {
//         "roomid": Get.arguments["room_id"],
//       });
//       final dataBody = json.decode(response.body);
//       print(dataBody);
//       return dataBody;
//     } catch (e) {
//       print("object");
//     }
//   }

//   scrollDownButtonStatus(bool status) {
//     scrollDownButton = status;
//     update();
//   }

//   Future<void> changeRoomStatus() async {
//     var url = Uri.parse(changeRoomPlan);
//     var response = await http.post(url, body: {
//       "roomId": Get.arguments["room_id"],
//     });
//     final dataBody = json.decode(response.body);
//     print(dataBody);
//     if (dataBody["status"] == "success") {
//       roomStatus = !roomStatus;
//     }
//     update();
//     // print(roomStatus);
//   }

//   void changeEmojiStatus(bool status) {
//     emojiStatus = status;
//     update();
//   }

  // joinLeaveCalls() {
  //   if (!inCall) {
  //     joinVoiceCall();
  //   } else {
  //     leaveVoiceCall();
  //   }
  //   inCall = !inCall;
  //   update();
  //   print(inCall);
  // }

  // toggleMic() {
  //   if (cameraWidget) {
  //     toggleCamera();
  //   }
  //   micWidget = !micWidget;
  //   update();
  //   // agoraEngine.muteLocalAudioStream(mic);
  // }

  // micStatus() {
  //   if (mute) {
  //     agoraEngineVoice.muteLocalAudioStream(false);
  //   } else {
  //     agoraEngineVoice.muteLocalAudioStream(true);
  //   }
  //   mute = !mute;
  //   update();
  // }

  // toggleCamera() {
  //   if (micWidget) {
  //     toggleMic();
  //   }
  //   cameraWidget = !cameraWidget;
  //   update();
  // }

//   Widget videoPanel() {
//     if (!_isJoinedVideo) {
//       return SizedBox();
//     } else if (_isHostVideo) {
//       // Show local video preview
//       return AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: agoraEngineVideo,
//           canvas: VideoCanvas(uid: 0),
//         ),
//       );
//     } else {
//       // Show remote video
//       if (_remoteUidVideo != null) {
//         return AgoraVideoView(
//           controller: VideoViewController.remote(
//             rtcEngine: agoraEngineVideo,
//             canvas: VideoCanvas(uid: _remoteUidVideo),
//             connection: RtcConnection(channelId: channelName),
//           ),
//         );
//       } else {
//         return const Text(
//           'Waiting for a host to join',
//           textAlign: TextAlign.center,
//         );
//       }
//     }
//   }

  // void joinVideoCall() async {
  //   // Set channel options
  //   ChannelMediaOptions options;

  //   // Set channel profile and client role
  //   if (_isHostVideo) {
  //     options = const ChannelMediaOptions(
  //       clientRoleType: ClientRoleType.clientRoleBroadcaster,
  //       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
  //     );
  //     await agoraEngineVideo.startPreview();
  //   } else {
  //     options = const ChannelMediaOptions(
  //       clientRoleType: ClientRoleType.clientRoleAudience,
  //       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
  //     );
  //   }

  //   await agoraEngineVideo.joinChannel(
  //     token: token,
  //     channelId: channelName,
  //     options: options,
  //     uid: uid,
  //   );
  // }

//   void leaveVideoCall() {
//     _isJoinedVideo = false;
//     _remoteUidVideo = null;
//     agoraEngineVideo.leaveChannel();
//   }

//   void _handleRadioValueChange(bool value) async {
//     _isHostVideo = (value == true);
//     update();
//     if (_isJoinedVideo) leaveVideoCall();
//   }
// }

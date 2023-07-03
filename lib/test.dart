import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class VoiceChat extends StatefulWidget {
  const VoiceChat({Key key}) : super(key: key);

  @override
  State<VoiceChat> createState() => _VoiceChatState();
}

class _VoiceChatState extends State<VoiceChat> {
  String channelName = "2";
  String token =
      "007eJxTYKh99aOr7HP0FNmPLzgVK1YnqwZP1vVbq75dyuf/pVtvzu5WYEg1NDVMTrYwM05JMTZJTEm2TDM3SzOwME01SUsyTzK30P28MKUhkJHhg74DEyMDBIL4jAxGDAwAlBAgUQ==";

  int uid = 0; // uid of the local user

  int _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    // Set up an instance of Agora engine
    setupVoiceSDKEngine();
    // initAgora();
  }

  // Clean up the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
  }

  // AgoraClient client = AgoraClient(
  //   agoraConnectionData: AgoraConnectionData(
  //     appId: 'e151cc863dd34adc9f76f085e4fb7b78',
  //     channelName: '2',
  //     tempToken:
  //         '007eJxTYKh99aOr7HP0FNmPLzgVK1YnqwZP1vVbq75dyuf/pVtvzu5WYEg1NDVMTrYwM05JMTZJTEm2TDM3SzOwME01SUsyTzK30P28MKUhkJHhg74DEyMDBIL4jAxGDAwAlBAgUQ==',
  //     uid: 0,
  //   ),
  // );

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(
        const RtcEngineContext(appId: 'e151cc863dd34adc9f76f085e4fb7b78'));

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

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Get started with Voice Calling'),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            children: [
              // Status text
              Container(height: 40, child: Center(child: _status())),
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
            ],
          )),
    );
  }

  Widget _status() {
    String statusText;

    if (!_isJoined)
      statusText = 'Join a channel';
    else if (_remoteUid == null)
      statusText = 'Waiting for a remote user to join...';
    else
      statusText = 'Connected to remote user, uid:$_remoteUid';

    return Text(
      statusText,
    );
  }
}


// ignore_for_file: prefer_const_constructors

/////////////////////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:lametna/controllers/userData/userCredentials.dart';
// // import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
// // import 'package:zego_express_engine/zego_express_engine.dart';
// import 'dart:math' as math;

// class VoiceChat extends StatefulWidget {
//   const VoiceChat({Key key}) : super(key: key);

//   @override
//   State<VoiceChat> createState() => _VoiceChatState();
// }

// final userIdvoice = math.Random().nextInt(1000000).toString();

// class _VoiceChatState extends State<VoiceChat> {
//   final callId = TextEditingController();
//   final username = TextEditingController();
//   bool isHost = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "username",
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             TextFormField(
//               controller: username,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//               decoration: InputDecoration(
//                 hintText: "username",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "channel number",
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//             TextFormField(
//               controller: callId,
//               style: TextStyle(
//                 color: Colors.black,
//               ),
//               decoration: InputDecoration(
//                 hintText: "Enter Channel Name",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Is Host ?",
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 ),
//                 Switch(
//                   value: isHost,
//                   onChanged: (value) {
//                     setState(() {
//                       isHost = value;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             Center(
//               child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LivePage(
//                           roomID: callId.text,
//                           isHost: isHost,
//                           username: username.text,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text("Join")),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LivePage extends StatelessWidget {
//   final String roomID;
//   final bool isHost;
//   final String username;

//   const LivePage(
//       {Key key, @required this.roomID, this.isHost = false, this.username})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZegoUIKitPrebuiltLiveAudioRoom(
//         appID:
//             1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//         appSign:
//             '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//         userID: userIdvoice,
//         userName: username,
//         roomID: roomID,
//         config: (isHost
//             ? (ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
//               ..takeSeatIndexWhenJoining = 0)
//             : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience()
//           ..innerText.memberListTitle = 'member list'
//           ..role.index)
//           ..hostSeatIndexes = [0]
//           ..seatConfig = ZegoLiveAudioRoomSeatConfig()
//           ..layoutConfig.rowConfigs = [
//             ZegoLiveAudioRoomLayoutRowConfig(
//                 count: 4,
//                 alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
//           ]
//           ..bottomMenuBarConfig = ZegoBottomMenuBarConfig(
//             hostButtons: [
//               ZegoMenuBarButtonName.toggleMicrophoneButton,
//               ZegoMenuBarButtonName.showMemberListButton,
//             ],
//             speakerButtons: [
//               ZegoMenuBarButtonName.toggleMicrophoneButton,
//               // ZegoMenuBarButtonName.showMemberListButton,
//             ],
//           ),
//       ),
//     );
//   }
// }

// class LivePage extends StatelessWidget {
//   const LivePage({Key key, @required this.roomID, this.isHost = false})
//       : super(key: key);

//   final String roomID;
//   final bool isHost;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZegoUIKitPrebuiltLiveAudioRoom(
//         appID:
//             1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//         appSign:
//             '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//         userID: userIdvoice,
//         userName: 'user_$userIdvoice',
//         roomID: roomID,

//         // Modify your custom configurations here.
//         config: isHost
//             ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
//             : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience()
//           ..seatConfig = (ZegoLiveAudioRoomSeatConfig()
//             ..backgroundBuilder = backgroundBuilder
//             ..foregroundBuilder = foregroundBuilder),
//       ),
//     );
//   }

//   bool isAttributeHost(Map<String, String> userInRoomAttributes) {
//     return (userInRoomAttributes[attributeKeyRole] ?? "") ==
//         ZegoLiveAudioRoomRole.host.index.toString();
//   }

//   Widget backgroundBuilder(
//       BuildContext context, Size size, ZegoUIKitUser user, Map extraInfo) {
//     if (!isAttributeHost(user.inRoomAttributes )) {
//       return Container();
//     }
//     return Positioned(
//       top: -8,
//       left: 0,
//       child: Container(
//         width: size.width,
//         height: size.height,
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(4),
//         ),
//       ),
//     );
//   }

//   Widget foregroundBuilder(
//       BuildContext context, Size size, ZegoUIKitUser user, Map extraInfo) {
//     var userName = user.name.isEmpty ?? true
//         ? Container()
//         : Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Text(
//               user?.name ?? "",
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 backgroundColor: Colors.black.withOpacity(0.1),
//                 fontSize: 9,
//                 fontWeight: FontWeight.w600,
//                 decoration: TextDecoration.none,
//               ),
//             ),
//           );

//     if (!isAttributeHost(user.inRoomAttributes)) {
//       return userName;
//     }

//     var hostIconSize = Size(size.width / 3, size.height / 3);
//     var hostIcon = Positioned(
//       bottom: 3,
//       right: 0,
//       child: Container(
//         width: hostIconSize.width,
//         height: hostIconSize.height,
//         // decoration: BoxDecoration(
//         //   image: YourHostFlagIcon(),
//         // ),
//       ),
//     );

//     return Stack(children: [userName, hostIcon]);
//   }
// }

// class CallPage extends StatelessWidget {
//   final String callId;
//   const CallPage({Key key, this.callId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return

//         // Container();
//         //     ZegoUIKitPrebuiltCall(
//         //   appID:
//         //       1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//         //   appSign:
//         //       '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//         //   userID: userIdvoice,
//         //   userName: 'user_$userIdvoice',
//         //   callID: callId,
//         //   appDesignSize: Size(375, 812),

//         //   // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
//         //   config: ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
//         //     // ..onOnlySelfInRoom = f(context),
//         //     ..turnOnCameraWhenJoining = false
//         //     ..turnOnMicrophoneWhenJoining = false
//         //     ..useSpeakerWhenJoining = true,
//         // );
//         ZegoUIKitPrebuiltLiveAudioRoom(
//       appID:
//           1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//       appSign:
//           '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//       userID: userIdvoice,
//       userName: 'user_$userIdvoice',
//       roomID: "1",
//       config: false
//           ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
//           : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
//     );
//     //     ZegoUIKitPrebuiltCall(
//     //   appID: 1424211637,
//     //   appSign:
//     //       '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e',
//     //   userID: userIdvoice,
//     //   userName: 'user_$userIdvoice',
//     //   callID: callId,

//     //   // Modify your custom configurations here.
//     //   config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
//     // ..turnOnCameraWhenJoining = false
//     // ..turnOnMicrophoneWhenJoining = false
//     // ..useSpeakerWhenJoining = true,
//     // );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// class test extends StatefulWidget {
//   const test({Key key}) : super(key: key);

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   String channelName = "2";
//   String token =
//       "007eJxTYLjsGX/px4H5kZn9nLebHrNqHI/Zz7zsApvyYvW2khUp1+coMKQamhomJ1uYGaekGJskpiRbppmbpRlYmKaapCWZJ5lbLGufkNIQyMhwLECCgREKQXxGBiMGBgA4wB7P";

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

//   @override
//   void initState() {
//     super.initState();
//     // Set up an instance of Agora engine
//     setupVoiceSDKEngine();
//   }

//   @override
//   void dispose() async {
//     await agoraEngine.leaveChannel();
//     super.dispose();
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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';
import 'dart:math' as math;

class VoiceChat extends StatefulWidget {
  const VoiceChat({Key key}) : super(key: key);

  @override
  State<VoiceChat> createState() => _VoiceChatState();
}

final userIdvoice = math.Random().nextInt(1000000).toString();

class _VoiceChatState extends State<VoiceChat> {
  final callId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: callId,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Enter Channel Name",
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CallPage(callId: callId.text),
                      ),
                    );
                  },
                  child: Text("Join")),
            ],
          ),
        ),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  final String callId;
  const CallPage({Key key, this.callId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

        // Container();
        ZegoUIKitPrebuiltCall(
      appID:
          1424211637, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: '1',
      userName: 'user_1',
      callID: callId,
      appDesignSize: Size(375, 812),

      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
        // ..onOnlySelfInRoom = f(context),
        ..turnOnCameraWhenJoining = false
        ..turnOnMicrophoneWhenJoining = false
        ..useSpeakerWhenJoining = true,
    );

    //     ZegoUIKitPrebuiltCall(
    //   appID: 1424211637,
    //   appSign:
    //       '550561384fe38cede999218a4dad780ca84e4b137a1a9e7fc5c7bf94771afa4e',
    //   userID: userIdvoice,
    //   userName: 'user_$userIdvoice',
    //   callID: callId,

    //   // Modify your custom configurations here.
    //   config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
    // ..turnOnCameraWhenJoining = false
    // ..turnOnMicrophoneWhenJoining = false
    // ..useSpeakerWhenJoining = true,
    // );
  }
}

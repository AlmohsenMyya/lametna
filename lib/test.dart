// // ignore_for_file: missing_return

// /*
//  * Copyright 2018, 2019, 2020, 2021 Dooboolab.
//  *
//  * This file is part of Flutter-Sound.
//  *
//  * Flutter-Sound is free software: you can redistribute it and/or modify
//  * it under the terms of the Mozilla Public License version 2 (MPL2.0),
//  * as published by the Mozilla organization.
//  *
//  * Flutter-Sound is distributed in the hope that it will be useful,
//  * but WITHOUT ANY WARRANTY; without even the implied warranty of
//  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  * MPL General Public License for more details.
//  *
//  * This Source Code Form is subject to the terms of the Mozilla Public
//  * License, v. 2.0. If a copy of the MPL was not distributed with this
//  * file, You can obtain one at https://mozilla.org/MPL/2.0/.
//  */

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'package:audio_session/audio_session.dart';

// /*
//  * This is an example showing how to record to a Dart Stream.
//  * It writes all the recorded data from a Stream to a File, which is completely stupid:
//  * if an App wants to record something to a File, it must not use Streams.
//  *
//  * The real interest of recording to a Stream is for example to feed a
//  * Speech-to-Text engine, or for processing the Live data in Dart in real time.
//  *
//  */

// ///
// typedef _Fn = void Function();

// /* This does not work. on Android we must have the Manifest.permission.CAPTURE_AUDIO_OUTPUT permission.
//  * But this permission is _is reserved for use by system components and is not available to third-party applications._
//  * Pleaser look to [this](https://developer.android.com/reference/android/media/MediaRecorder.AudioSource#VOICE_UPLINK)
//  *
//  * I think that the problem is because it is illegal to record a communication in many countries.
//  * Probably this stands also on iOS.
//  * Actually I am unable to record DOWNLINK on my Xiaomi Chinese phone.
//  *
//  */
// //const theSource = AudioSource.voiceUpLink;
// //const theSource = AudioSource.voiceDownlink;

// const theSource = AudioSource.microphone;

// /// Example app.
// class SimpleRecorder extends StatefulWidget {
//   @override
//   _SimpleRecorderState createState() => _SimpleRecorderState();
// }

// class _SimpleRecorderState extends State<SimpleRecorder> {
//   Codec _codec = Codec.aacMP4;
//   String _mPath = 'tau_file.mp4';
//   String audioPath = "";
//   FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
//   FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
//   bool _mPlayerIsInited = false;
//   bool _mRecorderIsInited = false;
//   bool _mplaybackReady = false;

//   @override
//   void initState() {
//     _mPlayer.openPlayer().then((value) {
//       setState(() {
//         _mPlayerIsInited = true;
//       });
//     });

//     openTheRecorder().then((value) {
//       setState(() {
//         _mRecorderIsInited = true;
//       });
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _mPlayer.closePlayer();
//     _mPlayer = null;

//     _mRecorder.closeRecorder();
//     _mRecorder = null;
//     super.dispose();
//   }

//   Future<void> openTheRecorder() async {
//     if (!kIsWeb) {
//       var status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         throw RecordingPermissionException('Microphone permission not granted');
//       }
//     }
//     await _mRecorder.openRecorder();
//     if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
//       _codec = Codec.opusWebM;
//       _mPath = 'tau_file.webm';
//       if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
//         _mRecorderIsInited = true;
//         return;
//       }
//     }
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions:
//           AVAudioSessionCategoryOptions.allowBluetooth |
//               AVAudioSessionCategoryOptions.defaultToSpeaker,
//       avAudioSessionMode: AVAudioSessionMode.spokenAudio,
//       avAudioSessionRouteSharingPolicy:
//           AVAudioSessionRouteSharingPolicy.defaultPolicy,
//       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//       androidAudioAttributes: const AndroidAudioAttributes(
//         contentType: AndroidAudioContentType.speech,
//         flags: AndroidAudioFlags.none,
//         usage: AndroidAudioUsage.voiceCommunication,
//       ),
//       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//       androidWillPauseWhenDucked: true,
//     ));

//     _mRecorderIsInited = true;
//   }

//   // ----------------------  Here is the code for recording and playback -------

//   void record() {
//     _mRecorder
//         .startRecorder(
//       toFile: _mPath,
//       codec: _codec,
//       audioSource: theSource,
//     )
//         .then((value) {
//       setState(() {});
//     });
//   }

//   void stopRecorder() async {
//     audioPath = await _mRecorder.stopRecorder();
//     setState(() {
//       //var url = value;
//       _mplaybackReady = true;
//     });

//     final path = await File(audioPath);
//     var request = http.MultipartRequest(
//       'POST', // Change this to your API method
//       Uri.parse(
//           'https://lametnachat.com/messages/audioInRoom.php'), // Replace with your API endpoint
//     );
//     request.fields['roomId'] = '4';
//     request.fields['senderUserRoom'] = 'ali';
//     request.fields['senderUserRoom'] = 'aliTest';
//     request.files.add(
//       http.MultipartFile(
//         'audioc', // API parameter name for the file
//         path.readAsBytes().asStream(),
//         path.lengthSync(),
//         filename: 'your_audio_filename.opus',
//         // contentType: MediaType('audio', 'wav'),
//       ),
//     );

//     var response = await request.send();
//     if (response.statusCode == 200) {
//       // Successfully uploaded
//       print('Audio uploaded successfully');
//     } else {
//       // Error uploading
//       print('Error uploading audio');
//     }

//     print("audioPath: $path");
//   }

//   void play() {
//     assert(_mPlayerIsInited &&
//         _mplaybackReady &&
//         _mRecorder.isStopped &&
//         _mPlayer.isStopped);
//     _mPlayer
//         .startPlayer(
//             fromURI: _mPath,
//             //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
//             whenFinished: () {
//               setState(() {});
//             })
//         .then((value) {
//       setState(() {});
//       print(value);
//     });
//   }

//   void stopPlayer() {
//     _mPlayer.stopPlayer().then((value) {
//       setState(() {});
//     });
//   }

// // ----------------------------- UI --------------------------------------------

//   _Fn getRecorderFn() {
//     if (!_mRecorderIsInited || !_mPlayer.isStopped) {
//       return null;
//     }
//     return _mRecorder.isStopped ? record : stopRecorder;
//   }

//   _Fn getPlaybackFn() {
//     if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder.isStopped) {
//       return null;
//     }
//     return _mPlayer.isStopped ? play : stopPlayer;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget makeBody() {
//       return Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(3),
//             padding: const EdgeInsets.all(3),
//             height: 80,
//             width: double.infinity,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Color(0xFFFAF0E6),
//               border: Border.all(
//                 color: Colors.indigo,
//                 width: 3,
//               ),
//             ),
//             child: Row(children: [
//               ElevatedButton(
//                 onPressed: getRecorderFn(),
//                 //color: Colors.white,
//                 //disabledColor: Colors.grey,
//                 child: Text(_mRecorder.isRecording ? 'Stop' : 'Record'),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(_mRecorder.isRecording
//                   ? 'Recording in progress'
//                   : 'Recorder is stopped'),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.all(3),
//             padding: const EdgeInsets.all(3),
//             height: 80,
//             width: double.infinity,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Color(0xFFFAF0E6),
//               border: Border.all(
//                 color: Colors.indigo,
//                 width: 3,
//               ),
//             ),
//             child: Row(children: [
//               ElevatedButton(
//                 onPressed: getPlaybackFn(),
//                 //color: Colors.white,
//                 //disabledColor: Colors.grey,
//                 child: Text(_mPlayer.isPlaying ? 'Stop' : 'Play'),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(_mPlayer.isPlaying
//                   ? 'Playback in progress'
//                   : 'Player is stopped'),
//             ]),
//           ),
//         ],
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: const Text('Simple Recorder'),
//       ),
//       body: makeBody(),
//     );
//   }
// }



import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Video extends StatefulWidget {
  const Video({Key key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
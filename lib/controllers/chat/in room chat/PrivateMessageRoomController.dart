import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

typedef _Fn = void Function();

class PrivateMessagesRoomController extends GetxController {
  var theSource = AudioSource.microphone;
  TextEditingController messageRoomController = TextEditingController();
  StreamController streamController = StreamController();
  late Timer _timer;

  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  String audioPath = "";
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? mRecorder = FlutterSoundRecorder();
  //  AudioPlayer audioPlayer = AudioPlayer();
  bool _mPlayerIsInited = false;
  bool mRecorderIsInited = false;
  bool _mplaybackReady = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    _mPlayer!.openPlayer().then((value) {
      _mPlayerIsInited = true;
    });

    openTheRecorder().then((value) {
      mRecorderIsInited = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
       getData();
    });
    update();
  }

  @override
  void onClose() {
    _timer.cancel();
    _mPlayer!.closePlayer();
    _mPlayer = null;

    mRecorder!.closeRecorder();
    mRecorder = null;
    super.onClose();
  }

  Future<dynamic> getData() async {
    try {
      // print(userName);
      // print("-------------------");
      // print(Get.arguments['username']);
      var url = Uri.parse(getPrivateMessageRoom);
      var response = await http.post(url, body: {
        "roomId": Get.arguments['room_id'],
        "senderUserRoom": Get.arguments["username"],
        "recieverUserRoom": mobileUserName,
      });
      final dataBody = json.decode(response.body);
      update();
      streamController.sink.add(dataBody);
      return dataBody; // add this line to return the data
    } catch (e) {
      // handle any errors here
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> sendMsg() async {
    try {
      var url = Uri.parse(sendPrivateMessageRoom);
      if (messageRoomController.text.trim() != "") {
        var response = await http.post(url, body: {
          "roomId": Get.arguments['room_id'],
          "senderUserRoom": mobileUserName,
          "recieverUserRoom": Get.arguments["username"],
          "message": messageRoomController.text.trim(),
        });
        final dataBody = json.decode(response.body);
        if (dataBody['status'] == "success") {
          messageRoomController.text = "";
          print("success سثىي ة");
        } else {
          print("error");
        }
        return dataBody;
      }
    } catch (e) {
      // handle any errors here
      print(e.toString());
    }
    return null;
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await mRecorder!.openRecorder();
    if (!await mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    mRecorderIsInited = true;
  }

  void record() {
    mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      update();
    });
  }

  void stopRecorder() async {
    audioPath = (await mRecorder!.stopRecorder())!;
    //var url = value;
    _mplaybackReady = true;
    update();

    final path = File(audioPath);
    var request = http.MultipartRequest(
      'POST', // Change this to your API method
      Uri.parse(
          'https://lametnachat.com/messages/audioInRoom.php'), // Replace with your API endpoint
    );
    request.fields['roomId'] = Get.arguments["room_id"];
    request.fields['senderUserRoom'] = mobileUserName;
    request.fields['recieverUserRoom'] = Get.arguments['username'];
    request.files.add(
      http.MultipartFile(
        'audioc', // API parameter name for the file
        path.readAsBytes().asStream(),
        path.lengthSync(),
        filename: 'record${Random().nextInt(9999)}.opus',
        // contentType: MediaType('audio', 'wav'),
      ),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      // Successfully uploaded
      print('Audio uploaded successfully');
    } else {
      // Error uploading
      print('Error uploading audio');
    }

    print("audioPath: $path");
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              update();
            })
        .then((value) {
      update();
    });
  }

  void playRecording(String url) {
    _mPlayer!.startPlayer(
      fromURI: "$baseURL/upload/audiochats/$url",
    );
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      update();
    });
  }

  _Fn? getRecorderFn() {
    if (!mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }
}

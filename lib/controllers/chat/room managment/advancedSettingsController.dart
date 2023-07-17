import 'dart:convert';

import 'package:get/get.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class AdvancedSettingsController extends GetxController {
  bool sendImage;
  bool sendText;
  bool sendVoiceInPrivate;
  bool sendAlerts;
  bool allowAddMaster;
  bool allowEditRoomSettings;
  var items = [
    {
      "title": "السماح بإرسال االصور في النص العام",
    },
    {
      "title": "توقيف النص للجميع",
    },
    {
      "title": "السماح بإرسال الرسائل الصوتية بالخاص",
    },
    {
      "title": "السماح بارسال رسالة التحذير",
    },
    {
      "title": "السماح بإضافة ماستر",
    },
    {
      "title": "السماح بتعديل إعداد الغرفة",
    }
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await getData();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    await saveData();
    print("object");
  }

  // @override
  void changeSendImage(bool value) {
    sendImage = value;
    update();
  }

  void changeSendText(bool value) {
    sendText = value;
    update();
  }

  void changeSendVoiceInPrivate(bool value) {
    sendVoiceInPrivate = value;
    update();
  }

  void changeSendAlerts(bool value) {
    sendAlerts = value;
    update();
  }

  void changeAllowAddMaster(bool value) {
    allowAddMaster = value;
    update();
  }

  void changeAllowEditRoomSettings(bool value) {
    allowEditRoomSettings = value;
    update();
  }

  getData() async {
    var url = Uri.parse(roomInfoUrl);
    var res = await http.post(url, body: {"roomId": Get.arguments["room_id"]});
    var data = await jsonDecode(res.body);

    if (res.statusCode == 200) {
      // await print(data["sendImage"]);
      print(data);
      // print(data["data"][0]["room_id"]);
      sendImage = data["data"][0]["sendImage"] == "true" ? true : false;
      sendText = data["data"][0]["sendText"] == "true" ? true : false;
      sendAlerts = data["data"][0]["sendAlert"] == "true" ? true : false;
      sendVoiceInPrivate =
          data["data"][0]["sendVoiceInPrivate"] == "true" ? true : false;
      allowAddMaster =
          data["data"][0]["allowAddMaster"] == "true" ? true : false;
      allowEditRoomSettings =
          data["data"][0]["allowEditRoom"] == "true" ? true : false;
      update();
    }
  }

  saveData() async {
    var url = Uri.parse(advancedSettings);
    var res = await http.post(url, body: {
      "room_id": Get.arguments["room_id"],
      "sendImage": sendImage.toString(),
      "sendText": sendText.toString(),
      "sendVoiceInPrivate": sendVoiceInPrivate.toString(),
      "sendAlert": sendAlerts.toString(),
      "allowAddMaster": allowAddMaster.toString(),
      "allowEditRoom": allowEditRoomSettings.toString(),
    });
    if (res.statusCode == 200) {
      print("saved");
    }
  }
}

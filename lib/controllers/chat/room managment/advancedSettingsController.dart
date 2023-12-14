import 'dart:convert';

import 'package:get/get.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class AdvancedSettingsController extends GetxController {
  var sendImage;
  var sendText;
  var sendVoiceInPrivate;
  var sendAlerts;
  bool allowAddMaster;
  bool allowEditRoomSettings;
  var roomEntries;

  bool canEdit;
  var items = [
    {
      "title": "السماح للمستخدمين إرسال الصور في غرفة الدردشة",
    },
    {
      "title": "السماح للمستخدمين إرسال رسائل في غرفة الدردشة",
    },
    {
      "title": "السماح للمستخدمين إرسال رسائل الصوتية في  الخاص",
    },
    {
      "title": "السماح للمستخدمين إرسال رسائل التحذير في غرفة الدردشة",
    },
    {
      "title": "السماح للمستخدمين الدخول بالدخوليات في غرفة الدردشة",
    },
  ];

  var masterOption = [
    {
      "title": "السماح بإضافة ماستر",
    },
    {
      "title": "السماح بتعديل إعداد الغرفة",
    }
  ];
  var sendOption = [
    {
      "title": "السماح للمستخدمين إرسال الصور في غرفة الدردشة",
    },
    {
      "title": "السماح للمستخدمين إرسال رسائل في غرفة الدردشة",
    },
    {
      "title": "السماح للمستخدمين إرسال رسائل الصوتية في  الخاص",
    },
    {
      "title": "السماح للمستخدمين إرسال رسائل التحذير في غرفة الدردشة",
    },
    {
      "title": "السماح للمستخدمين الدخول بالدخوليات في غرفة الدردشة",
    },
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await getData();
    await checkAuthorization();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    await saveData();
    checkAuthorization();
    print("object");
  }

  checkAuthorization() async {
    var url = Uri.parse(checkRoomEdit);
    var res = await http.post(url, body: {
      "roomId": Get.arguments["room_id"],
      // "user_id": Get.arguments["user_id"],
    });
    var data = await jsonDecode(res.body);
    if (res.statusCode == 200) {
      print(data);
      if (data["allowEditRoom"] == "true") {
        canEdit = true;
        update();
      } else {
        canEdit = false;
        update();
      }
      print(canEdit);
    }
  }

  // @override
  void changeSendImage(String value) {
    sendImage = value;
    update();
  }

  void changeSendText(String value) {
    sendText = value;
    update();
  }

  void changeSendVoiceInPrivate(String value) {
    sendVoiceInPrivate = value;
    update();
  }

  void changeSendAlerts(String value) {
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

  void changeRoomEntries(String value) {
    roomEntries = value;
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
      sendImage = data["data"][0]["sendImage"];
      sendText = data["data"][0]["sendText"];
      sendAlerts = data["data"][0]["sendAlert"];
      sendVoiceInPrivate = data["data"][0]["sendVoiceInPrivate"];
      allowAddMaster = data["data"][0]["allowAddMaster"];
      allowEditRoomSettings = data["data"][0]["allowEditRoom"];
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

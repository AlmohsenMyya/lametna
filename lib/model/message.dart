class MessagesModel {
  String? status;
  List<Data>? data;

  MessagesModel({this.status, this.data});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        (data??[]).add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data!.map((v) => v.toJson()).toList();
      return data;
  }
}

class Data {
  String? messageid;
  String ?time;
  String ?sender;
  String ?text;
  String ?roomId;
  String ?senderName;

  Data(
      {this.messageid,
      this.time,
      this.sender,
      this.text,
      this.roomId,
      this.senderName});

  Data.fromJson(Map<String, dynamic> json) {
    messageid = json['messageid'];
    time = json['time'];
    sender = json['sender'];
    text = json['text'];
    roomId = json['room_id'];
    senderName = json['sender_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageid'] = messageid;
    data['time'] = time;
    data['sender'] = sender;
    data['text'] = text;
    data['room_id'] = roomId;
    data['sender_name'] = senderName;
    return data;
  }
}

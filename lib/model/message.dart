class MessagesModel {
  String status;
  List<Data> data;

  MessagesModel({this.status, this.data});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String messageid;
  String time;
  String sender;
  String text;
  String roomId;
  String senderName;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageid'] = this.messageid;
    data['time'] = this.time;
    data['sender'] = this.sender;
    data['text'] = this.text;
    data['room_id'] = this.roomId;
    data['sender_name'] = this.senderName;
    return data;
  }
}

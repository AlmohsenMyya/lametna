import 'package:flutter/material.dart';

class Rooms {
  String roomId;
  String ownerUsername;
  String roomName;
  String channelName;
  String token;
  String roomImg;
  String backgroundImg;
  String backgroundColor;
  String status;
  String helloMsg;
  String password;
  String capacity;
  String numberOfConnections;
  String startDate;
  String expiryDate;
  String roomType;
  String roomPlan;
  String description;
  String countryName;
  String flag;

  Rooms(
      {@required this.roomId,
      @required this.ownerUsername,
      @required this.roomName,
      @required this.channelName,
      @required this.token,
      @required this.roomImg,
      @required this.backgroundImg,
      @required this.backgroundColor,
      @required this.status,
      @required this.helloMsg,
      @required this.password,
      @required this.capacity,
      @required this.numberOfConnections,
      @required this.startDate,
      @required this.expiryDate,
      @required this.roomType,
      @required this.roomPlan,
      @required this.description,
      @required this.countryName,
      @required this.flag});

  Rooms.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    ownerUsername = json['owner_username'];
    roomName = json['room_name'];
    channelName = json['Channel_Name'];
    token = json['Token'];
    roomImg = json['room_img'];
    backgroundImg = json['background_img'];
    backgroundColor = json['background_color'];
    status = json['status'];
    helloMsg = json['hello_msg'];
    password = json['password'];
    capacity = json['capacity'];
    numberOfConnections = json['number_of_connections'];
    startDate = json['start_date'];
    expiryDate = json['expiry_date'];
    roomType = json['room_type'];
    roomPlan = json['room_plan'];
    description = json['description'];
    countryName = json['country_name'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['owner_username'] = this.ownerUsername;
    data['room_name'] = this.roomName;
    data['Channel_Name'] = this.channelName;
    data['Token'] = this.token;
    data['room_img'] = this.roomImg;
    data['background_img'] = this.backgroundImg;
    data['background_color'] = this.backgroundColor;
    data['status'] = this.status;
    data['hello_msg'] = this.helloMsg;
    data['password'] = this.password;
    data['capacity'] = this.capacity;
    data['number_of_connections'] = this.numberOfConnections;
    data['start_date'] = this.startDate;
    data['expiry_date'] = this.expiryDate;
    data['room_type'] = this.roomType;
    data['room_plan'] = this.roomPlan;
    data['description'] = this.description;
    data['country_name'] = this.countryName;
    data['flag'] = this.flag;
    return data;
  }
}

import 'package:get/get.dart';

class RoomsPageController extends GetxController {
  bool roomStatus = false;

  void changeRoomStatus() {
    roomStatus = !roomStatus;
    update();
    // print(roomStatus);
  }
}

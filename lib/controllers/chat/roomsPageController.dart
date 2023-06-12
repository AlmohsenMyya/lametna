import 'package:get/get.dart';

class RoomsPageController extends GetxController {
  bool roomStatus = true;

  void changeRoomStatus() {
    roomStatus = !roomStatus;
    update();
    // print(roomStatus);
  }
}

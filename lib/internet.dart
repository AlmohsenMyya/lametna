import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  var _connectionStatus = ConnectivityResult.none;

  ConnectivityResult get connectionStatus => _connectionStatus;

  @override
  void onInit() {
    super.onInit();

    // Check the initial connectivity status
    checkConnectivity();

    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result;
      update();
    });
  }

  Future<void> checkConnectivity() async {
    _connectionStatus = await Connectivity().checkConnectivity();
  }
}

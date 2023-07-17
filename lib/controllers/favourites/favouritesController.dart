import 'dart:convert';

import 'package:get/get.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/controllers/userData/variables.dart';
import 'package:http/http.dart' as http;

class FavouritesController extends GetxController {
  List favouriteRooms = [];
  bool noFavourites = false;
  @override
  void onInit() {
    super.onInit();
    getFavourites();
    noFavourites = false;
  }

  getFavourites() async {
    favouriteRooms.clear();
    var url = Uri.parse(viewFavoriteRooms);
    var response = await http.post(url, body: {
      "username": userName,
    });
    final databody = json.decode(response.body);
    // update();
    if (databody["data"].length == 0) {
      noFavourites = true;
    }
    for (var i = 0; i < databody["data"].length; i++) {
      favouriteRooms.add(databody["data"][i]);
    }
    update();

    // return databody;
  }

  removeFavouriteFromList(String roomId) {
    for (var i = 0; i < favouriteRooms.length; i++) {
      if (favouriteRooms[i]["room_id"] == roomId) {
        favouriteRooms.removeAt(i);
        if (favouriteRooms.length == 0) {
          noFavourites = true;
        }
        update();
        break;
      }
    }
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/chathomePageController.dart';
import 'package:lametna/controllers/favourites/favouritesController.dart';
import 'package:lametna/controllers/userData/userCredentials.dart';
import 'package:lametna/view/VIPRoombuildder.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "المفضلة",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Portada',
            fontSize: 20.sp,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<FavouritesController>(
        init: FavouritesController(),
        builder: (controller) => controller.noFavourites
            ? Center(
                child: Text(
                  "لا يوجد غرف مفضلة",
                  style: TextStyle(fontSize: 20.sp, color: Colors.black),
                ),
              )
            : ListView.builder(
                itemCount: controller.favouriteRooms.length,
                itemBuilder: (context, index) => _builderRooms(
                    context,
                    controller.favouriteRooms[index]["room_name"],
                    controller.favouriteRooms[index]["country_name"],
                    controller.favouriteRooms[index]["flag"],
                    controller.favouriteRooms[index]["description"],
                    controller.favouriteRooms[index]["room_id"],
                    controller.favouriteRooms[index]["owner_username"],
                    controller,
                    color: controller.favouriteRooms[index]
                                ["background_color"] ==
                            ""
                        ? Colors.white
                        : Color(int.parse(
                                controller.favouriteRooms[index]
                                        ["background_color"]
                                    .substring(1, 7),
                                radix: 16) +
                            0xFF000000)),
              ),
      ),
    );
  }

  Widget _builderRooms(
      BuildContext context,
      String roomName,
      String countryName,
      String flag,
      String description,
      String roomId,
      String owner,
      FavouritesController controller2,
      {Color color = Colors.white}) {
    //bet5od color law mafesh color betb2a white
    //shayf el widget dy??
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          print(mobileUserName);
          print(owner);
          if (mobileUserName.isNotEmpty) {
            Get.toNamed('/room', arguments: {
              "room_name": roomName,
              "room_id": roomId,
              "owner": owner,
            });
          } else if (isGuest) {
            showAlert(context,
                roomId: roomId, roomName: roomName, roomOwner: owner);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: Color(0xFF43D0CA),
                              ),
                            ),
                            height: 56.h,
                            width: 60.w,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10.r), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(30.r), // Image radius
                                child: Image.network(
                                  'https://media.istockphoto.com/id/1295072146/vector/mini-heart-korean-love-hand-finger-symbol-on-pink-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=eihpG3p1GoSvMjlSAQjCft50iff2I1AweF2a1MLI1SQ=',
                                  fit: BoxFit.fill,
                                  // height: 30,
                                  // width: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            // height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  roomName,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "Portada"),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/flags/$flag.png",
                                      width: 14.w,
                                      height: 15.h,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      countryName,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: "Portada"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GetBuilder<ChatHomeController>(builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            // print(roomId);
                            controller.addOrRemoveToFavourite(roomId);
                            // controller2.getFavourites();
                            controller2.removeFavouriteFromList(roomId);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h, left: 5.h),
                            child: Icon(
                              Icons.delete,
                              size: 20.sp,
                              color: Colors.red,
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          description,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontFamily: "Portada"),
                        ),
                        Text("300 ",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontFamily: "Portada")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

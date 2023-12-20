// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators, avoid_print

import 'package:flutter/material.dart';
import 'package:lametna/controllers/chat/roomsPageController.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/videoController.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/controllers/chat/voice%20and%20video/voiceController.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

import '../../../controllers/userData/userCredentials.dart';
import '../../../controllers/userData/variables.dart';
import '../moments/viewComments.dart';

Widget buildMyNavBar(BuildContext context) {
  return GetBuilder<RoomsPageController>(
      init: RoomsPageController(),
      builder: (controller) {
        var color = Color(int.parse(controller.themeColor!.substring(1, 7), radix: 16) + 0xFF000000);

        onBackspacePressed() {
          controller.messageController
            ..text = controller.messageController.text.characters.toString()
            ..selection = TextSelection.fromPosition(TextPosition(offset: controller.messageController.text.length));
        }

        return controller.themeColor == null
            ? SizedBox()
            : Container(
                // height: 71.h,
                decoration: BoxDecoration(
                  // LinearGradient
                  // gradient: controller.themeColor == ""
                  //     ? LinearGradient(
                  //         colors: [
                  //           Color(0xFFF792F0),
                  //           Color(0xFFFABD63),
                  //         ],
                  //         begin: Alignment.centerLeft,
                  //         end: Alignment.centerRight,
                  //       )
                  //     : null,
                  color: color,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 11.h, 5.w, 11.h),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 55,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: TextFormField(
                              readOnly: true,
                              cursorColor: Colors.black,
                              controller: controller.messageController,
                              focusNode: FocusNode().enclosingScope,
                              style: TextStyle(
                                color: Colors.black, //Color(0xff9A8B8B),
                                fontSize: 14.sp,
                                // fontFamily: "Portada",
                              ),
                              // expands: true,
                              maxLines: 1,
                              onFieldSubmitted: (value) {
                                controller.sendMessage(controller.messageController.text);
                                controller.changeChatStatus(true);
                                print("close");
                              },
                              // onTapOutside: (event) => FocusScope.of(context).unfocus(),
                              onTap: () {
                                // FocusScope.of(context).unfocus();
                                controller.changeChatStatus(true);
                                print("tap");
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => Container(
                                          padding: EdgeInsets.all(10.sp),
                                          // height: 100.h,
                                          // width: 200.w,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.sendMessage(controller.messageController.text);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10.sp),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.5),
                                                      borderRadius: BorderRadius.circular(10.r),
                                                    ),
                                                    child: Text("ارسال"),
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,
                                                  child: TextFormField(
                                                    controller: controller.messageController,
                                                    onFieldSubmitted: (value) {
                                                      controller.sendMessage(controller.messageController.text);
                                                    },
                                                    style: TextStyle(
                                                      color: Colors.black, //Color(0xff9A8B8B),
                                                      fontSize: 14.sp,
                                                      // fontFamily: "Portada",
                                                    ),
                                                    decoration: InputDecoration(
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                        ),
                                                        borderRadius: BorderRadius.circular(10.r),
                                                      ),
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                                                      prefixIconConstraints: BoxConstraints.expand(height: 35.h, width: 37.w),
                                                      hintStyle: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: Colors.grey,
                                                          ),
                                                          borderRadius: BorderRadius.circular(10.r)),
                                                      filled: true,
                                                      fillColor: Colors.white, // Color(0xff00000029),
                                                    ),
                                                    autofocus: true,
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                Icon(Icons.emoji_emotions_outlined, size: 35.sp, color: Colors.grey),
                                                SizedBox(width: 10.w),
                                                Icon(Icons.image, size: 35.sp, color: Colors.grey),
                                              ],
                                            ),
                                          ),
                                        ));
                                if (!controller.emojiStatus) {
                                  controller.changeEmojiStatus(true);
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                                prefixIconConstraints: BoxConstraints.expand(height: 35.h, width: 37.w),
                                prefixIcon: Icon(
                                  Icons.chat_bubble,
                                  size: 25.sp,
                                  color: Colors.grey,
                                ),
                                hintText: 'hi..',
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  // fontFamily: "Portada",
                                ),
                                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50.r)),
                                filled: true,
                                fillColor: Colors.white, // Color(0xff00000029),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: GestureDetector(
                            onTap: () {
                              controller.changeEmojiStatus(!controller.emojiStatus);
                              print("object");
                              print("------");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "🙂",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 27.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: GestureDetector(
                            onTap: () async{
                            controller.voiceController.join();

                              print(isRole);
                              print(isGuest);
                              print("------");
                              controller.changeRoomStatus();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.mic, color: Colors.white, size: 27.sp),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: GestureDetector(
                            onTap: () {
                            controller.videoController.join();
                              print("object");
                              print("------");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.camera_alt, color: Colors.white, size: 27.sp),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: GestureDetector(
                            onTap: () {
                              // controller.changeEmojiStatus(!controller.emojiStatus);
                              print("object");
                              print("------");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.volume_up_rounded, color: Colors.white, size: 27.sp),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: GestureDetector(
                            onTap: () {
                              // controller.changeEmojiStatus(!controller.emojiStatus);
                              print("object");
                              print("------");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(Icons.back_hand, color: Colors.white, size: 27.sp),
                              ),
                            ),
                          ),
                        ),
                        if (isGuest == false && isRole == false)
                          Expanded(
                            flex: 20,
                            child: GestureDetector(
                              onTap: () {
                                // controller.changeEmojiStatus(!controller.emojiStatus);
                                // showMessageModal(context);
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) => Container(
                                    height: 500,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.sp),
                                          child: Text(
                                            "الرسائل",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        FutureBuilder(
                                          future: controller.getPeopleMessaged(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                            var data1 = snapshot.data as List<dynamic>;
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: data1.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    title: Text(
                                                        data1[index]["participant_name"].toString(),
                                                      // ,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                        data1[index]["last_message"].toString(),
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    leading: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                        imageURL + data1[index]["participant_name"].toString() + ".jpeg",
                                                      ),
                                                    ),
                                                    trailing: Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: Text(
                                                        convertTime(data1[index]["last_message_timestamp"]),
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 13.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                // Text(
                                                //   snapshot.data[index]["participant_name"].toString(),
                                                //   style: TextStyle(color: Colors.black),
                                                // ),
                                                );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                print("object");
                                print("------");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(Icons.mail, color: Colors.white, size: 27.sp),
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(),
                      ],
                    ),
                  ),
                ),
/////////////////////////////////////////////////////////////////////
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 71.h,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 17,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 GetBuilder<VideoController>(
//                                   init: VideoController(),
//                                   builder: (controller) {
//                                     return GestureDetector(
//                                       onTap: () {
//                                         // controller.toggleCamera();
//                                       },
//                                       child: Icon(
//                                         Icons.add_circle_outline,
//                                         size: 25.sp,
//                                         color: Colors.white,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                                 GetBuilder<VoiceController>(
//                                   init: VoiceController(),
//                                   builder: (controller) {
//                                     return GestureDetector(
//                                       onTap: () {
//                                         // controller.joinCall();/////////////////////////////////////////////////////////////
//                                         controller.join();
//                                         // controller.toogleMic();
//                                         // print("object");
//                                       },
//                                       onDoubleTap: () {
//                                         // controller.leaveCall();///////////////////////////////////////////////////////////////////
//                                         controller.leave();
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: controller.inCall ? Colors.white.withOpacity(0.8) : Colors.transparent,
//                                           borderRadius: BorderRadius.circular(8.r),
//                                         ),
//                                         padding: EdgeInsets.all(4.sp),
//                                         child: Image.asset(
//                                           'assets/icons/mic.png',
//                                           width: 25.w,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             flex: 73,
//                             child: SizedBox(
//                               height: 40.h,
//                               child: Directionality(
//                                 textDirection: TextDirection.rtl,
//                                 child: GetBuilder<RoomsPageController>(
//                                   builder: (controller) {
//                                     return TextFormField(
//                                       cursorColor: Colors.black,
//                                       controller: controller.messageController,
//                                       focusNode: FocusNode().enclosingScope,
//                                       style: TextStyle(
//                                         color: Colors.black, //Color(0xff9A8B8B),
//                                         fontSize: 14.sp,
//                                         // fontFamily: "Portada",
//                                       ),
//                                       // expands: true,
//                                       maxLines: 1,
//                                       // onFieldSubmitted: (value) => controller.sendMessage(controller.messageController.text),
//                                       onTapOutside: (event) => FocusScope.of(context).unfocus(),
//                                       onTap: () {
//                                         // FocusScope.of(context).unfocus();
//
//                                         if (!controller.emojiStatus) {
//                                           controller.changeEmojiStatus(true);
//                                         }
//                                       },
//                                       decoration: InputDecoration(
//                                         contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
//                                         suffixIconConstraints: BoxConstraints.expand(height: 35.h, width: 37.w),
//                                         suffixIcon: GestureDetector(
//                                             onTap: () {
//                                               controller.changeEmojiStatus(!controller.emojiStatus);
//                                               print("object");
//                                               FocusScope.of(context).unfocus();
//                                             },
//                                             child: Icon(
//                                               Icons.emoji_emotions_outlined,
//                                               color: color,
//                                             )),
//                                         hintText: 'اكتب رسالة',
//                                         hintStyle: TextStyle(
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w700,
//                                           // fontFamily: "Portada",
//                                         ),
//                                         border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
//                                         filled: true,
//                                         fillColor: Colors.white, // Color(0xff00000029),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 10,
//                             child: GetBuilder<RoomsPageController>(builder: (controller) {
//                               return !controller.messageStatus
//                                   ? GestureDetector(
//                                       onTap: () {
//                                         // MediaQuery.of(context).viewInsets.bottom
//                                         // if (MediaQuery.of(context).viewInsets.bottom != 0) {
//                                         //   print("object");
//                                         // } else {`
//                                         //   print("close");
//                                         // }
//                                         controller.sendMessage(controller.messageController.text);
//                                       },
//                                       child: Icon(
//                                         Icons.send,
//                                         color: Colors.white,
//                                         size: 25.sp,
//                                       ),
//                                     )
//                                   : SizedBox(
//                                       // width: 20.w,
//                                       height: 45.h,
//                                       child: Padding(
//                                         padding: EdgeInsets.all(8.sp),
//                                         child: Center(
//                                           child: CircularProgressIndicator(
//                                             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Offstage(
//                       offstage: controller.emojiStatus,
//                       child: SizedBox(
//                           height: 250,
//                           width: Get.width,
//                           child: EmojiPicker(
//                             textEditingController: controller.messageController,
//                             onBackspacePressed: onBackspacePressed,
//                             config: Config(
//                               columns: 7,
//                               // Issue: https://github.com/flutter/flutter/issues/28894
//                               emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
//                               verticalSpacing: 0,
//                               horizontalSpacing: 0,
//                               gridPadding: EdgeInsets.zero,
//                               initCategory: Category.RECENT,
//                               bgColor: const Color(0xFFF2F2F2),
//                               indicatorColor: color,
//                               iconColor: Colors.grey,
//                               iconColorSelected: color,
//                               backspaceColor: color,
//                               skinToneDialogBgColor: Colors.white,
//                               skinToneIndicatorColor: Colors.grey,
//                               enableSkinTones: true,
//                               recentTabBehavior: RecentTabBehavior.RECENT,
//                               recentsLimit: 28,
//                               replaceEmojiOnLimitExceed: false,
//
//                               loadingIndicator: const SizedBox.shrink(),
//                               tabIndicatorAnimDuration: kTabScrollDuration,
//                               categoryIcons: const CategoryIcons(),
//                               buttonMode: ButtonMode.MATERIAL,
//                               checkPlatformCompatibility: true,
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
              );
      });
}

Future<dynamic> showMessageModal(BuildContext context) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: Colors.white,
    context: context,
    builder: (context) => Container(),
  );
}
// convertTime(String time) {
//   var dateTime = DateTime.now();
//   var val = DateTime.parse(time);
//   var offset = dateTime.timeZoneOffset;
//   var hours = offset.inSeconds; // For fixing divide by 0

//   var val2 = val.add(Duration(seconds: hours));
//   // print(dateTime.difference(val2).inSeconds);
//   return formatTimeAgo(
//       int.parse(dateTime.difference(val2).inSeconds.toString()));
// }
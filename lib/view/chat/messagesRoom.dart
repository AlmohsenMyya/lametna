import 'package:flutter/material.dart';
import 'package:lametna/view/chat/appBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class MessagesRoom extends StatelessWidget {
  const MessagesRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appbarBuilder("الدردشات", false),
      body: userMessageBuilder("https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.jpg","نايف","","السلام عليكم"),
    );
  }
  Widget userMessageBuilder(
      String image, String name, String id, String lastMessage) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
        child: Container(
          height: 73.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFF43D0CA)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff00000029).withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                  // changes position of shadow
                ),
              ]),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () {
                //Get.toNamed("/privateMessage", arguments: [image, name, id]);
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:EdgeInsets.all(8.0.w),
                          child: Container(
                            width: 50.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(360.0.r)),
                              border: Border.all(
                                color: const Color(0xff707070),
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: Image.network(
                                image,
                                errorBuilder: (context, error, stackTrace) =>
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100.r),
                                      child: Image.network(
                                        'https://lametnachat.com/upload/imageUser/anonymous.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontFamily: "Portada",
                              ),
                            ),
                            Text(
                              lastMessage,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff707070),
                                fontSize: 11.sp,
                                fontFamily: "Portada",
                              ),
                            ),
                          ],
                        ),
                      ],
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

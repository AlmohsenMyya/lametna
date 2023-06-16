import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/view/chat/appBar.dart';

class RoomInfo extends StatelessWidget {
  const RoomInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("معلومات الغرفة", true),
      body: SafeArea(
        child: Column(
          children: [
            _builderRooms(context),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("إسم الغرفة", "❤️هــروب مـــن الــواقــع❤️"),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("إسم المالك", "Abed Al Majed"),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("البريد", "Abed Al Majed@gmail.com"),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("سعة الغرفة", "150"),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("المتصلين", "25"),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("رقم الغرفة", "226"),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("تاريخ البداية", "03/3/2023"),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("تاريخ الإنتهاء", "03/3/2023"),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            SizedBox(
              height: 42,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xffE7E7E7),
                thickness: 4.h,
              ),
            ),
            infosetting("ممبر", "20",
                color1: Color(0xff7F52A3),
                color2: Color(0xffFF0000),
                fontsize1: 15,
                fontsize2: 15,
                fontWeight1: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("أدمن", "20",
                color1: Color(0xff5D00FF),
                color2: Color(0xffFF0000),
                fontsize1: 15,
                fontsize2: 15,
                fontWeight1: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("سوبر أدمن", "20",
                color1: Color(0xff00B041),
                color2: Color(0xffFF0000),
                fontsize1: 15,
                fontsize2: 15,
                fontWeight1: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
            infosetting("ماستر", "20",
                color1: Color(0xffFF0000),
                color2: Color(0xffFF0000),
                fontsize1: 15,
                fontsize2: 15,
                fontWeight1: FontWeight.bold),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color(0xff43D0CA),
                thickness: 1.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding infosetting(String title, String subtitle,
      {Color color1 = Colors.black,
      Color color2 = Colors.black,
      int fontsize1 = 13,
      int fontsize2 = 15,
      FontWeight fontWeight1 = FontWeight.normal,
      FontWeight fontWeight2 = FontWeight.bold}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subtitle,
            style: TextStyle(
                fontSize: fontsize1.sp,
                color: color2,
                fontWeight: fontWeight1,
                fontFamily: "Segoe UI"),
          ),
          Text(title,
              style: TextStyle(
                  fontSize: fontsize2.sp,
                  color: color1,
                  fontWeight: fontWeight2,
                  fontFamily: "Segoe UI")),
        ],
      ),
    );
  }

  Widget _builderRooms(BuildContext context, {Color color = Colors.white}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // color: Colors.red,
                    height: 58.h,
                    width: 57.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2), // Image border
                      child: SizedBox.fromSize(
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
                          "❤️🌸هــروب مـــن الــواقــع🌸❤️",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontFamily: "Segoe UI"),
                        ),
                        Row(
                          children: [
                            Container(
                                child: Center(
                                  child: Text("ID:0000000",
                                      style: TextStyle(
                                          fontSize: 7.sp,
                                          color: Colors.black,
                                          fontFamily: "Segoe UI")),
                                ),
                                width: 54.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFF43D0CA),
                                    style: BorderStyle.solid,
                                    width: 1.0.w,
                                  ),
                                  borderRadius: BorderRadius.circular(9.0.sp),
                                )),
                            SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              "assets/images/flags/palestine.png",
                              width: 25.w,
                              height: 16.h,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "فلسطين",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "Segoe UI"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

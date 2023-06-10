// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomPage extends StatelessWidget {
  // const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: Container(
          decoration: const BoxDecoration(
            // LinearGradient
            gradient: LinearGradient(
              colors: [
                const Color(0xFFF792F0),
                const Color(0xFFFABD63),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            leadingWidth: 100,
            toolbarHeight: 72.35.h,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/icons/login.png'),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  Icon(Icons.settings),
                ],
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // actions widget
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.volume_up),
              ),
              ImageIcon(
                AssetImage('assets/icons/chat.png'),
                size: 23.sp,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.group),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 70.h,
                  width: 428.w,
                  decoration: const BoxDecoration(
                    // LinearGradient
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFA2ACAC),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 21.w,
                      ),
                      SizedBox(
                        child: OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xffF792F0)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0.r),
                                ))),
                            child: const Text(
                              'الروم الحديث',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Portada",
                                  color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text("22:10",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "Portada",
                              color: Colors.black)),
                      SizedBox(
                        width: 10.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 12),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45.r,
                          child: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 12),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45.r,
                          child: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 12),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45.r,
                          child: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildMyNavBar(context)
        ],
      ),
      // bottomNavigationBar: ,
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 71.h,
        decoration: const BoxDecoration(
          // LinearGradient
          gradient: LinearGradient(
            colors: [
              const Color(0xFFF792F0),
              const Color(0xFFFABD63),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
            Text(
              "🙂",
              style: TextStyle(fontSize: 25.sp),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                width: 230.w,
                height: 30.h,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    // textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.black, //Color(0xff9A8B8B),
                      fontSize: 14.sp,
                      fontFamily: "Portada",
                    ),
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      hintText: 'اكتب رسالة',

                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: "Portada",
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.r)),
                      filled: true,
                      fillColor: Colors.white, // Color(0xff00000029),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Icon(
                Icons.add_circle_outline,
                size: 25.sp,
              ),
            ),
            Icon(
              Icons.mic,
              size: 25.sp,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lametna/view/chat/appBar.dart';

class Moments extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Moments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFABD63),
                Color(0xFFF792F0),
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            leadingWidth: 130.w,
            leading: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
              ],
            ),
            title: Text(
              "Lametna",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Portada",
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Image.asset(
                  "assets/images/trophy.png",
                  width: 55.w,
                  height: 30.h,
                ),
              ),
              IconButton(
                  onPressed: () {
                    // print("object");
                    // Scaffold.of(context).openDrawer();
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                  icon: Icon(Icons.menu)),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Center(
            child: Stack(children: <Widget>[
              Container(
                height: 123.h,
                width: 366.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            ]),
          ),
          SizedBox(
            height: 11.h,
          ),
          Center(child: buildMyNavBar(context)),
          SizedBox(
            height: 15.h,
          ),
          momentsBuilder("ميار"),
          SizedBox(
            height: 25.h,
          ),
          momentsBuilder("محمود"),
        ],
      ),
    );
  }

  Widget momentsBuilder(String name) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          height: 175.h,
          width: 366.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00000029).withOpacity(0.2),
                  spreadRadius: 0.5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: true,
                leading: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(7.5.sp),
                      child: Image.asset(
                        'assets/icons/logo.png',
                        height: 39.h,
                        width: 39.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Image.asset(
                      'assets/images/badge1.png',
                      height: 55.h,
                      width: 55.w,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                title: SizedBox(
                  height: 35.h,
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Portada",
                        color: Color(0xff000000)),
                  ),
                ),
                subtitle: Text(
                  'منذ 5 دقائق',
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontFamily: "Portada",
                      color: Color(0xffA2ACAC)),
                ),
                isThreeLine: true,
                trailing: Icon(
                  Icons.more_vert,
                  color: Color(0xffA2ACAC),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 5.h),
                child: Text(
                  "كل عام وانتم بخير",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Portada",
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 29.w),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up_alt_outlined,
                            color: Colors.black, size: 23.sp),
                        SizedBox(
                          width: 5.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Text(
                            "14",
                            style: TextStyle(
                              color: Color(0xFFA2ACAC),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Row(
                      children: [
                        Icon(Icons.comment_outlined,
                            color: Colors.black, size: 23.sp),
                        SizedBox(
                          width: 5.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Text(
                            "14",
                            style: TextStyle(
                              color: Color(0xFFA2ACAC),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              // Row(
              //   children: [
              //     Stack(
              //       children: [
              //         Padding(
              //           padding: EdgeInsets.all(7.5.sp),
              //           child: Image.asset(
              //             'assets/icons/logo.png',
              //             height: 39.h,
              //             width: 39.w,
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //         Image.asset(
              //           'assets/images/badge1.png',
              //           height: 55.h,
              //           width: 55.w,
              //           fit: BoxFit.cover,
              //         ),
              //       ],
              //     ),
              //     SizedBox(
              //       width: 3.w,
              //     ),
              //     Column(
              //       mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'ميار',
              //           style: TextStyle(
              //               fontSize: 18.sp,
              //               fontFamily: "Portada",
              //               color: Color(0xff000000)),
              //         ),
              //         Text(
              //           'منذ 5 دقائق',
              //           style: TextStyle(
              //               fontSize: 10.sp,
              //               fontFamily: "Portada",
              //               color: Color(0xffA2ACAC)),
              //         ),
              //       ],
              //     )
              //   ],
              // )
            ],
          )),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 46.h,
        width: 366.w,
        child: SizedBox(
          width: 366.w,
          height: 46.h,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black, //Color(0xff9A8B8B),
                fontSize: 14.sp,
                fontFamily: "Portada",
              ),
              expands: true,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                hintText: 'اكتب شيئا',

                hintStyle: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: "Portada",
                    color: Color(0xffA2ACAC)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFABD63)),
                    borderRadius: BorderRadius.circular(16.r)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFABD63)),
                    borderRadius: BorderRadius.circular(16.r)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFABD63)),
                    borderRadius: BorderRadius.circular(10.r)),
                filled: true,
                fillColor: Colors.white, // Color(0xff00000029),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Moments extends StatelessWidget {
  const Moments({Key key}) : super(key: key);

  // const MomentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
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
            actions: [
              Center(
                child: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Text(
                      "اللحظات",
                      style: TextStyle(
                        color: Colors.white, //Color(0xff9A8B8B),
                        fontSize: 20.sp,
                        fontFamily: "Portada",
                      ),
                    )),
              )
            ],
            leadingWidth: 100,
            toolbarHeight: 72.35.h,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                  ),
                ],
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Column(
            children: [
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
            ],
          ),
          _builderRooms(context, "ميار"),
          _builderRooms(context, "محمود"),
        ],
      ),
    );
  }

  Widget buildMyNavBar(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 71.h,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
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
          ],
        ),
      ),
    );
  }

  Widget _builderRooms(BuildContext context, String text,
      {Color color = Colors.white}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          // showAlert(context);
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        // height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/badge1.png",
                                  width: 50.w,
                                  height: 50.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          text,
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: "Portada"),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "14/6/2023",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Color(0xffA2ACAC),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Portada"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "كل عام وانتم بخير",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontFamily: "Portada"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.thumb_up),
                      ),
                      Text(
                        "12",
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffA2ACAC),
                            fontFamily: "Portada"),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.message_outlined),
                      ),
                      Text(
                        "14",
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffA2ACAC),
                            fontFamily: "Portada"),
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

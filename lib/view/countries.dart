// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Countries extends StatelessWidget {
  Countries({Key key}) : super(key: key);
  //https://www.worldometers.info/img/flags/iz-flag.gif
  var countries = [
    {
      "العراق",
      "iz",
    },
    {
      "سرويا",
      "sy",
    },
    {
      "لبنان",
      "le",
    },
    {
      "الاردن",
      "jo",
    },
    {
      "فلسطين",
      "palestine",
    },
    {
      "السعودية",
      "sa",
    },
    {
      "المانيا",
      "gm",
    },
    {
      "تركيا",
      "tu",
    },
    {
      "المغرب",
      "mo",
    },
    {
      "اليمن",
      "ym",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: countries.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.star_border),
                Row(
                  children: [
                    Text(
                      countries[index].elementAt(0),
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 30.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://www.worldometers.info/img/flags/${countries[index].elementAt(1)}-flag.gif'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Colors.yellow,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

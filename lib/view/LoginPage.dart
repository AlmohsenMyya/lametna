// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF792F0),
            const Color(0xFFFABD63),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          _buildBackgroundImage("phone.png", -37.sp, -51.sp, 210),
          _buildBackgroundImage("heart.png", 214.sp, 0.sp, 202, opacity: 1),
          _buildBackgroundImage("message.png", 260.sp, 135.sp, 179),
          _buildBackgroundImage("phone.png", 274.sp, 353.sp, 210),
          _buildBackgroundImage("recipt.png", 41.sp, 651.sp, 201, opacity: 1),
          _buildBackgroundImage("heart.png", 274.sp, 700.sp, 202, opacity: 1),
          _buildBackgroundImage("heart.png", -101.sp, 231.sp, 202, opacity: 1),
          _buildBackgroundImage("message.png", 0.sp, 300.sp, 179),
        ],
      ),
    );
  }
}

Widget _buildBackgroundImage(String image, double x, double y, int size,
    {double? opacity = 0.07}) {
  return Container(
    child: Opacity(
      opacity: opacity!,
      child: Image.asset(
        'assets/images/$image',
        width: size.w,
        fit: BoxFit.scaleDown,
      ),
    ),
    transform: Matrix4.translationValues(x, y, 0),
  );
}
